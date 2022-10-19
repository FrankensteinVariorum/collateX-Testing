<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    xmlns:cx="http://interedition.eu/collatex/ns/1.0"
    
    exclude-result-prefixes="xs math"
    version="3.0">
    <!--2021-09-24 ebb with wdjacca and amoebabyte: We are writing XSLT to try to move
    solitary apps reliably into their neighboring app elements representing all witnesses. 
    
    -->
  <xsl:mode on-no-match="shallow-copy"/>
  
<!-- ********************************************************************************************
        LONER DELS: These templates deal with collateX output of app elements 
        containing a solitary MS witness containing a deletion, which we interpret as usually a false start, 
        before a passage.
     *********************************************************************************************
    -->  
    <xsl:template match="app[count(descendant::rdg) = 1]">
        <!-- 2022-10-11 yxj and ebb: let's not both just looking for deleted passages, but ANY loner rdg. We have
        removed this XPath predicate from the @match: [contains(descendant::rdg, '&lt;del')] 
        -->
  
        <xsl:if test="following-sibling::app[1][count(descendant::rdgGrp) = 1 and count(descendant::rdg) gt 1]">
               <xsl:apply-templates select="following-sibling::app[1]" mode="restructure">
                  <xsl:with-param as="node()" name="loner" select="descendant::rdg" tunnel="yes" />
                   <xsl:with-param as="attribute()" name="norm" select="rdgGrp/@n" tunnel="yes"/>
               </xsl:apply-templates>
               
           </xsl:if>
    </xsl:template>
    
    
    <xsl:template match="app[preceding-sibling::app[1][count(descendant::rdg) = 1]]"/>
    <!-- 2022-10-11 ebb and yxj: We also need to remove the predicate checking for the presence of &lt;del on this template
    Removed this: [contains(descendant::rdg, '&lt;del')]  
    -->


    <xsl:template match="app" mode="restructure">
        
        <!-- 2022-10-11 yxj ebb: Let's try creating a conditional processing rule here: 
        IF the $norm param only contains `['']` (string-length() = 4), do NOT create a new rdgGrp, and simply move
        the $loner param into the existing structure. 
        
        Example
        <app><rdgGrp n="['with', 'my', 'aunt', 'and', 'my']">
			<rdg wit="f1818">with my aunt and my </rdg>
			<rdg wit="f1823">with my aunt and my </rdg>
			<rdg wit="fThomas">with my aunt and my </rdg>
			<rdg wit="fMS">with my aunt &amp; my </rdg>
		</rdgGrp><rdgGrp n="['', 'with', 'my', 'aunt', 'and', 'my']"><rdg wit="fMS">&lt;sga-add eID="c56-0104__main__d5e21929"/&gt; with my aunt &amp; my </rdg></rdgGrp></app>
	
        -->
        <xsl:param name="loner" tunnel="yes"/>
        <xsl:param name="norm" tunnel="yes"/>
        <app>
        <xsl:apply-templates select="rdgGrp" mode="restructure">
                <xsl:with-param  as="node()" name="loner" tunnel="yes" select="$loner"/>
            </xsl:apply-templates>
            <xsl:choose>
                <xsl:when test="$norm ! string-length() &gt; 4">
                <xsl:variable name="TokenSquished">
                
                    <xsl:value-of select="$norm ! string()||descendant::rdgGrp[descendant::rdg[@wit=$loner/@wit]]/@n"/>
               
                </xsl:variable>
            <xsl:variable name="newToken">
                <xsl:value-of select="replace($TokenSquished, '\]\[', ', ')"/>
            </xsl:variable>
            <xsl:variable name="newNorm">
                <xsl:value-of select="replace(replace($newToken,'andquot;', '&#34;'),'&amp;','and')"/>
            </xsl:variable>
           <rdgGrp n="{$newNorm}">
               <rdg wit="{$loner/@wit}"><xsl:value-of select="replace(replace($loner/text(),'&amp;quot;', '&#34;'),'&amp;amp;','&amp;')"/>
                   <xsl:value-of select="replace(descendant::rdg[@wit = $loner/@wit], '&amp;quot;', '&#34;') ! replace(., '&amp;amp;', '&amp;')"/>
              </rdg>
               <!-- ebb: LET'S MAKE THIS AMP REPLACEMENT A FUNCTION ALREADY!!!! :-D -->
            </rdgGrp> 
            </xsl:when>
            <xsl:otherwise>
                
                <xsl:apply-templates select="rdgGrp" mode="emptyNormalize">
                    <xsl:with-param  as="text()" name="lonerText" tunnel="yes" select="$loner/text()"/>
                    <xsl:with-param as="xs:string" name="lonerWit" tunnel="yes" select="$loner/@wit"/>
                </xsl:apply-templates>
                
               <!-- 2022-10-18 ebb: SOMEHOW WE ARE NOT PASSING $loner/text() TO THE NEXT TEMPLATE NOW. Yikes. -->
                
                
                <!-- ebb: OTHERWISE would be in all cases when the @n has a string-length of 4: `['']`. 
               We do this instead: We simply take the existing @n on the current rdgGrp and use it instead. 
                
                -->
          <!--      <xsl:variable name="currentNorm">
                    <xsl:value-of select="descendant::rdgGrp[descendant::rdg[@wit=$loner/@wit]]/@n"/>
                </xsl:variable>      
                <xsl:variable name="newNorm">
                    <xsl:value-of select="replace(replace($currentNorm,'andquot;', '&#34;'),'&amp;','and')"/>
                </xsl:variable>
                
                
                <rdgGrp n="{$newNorm}">
                    <xsl:for-each select="descendant::rdg[@wit ne $loner/@wit]">
                        <xsl:apply-templates/>
                    </xsl:for-each>
                    <xsl:apply-templates select="descendant::rdg[@wit = $loner/@wit]" mode="restructure">
                        <xsl:with-param  as="text()" name="lonerText" tunnel="yes" select="$loner/text()"/>
                       
                    </xsl:apply-templates>
                    
                </rdgGrp>-->
                
            <!-- <xsl:apply-templates select="rdgGrp[rdg[@wit = $loner/@wit]]" mode="restructure">
                 <xsl:with-param  as="text()" name="lonerText" tunnel="yes" select="$loner/text()"/>
                 <xsl:with-param as="xs:string" name="lonerWit" tunnel="yes" select="$loner/@wit"/>
             </xsl:apply-templates>-->
 
            </xsl:otherwise>
            
            </xsl:choose>
        </app> 
    </xsl:template>
    
   
    
    <xsl:template match="rdgGrp" mode="restructure">
      
        <xsl:param name="loner" tunnel="yes"/>

           <xsl:if test="rdg[@wit ne $loner/@wit]">
            <xsl:copy-of select="current()" />
        </xsl:if>
    </xsl:template>
    
   <!-- <xsl:template match="rdg" mode="restructure">
        
        <xsl:param name="lonerText" tunnel="yes"/>
        
        <rdg wit="{@wit}">
            <xsl:value-of select="$lonerText"/>
            <xsl:value-of select="replace(current(), 'andquot;', '&#34;') ! replace(., '&amp;', 'and')"/>
        </rdg>
        
    </xsl:template>
    -->
    <xsl:template match="rdgGrp" mode="emptyNormalize">
        <xsl:param name="lonerText" tunnel="yes"/>
        <xsl:param name="lonerWit" tunnel="yes"/>
        <xsl:for-each select="rdg[@wit ne $lonerWit]">
            <xsl:copy-of select="current()" /> 
        </xsl:for-each>
           <rdg wit="{$lonerWit}"><xsl:value-of select="$lonerText"/>
               <xsl:value-of select="replace(current()/rdg[@wit = $lonerWit], 'andquot;', '&#34;') ! replace(., '&amp;', 'and')"/>
           </rdg>
   
    </xsl:template>
    
    <!-- 2022-10-18 yxj ebb: For all rdgs, in the normalized @n value, replace 'andquot' to '&#34;', and replace '&amp;' to 'and'.
    In the text nodes (the original text), replace '&amp;quot; to '&#34;', and replace '&amp;amp;' to '&amp;'. This template corrects a problem introduced by the use of expandNode() and node.toxml() in the Python pulldom script, used to output the contents of our added longtoken, add, del, and note (inlineVariationEvent elements). We made the same alterations in the restructured app processing above. It may be a good idea to move this processing to a function. 
    -->
    <xsl:template match="rdg/text()">
        <!--<xsl:value-of select="replace(.,'(&amp;)([^&]+?;)','&\2')"/>-->  
        <xsl:value-of select="replace(replace(.,'&amp;quot;', '&#34;'),'&amp;amp;','&amp;')"/>
    </xsl:template>
    <xsl:template match="rdgGrp">
        <rdGrp n="{replace(replace(@n,'andquot;', '&#34;'),'&amp;','and')}">
            <xsl:apply-templates/>
        </rdGrp>
    </xsl:template>

</xsl:stylesheet>