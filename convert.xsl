<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="xml" omit-xml-declaration="yes" />
  <xsl:param name="labels-file" />
  <xsl:variable name="labels">
    <xsl:copy-of select="document($labels-file)" />
  </xsl:variable>
  <xsl:template match="/">
    <!--xsl:copy-of select="$labels"></xsl:copy-of>
**********************************************************
  <xsl:value-of select="$labels/code_table/rows/row[code='header']/description"></xsl:value-of-->
    <xsl:call-template name="convert">
      <xsl:with-param name="xsl_string" select="/letter/xsl"></xsl:with-param>
      <xsl:with-param name="iter" select="1"></xsl:with-param>
    </xsl:call-template>
  </xsl:template>
  <!--xsl:template match="/letter/xsl">
    <xsl:call-template name="convert">
      <xsl:with-param name="xsl_string" select="/letter/xsl/."/>
    </xsl:call-template>
  </xsl:template-->
  <xsl:template name="convert">
    <xsl:param name="xsl_string"></xsl:param>
    <xsl:param name="iter"></xsl:param>
    <xsl:choose>
      <xsl:when test="not(contains($xsl_string,'@@'))">
        <xsl:value-of select="$xsl_string" disable-output-escaping="yes" />
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="substring-before($xsl_string,'@@')" disable-output-escaping="yes" />
        <xsl:value-of select="$labels/code_table/rows/row[code=substring-before(substring-after($xsl_string,'@@'),'@@')]/description" />
        <xsl:call-template name="convert">
          <xsl:with-param name="xsl_string" select="substring-after(substring-after($xsl_string,'@@'),'@@')" />
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>

  </xsl:template>
</xsl:stylesheet>