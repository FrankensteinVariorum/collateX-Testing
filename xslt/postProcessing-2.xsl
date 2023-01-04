<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    xmlns:cx="http://interedition.eu/collatex/ns/1.0"
    xmlns:fv="yeah"
    exclude-result-prefixes="xs math fv" version="3.0">
    <!-- ********************************************************************************************
           2023-01-04 ebb: DO NOT RUN THIS YET: IT COULD MUNCH APPS!
           If it finds an <app> to move, but cannot successfully move it, the result can destroy all trace
           of the rdgGrps being moved. The destruction occurs in the restructure template. 
           We are seeing ambiguous rule match errors on the templates for destruction and restructure modes, not a good sign. 

            
            
            POST-PROCESSING XSLT FOR THE FRANKENSTEIN VARIORUM: STAGE 2 
       This Stylesheet represents stage 2 of post-processing collation to improve alignments. 
       Run this over the output of postProcessing.xsl
    
    2023-01-01 ebb: Here is a  high-level summary of our second post-processing algorithm:
    In this stage, we are post-processing:
    
     3. app elements that contain less than four witnesses, where those witnesses contain deleted passages
        or longTokens aligned only with themselves. For this we need to look to the first preceding-sibling OR first following-sibling app 
        to find the best location to move the content. 

    ******************************************************************************************** -->
    <xsl:mode on-no-match="shallow-copy"/>
    
    <!--*****************************************************************************************
        FILE HANDLING: INPUTS AND OUTPUTS
        2023-01-01 ebb: This is now set to post-process a collection of output files from the Python collation script. 
        It's okay to run over a single file in an output directory but is more versatile for handling batches. 
    **************************************************************************************
    -->
    
    <xsl:variable name="collection" as="document-node()+" select="collection('../postprocOutputEpsilon/?select=*.xml')"/>
    
    <xsl:template match="/">
       <xsl:for-each select="$collection">
           <xsl:variable name="filename" as="xs:string" select="current() ! base-uri() ! tokenize(., '/')[last()]"/>
           <xsl:result-document
               href="../postprocOutputEpsilon-2/{$filename}"
               method="xml" indent="yes">
           <xsl:apply-templates/>
           </xsl:result-document>
       </xsl:for-each> 
    </xsl:template>

    <!-- ********************************************************************************************
       DELETIONS (OR LONGTOKENS) ALIGNED WITH ONLY THEMSELVES
      2023-01-01 ebb: Reviewing the collation of C13, I discover this phenomenon. It may be rare, but it seems like 
      a predictable pattern:
      
        <app>
      <rdgGrp n="['']">
         <rdg wit="fThomas">&lt;pb xml:id="F1818_v1_163" n="151"/&gt; </rdg>
         <rdg wit="fMS">&lt;sga-add eID="c56-0084__main__d5e18134"/&gt; </rdg>
      </rdgGrp>
      <rdgGrp n="['and then']">
         <rdg wit="f1831">&lt;longToken&gt;And then&lt;/longToken&gt; </rdg>
      </rdgGrp>
      <rdgGrp n="['besides,']">
         <rdg wit="f1818">&lt;pb xml:id="F1818_v1_163" n="151"/&gt;Besides, </rdg>
         <rdg wit="f1823">Besides, </rdg>
      </rdgGrp>
   </app>
   <app>
      <rdgGrp n="['&lt;delstart/&gt;besides&lt;delend/&gt;', '&lt;addedthomas-start/&gt;and&lt;addedthomas-end/&gt;', ',']">
         <rdg wit="fThomas">&lt;del rend="strikethrough"&gt;Besides&lt;/del&gt; &lt;add place="margin"&gt;And&lt;/add&gt; , </rdg>
      </rdgGrp>
      <rdgGrp n="['–', '&lt;delstart/&gt;the com&lt;delend/&gt;', 'mon', 'people', 'would', 'believe', 'it', 'to', 'be', 'a', 'real', 'devil', 'and', 'who', 'could', 'attempt', 'besides']">
         <rdg wit="fMS">– &lt;del rend="strikethrough" xml:id="c56-0084__main__d5e18152"&gt;the com&lt;/del&gt; &lt;lb n="c56-0085__main__1"/&gt;mon people would believe it to &lt;lb n="c56-0085__main__2"/&gt;be a real devil and who could attempt &lt;lb n="c56-0085__left_margin__1"/&gt;Besides </rdg>
      </rdgGrp>
   </app>
      
      
      This is the first time I've seen a case where we should move a special passage to an immediately preceding app. 
      It may sometimes happen with longToken passages or delstart....delend passages. Because Thomas AND fMS are involved, this wouldn't
      be picked up as a loner rdgGrp and runs the risk of being invisible in the Variorum viewer unless moved. 
      
      WHAT TO DO:
      1. Spot the pattern: 
         * app contains less than 4 rdg elements, and may have one more more rdgGrp 
         * (If it only had one rdgGrp and one rdg it would be picked up by our other postprocessing templates)
         * rdgGrp/@n contains "delstart" or rdg contains longToken
         
     2. Look at first preceding-sibling app for 
         * matching content in their rdgGrp/@n 
         * the outright absence of the rdg/@wit present in this app
         * the presence of the witnesses but with empty (non-meaningful) content in rdgGrp/@n 
         * NOTE: we run into ambiguous rule matches with the restructuring templates that move the other direction.
         So maybe best to ONLY handle preceding-sibling restructuring here?
         
     3. Where we find this, we move to process and restructure those apps (and delete their original forms)

     ********************************************************************************************* -->    

    <xsl:template match="app[count(descendant::rdg) gt 1 and count(descendant::rdg) lt 4]
        (:looks for an app with suspiciously few rdg elements...  :)
       (: [rdgGrp/@n[contains(., 'delstart')] or descendant::rdg[contains(., 'longToken')]] :)
        (: checks that it has a deleted passage or longToken. CAREFUL: THIS CAN RESULT IN MUNGING THINGS! .. :)
        [preceding-sibling::app[1]/rdgGrp[@n ! matches(., '^\W+$')]/rdg/@wit = descendant::rdg/@wit or
        not(preceding-sibling::app[1]//rdg/@wit = descendant::rdg/@wit) or following-sibling::app[1]/rdgGrp[@n ! matches(., '^\W+$')]/rdg/@wit = descendant::rdg/@wit or not(following-sibling::app[1]//rdg/@wit = descendant::rdg/@wit)]
        (: checks if the first preceding-sibling::app or first following-sibling::app either contains an empty-content rdg for the del/longToken witness OR no matching witness:)
        ">
        <xsl:variable name="currentApp" as="element()" select="current()"/>
      <!--  <xsl:variable name="targetRdgGrps" as="element()+" select="(rdgGrp[@n ! contains(., 'delstart') or descendant::rdg[contains(., 'longToken')]])"/>-->
        <xsl:variable name="targetRdgGrps" as="element()+" select="rdgGrp"/>
        <xsl:variable name="prevApp" as="element()" select="$currentApp/preceding-sibling::app[1]"/>
        <xsl:variable name="nextApp" as="element()" select="$currentApp/following-sibling::app[1]"/>
        <xsl:choose>
            <xsl:when test="preceding-sibling::app[1]/rdgGrp[@n ! matches(., '^\W+$')]/rdg/@wit = descendant::rdg/@wit or following-sibling::app[1]/rdgGrp[@n ! matches(., '^\W+$')]/rdg/@wit = descendant::rdg/@wit">

                <xsl:if test="$prevApp[rdgGrp/@n[matches(., '^\W+$')] and descendant::rdg/@wit = $currentApp//rdg/@wit] or not($prevApp//rdg/@wit = $currentApp//rdg/@wit)">
                    <xsl:apply-templates mode="restructure" select="$prevApp">
                        <xsl:with-param as="node()+" name="misplacedRdgGrps" select="$targetRdgGrps" tunnel="yes"/>
                        <xsl:with-param as="xs:string" name="whereMoving" select="'backward'" tunnel="yes"/>
                    </xsl:apply-templates>
                </xsl:if>
          <xsl:if test="$nextApp[rdgGrp/@n[matches(., '^\W+$')] and descendant::rdg/@wit = $currentApp//rdg/@wit] or not($nextApp//rdg/@wit = $currentApp//rdg/@wit)">
                    <xsl:apply-templates mode="restructure" select="$nextApp">
                        <xsl:with-param as="element()+" name="misplacedRdgGrps" select="$targetRdgGrps" tunnel="yes"/>
                        <xsl:with-param as="xs:string" name="whereMoving" select="'forward'" tunnel="yes"/>
                    </xsl:apply-templates>
                </xsl:if>
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

    
    <!--  The next two templates locates the app elements that met the conditions for accepting deleted or longToken passages from a following OR preceding app, 
        and it eliminates the original version. 
      
        app[count(descendant::rdg) gt 1 and count(descendant::rdg) lt 4]
        (:looks for an app with suspiciously few rdg elements...  :)
        [rdgGrp/@n[contains(., 'delstart')] or descendant::rdg[contains(., 'longToken')]]
        (: checks that it has a deleted passage or longToken... :)
        [preceding-sibling::app[1]/rdgGrp[@n ! matches(., '^\W+$')]/rdg/@wit = descendant::rdg/@wit or
        not(preceding-sibling::app[1]//rdg/@wit = descendant::rdg/@wit) or following-sibling::app[1]/rdgGrp[@n ! matches(., '^\W+$')]/rdg/@wit = descendant::rdg/@wit or not(following-sibling::app[1]//rdg/@wit = descendant::rdg/@wit)]
        (: checks if the first preceding-sibling::app or first following-sibling::app either contains an empty-content rdg for the del/longToken witness OR no matching witness:)

        -->
    
    <xsl:template match="app[rdgGrp[@n ! matches(., '^\W+$')]/rdg/@wit = descendant::rdg/@wit or
        not(following-sibling::app[1]//rdg/@wit = descendant::rdg/@wit)]
        [following-sibling::app[1][count(descendant::rdg) gt 1 and count(descendant::rdg) lt 4](:[rdgGrp/@n[contains(., 'delstart')] or descendant::rdg[contains(., 'longToken')]]:)]" 
        name="removeAppBeforeStrandedDel"/>
    
      <xsl:template match="app[rdgGrp[@n ! matches(., '^\W+$')]/rdg/@wit = descendant::rdg/@wit or
        not(preceding-sibling::app[1]//rdg/@wit = descendant::rdg/@wit)]
        [preceding-sibling::app[1][count(descendant::rdg) gt 1 and count(descendant::rdg) lt 4](:[rdgGrp/@n[contains(., 'delstart')] or descendant::rdg[contains(., 'longToken')]]:)]" 
        name="removeAppAfterStrandedDel"/>
    
    
    <!-- **************************************************************************
    RESTRUCTURE MODES: The following templates change the structure of app elements.
    ********************************************************************************
    -->

    <xsl:template match="app" mode="restructure" name="restructureApp">
        <xsl:param name="misplacedRdgGrps" tunnel="yes"/>
        <xsl:param name="whereMoving" tunnel="yes"/>
        <xsl:variable name="currentApp" as="element()" select="current()"/>

        <app><xsl:comment>YO! I'M BEING RESTRUCTURED HERE! </xsl:comment>
            <xsl:variable name="testMatcher" as="xs:string" select="string-join($misplacedRdgGrps/rdg/@wit)"/>
            <xsl:variable name="matchRdgGrp" as="xs:string*">
                <xsl:for-each select="$currentApp//rdg[contains($testMatcher, @wit)]">
                    <xsl:value-of select="current()/parent::rdgGrp/@n ! string()"/>
                </xsl:for-each>
            </xsl:variable>
            <xsl:message>What is matchRdgGrp? <xsl:value-of select="$matchRdgGrp"/></xsl:message>
           
            <xsl:variable name="otherRdgGrp" as="node()+">
                <xsl:for-each select="$currentApp//rdg[not(contains($testMatcher, @wit))]">
                    <xsl:copy-of select="current()/parent::rdgGrp"/>
                </xsl:for-each>
            </xsl:variable>
            
         <xsl:for-each select="$matchRdgGrp => distinct-values()">
             <!-- This should match on the rdgGrp @n attribute values that contain the same reading witnesses as the misplacedRdgGrps. -->
             <xsl:variable name="matchWitnesses" as="xs:string+" select="$currentApp/rdgGrp[@n = current()]//rdg/@wit ! string()"/>
             <xsl:variable name="matchingMisplacedRdgGrps" as="element()+">
                 <xsl:for-each select="$matchWitnesses">
                     <xsl:copy-of select="$misplacedRdgGrps[rdg/@wit = current()]"/>
                 </xsl:for-each>
             </xsl:variable>
             <xsl:variable name="matchNorm" as="xs:string" select="current() ! string()"/>
             <xsl:variable name="misplacedNorms" as="xs:string+" select="$matchingMisplacedRdgGrps/@n ! string()"/>
             <xsl:choose>
                 <xsl:when test="$misplacedNorms => distinct-values() => count() gt 1">
                <xsl:for-each select="$misplacedNorms"> 
                    <xsl:variable name="TokenSquished">
                         <xsl:choose>
                             <xsl:when test="$whereMoving = 'backward'"> 
                                 <xsl:value-of select="$matchNorm || current()"/>
                             </xsl:when>
                             <xsl:when test="$whereMoving = 'forward'"> 
                                 <xsl:value-of select="current() || $matchNorm"/>
                             </xsl:when>
                         </xsl:choose>
             </xsl:variable>
             <xsl:variable name="newNorm">
                 <xsl:value-of select="replace($TokenSquished, '\]\[', ', ')"/>
             </xsl:variable>

                          <rdgGrp n="$newNorm">
                              <xsl:for-each select="$matchWitnesses">
                                  <rdg wit="{current()}">
                                      <xsl:choose>
                                          <xsl:when test="$whereMoving = 'backward'">
                                              <xsl:value-of select="$currentApp//rdg[@wit=current()]"/>
                                              <xsl:value-of select="$misplacedRdgGrps/rdg[@wit=current()]"/>
                                          </xsl:when>
                                          <xsl:when test="$whereMoving = 'forward'">
                                              <xsl:value-of select="$misplacedRdgGrps/rdg[@wit=current()]"/>
                                              <xsl:value-of select="$currentApp//rdg[@wit=current()]"/>
                                          </xsl:when>
                                      </xsl:choose>
                                      
                                  </rdg>
                              </xsl:for-each> 
                          </rdgGrp>
                </xsl:for-each>
                 </xsl:when>
                 <xsl:otherwise>
                     <xsl:variable name="TokenSquished">
                         <xsl:choose>
                             <xsl:when test="$whereMoving = 'backward'"> 
                                 <xsl:value-of select="$matchNorm || $misplacedNorms"/>
                             </xsl:when>
                             <xsl:when test="$whereMoving = 'forward'"> 
                                 <xsl:value-of select="$misplacedNorms || $matchNorm"/>
                             </xsl:when>
                         </xsl:choose>
                     </xsl:variable>
                     <xsl:variable name="newNorm">
                         <xsl:value-of select="replace($TokenSquished, '\]\[', ', ')"/>
                     </xsl:variable>
                     
                     <rdgGrp n="$newNorm">
                         <xsl:for-each select="$matchWitnesses">
                             <rdg wit="{current()}">
                                 <xsl:choose>
                                     <xsl:when test="$whereMoving = 'backward'">
                                         <xsl:value-of select="$currentApp//rdg[@wit=current()]"/>
                                         <xsl:value-of select="$misplacedRdgGrps/rdg[@wit=current()]"/>
                                     </xsl:when>
                                     <xsl:when test="$whereMoving = 'forward'">
                                         <xsl:value-of select="$misplacedRdgGrps/rdg[@wit=current()]"/>
                                         <xsl:value-of select="$currentApp//rdg[@wit=current()]"/>
                                     </xsl:when>
                                 </xsl:choose>
                                 
                             </rdg>
                         </xsl:for-each> 
                     </rdgGrp>
                     
                 </xsl:otherwise>
                 
             </xsl:choose>
=
         </xsl:for-each>
        </app>

          
     
             
       
           
            
            
            
   <!--         <xsl:for-each select="$misplacedRdgGrps">
                <xsl:variable name="misplacedNormAtt" as="attribute()" select="current()/@n"/>
                <xsl:variable name="misplacedRdgs" as="element()+" select="current()/rdg"/>
                <xsl:for-each select="$misplacedRdgs">
                    <xsl:choose>
                        <xsl:when test="$currentApp//rdg[@wit = current()/@wit]">
                            <xsl:variable name="matchWit" as="text()" select="$currentApp//rdg[@wit = current()/@wit]/text()"/>
                            <xsl:variable name="matchNorm" as="xs:string" select="$matchWit/ancestor::rdgGrp/@n ! string()"/>
                            <xsl:variable name="TokenSquished">
                                <xsl:choose>
                                    <xsl:when test="$whereMoving = 'backward'"> 
                                        <xsl:value-of select="$matchNorm || $misplacedNormAtt ! string()"/>
                                    </xsl:when>
                                    <xsl:when test="$whereMoving = 'forward'"> 
                                        <xsl:value-of select="$misplacedNormAtt || $matchNorm"/>
                                    </xsl:when>
                                </xsl:choose>
                            </xsl:variable>
                            <xsl:variable name="newNorm">
                                <xsl:value-of select="replace($TokenSquished, '\]\[', ', ')"/>
                            </xsl:variable>
                            <rdgGrp n="{$newNorm}">
                                <rdg wit="{@wit}">
                                    <xsl:choose>
                                        <xsl:when test="$whereMoving = 'backward'">
                                            <xsl:value-of select="$matchWit"/>
                                            <xsl:value-of select="current()"/>
                                        </xsl:when>
                                        <xsl:when test="$whereMoving = 'forward'">
                                            <xsl:value-of select="current()"/>
                                            <xsl:value-of select="$matchWit"/>
                                        </xsl:when>
                                    </xsl:choose>
                                    
                                </rdg>
                            </rdgGrp>
                            
                        </xsl:when>
                        <xsl:otherwise>
                            <!-\- There is no matching rdg in the app -\->
                            <rdgGrp n="{$misplacedNormAtt}">
                                <xsl:copy-of select="current()"/>
                            </rdgGrp>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:for-each>
            </xsl:for-each>-->
            
            
           <!--<xsl:for-each select="rdgGrp[not(rdg/@wit = $misplacedRdgGrps/rdg/@wit)]">
               <xsl:comment><xsl:value-of select="$misplacedRdgGrps/rdg/@wit"/></xsl:comment>
               <!-\- The comment above shows me that in C14RA (app toward the end), the only witness being recognized is f1831, NOT the other two.
               Think WHY: We only looked for longToken or del...OR the idea of the next/prev app NOT HAVING the witness at all.  f1831 isn't present
               in the next witness, so it's delivered, but the others are not. Should we expand the scope of our transformation? 
               * Move ANYTHING that is bearing meaningful content forward to the prev or next app that either lacks the witness entirely or carries
               only empty content.
               -\->
               <xsl:copy-of select="current()"/><xsl:comment>It's Me</xsl:comment>
           </xsl:for-each>-->
         <!--  <xsl:for-each select="rdgGrp[rdg/@wit = $misplacedRdgGrps/rdg/@wit]/rdg">
                <xsl:variable name="thisMisplacedNorm" as="attribute()+" select="$misplacedRdgGrps/@n"/>
                <xsl:message><xsl:value-of select="$thisMisplacedNorm"/></xsl:message>
                <xsl:variable name="thisMisplacedRdg" as="element()+" select="$misplacedRdgGrps[rdg/@wit = current()/@wit]/rdg"/>
                <xsl:message><xsl:value-of select="$thisMisplacedRdg"/></xsl:message>
               <!-\- 2023-01-04 ebb: WE"RE HAVING TROUBLE HERE WITH PROCESSING MULTIPLE RDG ELEMENTS IN TWO RDGGRPS.  -\->
                <xsl:variable name="TokenSquished">
                   <xsl:choose>
                       <xsl:when test="$whereMoving = 'backward'"> 
                           <xsl:value-of select="current()/parent::rdgGrp/@n ! string() || $thisMisplacedNorm ! string()"/>
                       </xsl:when>
                       <xsl:when test="$whereMoving = 'forward'"> 
                           <xsl:value-of select="$thisMisplacedNorm ! string() || current()/parent::rdgGrp/@n ! string()"/>
                       </xsl:when>
                   </xsl:choose>
                </xsl:variable>
                <xsl:variable name="newNorm">
                    <xsl:value-of select="replace($TokenSquished, '\]\[', ', ')"/>
                </xsl:variable>
                <rdgGrp n="{$newNorm}">
                   <xsl:for-each select="$thisMisplacedRdg"> 
                       <rdg wit="{current()/@wit}">
                        <xsl:choose>
                            <xsl:when test="$whereMoving = 'backward'">
                                <xsl:value-of select="$currentApp//rdg[@wit=current()/@wit]"/>
                                <xsl:value-of select="current()"/>
                            </xsl:when>
                            <xsl:when test="$whereMoving = 'forward'">
                                <xsl:value-of select="current()"/>
                                <xsl:value-of select="$currentApp//rdg[@wit=current()/@wit]"/>
                            </xsl:when>
                        </xsl:choose>
                    </rdg>
                   </xsl:for-each>
                </rdgGrp>
            </xsl:for-each>-->

    </xsl:template>

</xsl:stylesheet>
