<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    xmlns:cx="http://interedition.eu/collatex/ns/1.0"
    xmlns:fv="yeah"
    exclude-result-prefixes="xs math fv" version="3.0">
    <!-- ********************************************************************************************
             POST-PROCESSING XSLT FOR THE FRANKENSTEIN VARIORUM: STAGE 2 
       This Stylesheet represents stage 2 of post-processing collation to improve alignments. 
       Run this over the output of postProcessing.xsl
    
    2023-01-01 ebb: Here is a  high-level summary of our second post-processing algorithm:
    In this stage, we are post-processing:
    
     3. app elements that contain less than four witnesses, where those witnesses contain deleted passages
        or longTokens aligned only with themselves. For this we need to look to the first preceding-sibling OR first following-sibling app 
        to find the best location to move the content. 
        
     4. Stranded deleted passages where the contents of the deletion are mostly represented in the next following-sibling::app. Example:
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
        [rdgGrp/@n[contains(., 'delstart')] or descendant::rdg[contains(., 'longToken')]]
        (: checks that it has a deleted passage or longToken... :)
        [preceding-sibling::app[1]/rdgGrp[@n ! matches(., '^\W+$')]/rdg/@wit = descendant::rdg/@wit or
        not(preceding-sibling::app[1]//rdg/@wit = descendant::rdg/@wit) or following-sibling::app[1]/rdgGrp[@n ! matches(., '^\W+$')]/rdg/@wit = descendant::rdg/@wit or not(following-sibling::app[1]//rdg/@wit = descendant::rdg/@wit)]
        (: checks if the first preceding-sibling::app or first following-sibling::app either contains an empty-content rdg for the del/longToken witness OR no matching witness:)
        ">
        <xsl:variable name="currentApp" as="element()" select="current()"/>
        <xsl:variable name="targetRdgGrps" as="element()+" select="rdgGrp[@n ! contains(., 'delstart') or descendant::rdg[contains(., 'longToken')]]"/>
        <xsl:variable name="prevApp" as="element()" select="($currentApp/preceding-sibling::app)[1]"/>
        <xsl:variable name="nextApp" as="element()" select="($currentApp/following-sibling::app)[1]"/>
        <xsl:choose>
            <xsl:when test="preceding-sibling::app[1]/rdgGrp[@n ! matches(., '^\W+$')]/rdg/@wit = descendant::rdg/@wit or following-sibling::app[1]/rdgGrp[@n ! matches(., '^\W+$')]/rdg/@wit = descendant::rdg/@wit">
                <xsl:for-each select="$targetRdgGrps">
                    <xsl:if test="$prevApp[rdgGrp/@n ! matches(., '^\W+$')][rdg/@wit = $currentApp//rdg/@wit] or not($prevApp//rdg/@wit = descendant::rdg/@wit)">
                   <xsl:apply-templates mode="restructure" select="$currentApp/preceding-sibling::app[1]">
                       <xsl:with-param as="node()" name="loner" select="current()/rdg" tunnel="yes"/>
                       <!-- ebb: There will almost certainly be only one rdg if it's a deletion or longToken in this stranded situation. -->
                       <xsl:with-param as="attribute()" name="norm" select="current()/@n" tunnel="yes"/>
                   </xsl:apply-templates>
                    </xsl:if>
                    <xsl:if test="$nextApp[rdgGrp/@n ! matches(., '^\W+$')][rdg/@wit = $currentApp//rdg/@wit] or not($nextApp//rdg/@wit = descendant::rdg/@wit)">
                        <xsl:apply-templates mode="restructure" select="$currentApp/following-sibling::app[1]">
                            <xsl:with-param as="node()" name="loner" select="current()/rdg" tunnel="yes"/>
                            <!-- ebb: There will almost certainly be only one rdg if it's a deletion or longToken in this stranded situation. -->
                            <xsl:with-param as="attribute()" name="norm" select="current()/@n" tunnel="yes"/>
                        </xsl:apply-templates>
                    </xsl:if>
                </xsl:for-each>
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
    
 <!-- *************************
    Handles del, add, note, or longToken sequestered tokens where most of the content is in
    following-sibling::app[1]
    
    Example from C-13:
       <app>
      <rdgGrp n="['&lt;delstart/&gt;our father looks so sorrowful:', 'this dreadful event seems to have revived in his mind his grief on the death of mamma.', 'poor elizabeth also is quite inconsolable.&#34;&lt;delend/&gt;', '&lt;addedthomas-start/&gt;the sense of our misfortune is yet unalleviated; the silence of our father is uninterrupted, and there is something more distressing than tears in his unaltered sadness—while poor elizabeth, seeking solitude and for ever weeping, already begins to feel the effects of incessant grief—for her colour is gone, and her eyes are hollow and lustreless&lt;addedthomas-end/&gt;']">
         <rdg wit="fThomas">&lt;del rend="strikethrough"&gt;Our father looks so sorrowful: this dreadful event seems to have revived in his mind his grief on the death of Mamma. Poor Elizabeth also is quite inconsolable.”&lt;/del&gt; &lt;add&gt;the sense of our misfortune is yet unalleviated; the silence of our father is uninterrupted, and there is something more distressing than tears in his unaltered sadness—while poor Elizabeth, seeking solitude and for ever weeping, already begins to feel the effects of incessant grief—for her colour is gone, and her eyes are hollow &amp; lustreless&lt;/add&gt;</rdg>
      </rdgGrp>
      <rdgGrp n="['our']">
         <rdg wit="f1818">Our</rdg>
         <rdg wit="f1823">Our</rdg>
         <rdg wit="fMS">&lt;sga-add eID="c56-0086__main__d5e18427"/&gt;&lt;sga-add place="superlinear" sID="c56-0086__main__d5e18433"/&gt;our</rdg>
      </rdgGrp>
   </app>
   <app>
      <rdgGrp n="['', 'father looks so sorrowful', 'and', 'it']">
         <rdg wit="fMS">&lt;sga-add eID="c56-0086__main__d5e18433"/&gt; &lt;longToken&gt;father looks so sorrowful&lt;/longToken&gt; and it</rdg>
      </rdgGrp>
      <rdgGrp n="['father looks so sorrowful:', 'this', 'dreadful', 'event']">
         <rdg wit="f1818">&lt;longToken&gt;father looks so sorrowful:&lt;/longToken&gt; this dreadful event</rdg>
         <rdg wit="f1823">&lt;longToken&gt;father looks so sorrowful:&lt;/longToken&gt; this dreadful event</rdg>
      </rdgGrp>
   </app>

************************* -->
    
    <!-- BUGGY TEMPLATE: generates ambiguous rule matches -->
<xsl:template match="app[rdgGrp/@n[contains(., 'delstart') or contains(., 'note_start') or contains(., 'addedThomas')] or descendant::rdg[contains(., 'longToken')]]">
    <xsl:variable name="currentApp" as="element()" select="current()"/>
    <xsl:variable name="testFollowingApp" as="xs:boolean+">
        <xsl:for-each select="rdgGrp/@n ! tokenize(., ',') ! replace(., '&lt;.+?&gt;', '')">          <xsl:variable name="currToken" as="xs:string" select="current()"/>         
            <xsl:for-each select="$currentApp/following-sibling::app[1]/rdgGrp/@n">   
            <xsl:value-of select="contains(., $currToken)"/>
            </xsl:for-each>
        </xsl:for-each> 
        
        
    </xsl:variable>
    <xsl:if test="$testFollowingApp = true()">
     
        
        <xsl:text>SHOUT!</xsl:text>
        
        
    </xsl:if>
</xsl:template>
    
    
    <!-- **************************************************************************
    DESTRUCTION MODES: Destroy the original app or rdgGrp elements that are being modified by
    this stylesheet.
    ****************************************************************************
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
        [following-sibling::app[1][count(descendant::rdg) gt 1 and count(descendant::rdg) lt 4][rdgGrp/@n[contains(., 'delstart')] or descendant::rdg[contains(., 'longToken')]]]" 
        name="removeAppBeforeStrandedDel"/>
    
    <xsl:template match="app[rdgGrp[@n ! matches(., '^\W+$')]/rdg/@wit = descendant::rdg/@wit or
        not(preceding-sibling::app[1]//rdg/@wit = descendant::rdg/@wit)]
        [preceding-sibling::app[1][count(descendant::rdg) gt 1 and count(descendant::rdg) lt 4][rdgGrp/@n[contains(., 'delstart')] or descendant::rdg[contains(., 'longToken')]]]" 
        name="removeAppBeforeAfterStrandedDel"/>
    
    
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
                select="rdgGrp[not(preceding::app[1][count(rdgGrp) = 1 and rdgGrp/@n ! string-length() = 4])]" mode="restructure">
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
                            select="$newToken"/>
                    </xsl:variable>
                    <rdgGrp n="{$newNorm}">
                        <rdg wit="{$loner/@wit}">
                            <xsl:value-of
                                select="$loner/text()"/>
                            <xsl:value-of
                                select="descendant::rdg[@wit = $loner/@wit]"
                            />
                        </rdg>
                    </rdgGrp>
                </xsl:when>
                <xsl:when test="not(descendant::rdg/@wit = $loner/@wit)"><!--2023-01-01 ebb: This should handle delstart cases not represented in following apps-->
                    <rdgGrp n="{$norm}">
                        <rdg wit="{$loner/@wit}">
                            <xsl:value-of
                                select="$loner/text()"/>
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
                    select="current()/rdg[@wit = $lonerWit]"
                />
            </rdg>
        </rdgGrp>
    </xsl:template>

</xsl:stylesheet>
