<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<xsl:template match="/library">
<html>
	<head>
		<title>My library</title>
	</head>
	<body>
		<xsl:apply-templates/>
	</body>
</html>
</xsl:template>

<xsl:template match="book">
	<xsl:apply-templates select="title"/>
	<xsl:apply-templates select="isbn"/>
	<p>Authors:</p>
	<ul><xsl:apply-templates select="author"/></ul>
	<p>Characters:</p>
	<ul><xsl:apply-templates select="character"/></ul>
</xsl:template>

<xsl:template match="title">
	<h1><xsl:apply-templates/></h1>
</xsl:template>

<xsl:template match="isbn">
<p>	ISBN: <b><xsl:apply-templates/></b></p>
</xsl:template>

<xsl:template match="author">
	<li><b><xsl:value-of select="name"/></b>
		(<xsl:value-of select="born"/> - <xsl:value-of select="dead"/>)
		alias "<xsl:value-of select="nickName"/>"</li>
</xsl:template>

<xsl:template match="character">
	<li><b><xsl:value-of select="name"/></b>
		(since <xsl:value-of select="since"/>)
		<xsl:value-of select="qualification"/></li>
</xsl:template>

</xsl:stylesheet>