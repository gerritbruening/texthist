<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">

	<xsl:template match="kaLine">
		<kaLine n="{preceding::pb[1]/@n}-{@n}">
			<xsl:apply-templates select="@* except @n, node()"/>
		</kaLine>
	</xsl:template>

	<xsl:template match="text">
		<TEI xmlns="http://www.tei-c.org/ns/1.0">
			<xsl:copy inherit-namespaces="no">
				<xsl:apply-templates select="@*, node()"/>
			</xsl:copy>
		</TEI>
	</xsl:template>


	<xsl:template match="node() | @*">
		<xsl:copy copy-namespaces="no">
			<xsl:apply-templates select="@*, node()"/>
		</xsl:copy>
	</xsl:template>
</xsl:stylesheet>
