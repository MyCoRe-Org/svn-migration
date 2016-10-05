<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fn="http://www.w3.org/2005/xpath-functions" version="2.0">
  <xsl:strip-space elements="log"/>
  <xsl:param name="svntransition" select="'12979'" />
  <xsl:param name="gittransition" select="'36341'" />
  <xsl:template match='@*|node()'>
    <xsl:param name="ID" />
    <!-- default template: just copy -->
    <xsl:copy>
      <xsl:apply-templates select='@*|node()' />
      <xsl:if test="$ID">
        <xsl:attribute name="ID">
          <xsl:value-of select="$ID" />
        </xsl:attribute>
      </xsl:if>
    </xsl:copy>
  </xsl:template>
  <xsl:template match="logentry">
    <xsl:if test="number(@revision) &gt; number($svntransition) and fn:matches(msg/text(),'[^#0-9][0-9]{5,6}\b','!')">
      <xsl:copy>
        <xsl:apply-templates select='@*|node()' />
      </xsl:copy>
    </xsl:if>
  </xsl:template>
</xsl:stylesheet>
