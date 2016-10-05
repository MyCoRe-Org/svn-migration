<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fn="http://www.w3.org/2005/xpath-functions" version="2.0">
  <xsl:output method="text" />
  <xsl:strip-space elements="log"/>
  <xsl:template match="logentry">
    <xsl:value-of select="concat(@revision,': ',msg)" />
    <xsl:text>
-------------------------------------------------------
</xsl:text>
  </xsl:template>
</xsl:stylesheet>
