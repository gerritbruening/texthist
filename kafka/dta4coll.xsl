<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs"
	xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns="http://www.tei-c.org/ns/1.0"
	xpath-default-namespace="http://www.tei-c.org/ns/1.0" version="2.0">


	<xsl:template match="div[@n]">
		<anchor xml:id="{generate-id(.)}"/>
		<!--<xsl:variable name="content" select="node() except .//lb/following::node()"/>
		<xsl:variable name="textcontent" select="string-join($content, '')"/>
		<xsl:value-of select="replace($content, '\W+', '')"/>-->
		<xsl:next-match/>
	</xsl:template>

	<xsl:template match="pb"/>

	<xsl:template match="node() | @*" mode="#all">
		<xsl:copy copy-namespaces="no">
			<xsl:apply-templates select="@*, node()" mode="#current"/>
		</xsl:copy>
	</xsl:template>
</xsl:stylesheet>
