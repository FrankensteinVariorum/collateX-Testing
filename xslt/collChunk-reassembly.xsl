<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="3.0">
    <xsl:mode on-no-match="shallow-copy"/>
   
    <xsl:variable name="subChunk-a" as="document-node()+" select="collection('../collChunk-14a/?select=*.xml')"/>
    <xsl:variable name="subChunk-b" as="document-node()+" select="collection('../collChunk-14b/?select=*.xml')"/>
    <xsl:template match="/">
        <xsl:for-each select="$subChunk-a">
            <xsl:variable name="currFile" as="document-node()" select="current()"/>
            <xsl:variable name="matchPart" as="xs:string" select="$currFile ! base-uri() ! tokenize(., '/')[last()] ! substring-before(., '_a.xml')"/>
            <xsl:variable name="matchFile" as="document-node()" select="$subChunk-b[base-uri() ! tokenize(., '/')[last()] ! substring-before(., '_b.xml') = $matchPart]"/>
            
       
            <xsl:result-document
                href="../collChunk14-reassembled/{$matchPart}.xml"
                method="xml" indent="yes">
                <xml>
                   <xsl:apply-templates select="$currFile//xml/node()"/>
                    <xsl:apply-templates select="$matchFile//xml/node()"/>
                </xml>
            </xsl:result-document>
            
        </xsl:for-each>
    </xsl:template>

</xsl:stylesheet>
