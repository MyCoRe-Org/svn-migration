# svn-migration
## Check Subversion commit logs

In the [mycore](mycore) subdirectory are some XSLT files that can be helpful to get relevant information of Subversion commit logs. Start there to correct any logs that a not in form `r{revision}`, `rev {revision}`, `rev. {revision}` or `revision {revision}` required for the next steps.

## Create a local Git clone of the Subversion repository
```
mkdir -p git-repos/mycore && cd git-repos/mycore
```

Make sure you use a file system that **does NOT ignore** cases of filenames (e.g. MacOS default).

```
MIGBASEDIR=$(cd ../.. && pwd -P)
svn2git https://server.mycore.de/svn/mycore \
 --exclude '.*[/]\.project$' --exclude '.*[/]\.classpath$' \
 --exclude '.*\.class$' --exclude '.*\.settings($|[/].*)' \
 --exclude '(?!.*[/](src|sources)[/]).*[/]target($|[/].*)' \
 -m --no-minimize-url --authors "${MIGBASEDIR}/authors.txt"
```

This monster will initialize a local Git repository in the current directory and uses the author mapping from [authors.txt](authors.txt). It also exluded some accidental commit files and directories.

Now we can finally convert SVN revision to GIT SHA checksums:

```
"${MIGBASEDIR}/filter-branch-date-order" \
 --msg-filter "${MIGBASEDIR}/mycore/mycore-msgfilter" \
 --tag-name-filter cat -- --all
```

After the initial convertation we need to update the checksum. Look [here](http://www.tt-solutions.com/en/articles/advanced_svn_to_git) further information.

```
"${MIGBASEDIR}/filter-branch-date-order" -f --prune-empty \
 --msg-filter "${MIGBASEDIR}/msgfilter-updatesha" \
 --tag-name-filter cat -- --all
```

Git saves a backup before rewriting everything in `refs/original`, which we can clean now with:

```
git for-each-ref --format="%(refname)" refs/original/ | xargs -n 1 git update-ref -d
git gc --aggressive --prune=all
```

Finally we can put it online

```
git remote add origin https://github.com/MyCoRe-Org/{repository}.git
git push -u origin --all
git push origin --tags
```

Some final cleanup like adding a `README.md` and `.gitignore` file are left to do. 
