<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:transform version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<!-- omit xml declaration -->
	<xsl:output method="xml" omit-xml-declaration="yes" />
	<!-- stripping out whitespaces -->
	<xsl:strip-space elements="*"/>
	
	<!-- grab tags -->
	<xsl:template match="*">
		<xsl:text>{</xsl:text>
		<!-- add tag name -->
		<xsl:text>"name":"</xsl:text>
		<xsl:value-of select="name()" />
		<xsl:text>"</xsl:text>
		<!-- add attributes if any -->
		<xsl:if test="@*">
			<xsl:text>,</xsl:text>
			<!-- add attributes hash, -->
			<xsl:text>"attributes":{</xsl:text>
			<!-- grab attributes -->
			<xsl:for-each select="@*">
				<xsl:text>"</xsl:text>
				<!-- show key-value pair -->
				<xsl:value-of select="name()" />
				<xsl:text>":"</xsl:text>
				<xsl:value-of select="." />
				<xsl:text>"</xsl:text>
				<!-- don't show last comma -->
				<xsl:if test="position() != last()">
					<xsl:text>,</xsl:text>
				</xsl:if>
			</xsl:for-each>
			<xsl:text>}</xsl:text>
		</xsl:if>
		<!-- add children if any -->
		<xsl:if test="child::*|child::text()">
			<xsl:text>,</xsl:text>
			<!-- add children -->
			<xsl:text>"children":[</xsl:text>
			<xsl:for-each select="child::*|child::text()">
				<xsl:choose>
					<!-- if text -->
					<xsl:when test="self::text()">		
						<!-- add formatting for the text -->
						<xsl:text>&#x0A;</xsl:text>
						<xsl:for-each select="ancestor::*">
							<xsl:text>&#x09;</xsl:text>
						</xsl:for-each>
						<!-- show the text as an independent child with "text" node -->
						<xsl:text>{"text":"</xsl:text>
						<!-- normalizing value for trimming spaces -->
						<xsl:value-of select="normalize-space(.)"/>
						<xsl:text>"}</xsl:text>
						<!-- don't show last comma -->
						<xsl:if test="position() != last()">
							<xsl:text>,</xsl:text>
						</xsl:if>
					</xsl:when>
					<!-- if not text -->
					<xsl:otherwise>
						<!-- add formatting for element -->
						<xsl:text>&#xa;</xsl:text>
						<xsl:for-each select="ancestor::*">
							<xsl:text>&#x09;</xsl:text>
						</xsl:for-each>
						<!-- apply this template to the current element -->
						<xsl:apply-templates select="current()" />
						<!-- don't display the last comma -->
						<xsl:if test="position() != last()">
							<xsl:text>,</xsl:text>
						</xsl:if>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:for-each>
			<xsl:text>]</xsl:text>
		</xsl:if>
		<xsl:text>}</xsl:text>
	</xsl:template>
</xsl:transform>