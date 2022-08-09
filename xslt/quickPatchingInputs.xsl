<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="3.0">

<!-- 2022-08-08 ebb: This stylesheet is intended to serve for speedy repairs of marked up collation input files. Optimally the templates in this sheet will be run during pre-processing, 
        preparing the collation chunk files. But this XSLT is designed to assist with quickly updating a set of test input files as we are refining our collation methods.  -->
<xsl:mode on-no-match="shallow-copy"/>
    
  
    <!-- 2022-08-08 I'm including this template as an example of the kinds of edits we can make to improve collation and prevent fusing of normalized word tokens.
        It has already been applied to the source inputs, so leave it commented out. 
        
       With the next template rule, I'm making sure there's a white space following every lb element that isn't inside word-boundary markup. 
        This may help to prevent squishing of normalized word tokens together in the output collation.
        (Already run on all files)
   <xsl:template match="lb[not(following-sibling::node()[2]/@ana='end')]">
        <xsl:copy><xsl:apply-templates select="@*"/></xsl:copy><xsl:text> </xsl:text>
    </xsl:template>
    -->
    
    <!--ADDED TO PRE-PROCESSING XSLT 2022-08-08 ebb: This template  ensures a space preceding the end of every sga-add endtag marker, again to prevent fused word tokens during the collation normalization process.
        <xsl:template match="sga-add[@eID]">
        <xsl:text> </xsl:text><xsl:copy><xsl:apply-templates select="@*"/></xsl:copy>
    </xsl:template>-->
    
    
    <!-- ############################# -->
    <!-- NOTE YET ADDED TO PRE-PROCESSING XSLT  -->
    <!-- 2022-08-08 ebb: Discovered that characters immediately following <mod eID="..."/> aren't picked up as normalized tokens, 
        so let's add a space after those. -->
  
   <!-- <xsl:template match="mod[@eID]">
        <xsl:copy><xsl:apply-templates select="@*"/></xsl:copy><xsl:text> </xsl:text>
    </xsl:template>-->
 
 <!-- Apparently we *also* need to make sure there's a space before sga-add START markers. 
Add this with an "or" pipe to the template match in the preprocessing XSLT>  -->
    <xsl:template match="sga-add[@sID]">
        <xsl:text> </xsl:text><xsl:copy><xsl:apply-templates select="@*"/></xsl:copy>
    </xsl:template>
 
    
    <!-- If we continue to set subcollation anchors manually, run this template on ALL editions (msColl and print) -->
  <!--  <xsl:template match="anchor">
        <xsl:copy><xsl:apply-templates select="@*"/></xsl:copy><xsl:text> </xsl:text>
    </xsl:template>-->
    
</xsl:stylesheet>