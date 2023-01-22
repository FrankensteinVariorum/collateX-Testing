<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="3.0">
<!-- UPDATED 2023-01-21 to add <head> to the elements we are not flattening. 
        2022-07-30 ebb: This XSLT stylesheet is designed to "flatten" most of the elements
        in the print edition edition XML files in the Frankenstein Variorum project.
        Flattening the files involves transforming hierarchical structure elements 
        including <div> and <p> into milestone-style self-closing elements with attributes 
        indicating whether they are a start or end position. Flattening these elements permits us 
        to break them into fine tokens for comparison so passages that change around paragraph or chapter or 
        letter boundaries in the source texts can be captured as moments of variation.
        
        I have updated the stylesheet so it does *not* flatten certain elements that we never expect 
        to be broken around structural hierarchy elements: these are <head>, <add>, <del>, and <note> elements 
        that represent Mary Shelley's comments added to the Thomas edition. We will attempt 
        to treat these whole elements as very long single tokens for the purposes of
        improving the alignment of our collation output. 
       
    -->
    <xsl:mode on-no-match="shallow-copy"/>
    <xsl:variable name="printColl" as="document-node()+" select="collection('print-full/?select=*.xml')[tokenize(base-uri(), '/')[last()][not(contains(., 'C'))]]"/>
    <xsl:template match="/">
        <xsl:for-each select="$printColl//xml">
            <xsl:variable name="currFile" as="xs:string">
                <xsl:value-of select="concat(tokenize(base-uri(.), '/')[last()] ! substring-before(., '.xml'), 'Flat.xml')"/>
            </xsl:variable> 
            <xsl:result-document method="xml" indent="yes" href=" print-fullFlat/{$currFile}">
                <xml>
        
                    <xsl:apply-templates/>
                </xml>
            </xsl:result-document> 
        </xsl:for-each>
    </xsl:template>
    
    
    <xsl:template match="text//*[text() | *][not(self::div) and not(self::note[@resp]) and not(self::add) and not(self::del)]">
        <xsl:variable name="nodeName" as="xs:string" select="name()"/>
        <xsl:variable name="locationFlag">
            <xsl:for-each select="ancestor::div">
                <xsl:value-of select="@type"/>
                <xsl:value-of select="count(current()/preceding-sibling::div[@type=current()/@type]) + 1"/>
                <xsl:text>_</xsl:text>
            </xsl:for-each>
            <!--<xsl:if test="ancestor::*[. [ancestor::div[1]]]">-->
            <xsl:for-each select="ancestor::*[ancestor::div[1]]">
                    <xsl:variable name="ancNodeName" as="xs:string" select="name()"/>
                    <xsl:value-of select="$ancNodeName"/>
                    <xsl:value-of select="count(preceding-sibling::*[name() = $ancNodeName]) + 1"/>
                    <xsl:text>_</xsl:text>
                </xsl:for-each>
            <!--</xsl:if>-->
            <xsl:value-of select="$nodeName"/>
            <xsl:value-of select="count(preceding-sibling::*[name() = $nodeName]) + 1"/>
        </xsl:variable>
        <xsl:copy>
            <xsl:attribute name="sID">
                <xsl:value-of select="$locationFlag"/>
            </xsl:attribute>
        </xsl:copy>
       
   <xsl:apply-templates/>
        <xsl:copy>
            <xsl:attribute name="eID">
                <xsl:value-of select="$locationFlag"/>
            </xsl:attribute>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="div">
        <milestone unit="{@type}" type="start">
            <xsl:choose><xsl:when test="@n">
                <xsl:attribute name="n">
                <xsl:value-of select="@n"/>
            </xsl:attribute></xsl:when>
            <xsl:otherwise>
                <xsl:attribute name="n">
                    <xsl:value-of select="count(preceding::div[@type=current()/@type]) + 1"/>
                </xsl:attribute>
            </xsl:otherwise>
            </xsl:choose>
            </milestone>
            <xsl:apply-templates/>
        <milestone unit="{@type}" type="end">
            <xsl:choose><xsl:when test="@n">
                <xsl:attribute name="n">
                    <xsl:value-of select="@n"/>
                </xsl:attribute></xsl:when>
                <xsl:otherwise>
                    <xsl:attribute name="n">
                        <xsl:value-of select="count(preceding::div[@type=current()/@type]) + 1"/>
                    </xsl:attribute>
                </xsl:otherwise>
            </xsl:choose>
            </milestone>
    </xsl:template>
    <xsl:template match="note | head">
        <xsl:element name="{name()}">
            <xsl:copy-of select="@*"/>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="(add | del)[not(ancestor::add) and not(ancestor::del)]">
        <xsl:element name="{name()}">
            <xsl:copy-of select="@*"/>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="(add | del)[ancestor::add or ancestor::del]">
        <xsl:element name="{name()}-INNER">
            <xsl:copy-of select="@*"/>
            <xsl:apply-templates/>
        </xsl:element> 
    </xsl:template>
    
</xsl:stylesheet>