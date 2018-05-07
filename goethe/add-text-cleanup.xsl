<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	exclude-result-prefixes="xs" xmlns:tei="http://www.tei-c.org/ns/1.0"
	xmlns="http://www.tei-c.org/ns/1.0"
	xmlns:f="http://www.faustedition.net/ns"
	xmlns:ge="http://www.tei-c.org/ns/geneticEditions"
	xpath-default-namespace="http://www.tei-c.org/ns/1.0" version="2.0">

	<xsl:template match="seg"/>
	<xsl:template
		match="
			*/@f:schroer | */@f:act | */@f:label | */@f:first-verse | */@f:last-verse |
			*/@f:section | */@f:verse-range | */@f:scene"/>
	<xsl:template match="hi/@status | pb | lg/@type"/>

	<xsl:template match="node() | @*" mode="#all">
		<xsl:copy copy-namespaces="no">
			<xsl:apply-templates select="@*, node()" mode="#current"/>
		</xsl:copy>
	</xsl:template>
</xsl:stylesheet>
