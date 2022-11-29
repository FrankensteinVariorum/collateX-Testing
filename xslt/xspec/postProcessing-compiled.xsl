<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                exclude-result-prefixes="#all"
                version="3.0">
   <!-- the tested stylesheet -->
   <xsl:import href="file:/C:/Users/Jessie/Documents/Github/fv/collateX-Testing/xslt/postProcessing.xsl"/>
   <!-- XSpec library modules providing tools -->
   <xsl:include href="file:/C:/Users/Jessie/AppData/Roaming/com.oxygenxml/extensions/v23.1/frameworks/https_www.oxygenxml.com_InstData_Addons_community_updateSite.xml/xspec.support-2.2.5/src/common/runtime-utils.xsl"/>
   <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}stylesheet-uri"
                 as="Q{http://www.w3.org/2001/XMLSchema}anyURI">file:/C:/Users/Jessie/Documents/Github/fv/collateX-Testing/xslt/postProcessing.xsl</xsl:variable>
   <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}xspec-uri"
                 as="Q{http://www.w3.org/2001/XMLSchema}anyURI">file:/C:/Users/Jessie/Documents/Github/fv/collateX-Testing/xslt/postProcessing.xspec</xsl:variable>
   <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}is-external"
                 as="Q{http://www.w3.org/2001/XMLSchema}boolean"
                 select="false()"/>
   <xsl:variable xmlns:xs="http://www.w3.org/2001/XMLSchema"
                 name="Q{urn:x-xspec:compile:impl}thread-aware"
                 as="xs:boolean"
                 select="(system-property('Q{http://www.w3.org/1999/XSL/Transform}product-name') eq 'SAXON') and starts-with(system-property('Q{http://www.w3.org/1999/XSL/Transform}product-version'), 'EE ')"
                 static="yes"/>
   <xsl:variable name="Q{urn:x-xspec:compile:impl}logical-processor-count"
                 as="Q{http://www.w3.org/2001/XMLSchema}integer"
                 use-when="$Q{urn:x-xspec:compile:impl}thread-aware"
                 select="Q{java:java.lang.Runtime}getRuntime() =&gt; Q{java:java.lang.Runtime}availableProcessors()"/>
   <xsl:variable name="Q{urn:x-xspec:compile:impl}thread-count"
                 as="Q{http://www.w3.org/2001/XMLSchema}integer"
                 select="1"
                 use-when="$Q{urn:x-xspec:compile:impl}thread-aware =&gt; not()"/>
   <xsl:variable name="Q{urn:x-xspec:compile:impl}variable-d58e3-doc"
                 as="document-node()"
                 select="doc('file:/C:/Users/Jessie/Documents/Github/fv/collateX-Testing/xslt/unitTesting.xml')"/>
   <xsl:variable xmlns:x="http://www.jenitennison.com/xslt/xspec"
                 name="Q{}infile"
                 as="document-node()"
                 select="$Q{urn:x-xspec:compile:impl}variable-d58e3-doc ! ( . )"/>
   <!-- the main template to run the suite -->
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}main"
                 as="empty-sequence()">
      <xsl:context-item use="absent"/>
      <!-- info message -->
      <xsl:message>
         <xsl:text>Testing with </xsl:text>
         <xsl:value-of select="system-property('Q{http://www.w3.org/1999/XSL/Transform}product-name')"/>
         <xsl:text> </xsl:text>
         <xsl:value-of select="system-property('Q{http://www.w3.org/1999/XSL/Transform}product-version')"/>
      </xsl:message>
      <!-- set up the result document (the report) -->
      <xsl:result-document format="Q{{http://www.jenitennison.com/xslt/xspec}}xml-report-serialization-parameters">
         <xsl:element name="report" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:attribute name="xspec" namespace="">file:/C:/Users/Jessie/Documents/Github/fv/collateX-Testing/xslt/postProcessing.xspec</xsl:attribute>
            <xsl:attribute name="stylesheet" namespace="">file:/C:/Users/Jessie/Documents/Github/fv/collateX-Testing/xslt/postProcessing.xsl</xsl:attribute>
            <xsl:attribute name="date" namespace="" select="current-dateTime()"/>
            <!-- invoke each compiled top-level x:scenario -->
            <xsl:for-each select="1 to 6">
               <xsl:choose>
                  <xsl:when test=". eq 1">
                     <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}x645b9013-0c8d-3c92-ae53-9216f2a60443"/>
                  </xsl:when>
                  <xsl:when test=". eq 2">
                     <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}x18929eca-33b4-34df-ba59-bfec579288a4"/>
                  </xsl:when>
                  <xsl:when test=". eq 3">
                     <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}xe708bb62-a42b-3e71-b5bb-fcbd643d86c5"/>
                  </xsl:when>
                  <xsl:when test=". eq 4">
                     <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}x2ff013dc-fad0-347f-8d27-8f5c3eedf174"/>
                  </xsl:when>
                  <xsl:when test=". eq 5">
                     <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}xea9320dd-491e-327e-8d5c-b066e3cf7c73"/>
                  </xsl:when>
                  <xsl:when test=". eq 6">
                     <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}xae6f131d-491c-3eb4-929c-e03263392a11"/>
                  </xsl:when>
                  <xsl:otherwise>
                     <xsl:message terminate="yes">ERROR: Unhandled scenario invocation</xsl:message>
                  </xsl:otherwise>
               </xsl:choose>
            </xsl:for-each>
         </xsl:element>
      </xsl:result-document>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}x645b9013-0c8d-3c92-ae53-9216f2a60443"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}scenario)">
      <xsl:context-item use="absent"/>
      <xsl:message>Scenario for testing template with match 'app[count(descendant::rdg) = 1]</xsl:message>
      <xsl:element name="scenario" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">x645b9013-0c8d-3c92-ae53-9216f2a60443</xsl:attribute>
         <xsl:attribute name="xspec" namespace="">file:/C:/Users/Jessie/Documents/Github/fv/collateX-Testing/xslt/postProcessing.xspec</xsl:attribute>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>Scenario for testing template with match 'app[count(descendant::rdg) = 1]</xsl:text>
         </xsl:element>
         <xsl:element name="input-wrap" namespace="">
            <xsl:element name="x:context" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:element name="app" namespace="">
                  <xsl:namespace name="x">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
                  <xsl:element name="rdgGrp" namespace="">
                     <xsl:namespace name="x">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
                     <xsl:attribute xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                    name="n"
                                    namespace=""
                                    select="'', ''"
                                    separator="['never']"/>
                     <xsl:element name="rdg" namespace="">
                        <xsl:namespace name="x">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
                        <xsl:attribute xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                       name="wit"
                                       namespace=""
                                       select="'', ''"
                                       separator="fMS"/>
                        <xsl:text>never </xsl:text>
                     </xsl:element>
                  </xsl:element>
               </xsl:element>
               <xsl:element name="app" namespace="">
                  <xsl:namespace name="x">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
                  <xsl:element name="rdgGrp" namespace="">
                     <xsl:namespace name="x">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
                     <xsl:attribute xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                    name="n"
                                    namespace=""
                                    select="'', ''"
                                    separator="['never']"/>
                     <xsl:element name="rdg" namespace="">
                        <xsl:namespace name="x">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
                        <xsl:attribute xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                       name="wit"
                                       namespace=""
                                       select="'', ''"
                                       separator="f1818"/>
                        <xsl:text>never </xsl:text>
                     </xsl:element>
                     <xsl:element name="rdg" namespace="">
                        <xsl:namespace name="x">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
                        <xsl:attribute xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                       name="wit"
                                       namespace=""
                                       select="'', ''"
                                       separator="f1823"/>
                        <xsl:text>never </xsl:text>
                     </xsl:element>
                     <xsl:element name="rdg" namespace="">
                        <xsl:namespace name="x">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
                        <xsl:attribute xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                       name="wit"
                                       namespace=""
                                       select="'', ''"
                                       separator="fThomas"/>
                        <xsl:text>never </xsl:text>
                     </xsl:element>
                     <xsl:element name="rdg" namespace="">
                        <xsl:namespace name="x">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
                        <xsl:attribute xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                       name="wit"
                                       namespace=""
                                       select="'', ''"
                                       separator="f1831"/>
                        <xsl:text>never </xsl:text>
                     </xsl:element>
                     <xsl:element name="rdg" namespace="">
                        <xsl:namespace name="x">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
                        <xsl:attribute xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                       name="wit"
                                       namespace=""
                                       select="'', ''"
                                       separator="fMS"/>
                        <xsl:text>&lt;lb n="c56-0103__main__19"/&gt;never </xsl:text>
                     </xsl:element>
                  </xsl:element>
               </xsl:element>
            </xsl:element>
         </xsl:element>
         <xsl:variable name="Q{urn:x-xspec:compile:impl}context-d60e0-doc"
                       as="document-node()">
            <xsl:document>
               <xsl:element name="app" namespace="">
                  <xsl:namespace name="x">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
                  <xsl:element name="rdgGrp" namespace="">
                     <xsl:namespace name="x">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
                     <xsl:attribute xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                    name="n"
                                    namespace=""
                                    select="'', ''"
                                    separator="['never']"/>
                     <xsl:element name="rdg" namespace="">
                        <xsl:namespace name="x">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
                        <xsl:attribute xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                       name="wit"
                                       namespace=""
                                       select="'', ''"
                                       separator="fMS"/>
                        <xsl:text>never </xsl:text>
                     </xsl:element>
                  </xsl:element>
               </xsl:element>
               <xsl:element name="app" namespace="">
                  <xsl:namespace name="x">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
                  <xsl:element name="rdgGrp" namespace="">
                     <xsl:namespace name="x">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
                     <xsl:attribute xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                    name="n"
                                    namespace=""
                                    select="'', ''"
                                    separator="['never']"/>
                     <xsl:element name="rdg" namespace="">
                        <xsl:namespace name="x">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
                        <xsl:attribute xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                       name="wit"
                                       namespace=""
                                       select="'', ''"
                                       separator="f1818"/>
                        <xsl:text>never </xsl:text>
                     </xsl:element>
                     <xsl:element name="rdg" namespace="">
                        <xsl:namespace name="x">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
                        <xsl:attribute xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                       name="wit"
                                       namespace=""
                                       select="'', ''"
                                       separator="f1823"/>
                        <xsl:text>never </xsl:text>
                     </xsl:element>
                     <xsl:element name="rdg" namespace="">
                        <xsl:namespace name="x">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
                        <xsl:attribute xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                       name="wit"
                                       namespace=""
                                       select="'', ''"
                                       separator="fThomas"/>
                        <xsl:text>never </xsl:text>
                     </xsl:element>
                     <xsl:element name="rdg" namespace="">
                        <xsl:namespace name="x">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
                        <xsl:attribute xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                       name="wit"
                                       namespace=""
                                       select="'', ''"
                                       separator="f1831"/>
                        <xsl:text>never </xsl:text>
                     </xsl:element>
                     <xsl:element name="rdg" namespace="">
                        <xsl:namespace name="x">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
                        <xsl:attribute xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                       name="wit"
                                       namespace=""
                                       select="'', ''"
                                       separator="fMS"/>
                        <xsl:text>&lt;lb n="c56-0103__main__19"/&gt;never </xsl:text>
                     </xsl:element>
                  </xsl:element>
               </xsl:element>
            </xsl:document>
         </xsl:variable>
         <xsl:variable name="Q{urn:x-xspec:compile:impl}context-d60e0"
                       select="$Q{urn:x-xspec:compile:impl}context-d60e0-doc ! ( node() )"/>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}context"
                       as="item()*"
                       select="$Q{urn:x-xspec:compile:impl}context-d60e0"/>
         <xsl:element name="input-wrap" namespace="">
            <xsl:element name="x:call" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:attribute name="template" namespace="">mergeLoner</xsl:attribute>
            </xsl:element>
         </xsl:element>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}result" as="item()*">
            <xsl:for-each select="$Q{urn:x-xspec:compile:impl}context-d60e0">
               <xsl:call-template name="Q{}mergeLoner"/>
            </xsl:for-each>
         </xsl:variable>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            <xsl:with-param name="report-name" select="'result'"/>
         </xsl:call-template>
         <!-- invoke each compiled x:expect -->
         <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}x645b9013-0c8d-3c92-ae53-9216f2a60443-expect1">
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}context"/>
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}x645b9013-0c8d-3c92-ae53-9216f2a60443-expect1"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}test)">
      <xsl:context-item use="absent"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                 as="item()*"
                 required="yes"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                 as="item()*"
                 required="yes"/>
      <xsl:message>merge the loner rdg into the next app</xsl:message>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}expect-d58e28-doc"
                    as="document-node()">
         <xsl:document>
            <xsl:element name="app" namespace="">
               <xsl:namespace name="x">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
               <xsl:element name="rdgGrp" namespace="">
                  <xsl:namespace name="x">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
                  <xsl:attribute xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                 name="n"
                                 namespace=""
                                 select="'', ''"
                                 separator="['never']"/>
                  <xsl:element name="rdg" namespace="">
                     <xsl:namespace name="x">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
                     <xsl:attribute xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                    name="wit"
                                    namespace=""
                                    select="'', ''"
                                    separator="f1818"/>
                     <xsl:text>never </xsl:text>
                  </xsl:element>
                  <xsl:element name="rdg" namespace="">
                     <xsl:namespace name="x">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
                     <xsl:attribute xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                    name="wit"
                                    namespace=""
                                    select="'', ''"
                                    separator="f1823"/>
                     <xsl:text>never </xsl:text>
                  </xsl:element>
                  <xsl:element name="rdg" namespace="">
                     <xsl:namespace name="x">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
                     <xsl:attribute xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                    name="wit"
                                    namespace=""
                                    select="'', ''"
                                    separator="fThomas"/>
                     <xsl:text>never </xsl:text>
                  </xsl:element>
                  <xsl:element name="rdg" namespace="">
                     <xsl:namespace name="x">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
                     <xsl:attribute xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                    name="wit"
                                    namespace=""
                                    select="'', ''"
                                    separator="f1831"/>
                     <xsl:text>never </xsl:text>
                  </xsl:element>
               </xsl:element>
               <xsl:element name="rdgGrp" namespace="">
                  <xsl:namespace name="x">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
                  <xsl:attribute xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                 name="n"
                                 namespace=""
                                 select="'', ''"
                                 separator="['never', 'never']"/>
                  <xsl:element name="rdg" namespace="">
                     <xsl:namespace name="x">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
                     <xsl:attribute xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                    name="wit"
                                    namespace=""
                                    select="'', ''"
                                    separator="fMS"/>
                     <xsl:text>never &lt;lb n="c56-0103__main__19"/&gt;never </xsl:text>
                  </xsl:element>
               </xsl:element>
            </xsl:element>
         </xsl:document>
      </xsl:variable>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}expect-d58e28"
                    select="$Q{urn:x-xspec:compile:impl}expect-d58e28-doc ! ( node() )"><!--expected result--></xsl:variable>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}successful"
                    as="Q{http://www.w3.org/2001/XMLSchema}boolean"
                    select="Q{urn:x-xspec:common:deep-equal}deep-equal($Q{urn:x-xspec:compile:impl}expect-d58e28, $Q{http://www.jenitennison.com/xslt/xspec}result, '')"/>
      <xsl:if test="not($Q{urn:x-xspec:compile:impl}successful)">
         <xsl:message>      FAILED</xsl:message>
      </xsl:if>
      <xsl:element name="test" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">x645b9013-0c8d-3c92-ae53-9216f2a60443-expect1</xsl:attribute>
         <xsl:attribute name="successful"
                        namespace=""
                        select="$Q{urn:x-xspec:compile:impl}successful"/>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>merge the loner rdg into the next app</xsl:text>
         </xsl:element>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence" select="$Q{urn:x-xspec:compile:impl}expect-d58e28"/>
            <xsl:with-param name="report-name" select="'expect'"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}x18929eca-33b4-34df-ba59-bfec579288a4"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}scenario)">
      <xsl:context-item use="absent"/>
      <xsl:message>Scenario for testing template with match 'app[preceding-sibling::app[1][count(descendant::rdg) = 1]]</xsl:message>
      <xsl:element name="scenario" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">x18929eca-33b4-34df-ba59-bfec579288a4</xsl:attribute>
         <xsl:attribute name="xspec" namespace="">file:/C:/Users/Jessie/Documents/Github/fv/collateX-Testing/xslt/postProcessing.xspec</xsl:attribute>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>Scenario for testing template with match 'app[preceding-sibling::app[1][count(descendant::rdg) = 1]]</xsl:text>
         </xsl:element>
         <xsl:element name="input-wrap" namespace="">
            <xsl:element name="x:context" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:element name="app" namespace="">
                  <xsl:namespace name="x">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
                  <xsl:element name="rdgGrp" namespace="">
                     <xsl:namespace name="x">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
                     <xsl:attribute xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                    name="n"
                                    namespace=""
                                    select="'', ''"
                                    separator="['&lt;delstart/&gt;of&lt;delend/&gt;', 'of']"/>
                     <xsl:element name="rdg" namespace="">
                        <xsl:namespace name="x">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
                        <xsl:attribute xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                       name="wit"
                                       namespace=""
                                       select="'', ''"
                                       separator="fMS"/>
                        <xsl:text>&lt;del rend="strikethrough"
                        xml:id="c56-0107__main__d5e22344"&gt;of&lt;/del&gt; of </xsl:text>
                     </xsl:element>
                  </xsl:element>
               </xsl:element>
               <xsl:element name="app" namespace="">
                  <xsl:namespace name="x">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
                  <xsl:element name="rdgGrp" namespace="">
                     <xsl:namespace name="x">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
                     <xsl:attribute xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                    name="n"
                                    namespace=""
                                    select="'', ''"
                                    separator="['others']"/>
                     <xsl:element name="rdg" namespace="">
                        <xsl:namespace name="x">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
                        <xsl:attribute xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                       name="wit"
                                       namespace=""
                                       select="'', ''"
                                       separator="f1818"/>
                        <xsl:text>others </xsl:text>
                     </xsl:element>
                     <xsl:element name="rdg" namespace="">
                        <xsl:namespace name="x">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
                        <xsl:attribute xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                       name="wit"
                                       namespace=""
                                       select="'', ''"
                                       separator="f1823"/>
                        <xsl:text>others </xsl:text>
                     </xsl:element>
                     <xsl:element name="rdg" namespace="">
                        <xsl:namespace name="x">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
                        <xsl:attribute xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                       name="wit"
                                       namespace=""
                                       select="'', ''"
                                       separator="fThomas"/>
                        <xsl:text>others </xsl:text>
                     </xsl:element>
                     <xsl:element name="rdg" namespace="">
                        <xsl:namespace name="x">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
                        <xsl:attribute xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                       name="wit"
                                       namespace=""
                                       select="'', ''"
                                       separator="f1831"/>
                        <xsl:text>others </xsl:text>
                     </xsl:element>
                     <xsl:element name="rdg" namespace="">
                        <xsl:namespace name="x">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
                        <xsl:attribute xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                       name="wit"
                                       namespace=""
                                       select="'', ''"
                                       separator="fMS"/>
                        <xsl:text>others </xsl:text>
                     </xsl:element>
                  </xsl:element>
               </xsl:element>
               <xsl:element name="app" namespace="">
                  <xsl:namespace name="x">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
                  <xsl:element name="rdgGrp" namespace="">
                     <xsl:namespace name="x">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
                     <xsl:attribute xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                    name="n"
                                    namespace=""
                                    select="'', ''"
                                    separator="['so.&#34;']"/>
                     <xsl:element name="rdg" namespace="">
                        <xsl:namespace name="x">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
                        <xsl:attribute xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                       name="wit"
                                       namespace=""
                                       select="'', ''"
                                       separator="f1818"/>
                        <xsl:text>so.” </xsl:text>
                     </xsl:element>
                     <xsl:element name="rdg" namespace="">
                        <xsl:namespace name="x">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
                        <xsl:attribute xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                       name="wit"
                                       namespace=""
                                       select="'', ''"
                                       separator="f1823"/>
                        <xsl:text>so.” </xsl:text>
                     </xsl:element>
                     <xsl:element name="rdg" namespace="">
                        <xsl:namespace name="x">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
                        <xsl:attribute xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                       name="wit"
                                       namespace=""
                                       select="'', ''"
                                       separator="fThomas"/>
                        <xsl:text>so.” </xsl:text>
                     </xsl:element>
                     <xsl:element name="rdg" namespace="">
                        <xsl:namespace name="x">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
                        <xsl:attribute xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                       name="wit"
                                       namespace=""
                                       select="'', ''"
                                       separator="f1831"/>
                        <xsl:text>so.” </xsl:text>
                     </xsl:element>
                  </xsl:element>
                  <xsl:element name="rdgGrp" namespace="">
                     <xsl:namespace name="x">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
                     <xsl:attribute xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                    name="n"
                                    namespace=""
                                    select="'', ''"
                                    separator="['so.']"/>
                     <xsl:element name="rdg" namespace="">
                        <xsl:namespace name="x">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
                        <xsl:attribute xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                       name="wit"
                                       namespace=""
                                       select="'', ''"
                                       separator="fMS"/>
                        <xsl:text>so. </xsl:text>
                     </xsl:element>
                  </xsl:element>
               </xsl:element>
            </xsl:element>
         </xsl:element>
         <xsl:variable name="Q{urn:x-xspec:compile:impl}context-d70e0-doc"
                       as="document-node()">
            <xsl:document>
               <xsl:element name="app" namespace="">
                  <xsl:namespace name="x">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
                  <xsl:element name="rdgGrp" namespace="">
                     <xsl:namespace name="x">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
                     <xsl:attribute xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                    name="n"
                                    namespace=""
                                    select="'', ''"
                                    separator="['&lt;delstart/&gt;of&lt;delend/&gt;', 'of']"/>
                     <xsl:element name="rdg" namespace="">
                        <xsl:namespace name="x">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
                        <xsl:attribute xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                       name="wit"
                                       namespace=""
                                       select="'', ''"
                                       separator="fMS"/>
                        <xsl:text>&lt;del rend="strikethrough"
                        xml:id="c56-0107__main__d5e22344"&gt;of&lt;/del&gt; of </xsl:text>
                     </xsl:element>
                  </xsl:element>
               </xsl:element>
               <xsl:element name="app" namespace="">
                  <xsl:namespace name="x">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
                  <xsl:element name="rdgGrp" namespace="">
                     <xsl:namespace name="x">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
                     <xsl:attribute xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                    name="n"
                                    namespace=""
                                    select="'', ''"
                                    separator="['others']"/>
                     <xsl:element name="rdg" namespace="">
                        <xsl:namespace name="x">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
                        <xsl:attribute xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                       name="wit"
                                       namespace=""
                                       select="'', ''"
                                       separator="f1818"/>
                        <xsl:text>others </xsl:text>
                     </xsl:element>
                     <xsl:element name="rdg" namespace="">
                        <xsl:namespace name="x">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
                        <xsl:attribute xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                       name="wit"
                                       namespace=""
                                       select="'', ''"
                                       separator="f1823"/>
                        <xsl:text>others </xsl:text>
                     </xsl:element>
                     <xsl:element name="rdg" namespace="">
                        <xsl:namespace name="x">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
                        <xsl:attribute xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                       name="wit"
                                       namespace=""
                                       select="'', ''"
                                       separator="fThomas"/>
                        <xsl:text>others </xsl:text>
                     </xsl:element>
                     <xsl:element name="rdg" namespace="">
                        <xsl:namespace name="x">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
                        <xsl:attribute xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                       name="wit"
                                       namespace=""
                                       select="'', ''"
                                       separator="f1831"/>
                        <xsl:text>others </xsl:text>
                     </xsl:element>
                     <xsl:element name="rdg" namespace="">
                        <xsl:namespace name="x">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
                        <xsl:attribute xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                       name="wit"
                                       namespace=""
                                       select="'', ''"
                                       separator="fMS"/>
                        <xsl:text>others </xsl:text>
                     </xsl:element>
                  </xsl:element>
               </xsl:element>
               <xsl:element name="app" namespace="">
                  <xsl:namespace name="x">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
                  <xsl:element name="rdgGrp" namespace="">
                     <xsl:namespace name="x">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
                     <xsl:attribute xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                    name="n"
                                    namespace=""
                                    select="'', ''"
                                    separator="['so.&#34;']"/>
                     <xsl:element name="rdg" namespace="">
                        <xsl:namespace name="x">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
                        <xsl:attribute xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                       name="wit"
                                       namespace=""
                                       select="'', ''"
                                       separator="f1818"/>
                        <xsl:text>so.” </xsl:text>
                     </xsl:element>
                     <xsl:element name="rdg" namespace="">
                        <xsl:namespace name="x">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
                        <xsl:attribute xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                       name="wit"
                                       namespace=""
                                       select="'', ''"
                                       separator="f1823"/>
                        <xsl:text>so.” </xsl:text>
                     </xsl:element>
                     <xsl:element name="rdg" namespace="">
                        <xsl:namespace name="x">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
                        <xsl:attribute xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                       name="wit"
                                       namespace=""
                                       select="'', ''"
                                       separator="fThomas"/>
                        <xsl:text>so.” </xsl:text>
                     </xsl:element>
                     <xsl:element name="rdg" namespace="">
                        <xsl:namespace name="x">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
                        <xsl:attribute xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                       name="wit"
                                       namespace=""
                                       select="'', ''"
                                       separator="f1831"/>
                        <xsl:text>so.” </xsl:text>
                     </xsl:element>
                  </xsl:element>
                  <xsl:element name="rdgGrp" namespace="">
                     <xsl:namespace name="x">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
                     <xsl:attribute xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                    name="n"
                                    namespace=""
                                    select="'', ''"
                                    separator="['so.']"/>
                     <xsl:element name="rdg" namespace="">
                        <xsl:namespace name="x">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
                        <xsl:attribute xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                       name="wit"
                                       namespace=""
                                       select="'', ''"
                                       separator="fMS"/>
                        <xsl:text>so. </xsl:text>
                     </xsl:element>
                  </xsl:element>
               </xsl:element>
            </xsl:document>
         </xsl:variable>
         <xsl:variable name="Q{urn:x-xspec:compile:impl}context-d70e0"
                       select="$Q{urn:x-xspec:compile:impl}context-d70e0-doc ! ( node() )"/>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}context"
                       as="item()*"
                       select="$Q{urn:x-xspec:compile:impl}context-d70e0"/>
         <xsl:element name="input-wrap" namespace="">
            <xsl:element name="x:call" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:attribute name="template" namespace="">removeApp</xsl:attribute>
            </xsl:element>
         </xsl:element>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}result" as="item()*">
            <xsl:for-each select="$Q{urn:x-xspec:compile:impl}context-d70e0">
               <xsl:call-template name="Q{}removeApp"/>
            </xsl:for-each>
         </xsl:variable>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            <xsl:with-param name="report-name" select="'result'"/>
         </xsl:call-template>
         <!-- invoke each compiled x:expect -->
         <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}x18929eca-33b4-34df-ba59-bfec579288a4-expect1">
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}context"/>
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}x18929eca-33b4-34df-ba59-bfec579288a4-expect1"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}test)">
      <xsl:context-item use="absent"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                 as="item()*"
                 required="yes"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                 as="item()*"
                 required="yes"/>
      <xsl:message>Remove the original app modified</xsl:message>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}expect-d58e75" select="()"><!--expected result--></xsl:variable>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}successful"
                    as="Q{http://www.w3.org/2001/XMLSchema}boolean"
                    select="Q{urn:x-xspec:common:deep-equal}deep-equal($Q{urn:x-xspec:compile:impl}expect-d58e75, $Q{http://www.jenitennison.com/xslt/xspec}result, '')"/>
      <xsl:if test="not($Q{urn:x-xspec:compile:impl}successful)">
         <xsl:message>      FAILED</xsl:message>
      </xsl:if>
      <xsl:element name="test" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">x18929eca-33b4-34df-ba59-bfec579288a4-expect1</xsl:attribute>
         <xsl:attribute name="successful"
                        namespace=""
                        select="$Q{urn:x-xspec:compile:impl}successful"/>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>Remove the original app modified</xsl:text>
         </xsl:element>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence" select="$Q{urn:x-xspec:compile:impl}expect-d58e75"/>
            <xsl:with-param name="report-name" select="'expect'"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}xe708bb62-a42b-3e71-b5bb-fcbd643d86c5"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}scenario)">
      <xsl:context-item use="absent"/>
      <xsl:message>restructure</xsl:message>
      <xsl:element name="scenario" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">xe708bb62-a42b-3e71-b5bb-fcbd643d86c5</xsl:attribute>
         <xsl:attribute name="xspec" namespace="">file:/C:/Users/Jessie/Documents/Github/fv/collateX-Testing/xslt/postProcessing.xspec</xsl:attribute>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>restructure</xsl:text>
         </xsl:element>
         <xsl:variable xmlns:x="http://www.jenitennison.com/xslt/xspec"
                       name="Q{}loner"
                       as="node()"
                       select="$infile/descendant::rdgGrp[not(preceding::app[1][count(rdgGrp) = 1 and rdgGrp/@n ! string-length() = 4])]"/>
         <xsl:for-each select="1 to 3">
            <xsl:choose>
               <xsl:when test=". eq 1">
                  <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}x3d298972-1a7c-32a5-9d09-78136b336e24">
                     <xsl:with-param name="Q{}loner" select="$Q{}loner"/>
                  </xsl:call-template>
               </xsl:when>
               <xsl:when test=". eq 2">
                  <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}xae6a2b6b-717a-3ec8-aa67-71ae382d6275">
                     <xsl:with-param name="Q{}loner" select="$Q{}loner"/>
                  </xsl:call-template>
               </xsl:when>
               <xsl:when test=". eq 3">
                  <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}x664ea1ff-4426-3b9f-b298-22f89478aa64">
                     <xsl:with-param name="Q{}loner" select="$Q{}loner"/>
                  </xsl:call-template>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:message terminate="yes">ERROR: Unhandled scenario invocation</xsl:message>
               </xsl:otherwise>
            </xsl:choose>
         </xsl:for-each>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}x3d298972-1a7c-32a5-9d09-78136b336e24"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}scenario)">
      <xsl:context-item use="absent"/>
      <xsl:param name="Q{}loner" as="item()*" required="yes"/>
      <xsl:message>..Scenario for testing template with match 'app' and mode 'restructure'</xsl:message>
      <xsl:element name="scenario" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">x3d298972-1a7c-32a5-9d09-78136b336e24</xsl:attribute>
         <xsl:attribute name="xspec" namespace="">file:/C:/Users/Jessie/Documents/Github/fv/collateX-Testing/xslt/postProcessing.xspec</xsl:attribute>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>Scenario for testing template with match 'app' and mode 'restructure'</xsl:text>
         </xsl:element>
         <xsl:element name="input-wrap" namespace="">
            <xsl:element name="x:context" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:attribute name="select" namespace="">$infile</xsl:attribute>
            </xsl:element>
         </xsl:element>
         <xsl:variable xmlns:x="http://www.jenitennison.com/xslt/xspec"
                       name="Q{urn:x-xspec:compile:impl}context-d83e0"
                       select="$infile"/>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}context"
                       as="item()*"
                       select="$Q{urn:x-xspec:compile:impl}context-d83e0"/>
         <xsl:element name="input-wrap" namespace="">
            <xsl:element name="x:call" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:attribute name="template" namespace="">restructureApp</xsl:attribute>
               <xsl:element name="x:param" namespace="http://www.jenitennison.com/xslt/xspec">
                  <xsl:attribute name="name" namespace="">loner</xsl:attribute>
                  <xsl:attribute name="select" namespace="">$loner/rdg</xsl:attribute>
                  <xsl:attribute name="tunnel" namespace="">yes</xsl:attribute>
               </xsl:element>
               <xsl:element name="x:param" namespace="http://www.jenitennison.com/xslt/xspec">
                  <xsl:attribute name="name" namespace="">norm</xsl:attribute>
                  <xsl:attribute name="select" namespace="">$loner/@n</xsl:attribute>
                  <xsl:attribute name="tunnel" namespace="">yes</xsl:attribute>
               </xsl:element>
            </xsl:element>
         </xsl:element>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}result" as="item()*">
            <xsl:variable xmlns:x="http://www.jenitennison.com/xslt/xspec"
                          name="Q{}loner"
                          select="$loner/rdg"/>
            <xsl:variable xmlns:x="http://www.jenitennison.com/xslt/xspec"
                          name="Q{}norm"
                          select="$loner/@n"/>
            <xsl:for-each select="$Q{urn:x-xspec:compile:impl}context-d83e0">
               <xsl:call-template name="Q{}restructureApp">
                  <xsl:with-param xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                  name="Q{}loner"
                                  select="$Q{}loner"
                                  tunnel="yes"/>
                  <xsl:with-param xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                  name="Q{}norm"
                                  select="$Q{}norm"
                                  tunnel="yes"/>
               </xsl:call-template>
            </xsl:for-each>
         </xsl:variable>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            <xsl:with-param name="report-name" select="'result'"/>
         </xsl:call-template>
         <!-- invoke each compiled x:expect -->
         <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}x3d298972-1a7c-32a5-9d09-78136b336e24-expect1">
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}context"/>
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            <xsl:with-param name="Q{}loner" select="$Q{}loner"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}x3d298972-1a7c-32a5-9d09-78136b336e24-expect1"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}test)">
      <xsl:context-item use="absent"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                 as="item()*"
                 required="yes"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                 as="item()*"
                 required="yes"/>
      <xsl:param name="Q{}loner" as="item()*" required="yes"/>
      <xsl:message>restructure app</xsl:message>
      <xsl:variable xmlns:x="http://www.jenitennison.com/xslt/xspec"
                    name="Q{urn:x-xspec:compile:impl}expect-d58e84"
                    select="'Not yet implemented'"><!--expected result--></xsl:variable>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}successful"
                    as="Q{http://www.w3.org/2001/XMLSchema}boolean"
                    select="Q{urn:x-xspec:common:deep-equal}deep-equal($Q{urn:x-xspec:compile:impl}expect-d58e84, $Q{http://www.jenitennison.com/xslt/xspec}result, '')"/>
      <xsl:if test="not($Q{urn:x-xspec:compile:impl}successful)">
         <xsl:message>      FAILED</xsl:message>
      </xsl:if>
      <xsl:element name="test" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">x3d298972-1a7c-32a5-9d09-78136b336e24-expect1</xsl:attribute>
         <xsl:attribute name="successful"
                        namespace=""
                        select="$Q{urn:x-xspec:compile:impl}successful"/>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>restructure app</xsl:text>
         </xsl:element>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence" select="$Q{urn:x-xspec:compile:impl}expect-d58e84"/>
            <xsl:with-param name="report-name" select="'expect'"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}xae6a2b6b-717a-3ec8-aa67-71ae382d6275"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}scenario)">
      <xsl:context-item use="absent"/>
      <xsl:param name="Q{}loner" as="item()*" required="yes"/>
      <xsl:message>..Scenario for testing template with match 'rdgGrp' and mode 'restructure'</xsl:message>
      <xsl:element name="scenario" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">xae6a2b6b-717a-3ec8-aa67-71ae382d6275</xsl:attribute>
         <xsl:attribute name="xspec" namespace="">file:/C:/Users/Jessie/Documents/Github/fv/collateX-Testing/xslt/postProcessing.xspec</xsl:attribute>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>Scenario for testing template with match 'rdgGrp' and mode 'restructure'</xsl:text>
         </xsl:element>
         <xsl:element name="input-wrap" namespace="">
            <xsl:element name="x:context" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:attribute name="select" namespace="">$infile</xsl:attribute>
            </xsl:element>
         </xsl:element>
         <xsl:variable xmlns:x="http://www.jenitennison.com/xslt/xspec"
                       name="Q{urn:x-xspec:compile:impl}context-d95e0"
                       select="$infile"/>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}context"
                       as="item()*"
                       select="$Q{urn:x-xspec:compile:impl}context-d95e0"/>
         <xsl:element name="input-wrap" namespace="">
            <xsl:element name="x:call" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:attribute name="template" namespace="">restructure-rdgGrp</xsl:attribute>
               <xsl:element name="x:param" namespace="http://www.jenitennison.com/xslt/xspec">
                  <xsl:attribute name="name" namespace="">loner</xsl:attribute>
                  <xsl:attribute name="select" namespace="">$loner/rdg</xsl:attribute>
                  <xsl:attribute name="tunnel" namespace="">yes</xsl:attribute>
               </xsl:element>
            </xsl:element>
         </xsl:element>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}result" as="item()*">
            <xsl:variable xmlns:x="http://www.jenitennison.com/xslt/xspec"
                          name="Q{}loner"
                          select="$loner/rdg"/>
            <xsl:for-each select="$Q{urn:x-xspec:compile:impl}context-d95e0">
               <xsl:call-template name="Q{}restructure-rdgGrp">
                  <xsl:with-param xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                  name="Q{}loner"
                                  select="$Q{}loner"
                                  tunnel="yes"/>
               </xsl:call-template>
            </xsl:for-each>
         </xsl:variable>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            <xsl:with-param name="report-name" select="'result'"/>
         </xsl:call-template>
         <!-- invoke each compiled x:expect -->
         <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}xae6a2b6b-717a-3ec8-aa67-71ae382d6275-expect1">
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}context"/>
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            <xsl:with-param name="Q{}loner" select="$Q{}loner"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}xae6a2b6b-717a-3ec8-aa67-71ae382d6275-expect1"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}test)">
      <xsl:context-item use="absent"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                 as="item()*"
                 required="yes"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                 as="item()*"
                 required="yes"/>
      <xsl:param name="Q{}loner" as="item()*" required="yes"/>
      <xsl:message>restructure rdgGrp</xsl:message>
      <xsl:variable xmlns:x="http://www.jenitennison.com/xslt/xspec"
                    name="Q{urn:x-xspec:compile:impl}expect-d58e89"
                    select="'Not yet implemented'"><!--expected result--></xsl:variable>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}successful"
                    as="Q{http://www.w3.org/2001/XMLSchema}boolean"
                    select="Q{urn:x-xspec:common:deep-equal}deep-equal($Q{urn:x-xspec:compile:impl}expect-d58e89, $Q{http://www.jenitennison.com/xslt/xspec}result, '')"/>
      <xsl:if test="not($Q{urn:x-xspec:compile:impl}successful)">
         <xsl:message>      FAILED</xsl:message>
      </xsl:if>
      <xsl:element name="test" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">xae6a2b6b-717a-3ec8-aa67-71ae382d6275-expect1</xsl:attribute>
         <xsl:attribute name="successful"
                        namespace=""
                        select="$Q{urn:x-xspec:compile:impl}successful"/>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>restructure rdgGrp</xsl:text>
         </xsl:element>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence" select="$Q{urn:x-xspec:compile:impl}expect-d58e89"/>
            <xsl:with-param name="report-name" select="'expect'"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}x664ea1ff-4426-3b9f-b298-22f89478aa64"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}scenario)">
      <xsl:context-item use="absent"/>
      <xsl:param name="Q{}loner" as="item()*" required="yes"/>
      <xsl:message>..Scenario for testing template with match 'rdgGrp' and mode 'emptyNormalize'</xsl:message>
      <xsl:element name="scenario" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">x664ea1ff-4426-3b9f-b298-22f89478aa64</xsl:attribute>
         <xsl:attribute name="xspec" namespace="">file:/C:/Users/Jessie/Documents/Github/fv/collateX-Testing/xslt/postProcessing.xspec</xsl:attribute>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>Scenario for testing template with match 'rdgGrp' and mode 'emptyNormalize'</xsl:text>
         </xsl:element>
         <xsl:element name="input-wrap" namespace="">
            <xsl:element name="x:context" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:attribute name="select" namespace="">$infile</xsl:attribute>
            </xsl:element>
         </xsl:element>
         <xsl:variable xmlns:x="http://www.jenitennison.com/xslt/xspec"
                       name="Q{urn:x-xspec:compile:impl}context-d106e0"
                       select="$infile"/>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}context"
                       as="item()*"
                       select="$Q{urn:x-xspec:compile:impl}context-d106e0"/>
         <xsl:element name="input-wrap" namespace="">
            <xsl:element name="x:call" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:attribute name="template" namespace="">emptyNormalize</xsl:attribute>
               <xsl:element name="x:param" namespace="http://www.jenitennison.com/xslt/xspec">
                  <xsl:attribute name="name" namespace="">lonerText</xsl:attribute>
                  <xsl:attribute name="select" namespace="">$loner/rdg/text()</xsl:attribute>
                  <xsl:attribute name="tunnel" namespace="">yes</xsl:attribute>
               </xsl:element>
               <xsl:element name="x:param" namespace="http://www.jenitennison.com/xslt/xspec">
                  <xsl:attribute name="name" namespace="">lonerWit</xsl:attribute>
                  <xsl:attribute name="select" namespace="">$loner/descendant::rdg/@wit</xsl:attribute>
                  <xsl:attribute name="tunnel" namespace="">yes</xsl:attribute>
               </xsl:element>
            </xsl:element>
         </xsl:element>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}result" as="item()*">
            <xsl:variable xmlns:x="http://www.jenitennison.com/xslt/xspec"
                          name="Q{}lonerText"
                          select="$loner/rdg/text()"/>
            <xsl:variable xmlns:x="http://www.jenitennison.com/xslt/xspec"
                          name="Q{}lonerWit"
                          select="$loner/descendant::rdg/@wit"/>
            <xsl:for-each select="$Q{urn:x-xspec:compile:impl}context-d106e0">
               <xsl:call-template name="Q{}emptyNormalize">
                  <xsl:with-param xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                  name="Q{}lonerText"
                                  select="$Q{}lonerText"
                                  tunnel="yes"/>
                  <xsl:with-param xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                  name="Q{}lonerWit"
                                  select="$Q{}lonerWit"
                                  tunnel="yes"/>
               </xsl:call-template>
            </xsl:for-each>
         </xsl:variable>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            <xsl:with-param name="report-name" select="'result'"/>
         </xsl:call-template>
         <!-- invoke each compiled x:expect -->
         <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}x664ea1ff-4426-3b9f-b298-22f89478aa64-expect1">
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}context"/>
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            <xsl:with-param name="Q{}loner" select="$Q{}loner"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}x664ea1ff-4426-3b9f-b298-22f89478aa64-expect1"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}test)">
      <xsl:context-item use="absent"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                 as="item()*"
                 required="yes"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                 as="item()*"
                 required="yes"/>
      <xsl:param name="Q{}loner" as="item()*" required="yes"/>
      <xsl:message>Not yet implemented</xsl:message>
      <xsl:variable xmlns:x="http://www.jenitennison.com/xslt/xspec"
                    name="Q{urn:x-xspec:compile:impl}expect-d58e95"
                    select="'Not yet implemented'"><!--expected result--></xsl:variable>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}successful"
                    as="Q{http://www.w3.org/2001/XMLSchema}boolean"
                    select="Q{urn:x-xspec:common:deep-equal}deep-equal($Q{urn:x-xspec:compile:impl}expect-d58e95, $Q{http://www.jenitennison.com/xslt/xspec}result, '')"/>
      <xsl:if test="not($Q{urn:x-xspec:compile:impl}successful)">
         <xsl:message>      FAILED</xsl:message>
      </xsl:if>
      <xsl:element name="test" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">x664ea1ff-4426-3b9f-b298-22f89478aa64-expect1</xsl:attribute>
         <xsl:attribute name="successful"
                        namespace=""
                        select="$Q{urn:x-xspec:compile:impl}successful"/>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>Not yet implemented</xsl:text>
         </xsl:element>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence" select="$Q{urn:x-xspec:compile:impl}expect-d58e95"/>
            <xsl:with-param name="report-name" select="'expect'"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}x2ff013dc-fad0-347f-8d27-8f5c3eedf174"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}scenario)">
      <xsl:context-item use="absent"/>
      <xsl:message>Scenario for testing template with match 'rdg/text()</xsl:message>
      <xsl:element name="scenario" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">x2ff013dc-fad0-347f-8d27-8f5c3eedf174</xsl:attribute>
         <xsl:attribute name="xspec" namespace="">file:/C:/Users/Jessie/Documents/Github/fv/collateX-Testing/xslt/postProcessing.xspec</xsl:attribute>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>Scenario for testing template with match 'rdg/text()</xsl:text>
         </xsl:element>
         <xsl:element name="input-wrap" namespace="">
            <xsl:element name="x:context" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:element name="app" namespace="">
                  <xsl:namespace name="x">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
                  <xsl:element name="rdgGrp" namespace="">
                     <xsl:namespace name="x">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
                     <xsl:attribute xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                    name="n"
                                    namespace=""
                                    select="'', ''"
                                    separator="['&lt;delstart/&gt;and&lt;delend/&gt;']"/>
                     <xsl:element name="rdg" namespace="">
                        <xsl:namespace name="x">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
                        <xsl:attribute xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                       name="wit"
                                       namespace=""
                                       select="'', ''"
                                       separator="fMS"/>
                        <xsl:text>&lt;del rend="strikethrough"xml:id="c56-0107__main__d5e22411"&gt;&amp;amp;&lt;/del&gt;</xsl:text>
                     </xsl:element>
                  </xsl:element>
               </xsl:element>
            </xsl:element>
         </xsl:element>
         <xsl:variable name="Q{urn:x-xspec:compile:impl}context-d118e0-doc"
                       as="document-node()">
            <xsl:document>
               <xsl:element name="app" namespace="">
                  <xsl:namespace name="x">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
                  <xsl:element name="rdgGrp" namespace="">
                     <xsl:namespace name="x">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
                     <xsl:attribute xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                    name="n"
                                    namespace=""
                                    select="'', ''"
                                    separator="['&lt;delstart/&gt;and&lt;delend/&gt;']"/>
                     <xsl:element name="rdg" namespace="">
                        <xsl:namespace name="x">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
                        <xsl:attribute xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                       name="wit"
                                       namespace=""
                                       select="'', ''"
                                       separator="fMS"/>
                        <xsl:text>&lt;del rend="strikethrough"xml:id="c56-0107__main__d5e22411"&gt;&amp;amp;&lt;/del&gt;</xsl:text>
                     </xsl:element>
                  </xsl:element>
               </xsl:element>
            </xsl:document>
         </xsl:variable>
         <xsl:variable name="Q{urn:x-xspec:compile:impl}context-d118e0"
                       select="$Q{urn:x-xspec:compile:impl}context-d118e0-doc ! ( node() )"/>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}context"
                       as="item()*"
                       select="$Q{urn:x-xspec:compile:impl}context-d118e0"/>
         <xsl:element name="input-wrap" namespace="">
            <xsl:element name="x:call" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:attribute name="template" namespace="">textAmpFix</xsl:attribute>
            </xsl:element>
         </xsl:element>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}result" as="item()*">
            <xsl:for-each select="$Q{urn:x-xspec:compile:impl}context-d118e0">
               <xsl:call-template name="Q{}textAmpFix"/>
            </xsl:for-each>
         </xsl:variable>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            <xsl:with-param name="report-name" select="'result'"/>
         </xsl:call-template>
         <!-- invoke each compiled x:expect -->
         <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}x2ff013dc-fad0-347f-8d27-8f5c3eedf174-expect1">
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}context"/>
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}x2ff013dc-fad0-347f-8d27-8f5c3eedf174-expect1"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}test)">
      <xsl:context-item use="absent"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                 as="item()*"
                 required="yes"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                 as="item()*"
                 required="yes"/>
      <xsl:message>replace &amp;amp; to &amp; for text()</xsl:message>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}expect-d58e104-doc"
                    as="document-node()">
         <xsl:document>
            <xsl:text>&lt;del rend="strikethrough"xml:id="c56-0107__main__d5e22411"&gt;&amp;&lt;/del&gt;</xsl:text>
         </xsl:document>
      </xsl:variable>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}expect-d58e104"
                    select="$Q{urn:x-xspec:compile:impl}expect-d58e104-doc ! ( node() )"><!--expected result--></xsl:variable>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}successful"
                    as="Q{http://www.w3.org/2001/XMLSchema}boolean"
                    select="Q{urn:x-xspec:common:deep-equal}deep-equal($Q{urn:x-xspec:compile:impl}expect-d58e104, $Q{http://www.jenitennison.com/xslt/xspec}result, '')"/>
      <xsl:if test="not($Q{urn:x-xspec:compile:impl}successful)">
         <xsl:message>      FAILED</xsl:message>
      </xsl:if>
      <xsl:element name="test" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">x2ff013dc-fad0-347f-8d27-8f5c3eedf174-expect1</xsl:attribute>
         <xsl:attribute name="successful"
                        namespace=""
                        select="$Q{urn:x-xspec:compile:impl}successful"/>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>replace &amp;amp; to &amp; for text()</xsl:text>
         </xsl:element>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence" select="$Q{urn:x-xspec:compile:impl}expect-d58e104"/>
            <xsl:with-param name="report-name" select="'expect'"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}xea9320dd-491e-327e-8d5c-b066e3cf7c73"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}scenario)">
      <xsl:context-item use="absent"/>
      <xsl:message>Scenario for testing template with match 'rdg/text() again</xsl:message>
      <xsl:element name="scenario" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">xea9320dd-491e-327e-8d5c-b066e3cf7c73</xsl:attribute>
         <xsl:attribute name="xspec" namespace="">file:/C:/Users/Jessie/Documents/Github/fv/collateX-Testing/xslt/postProcessing.xspec</xsl:attribute>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>Scenario for testing template with match 'rdg/text() again</xsl:text>
         </xsl:element>
         <xsl:element name="input-wrap" namespace="">
            <xsl:element name="x:context" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:element name="rdgGrp" namespace="">
                  <xsl:namespace name="x">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
                  <xsl:attribute xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                 name="n"
                                 namespace=""
                                 select="'', ''"
                                 separator="['', '&lt;delstart/&gt;andquot;&lt;delend/&gt;', '&#34;i']"/>
                  <xsl:element name="rdg" namespace="">
                     <xsl:namespace name="x">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
                     <xsl:attribute xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                    name="wit"
                                    namespace=""
                                    select="'', ''"
                                    separator="fMS"/>
                     <xsl:text>&lt;lb n="c56-0105__main__17"/&gt; &lt;del rend="strikethrough" xml:id="c56-0105__main__d5e22055"&gt;&amp;quot;&lt;/del&gt; "I</xsl:text>
                  </xsl:element>
               </xsl:element>
            </xsl:element>
         </xsl:element>
         <xsl:variable name="Q{urn:x-xspec:compile:impl}context-d128e0-doc"
                       as="document-node()">
            <xsl:document>
               <xsl:element name="rdgGrp" namespace="">
                  <xsl:namespace name="x">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
                  <xsl:attribute xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                 name="n"
                                 namespace=""
                                 select="'', ''"
                                 separator="['', '&lt;delstart/&gt;andquot;&lt;delend/&gt;', '&#34;i']"/>
                  <xsl:element name="rdg" namespace="">
                     <xsl:namespace name="x">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
                     <xsl:attribute xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                    name="wit"
                                    namespace=""
                                    select="'', ''"
                                    separator="fMS"/>
                     <xsl:text>&lt;lb n="c56-0105__main__17"/&gt; &lt;del rend="strikethrough" xml:id="c56-0105__main__d5e22055"&gt;&amp;quot;&lt;/del&gt; "I</xsl:text>
                  </xsl:element>
               </xsl:element>
            </xsl:document>
         </xsl:variable>
         <xsl:variable name="Q{urn:x-xspec:compile:impl}context-d128e0"
                       select="$Q{urn:x-xspec:compile:impl}context-d128e0-doc ! ( node() )"/>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}context"
                       as="item()*"
                       select="$Q{urn:x-xspec:compile:impl}context-d128e0"/>
         <xsl:element name="input-wrap" namespace="">
            <xsl:element name="x:call" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:attribute name="template" namespace="">textAmpFix</xsl:attribute>
            </xsl:element>
         </xsl:element>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}result" as="item()*">
            <xsl:for-each select="$Q{urn:x-xspec:compile:impl}context-d128e0">
               <xsl:call-template name="Q{}textAmpFix"/>
            </xsl:for-each>
         </xsl:variable>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            <xsl:with-param name="report-name" select="'result'"/>
         </xsl:call-template>
         <!-- invoke each compiled x:expect -->
         <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}xea9320dd-491e-327e-8d5c-b066e3cf7c73-expect1">
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}context"/>
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}xea9320dd-491e-327e-8d5c-b066e3cf7c73-expect1"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}test)">
      <xsl:context-item use="absent"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                 as="item()*"
                 required="yes"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                 as="item()*"
                 required="yes"/>
      <xsl:message>replace &amp;quot; to " for text()</xsl:message>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}expect-d58e112-doc"
                    as="document-node()">
         <xsl:document>
            <xsl:text>&lt;lb n="c56-0105__main__17"/&gt; &lt;del rend="strikethrough" xml:id="c56-0105__main__d5e22055"&gt;"&lt;/del&gt; "I</xsl:text>
         </xsl:document>
      </xsl:variable>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}expect-d58e112"
                    select="$Q{urn:x-xspec:compile:impl}expect-d58e112-doc ! ( node() )"><!--expected result--></xsl:variable>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}successful"
                    as="Q{http://www.w3.org/2001/XMLSchema}boolean"
                    select="Q{urn:x-xspec:common:deep-equal}deep-equal($Q{urn:x-xspec:compile:impl}expect-d58e112, $Q{http://www.jenitennison.com/xslt/xspec}result, '')"/>
      <xsl:if test="not($Q{urn:x-xspec:compile:impl}successful)">
         <xsl:message>      FAILED</xsl:message>
      </xsl:if>
      <xsl:element name="test" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">xea9320dd-491e-327e-8d5c-b066e3cf7c73-expect1</xsl:attribute>
         <xsl:attribute name="successful"
                        namespace=""
                        select="$Q{urn:x-xspec:compile:impl}successful"/>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>replace &amp;quot; to " for text()</xsl:text>
         </xsl:element>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence" select="$Q{urn:x-xspec:compile:impl}expect-d58e112"/>
            <xsl:with-param name="report-name" select="'expect'"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}xae6f131d-491c-3eb4-929c-e03263392a11"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}scenario)">
      <xsl:context-item use="absent"/>
      <xsl:message>Scenario for testing template with match 'rdgGrp</xsl:message>
      <xsl:element name="scenario" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">xae6f131d-491c-3eb4-929c-e03263392a11</xsl:attribute>
         <xsl:attribute name="xspec" namespace="">file:/C:/Users/Jessie/Documents/Github/fv/collateX-Testing/xslt/postProcessing.xspec</xsl:attribute>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>Scenario for testing template with match 'rdgGrp</xsl:text>
         </xsl:element>
         <xsl:element name="input-wrap" namespace="">
            <xsl:element name="x:context" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:element name="rdgGrp" namespace="">
                  <xsl:namespace name="x">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
                  <xsl:attribute xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                 name="n"
                                 namespace=""
                                 select="'', ''"
                                 separator="['', '&lt;delstart/&gt;andquot;&lt;delend/&gt;', '&#34;i']"/>
                  <xsl:element name="rdg" namespace="">
                     <xsl:namespace name="x">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
                     <xsl:attribute xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                    name="wit"
                                    namespace=""
                                    select="'', ''"
                                    separator="fMS"/>
                     <xsl:text>&lt;lb n="c56-0105__main__17"/&gt; &lt;del
                    rend="strikethrough"
                    xml:id="c56-0105__main__d5e22055"&gt;&amp;quot;&lt;/del&gt; "I
                </xsl:text>
                  </xsl:element>
               </xsl:element>
            </xsl:element>
         </xsl:element>
         <xsl:variable name="Q{urn:x-xspec:compile:impl}context-d138e0-doc"
                       as="document-node()">
            <xsl:document>
               <xsl:element name="rdgGrp" namespace="">
                  <xsl:namespace name="x">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
                  <xsl:attribute xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                 name="n"
                                 namespace=""
                                 select="'', ''"
                                 separator="['', '&lt;delstart/&gt;andquot;&lt;delend/&gt;', '&#34;i']"/>
                  <xsl:element name="rdg" namespace="">
                     <xsl:namespace name="x">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
                     <xsl:attribute xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                    name="wit"
                                    namespace=""
                                    select="'', ''"
                                    separator="fMS"/>
                     <xsl:text>&lt;lb n="c56-0105__main__17"/&gt; &lt;del
                    rend="strikethrough"
                    xml:id="c56-0105__main__d5e22055"&gt;&amp;quot;&lt;/del&gt; "I
                </xsl:text>
                  </xsl:element>
               </xsl:element>
            </xsl:document>
         </xsl:variable>
         <xsl:variable name="Q{urn:x-xspec:compile:impl}context-d138e0"
                       select="$Q{urn:x-xspec:compile:impl}context-d138e0-doc ! ( node() )"/>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}context"
                       as="item()*"
                       select="$Q{urn:x-xspec:compile:impl}context-d138e0"/>
         <xsl:element name="input-wrap" namespace="">
            <xsl:element name="x:call" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:attribute name="template" namespace="">normAmpFix</xsl:attribute>
            </xsl:element>
         </xsl:element>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}result" as="item()*">
            <xsl:for-each select="$Q{urn:x-xspec:compile:impl}context-d138e0">
               <xsl:call-template name="Q{}normAmpFix"/>
            </xsl:for-each>
         </xsl:variable>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            <xsl:with-param name="report-name" select="'result'"/>
         </xsl:call-template>
         <!-- invoke each compiled x:expect -->
         <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}xae6f131d-491c-3eb4-929c-e03263392a11-expect1">
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}context"/>
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}xae6f131d-491c-3eb4-929c-e03263392a11-expect1"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}test)">
      <xsl:context-item use="absent"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                 as="item()*"
                 required="yes"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                 as="item()*"
                 required="yes"/>
      <xsl:message>replace andquot; to " for @n</xsl:message>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}expect-d58e120-doc"
                    as="document-node()">
         <xsl:document>
            <xsl:element name="rdgGrp" namespace="">
               <xsl:namespace name="x">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
               <xsl:attribute xmlns:x="http://www.jenitennison.com/xslt/xspec"
                              name="n"
                              namespace=""
                              select="'', ''"
                              separator="['', '&lt;delstart/&gt;&#34;&lt;delend/&gt;', '&#34;i']"/>
               <xsl:element name="rdg" namespace="">
                  <xsl:namespace name="x">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
                  <xsl:attribute xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                 name="wit"
                                 namespace=""
                                 select="'', ''"
                                 separator="fMS"/>
                  <xsl:text>&lt;lb n="c56-0105__main__17"/&gt; &lt;del
                    rend="strikethrough"
                    xml:id="c56-0105__main__d5e22055"&gt;"&lt;/del&gt; "I
                </xsl:text>
               </xsl:element>
            </xsl:element>
         </xsl:document>
      </xsl:variable>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}expect-d58e120"
                    select="$Q{urn:x-xspec:compile:impl}expect-d58e120-doc ! ( node() )"><!--expected result--></xsl:variable>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}successful"
                    as="Q{http://www.w3.org/2001/XMLSchema}boolean"
                    select="Q{urn:x-xspec:common:deep-equal}deep-equal($Q{urn:x-xspec:compile:impl}expect-d58e120, $Q{http://www.jenitennison.com/xslt/xspec}result, '')"/>
      <xsl:if test="not($Q{urn:x-xspec:compile:impl}successful)">
         <xsl:message>      FAILED</xsl:message>
      </xsl:if>
      <xsl:element name="test" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">xae6f131d-491c-3eb4-929c-e03263392a11-expect1</xsl:attribute>
         <xsl:attribute name="successful"
                        namespace=""
                        select="$Q{urn:x-xspec:compile:impl}successful"/>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>replace andquot; to " for @n</xsl:text>
         </xsl:element>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence" select="$Q{urn:x-xspec:compile:impl}expect-d58e120"/>
            <xsl:with-param name="report-name" select="'expect'"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
</xsl:stylesheet>
