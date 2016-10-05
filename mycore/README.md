# Easily check all commit logs at once

You need [Saxon](http://saxon.sourceforge.net/) for the XSLT files as they are using some XSLT 2.0 features.

```
svn log --xml https://server.mycore.de/svn/mycore > svnlog-complete.xml
#filters only relevant logs
java -jar saxon9he.jar -s:svnlog-complete.xml -xsl:filterrev.xsl > svnlog-filtered.xml
java -jar saxon9he.jar -s:svnlog-filtered.xml -xsl:revisions.xsl > svnlog.txt
```

If you find any commit log that needs to be corrected:

```
svn propedit --revprop svn:log https://server.mycore.de/svn -r {revision}
```
