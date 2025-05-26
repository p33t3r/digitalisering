<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:html="http://www.w3.org/1999/xhtml" exclude-result-prefixes="xs tei html" version="2.0">
    <xsl:output method="html"/>
    <xsl:template match="tei:TEI">
        <html lang="en" xml:lang="en">
            <head>
                <title>
                    <!-- add the title from the metadata. This is what will be shown on your browsers tab -->
                    <xsl:apply-templates select="//tei:titleStmt/tei:title"/>: diplomatarisk transkription
                </title>
                <!-- load the stylesheets in the assets/css folder, where you can modify the styling of your website -->
                <meta charset="utf-8"/>
                <meta name="viewport" content="width=device-width, initial-scale=1"/>
            </head>
            <body>
                <img>
                    <xsl:attribute name="href">
                        <xsl:text>https://archive.org/download/aa-001964-f-v-elma-danielsson-a-1/</xsl:text>
                        <xsl:value-of select="//tei:facsimile/@xml:id"/>
                        <xsl:text>/</xsl:text>
                        <xsl:value-of select="//tei:facsimile/@xml:id"/>
                        <xsl:text>_</xsl:text>
                        <xsl:value-of select="@facs"/>
                        <xsl:text>.tif</xsl:text>
                    </xsl:attribute>
                </img>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>