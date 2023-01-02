<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="3.0">

    <xsl:template match="/">
        <xsl:for-each-group select="//anchor[@type='collate']/following-sibling::node()" group-starting-with="anchor[@type='collate']">
            <!--2018-05-07 ebb: Things discovered the hard way: when creating new XML out of groups of elements like this, the elements that define the groups really must be at the same hierarchical level. Otherwise the output is full of weird duplicated stuff. Don't use the following:: axis here. Make sure the input is properly flattened accordingly. -->
            <!--2018-04-01 ebb: CHANGE THE FILE DIRECTORY BELOW (to collChunkFrags_c58) as needed. -->
            <xsl:result-document href="2023_collationChunks/{current()/@xml:id}/{substring-before(tokenize(ancestor::xml/base-uri(), '/')[last()], '.')  ! substring-before(., '_')}_{current()/@xml:id}.xml" method="xml" indent="no">
                <xml>
                    
                    <xsl:apply-templates select="current-group()"/>
                </xml>
                
            </xsl:result-document>
        </xsl:for-each-group>
    </xsl:template>
    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>
    <!--2022-08-10 ebb yxj: We do NOT think we want this next template at ALL in the pre-processing now with our new methods! We should REMOVE it from the preprocessing.  -->
    <!--2018-05-12 ebb: With the next template rule, I'm making sure there's a white space following every lb element that isn't inside word-boundary markup. This may help to prevent squishing of normalized word tokens together in the output collation 
    -->
   <!-- <xsl:template match="lb[not(following-sibling::node()[2]/@ana='end')]">
        <xsl:copy><xsl:apply-templates select="@*"/></xsl:copy><xsl:text> </xsl:text>
    </xsl:template>-->
    
    
    <!--2022-08-08 ebb: This template similarly ensures a space preceding the end of every sga-add endtag marker, again to prevent fused word tokens during the collation normalization process. -->
    <xsl:template match="sga-add[@eID]">
        <xsl:text> </xsl:text><xsl:copy><xsl:apply-templates select="@*"/></xsl:copy>
    </xsl:template>
    <xsl:template match="milestone[@unit='tei:p-END']">
        <xsl:variable name="current" as="element()" select="current()"/>
        <xsl:variable name="currentCollAnchor" as="attribute()" select="$current/preceding::anchor[@type='collate'][1]/@xml:id"/>
        
        <xsl:choose>
            <xsl:when test="not(preceding-sibling::milestone[contains(@unit, 'tei:p') and preceding-sibling::anchor[@type='collate'][1]/@xml:id eq $currentCollAnchor])">
                <!-- ebb: Process nothing and remove this milestone -->
            </xsl:when>
            <xsl:otherwise>
                <xsl:copy><xsl:apply-templates select="@*"/></xsl:copy>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    

    <!-- 2022-08-08 ebb: Discovered that characters immediately following <mod eID="..."/> aren't picked up as normalized tokens, 
        so let's add a space after those. -->
    
    <xsl:template match="mod[@eID]">
        <xsl:copy><xsl:apply-templates select="@*"/></xsl:copy><xsl:text> </xsl:text>
    </xsl:template>
    
    <!-- Apparently we *also* need to make sure there's a space before sga-add START markers. 
Add this with an "or" pipe to the template match in the preprocessing XSLT>  -->
    <xsl:template match="sga-add[@sID]">
        <xsl:text> </xsl:text><xsl:copy><xsl:apply-templates select="@*"/></xsl:copy>
    </xsl:template>
    
    <!-- 2023-01-02 ebb: Adding newlines and spaces before the following provided they are not in between <w/> marker elements:
    lb
    anchor
    mod[@sID]
    -->
    <xsl:template match="(lb | anchor | zone[@sID] | mod[@sID])[not(preceding-sibling::*[1][name() = 'w' and @ana='start'])]">
       <xsl:choose> 
           <xsl:when test="preceding-sibling::text()[1][not(matches(., '\n'))]">
            <xsl:text> &#10;</xsl:text><xsl:copy><xsl:apply-templates select="@*"/></xsl:copy>
        </xsl:when>
       <xsl:otherwise>
           <xsl:copy><xsl:apply-templates select="@*"/></xsl:copy>
       </xsl:otherwise>
       </xsl:choose>
    </xsl:template>
    
    
</xsl:stylesheet>