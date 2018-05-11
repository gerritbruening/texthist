<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs tei"
	xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns="http://www.tei-c.org/ns/1.0"
	xpath-default-namespace="http://www.tei-c.org/ns/1.0" version="2.0">


	<xsl:template match="div[@n='1']">
		<xsl:variable name="content" select="argument"/>
		<!-- after argument: except  .//lb/following::node() -->
		<xsl:variable name="textcontent" select="string-join($content, '')"/>
		<!-- für den Fall, dass mehrere argument elemente vorkommen -->
		<xsl:variable name="id" select="replace($textcontent, '\W+', '')"/>
		<!-- \W ist alles, was kein Word-Character ist -->
		<xsl:variable name="idae" select="replace($id, 'Ä', 'AE')"/>
		<xsl:variable name="idoe" select="replace($idae, 'Ö', 'OE')"/>
		<xsl:variable name="idue" select="replace($idoe, 'Ü', 'UE')"/>
		<anchor xml:id="{$idue}"/>
		<milestone unit="div"/>
		<xsl:next-match/>
	</xsl:template>

	<xsl:template match="
		back
		| div[@type='imprint']
		| front
		| pb
		| teiHeader"/>

	<xsl:template match="argument/p">
		<head>
			<xsl:apply-templates/>
		</head>
	</xsl:template>

	<xsl:template match="
			argument
			| div">
		<xsl:apply-templates/>
	</xsl:template>

	<xsl:template match="node() | @*">
		<xsl:copy copy-namespaces="no">
			<xsl:apply-templates select="@*, node()"/>
		</xsl:copy>
	</xsl:template>
</xsl:stylesheet>
