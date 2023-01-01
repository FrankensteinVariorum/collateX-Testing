<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    xmlns:cx="http://interedition.eu/collatex/ns/1.0"
    xmlns:fv="yeah"
    exclude-result-prefixes="xs math fv" version="3.0">
    <!-- ********************************************************************************************
             POST-PROCESSING XSLT FOR THE FRANKENSTEIN VARIORUM: 
       This stylesheet corrects common alignment problems in the output of the Python collation script. 
       ebb began work on this in Fall of 2021 with wdjacca and amoebabyte and continued with yxj in 2022.
    
    2023-01-01 ebb: Here is a  high-level summary of our post-processing algorithm:
    We are post-processing 
        1. "Orphan apps" that contain a single rdGrp and a single witness
        2. Deleted passages that are aligned in apps with empty normalized tokens, and where the very next app
        does not contain the witness with a deleted passage. Both of these special cases are aligned with the next following app. 
        
        * In the case of the deleted passages, we wanted to check whether the next following-sibling app contains some of the content, but
        this is tricky and raised problems because it happens far too frequently. (Think of simple deleted letters or generic like "and", etc. Just because those
        characters or words appear in the next app doesn't mean they are relevant for the alignment, and quite often it was better to leave the deleted passage in its
        original app.)
        
        Instead we needed to recognize the real need to move a deleted passage, and it was better to test for this specific alignment problem:
            * A witness with a deleted passage is aligned with emtpy-content witnesses (aligned against meaningless markup), and 
            * the very next following-sibling app contains all witnesses except the one with the deletion. This limits changes that warp
        the alignment. 
        This case captures the need to move: If we left the deleted passage in its original app, it would be comparable with empty space in the Variorum reader, 
        not aligned with any meaningful content.
        
    * To simplify processing, all changes are moved by default from one app to the very next following-sibling app. 
    This stylesheet does not move content backwards to the next preceding-sibling. This seems to work to improve alignments based on
    how collateX is distributing variants in this project: empty passages (representing alignments of markup tokens) tend to precede collation of meaningful variants
    
    ******************************************************************************************** -->
    <xsl:mode on-no-match="shallow-copy"/>
    
    <!-- 2023-01-01 ebb: This is now set to post-process a collection of output files from the Python collation script. 
        It's okay to run over a single file in an output directory but is more versatile for handling batches. 
    -->
    
    <xsl:variable name="collection" as="document-node()+" select="collection('../simpleOutputEpsilon/?select=*.xml')"/>
    
    <xsl:template match="/">
       <xsl:for-each select="$collection">
           <xsl:variable name="filename" as="xs:string" select="current() ! base-uri() ! tokenize(., '/')[last()]"/>
           <xsl:result-document
               href="../postprocOutputEpsilon/{$filename}"
               method="xml" indent="yes">
           <xsl:apply-templates/>
           </xsl:result-document>
       </xsl:for-each> 
    </xsl:template>


    <xsl:function name="fv:ampFix"  as="xs:string">
        <xsl:param name="text" as="item()?"/> 
        <xsl:value-of select="$text ! replace(.,'&amp;amp;','&amp;') ! replace(.,'&amp;quot;', '&#34;') ! replace(.,'andquot;', '&#34;')"/>
    </xsl:function>

    <!-- ********************************************************************************************
        ORPHAN / LONER RDGS: These templates deal with collateX output of app elements 
        containing a solitary MS witness
        
        2022-10-11 yxj and ebb: Originally (with wdjacca and amoebabyte) we were looking for deleted passages, but we have generalized 
        this to search for ANY loner rdg. element We have
        removed this XPath predicate from the @match: [contains(descendant::rdg, '&lt;del')] and handle other kinds of
        deletions in a different template.
     ********************************************************************************************* -->
    <xsl:template match="app[count(descendant::rdg) = 1]" name="mergeLoner">

        <xsl:if test="following-sibling::app[1][count(descendant::rdgGrp) = 1 and count(descendant::rdg) gt 1]">
            <xsl:apply-templates select="following-sibling::app[1]" mode="restructure">
                <xsl:with-param as="node()" name="loner" select="descendant::rdg" tunnel="yes"/>
                <xsl:with-param as="attribute()" name="norm" select="rdgGrp/@n" tunnel="yes"/>
            </xsl:apply-templates>
        </xsl:if>
    </xsl:template>
    
    <!-- ********************************************************************************************
       DELETIONS ALIGNED WITH EMPTY NORMALIZED PASSAGES
       The next template handles app elements that hold an orphaned rdgGrp with a deleted span that's aligned with rdgGrp(s) that are semantically empty (around markup). 
       In these cases, the following-sibling::app tends to hold more meaningful content for comparison. (If we did not move these, they would not appear in the collation view 
       as meaningfully contrasted with passages in the other witnesses.) 
       
       2023-01-01 ebb:With the next template we migrate solitary "orphaned deletions" to the next app. 
       We then rearrange the app wtih the orphaned deletion (preserve it but remove the rdgGrp with the solitary deletion).
       We also destroy the original version of its first following-sibling app.
       
     ********************************************************************************************* -->    

     
    <xsl:template match="app[rdgGrp[@n ! contains(., 'delstart')]/rdg => count() = 1][count(descendant::rdg) gt 1]" name="mergeOutofPlace">
        <xsl:variable name="currentApp" as="element()" select="current()"/>
       <!-- <xsl:variable name="testMatches" as="xs:string+" select="rdgGrp/@n[contains(., 'delstart')] ! substring-after(., '&lt;delstart/&gt;') ! substring-before(., '&lt;delend/&gt;')"/>-->
        <xsl:variable name="delPassageAtt" as="attribute()" select="$currentApp/rdgGrp[@n[contains(., 'delstart')] and rdg => count() = 1]/@n"/>
        <xsl:variable name="otherRdgGrpAtts" as="attribute()+" select="$currentApp/rdgGrp[not(contains(@n, 'delstart'))]/@n"/>
        <xsl:variable name="booleanTest" as="xs:boolean+">
            <xsl:for-each select="$otherRdgGrpAtts">
                <!--<xsl:value-of select="$delPassageAtt ! contains(. ! replace(., '\W', ''), current() ! replace(., '\W', ''))"/>-->
                <xsl:value-of select="matches(., '^\W+$')"/>
                <!-- This means, the other rdgGrps must contain nothing by empty (non-alphanumeric characters) in the normalized tokens.
                That way, there is nothing comparable to the words in the deleted passage. The witness with the deleted passage has just been aligned to witnesses with empty tokens. 
                -->
            </xsl:for-each>
        </xsl:variable>
        <xsl:choose> 
             <xsl:when test="not($currentApp/rdgGrp[@n[contains(., 'delstart')] and rdg => count() = 1]/rdg/@wit = following-sibling::app[1]//rdg/@wit)
                 and $booleanTest => distinct-values() = true()">
                 <xsl:variable name="nextApp" as="element()" select="($currentApp/following-sibling::app)[1]"/>
                 <!-- This test is simply to make sure the very next following-sibling app is missing the witness that carries the deleted passage.  -->
                 <xsl:apply-templates select="$currentApp" mode="reduceCurrentApp">
                     <xsl:with-param name="witToRemove" as="attribute()" select="rdgGrp[@n ! contains(., 'delstart')]/rdg/@wit" tunnel="yes"/>
                 </xsl:apply-templates>
                 <xsl:apply-templates select="($currentApp/following-sibling::app)[1]" mode="restructure">
                     <xsl:with-param as="node()" name="loner" select="$currentApp/rdgGrp[@n[contains(., 'delstart')] and rdg => count() = 1]/rdg" tunnel="yes"/>
                     <xsl:with-param as="attribute()" name="norm" select="$currentApp/rdgGrp[rdg => count() = 1]/@n[contains(., 'delstart')]" tunnel="yes"/>
                  </xsl:apply-templates>
                <!-- <xsl:apply-templates select="$nextApp" mode="removeAppAfterProblemDel"/>-->
            </xsl:when>   
         <xsl:otherwise>
             <xsl:apply-templates mode="copyOriginal" select="$currentApp"/>
         </xsl:otherwise>
       </xsl:choose>
  
    </xsl:template>
    
    <xsl:template match="app" mode="copyOriginal">
       <app> 
           <xsl:apply-templates/>
       </app>
    </xsl:template>

    <!-- **************************************************************************
    DESTRUCTION MODES: Destroy the original app or rdgGrp elements that are being modified by
    this stylesheet.
    ****************************************************************************
    -->
    <xsl:template match="app[preceding-sibling::app[1][count(descendant::rdg) = 1]]" name="removeApp"/>
    <!-- The template above prevents the old unrestructured app from being output with the new one.
    -->
    
    <xsl:template match="app" mode="reduceCurrentApp">
      <xsl:param name="witToRemove" tunnel="yes"/>
        <app>
           <xsl:apply-templates mode="destroy" select="rdgGrp[rdg/@wit = $witToRemove]"/>
                
           <xsl:apply-templates select="rdgGrp[not(rdg/@wit = $witToRemove)]"/>
        </app>
    </xsl:template>
    <!-- 2023-01-01 ebb The template above processes the removal of a rdgGrp contain a witness that is moving to the next following app.
        It alters the source app.
    -->

    <xsl:template match="rdgGrp" mode="destroy"/>
    
    <!--  The next template locates the app elements that met the conditions for accepting deleted passages from a preceding app, 
        and it eliminates the original version. We have set LOTS of predicate conditions set below to make sure we don't eliminate the wrong apps -->
    <xsl:template match="app[preceding-sibling::app[1][rdgGrp[@n ! matches(., '^\W+$')] and rdgGrp[@n ! contains(., 'delstart') and count(rdg) = 1]]][not(.//rdg/@wit = preceding-sibling::app[1]/rdgGrp[@n ! contains(., 'delstart') and count(rdg) = 1]/rdg/@wit)][count(descendant::rdg) gt 1] " 
        name="removeAppAfterProblemDel"/>
    
    
    <!-- **************************************************************************
    RESTRUCTURE MODES: The following templates change the structure of app elements.
    ********************************************************************************
    -->

    <xsl:template match="app" mode="restructure" name="restructureApp">
        <!-- 2022-10-11 yxj ebb: Let's try creating a conditional processing rule here: 
        IF the $norm param only contains `['']` (string-length() = 4), do NOT create a new rdgGrp, and simply move
        the $loner param into the existing structure. 
        
        Example (features a PROBLEM: extra rdg element)
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
            <xsl:apply-templates
                select="rdgGrp[not(preceding::app[1][count(rdgGrp) = 1 and rdgGrp/@n ! string-length() = 4])]"
                mode="restructure">
                <xsl:with-param as="node()" name="loner" tunnel="yes" select="$loner"/>
            </xsl:apply-templates>
            <xsl:choose>
                <xsl:when test="$norm ! string-length() &gt; 4 and descendant::rdg/@wit = $loner/@wit">
                    <xsl:variable name="TokenSquished">
                        <xsl:value-of
                            select="$norm ! string() || descendant::rdgGrp[descendant::rdg[@wit = $loner/@wit]]/@n"/>
                    </xsl:variable>
                    <xsl:variable name="newToken">
                        <xsl:value-of select="replace($TokenSquished, '\]\[', ', ')"/>
                    </xsl:variable>
                    <xsl:variable name="newNorm">
                        <xsl:value-of
                            select="fv:ampFix($newToken)"/>
                    </xsl:variable>
                    <rdgGrp n="{$newNorm}">
                        <rdg wit="{$loner/@wit}">
                            <xsl:value-of
                                select="fv:ampFix($loner/text())"/>
                            <xsl:value-of
                                select="fv:ampFix(descendant::rdg[@wit = $loner/@wit])"
                            />
                        </rdg>
                    </rdgGrp>
                </xsl:when>
                <xsl:when test="not(descendant::rdg/@wit = $loner/@wit)"><!--2023-01-01 ebb: This should handle delstart cases not represented in following apps-->
                    <rdgGrp n="{fv:ampFix($norm)}">
                        <rdg wit="{$loner/@wit}">
                            <xsl:value-of
                                select="fv:ampFix($loner/text())"/>
                        </rdg>
                    </rdgGrp>
                    
                </xsl:when>
                <xsl:otherwise><!-- This handles an empty loner witness and doesn't disturb the rdgGrp structure. -->
                    <xsl:apply-templates select="rdgGrp" mode="emptyNormalize">
                        <xsl:with-param as="text()" name="lonerText" tunnel="yes"
                            select="$loner/text()"/>
                        <xsl:with-param as="xs:string" name="lonerWit" tunnel="yes"
                            select="$loner/@wit"/>
                    </xsl:apply-templates>

                    <!-- 2022-10-18 ebb: Now passing $lonerText, but still doubled output -->

                </xsl:otherwise>
            </xsl:choose>
        </app>
    </xsl:template>

    <xsl:template match="rdgGrp" mode="restructure" name="restructure-rdgGrp">
        <xsl:param name="loner" tunnel="yes"/>
        <!--    <xsl:if test="rdg[@wit != $loner/@wit]">
            <xsl:copy-of select="current()" />
        </xsl:if>-->
        <rdgGrp n="{@n}">
            <xsl:for-each select="rdg">
                <xsl:if test="current()/@wit ne $loner/@wit">
                    <xsl:copy-of select="current()"/>
                </xsl:if>
            </xsl:for-each>
        </rdgGrp>
    </xsl:template>

    <xsl:template match="rdgGrp" mode="emptyNormalize" name="emptyNormalize">
        <xsl:param name="lonerText" tunnel="yes"/>
        <xsl:param name="lonerWit" tunnel="yes"/>
        <rdgGrp n="{@n}">
            <xsl:for-each select="rdg[@wit ne $lonerWit]">
                <xsl:copy-of select="current()"/>
            </xsl:for-each>
            <rdg wit="{$lonerWit}">
                <xsl:value-of select="$lonerText"/>
                <xsl:value-of
                    select="fv:ampFix(current()/rdg[@wit = $lonerWit])"
                />
            </rdg>
        </rdgGrp>
    </xsl:template>
    <!-- 2022-10-18 yxj ebb: For all rdgs, in the normalized @n value, replace 'andquot' to '&#34;', and replace '&amp;' to 'and'.
    In the text nodes (the original text), replace '&amp;quot; to '&#34;', and replace '&amp;amp;' to '&amp;'. 
    This template corrects a problem introduced by the use of expandNode() and node.toxml() in the Python pulldom script, 
    used to output the contents of our added longtoken, add, del, and note (inlineVariationEvent elements). 
    We made the same alterations in the restructured app processing above. It may be a good idea to move this processing to a function. 
    -->
    <xsl:template match="rdg/text()" name="textAmpFix">
        <xsl:value-of select="fv:ampFix(.)"/>
    </xsl:template>
    <xsl:template match="rdgGrp" name="normAmpFix">
        <rdgGrp n="{fv:ampFix(@n)}">
            <xsl:apply-templates/>
        </rdgGrp>
    </xsl:template>

</xsl:stylesheet>
