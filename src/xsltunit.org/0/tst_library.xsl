<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:exsl="http://exslt.org/common" 
	extension-element-prefixes="exsl"
	xmlns:xsltu="http://xsltunit.org/0/" 
	exclude-result-prefixes="exsl">
  <xsl:import href="library.xsl"/>
  <xsl:import href="xsltunit.xsl"/>
  <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
  <xsl:template match="/">
    <xsltu:tests>
      <xsltu:test id="test-title">
        <xsl:call-template name="xsltu:assertEqual">
          <xsl:with-param name="id" select="'full-value'"/>
          <xsl:with-param name="nodes1">
            <xsl:apply-templates select="document('library.xml')/library/book[isbn='0836217462']/title"/>
          </xsl:with-param>
          <xsl:with-param name="nodes2">
            <h1>Being a Dog Is a Full-Time Job</h1>
          </xsl:with-param>
        </xsl:call-template>
      </xsltu:test>
      <xsltu:test id="test-title-reverted">
        <xsl:call-template name="xsltu:assertNotEqual">
          <xsl:with-param name="id" select="'non-empty-h1'"/>
          <xsl:with-param name="nodes1">
            <xsl:apply-templates select="document('library.xml')/library/book[isbn='0836217462']/title"/>
          </xsl:with-param>
          <xsl:with-param name="nodes2">
            <h1/>
          </xsl:with-param>
        </xsl:call-template>
      </xsltu:test>
      <xsltu:test id="XPath-expressions">
        <xsl:variable name="source">
          <title>My title</title>
        </xsl:variable>
        <xsl:variable name="result-rtf">
          <xsl:apply-templates select="exsl:node-set($source)/title"/>
        </xsl:variable>
        <xsl:variable name="result" select="exsl:node-set($result-rtf)"/>
        <xsl:call-template name="xsltu:assert">
          <xsl:with-param name="id" select="'h1'"/>
          <xsl:with-param name="test" select="$result/h1"/>
          <xsl:with-param name="message">This should be a h1!</xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="xsltu:assert">
          <xsl:with-param name="id" select="'value'"/>
          <xsl:with-param name="test" select="$result/h1=$source"/>
          <xsl:with-param name="message">h1 is "<xsl:value-of select="$result/h1"/>"</xsl:with-param>
        </xsl:call-template>
      </xsltu:test>
    </xsltu:tests>
  </xsl:template>
</xsl:stylesheet>
