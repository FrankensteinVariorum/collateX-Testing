<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="3.0">
    
    <xsl:mode on-no-match="shallow-copy"/>
    
    <xsl:variable name="printCollFlat" as="document-node()+" select="collection('print-fullFlat/?select=*.xml')"/>
    <xsl:template match="/">
        <xsl:for-each select="$printCollFlat">
            <xsl:variable name="currFile" as="document-node()" select="current()"/>
        <xsl:for-each-group select="$currFile//anchor/following-sibling::node()" group-starting-with="anchor">
            <!-- ebb: outputs folders for each unit: <xsl:result-document
                href="2023_collationChunks/{current()/@xml:id}/{base-uri() ! tokenize(., '/')[last()] ! substring-before(., '.')}_{current()/@xml:id}.xml"
                method="xml" indent="yes">-->
     <!-- 2023-04-11 outputting just a single directory with all unit inside to help support interface work. -->
            <xsl:result-document
                href="collationChunks-simple/{base-uri() ! tokenize(., '/')[last()] ! substring-before(., '.')}_{current()/@xml:id}.xml"
                method="xml" indent="yes">
            
            
                <xml>
                    <xsl:apply-templates select="current-group()"/>
                </xml>
                
            </xsl:result-document>

            <!--</xsl:result-document>-->
        </xsl:for-each-group>
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>
