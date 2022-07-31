<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"  
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
exclude-result-prefixes="#all"
    version="3.0">
    <!--2018-07-20 ebb: This stylesheet plants "location flags" on <lb/> elements to mark their XPath position, and it sets "trojan-horse" style start and end markers with @th:sID and @th:eID on other elements as they are being flattened. On up-conversion following collation, we may convert the trojan-horse marker elements back into xml:ids again, should we decide to build from our S-GA "bridge" files. -->
    <!--2022-07 ebb: I am updating this stylesheet to 
        * transform <milestone unit="tei:p"/> elements into end and start milestone markers
        * transform <add> elements into <sga-add> (and treat them as trojan style elements). We want these element tags from the S-GA edition only to be ignored in the collation, but need to preserve their contents for collation.
        * output <del> elements as whole elements so that they can be treated as very long single tokens in the collation, for the purposes of improving the alignment of our collation output. 
        * also output <note> elements as whole elements, so they, too can be treated as very long single tokens. 
        
        These changes may improve the collation alignment of the S-GA document with the print edition documents.

    -->
   <xsl:output method="xml" indent="no"/>
    <xsl:template match="@* | node()">
        <xsl:copy copy-namespaces="no">
            <xsl:apply-templates select="@* | node()[not(namespace::*)]"/>
        </xsl:copy>
    </xsl:template>
    <xsl:variable name="msColl-full" as="document-node()+" select="collection('msColl-full/?select=*.xml')"/>
    <xsl:template match="/">
        <xsl:for-each select="$msColl-full//xml">
            <xsl:variable name="currFile" as="xs:string" select="tokenize(base-uri(.), '/')[last()] ! substring-before(., '.xml')"/>
            <xsl:result-document method="xml" indent="yes" href="msColl-fullFlat/{$currFile}Flat.xml">
                <xml>
                    <xsl:apply-templates/>
                </xml>
            </xsl:result-document> 
        </xsl:for-each>
    </xsl:template>

    <xsl:template match="lb">
        <xsl:choose>
            <xsl:when test="parent::zone[@type = 'main']">
                <xsl:element name="{local-name()}">  
                    <xsl:attribute name="n">
                        <xsl:value-of select="substring-after(ancestor::surface/@xml:id, 'ox-ms_abinger_')"/><xsl:text>__main__</xsl:text>
                        <xsl:value-of select="count(preceding-sibling::lb) + (preceding-sibling::gap[@reason='resequencing' and @unit='lines']/@quantity, 0)[1] + 1"/>
                    </xsl:attribute>
                    <xsl:apply-templates/>
                </xsl:element>
            </xsl:when>
            <xsl:when test="parent::zone[@corresp]">
                <xsl:element name="{local-name()}">
                    <xsl:attribute name="n">
                        <xsl:value-of select="substring-after(ancestor::surface/@xml:id, 'ox-ms_abinger_')"/><xsl:text>__</xsl:text>
                        <xsl:value-of select="parent::zone/@type"/>
                        <xsl:text>__</xsl:text>
                        <xsl:value-of select="count(preceding-sibling::lb) + (preceding-sibling::gap[@reason='resequencing' and @unit='lines']/@quantity, 0)[1] + 1"/>
                    </xsl:attribute>
                    <xsl:apply-templates/>
                </xsl:element>
            </xsl:when>
        </xsl:choose> 
    </xsl:template>
    
    <xsl:template match="surface">
        <xsl:element name="{local-name()}">
            <xsl:for-each select="@*">
                <xsl:attribute name="{local-name()}">
                    <xsl:value-of select="."/>
                </xsl:attribute>
            </xsl:for-each>
            <xsl:attribute name="sID">
                <xsl:value-of select="@xml:id"/>
            </xsl:attribute>    
        </xsl:element>
     <xsl:apply-templates/>   
        
        <xsl:element name="{local-name()}"> 
               <xsl:attribute name="eID">
                <xsl:value-of select="@xml:id"/>
            </xsl:attribute>    
           </xsl:element>
           
    </xsl:template>
    <xsl:template match="zone">
      <xsl:variable name="locFlag">
          <xsl:value-of select="substring-after(ancestor::surface/@xml:id, 'abinger_')"/><xsl:text>__</xsl:text><xsl:value-of select="@type"/> 
      </xsl:variable>  
        
        <xsl:element name="{local-name()}">
            <xsl:copy-of select="@*" copy-namespaces="no"/>
            <xsl:attribute name="sID">
 <xsl:value-of select="$locFlag"/>
            </xsl:attribute>    
            </xsl:element> 
        <xsl:apply-templates/>
        <xsl:element name="{local-name()}">  
              <xsl:attribute name="eID">
                <xsl:value-of select="$locFlag"/>
            </xsl:attribute>    
          </xsl:element>     
    </xsl:template>
    <xsl:template match="mod">
        <xsl:variable name="locFlag">
            <xsl:value-of select="substring-after(ancestor::surface/@xml:id, 'abinger_')"/><xsl:text>__</xsl:text><xsl:value-of select="ancestor::zone[1]/@type"/><xsl:text>__</xsl:text><xsl:value-of select="generate-id(.)"/> 
        </xsl:variable>  
        <xsl:element name="{local-name()}">
            <xsl:copy-of select="@*" copy-namespaces="no"/>
            <xsl:attribute name="sID">
                <xsl:value-of select="$locFlag"/>
            </xsl:attribute>
            </xsl:element>     
        <xsl:apply-templates/>
        <xsl:element name="{local-name()}"> 
            <xsl:attribute name="eID">
                <xsl:value-of select="$locFlag"/>
            </xsl:attribute>   
           </xsl:element>   
    </xsl:template>
    <xsl:template match="add">
        <xsl:variable name="locFlag">
            <xsl:value-of select="substring-after(ancestor::surface/@xml:id, 'abinger_')"/><xsl:text>__</xsl:text><xsl:value-of select="ancestor::zone[1]/@type"/><xsl:text>__</xsl:text><xsl:value-of select="generate-id(.)"/> 
        </xsl:variable>  
        <xsl:element name="sga-{local-name()}">
            <xsl:copy-of select="@*" copy-namespaces="no"/>
            <xsl:attribute name="sID">
                <xsl:value-of select="$locFlag"/>
            </xsl:attribute>
        </xsl:element>     
        <xsl:apply-templates/>
        <xsl:element name="sga-{local-name()}"> 
            <xsl:attribute name="eID">
                <xsl:value-of select="$locFlag"/>
            </xsl:attribute>   
        </xsl:element>   
    </xsl:template>
    <xsl:template match="del[not(ancestor::del)]">
        <xsl:variable name="locFlag">
            <xsl:value-of select="substring-after(ancestor::surface/@xml:id, 'abinger_')"/><xsl:text>__</xsl:text><xsl:value-of select="ancestor::zone[1]/@type"/><xsl:text>__</xsl:text><xsl:value-of select="generate-id(.)"/> 
        </xsl:variable>  
        <xsl:element name="{local-name()}">
            <xsl:copy-of select="@*" copy-namespaces="no"/>
            <xsl:attribute name="xml:id">
                <xsl:value-of select="$locFlag"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </xsl:element>     
    </xsl:template>
    <xsl:template match="del[ancestor::del]">
        <xsl:variable name="locFlag">
            <xsl:value-of select="substring-after(ancestor::surface/@xml:id, 'abinger_')"/><xsl:text>__</xsl:text><xsl:value-of select="ancestor::zone[1]/@type"/><xsl:text>__</xsl:text><xsl:value-of select="generate-id(.)"/> 
        </xsl:variable>  
        <xsl:element name="{local-name()}-INNER">
            <xsl:copy-of select="@*" copy-namespaces="no"/>
            <xsl:attribute name="xml:id">
                <xsl:value-of select="$locFlag"/>
            </xsl:attribute>'
            <xsl:apply-templates/>
        </xsl:element>     
    </xsl:template>
    <xsl:template match="milestone[@unit='tei:p']">
        <xsl:element name="{local-name()}">
            <xsl:copy-of select="@*[not(name() = 'unit')]" copy-namespaces="no"/>
            <xsl:attribute name="unit">
                <xsl:text>tei:p-END</xsl:text>
            </xsl:attribute>
        </xsl:element>
        <xsl:element name="{local-name()}">
            <xsl:copy-of select="@*[not(name() = 'unit')]" copy-namespaces="no"/>
            <xsl:attribute name="unit">
                <xsl:text>tei:p-START</xsl:text>
            </xsl:attribute>
        </xsl:element>
    </xsl:template>
      
</xsl:stylesheet>