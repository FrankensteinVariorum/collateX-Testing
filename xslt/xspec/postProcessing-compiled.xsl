<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                exclude-result-prefixes="#all"
                version="3.0">
   <!-- the tested stylesheet -->
   <xsl:import href="file:/C:/Users/Jessie/Documents/Github/collateX-Testing/xslt/postProcessing.xsl"/>
   <!-- XSpec library modules providing tools -->
   <xsl:include href="file:/C:/Users/Jessie/AppData/Roaming/com.oxygenxml/extensions/v23.1/frameworks/https_www.oxygenxml.com_InstData_Addons_community_updateSite.xml/xspec.support-2.2.5/src/common/runtime-utils.xsl"/>
   <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}stylesheet-uri"
                 as="Q{http://www.w3.org/2001/XMLSchema}anyURI">file:/C:/Users/Jessie/Documents/Github/collateX-Testing/xslt/postProcessing.xsl</xsl:variable>
   <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}xspec-uri"
                 as="Q{http://www.w3.org/2001/XMLSchema}anyURI">file:/C:/Users/Jessie/Documents/Github/collateX-Testing/xslt/postProcessing.xspec</xsl:variable>
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
   <xsl:variable xmlns:x="http://www.jenitennison.com/xslt/xspec"
                 name="Q{}testFile"
                 select="../simpleOutput/Collation_C14_b.xml"/>
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
            <xsl:attribute name="xspec" namespace="">file:/C:/Users/Jessie/Documents/Github/collateX-Testing/xslt/postProcessing.xspec</xsl:attribute>
            <xsl:attribute name="stylesheet" namespace="">file:/C:/Users/Jessie/Documents/Github/collateX-Testing/xslt/postProcessing.xsl</xsl:attribute>
            <xsl:attribute name="date" namespace="" select="current-dateTime()"/>
            <!-- invoke each compiled top-level x:scenario -->
            <xsl:for-each select="1 to 7">
               <xsl:choose>
                  <xsl:when test=". eq 1">
                     <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}x645b9013-0c8d-3c92-ae53-9216f2a60443"/>
                  </xsl:when>
                  <xsl:when test=". eq 2">
                     <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}x18929eca-33b4-34df-ba59-bfec579288a4"/>
                  </xsl:when>
                  <xsl:when test=". eq 3">
                     <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}xb74bbc6e-24cd-3892-830e-e1df568f6d5a"/>
                  </xsl:when>
                  <xsl:when test=". eq 4">
                     <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}x79f59b8b-37f2-3e30-8a1a-eebfdaa620c7"/>
                  </xsl:when>
                  <xsl:when test=". eq 5">
                     <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}x8f5ab7e9-27b7-35c5-9c46-662859f9c74a"/>
                  </xsl:when>
                  <xsl:when test=". eq 6">
                     <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}xd5341b0b-0dc2-3aa9-899f-ae8296367d1a"/>
                  </xsl:when>
                  <xsl:when test=". eq 7">
                     <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}xee3396ba-0f4a-3f13-b4d0-2a446a848210"/>
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
         <xsl:attribute name="xspec" namespace="">file:/C:/Users/Jessie/Documents/Github/collateX-Testing/xslt/postProcessing.xspec</xsl:attribute>
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
         <xsl:variable name="Q{urn:x-xspec:compile:impl}context-d61e0-doc"
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
         <xsl:variable name="Q{urn:x-xspec:compile:impl}context-d61e0"
                       select="$Q{urn:x-xspec:compile:impl}context-d61e0-doc ! ( node() )"/>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}context"
                       as="item()*"
                       select="$Q{urn:x-xspec:compile:impl}context-d61e0"/>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}result" as="item()*">
            <xsl:apply-templates select="$Q{urn:x-xspec:compile:impl}context-d61e0"/>
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
      <xsl:message>Not yet implemented</xsl:message>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}expect-d59e22-doc"
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
      <xsl:variable xmlns:x="http://www.jenitennison.com/xslt/xspec"
                    name="Q{urn:x-xspec:compile:impl}expect-d59e22"
                    select="$Q{urn:x-xspec:compile:impl}expect-d59e22-doc ! ( 'Not yet implemented' )"><!--expected result--></xsl:variable>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}successful"
                    as="Q{http://www.w3.org/2001/XMLSchema}boolean"
                    select="Q{urn:x-xspec:common:deep-equal}deep-equal($Q{urn:x-xspec:compile:impl}expect-d59e22, $Q{http://www.jenitennison.com/xslt/xspec}result, '')"/>
      <xsl:if test="not($Q{urn:x-xspec:compile:impl}successful)">
         <xsl:message>      FAILED</xsl:message>
      </xsl:if>
      <xsl:element name="test" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">x645b9013-0c8d-3c92-ae53-9216f2a60443-expect1</xsl:attribute>
         <xsl:attribute name="successful"
                        namespace=""
                        select="$Q{urn:x-xspec:compile:impl}successful"/>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>Not yet implemented</xsl:text>
         </xsl:element>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence" select="$Q{urn:x-xspec:compile:impl}expect-d59e22"/>
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
         <xsl:attribute name="xspec" namespace="">file:/C:/Users/Jessie/Documents/Github/collateX-Testing/xslt/postProcessing.xspec</xsl:attribute>
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
         <xsl:variable name="Q{urn:x-xspec:compile:impl}context-d69e0-doc"
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
         <xsl:variable name="Q{urn:x-xspec:compile:impl}context-d69e0"
                       select="$Q{urn:x-xspec:compile:impl}context-d69e0-doc ! ( node() )"/>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}context"
                       as="item()*"
                       select="$Q{urn:x-xspec:compile:impl}context-d69e0"/>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}result" as="item()*">
            <xsl:apply-templates select="$Q{urn:x-xspec:compile:impl}context-d69e0"/>
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
      <xsl:message>Not yet implemented</xsl:message>
      <xsl:variable xmlns:x="http://www.jenitennison.com/xslt/xspec"
                    name="Q{urn:x-xspec:compile:impl}expect-d59e51"
                    select="'Not yet implemented'"><!--expected result--></xsl:variable>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}successful"
                    as="Q{http://www.w3.org/2001/XMLSchema}boolean"
                    select="Q{urn:x-xspec:common:deep-equal}deep-equal($Q{urn:x-xspec:compile:impl}expect-d59e51, $Q{http://www.jenitennison.com/xslt/xspec}result, '')"/>
      <xsl:if test="not($Q{urn:x-xspec:compile:impl}successful)">
         <xsl:message>      FAILED</xsl:message>
      </xsl:if>
      <xsl:element name="test" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">x18929eca-33b4-34df-ba59-bfec579288a4-expect1</xsl:attribute>
         <xsl:attribute name="successful"
                        namespace=""
                        select="$Q{urn:x-xspec:compile:impl}successful"/>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>Not yet implemented</xsl:text>
         </xsl:element>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence" select="$Q{urn:x-xspec:compile:impl}expect-d59e51"/>
            <xsl:with-param name="report-name" select="'expect'"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}xb74bbc6e-24cd-3892-830e-e1df568f6d5a"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}scenario)">
      <xsl:context-item use="absent"/>
      <xsl:message>Scenario for testing template with match 'app' and mode 'restructure'</xsl:message>
      <xsl:element name="scenario" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">xb74bbc6e-24cd-3892-830e-e1df568f6d5a</xsl:attribute>
         <xsl:attribute name="xspec" namespace="">file:/C:/Users/Jessie/Documents/Github/collateX-Testing/xslt/postProcessing.xspec</xsl:attribute>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>Scenario for testing template with match 'app' and mode 'restructure'</xsl:text>
         </xsl:element>
         <xsl:element name="input-wrap" namespace="">
            <xsl:element name="x:context" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:attribute name="mode" namespace="">restructure</xsl:attribute>
               <xsl:element name="x:param" namespace="http://www.jenitennison.com/xslt/xspec">
                  <xsl:attribute name="name" namespace="">loner</xsl:attribute>
                  <xsl:attribute name="select" namespace="">'no_value'</xsl:attribute>
                  <xsl:attribute name="tunnel" namespace="">yes</xsl:attribute>
               </xsl:element>
               <xsl:element name="x:param" namespace="http://www.jenitennison.com/xslt/xspec">
                  <xsl:attribute name="name" namespace="">norm</xsl:attribute>
                  <xsl:attribute name="select" namespace="">'no_value'</xsl:attribute>
                  <xsl:attribute name="tunnel" namespace="">yes</xsl:attribute>
               </xsl:element>
            </xsl:element>
         </xsl:element>
         <xsl:variable name="Q{urn:x-xspec:compile:impl}context-d77e0-doc"
                       as="document-node()">
            <xsl:document/>
         </xsl:variable>
         <xsl:variable name="Q{urn:x-xspec:compile:impl}context-d77e0"
                       select="$Q{urn:x-xspec:compile:impl}context-d77e0-doc ! ( node() )"/>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}context"
                       as="item()*"
                       select="$Q{urn:x-xspec:compile:impl}context-d77e0"/>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}result" as="item()*">
            <xsl:variable xmlns:x="http://www.jenitennison.com/xslt/xspec"
                          name="Q{}loner"
                          select="'no_value'"/>
            <xsl:variable xmlns:x="http://www.jenitennison.com/xslt/xspec"
                          name="Q{}norm"
                          select="'no_value'"/>
            <xsl:apply-templates select="$Q{urn:x-xspec:compile:impl}context-d77e0"
                                 mode="Q{}restructure">
               <xsl:with-param xmlns:x="http://www.jenitennison.com/xslt/xspec"
                               name="Q{}loner"
                               select="$Q{}loner"
                               tunnel="yes"/>
               <xsl:with-param xmlns:x="http://www.jenitennison.com/xslt/xspec"
                               name="Q{}norm"
                               select="$Q{}norm"
                               tunnel="yes"/>
            </xsl:apply-templates>
         </xsl:variable>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            <xsl:with-param name="report-name" select="'result'"/>
         </xsl:call-template>
         <!-- invoke each compiled x:expect -->
         <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}xb74bbc6e-24cd-3892-830e-e1df568f6d5a-expect1">
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}context"/>
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}xb74bbc6e-24cd-3892-830e-e1df568f6d5a-expect1"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}test)">
      <xsl:context-item use="absent"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                 as="item()*"
                 required="yes"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                 as="item()*"
                 required="yes"/>
      <xsl:message>Not yet implemented</xsl:message>
      <xsl:variable xmlns:x="http://www.jenitennison.com/xslt/xspec"
                    name="Q{urn:x-xspec:compile:impl}expect-d59e56"
                    select="'Not yet implemented'"><!--expected result--></xsl:variable>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}successful"
                    as="Q{http://www.w3.org/2001/XMLSchema}boolean"
                    select="Q{urn:x-xspec:common:deep-equal}deep-equal($Q{urn:x-xspec:compile:impl}expect-d59e56, $Q{http://www.jenitennison.com/xslt/xspec}result, '')"/>
      <xsl:if test="not($Q{urn:x-xspec:compile:impl}successful)">
         <xsl:message>      FAILED</xsl:message>
      </xsl:if>
      <xsl:element name="test" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">xb74bbc6e-24cd-3892-830e-e1df568f6d5a-expect1</xsl:attribute>
         <xsl:attribute name="successful"
                        namespace=""
                        select="$Q{urn:x-xspec:compile:impl}successful"/>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>Not yet implemented</xsl:text>
         </xsl:element>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence" select="$Q{urn:x-xspec:compile:impl}expect-d59e56"/>
            <xsl:with-param name="report-name" select="'expect'"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}x79f59b8b-37f2-3e30-8a1a-eebfdaa620c7"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}scenario)">
      <xsl:context-item use="absent"/>
      <xsl:message>Scenario for testing template with match 'rdgGrp' and mode 'restructure'</xsl:message>
      <xsl:element name="scenario" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">x79f59b8b-37f2-3e30-8a1a-eebfdaa620c7</xsl:attribute>
         <xsl:attribute name="xspec" namespace="">file:/C:/Users/Jessie/Documents/Github/collateX-Testing/xslt/postProcessing.xspec</xsl:attribute>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>Scenario for testing template with match 'rdgGrp' and mode 'restructure'</xsl:text>
         </xsl:element>
         <xsl:element name="input-wrap" namespace="">
            <xsl:element name="x:context" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:attribute name="mode" namespace="">restructure</xsl:attribute>
               <xsl:element name="x:param" namespace="http://www.jenitennison.com/xslt/xspec">
                  <xsl:attribute name="name" namespace="">loner</xsl:attribute>
                  <xsl:attribute name="select" namespace="">'no_value'</xsl:attribute>
                  <xsl:attribute name="tunnel" namespace="">yes</xsl:attribute>
               </xsl:element>
            </xsl:element>
         </xsl:element>
         <xsl:variable name="Q{urn:x-xspec:compile:impl}context-d85e0-doc"
                       as="document-node()">
            <xsl:document/>
         </xsl:variable>
         <xsl:variable name="Q{urn:x-xspec:compile:impl}context-d85e0"
                       select="$Q{urn:x-xspec:compile:impl}context-d85e0-doc ! ( node() )"/>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}context"
                       as="item()*"
                       select="$Q{urn:x-xspec:compile:impl}context-d85e0"/>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}result" as="item()*">
            <xsl:variable xmlns:x="http://www.jenitennison.com/xslt/xspec"
                          name="Q{}loner"
                          select="'no_value'"/>
            <xsl:apply-templates select="$Q{urn:x-xspec:compile:impl}context-d85e0"
                                 mode="Q{}restructure">
               <xsl:with-param xmlns:x="http://www.jenitennison.com/xslt/xspec"
                               name="Q{}loner"
                               select="$Q{}loner"
                               tunnel="yes"/>
            </xsl:apply-templates>
         </xsl:variable>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            <xsl:with-param name="report-name" select="'result'"/>
         </xsl:call-template>
         <!-- invoke each compiled x:expect -->
         <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}x79f59b8b-37f2-3e30-8a1a-eebfdaa620c7-expect1">
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}context"/>
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}x79f59b8b-37f2-3e30-8a1a-eebfdaa620c7-expect1"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}test)">
      <xsl:context-item use="absent"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                 as="item()*"
                 required="yes"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                 as="item()*"
                 required="yes"/>
      <xsl:message>Not yet implemented</xsl:message>
      <xsl:variable xmlns:x="http://www.jenitennison.com/xslt/xspec"
                    name="Q{urn:x-xspec:compile:impl}expect-d59e60"
                    select="'Not yet implemented'"><!--expected result--></xsl:variable>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}successful"
                    as="Q{http://www.w3.org/2001/XMLSchema}boolean"
                    select="Q{urn:x-xspec:common:deep-equal}deep-equal($Q{urn:x-xspec:compile:impl}expect-d59e60, $Q{http://www.jenitennison.com/xslt/xspec}result, '')"/>
      <xsl:if test="not($Q{urn:x-xspec:compile:impl}successful)">
         <xsl:message>      FAILED</xsl:message>
      </xsl:if>
      <xsl:element name="test" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">x79f59b8b-37f2-3e30-8a1a-eebfdaa620c7-expect1</xsl:attribute>
         <xsl:attribute name="successful"
                        namespace=""
                        select="$Q{urn:x-xspec:compile:impl}successful"/>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>Not yet implemented</xsl:text>
         </xsl:element>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence" select="$Q{urn:x-xspec:compile:impl}expect-d59e60"/>
            <xsl:with-param name="report-name" select="'expect'"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}x8f5ab7e9-27b7-35c5-9c46-662859f9c74a"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}scenario)">
      <xsl:context-item use="absent"/>
      <xsl:message>Scenario for testing template with match 'rdgGrp' and mode 'emptyNormalize'</xsl:message>
      <xsl:element name="scenario" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">x8f5ab7e9-27b7-35c5-9c46-662859f9c74a</xsl:attribute>
         <xsl:attribute name="xspec" namespace="">file:/C:/Users/Jessie/Documents/Github/collateX-Testing/xslt/postProcessing.xspec</xsl:attribute>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>Scenario for testing template with match 'rdgGrp' and mode 'emptyNormalize'</xsl:text>
         </xsl:element>
         <xsl:element name="input-wrap" namespace="">
            <xsl:element name="x:context" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:attribute name="mode" namespace="">emptyNormalize</xsl:attribute>
               <xsl:element name="x:param" namespace="http://www.jenitennison.com/xslt/xspec">
                  <xsl:attribute name="name" namespace="">lonerText</xsl:attribute>
                  <xsl:attribute name="select" namespace="">'no_value'</xsl:attribute>
                  <xsl:attribute name="tunnel" namespace="">yes</xsl:attribute>
               </xsl:element>
               <xsl:element name="x:param" namespace="http://www.jenitennison.com/xslt/xspec">
                  <xsl:attribute name="name" namespace="">lonerWit</xsl:attribute>
                  <xsl:attribute name="select" namespace="">'no_value'</xsl:attribute>
                  <xsl:attribute name="tunnel" namespace="">yes</xsl:attribute>
               </xsl:element>
            </xsl:element>
         </xsl:element>
         <xsl:variable name="Q{urn:x-xspec:compile:impl}context-d93e0-doc"
                       as="document-node()">
            <xsl:document/>
         </xsl:variable>
         <xsl:variable name="Q{urn:x-xspec:compile:impl}context-d93e0"
                       select="$Q{urn:x-xspec:compile:impl}context-d93e0-doc ! ( node() )"/>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}context"
                       as="item()*"
                       select="$Q{urn:x-xspec:compile:impl}context-d93e0"/>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}result" as="item()*">
            <xsl:variable xmlns:x="http://www.jenitennison.com/xslt/xspec"
                          name="Q{}lonerText"
                          select="'no_value'"/>
            <xsl:variable xmlns:x="http://www.jenitennison.com/xslt/xspec"
                          name="Q{}lonerWit"
                          select="'no_value'"/>
            <xsl:apply-templates select="$Q{urn:x-xspec:compile:impl}context-d93e0"
                                 mode="Q{}emptyNormalize">
               <xsl:with-param xmlns:x="http://www.jenitennison.com/xslt/xspec"
                               name="Q{}lonerText"
                               select="$Q{}lonerText"
                               tunnel="yes"/>
               <xsl:with-param xmlns:x="http://www.jenitennison.com/xslt/xspec"
                               name="Q{}lonerWit"
                               select="$Q{}lonerWit"
                               tunnel="yes"/>
            </xsl:apply-templates>
         </xsl:variable>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            <xsl:with-param name="report-name" select="'result'"/>
         </xsl:call-template>
         <!-- invoke each compiled x:expect -->
         <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}x8f5ab7e9-27b7-35c5-9c46-662859f9c74a-expect1">
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}context"/>
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}x8f5ab7e9-27b7-35c5-9c46-662859f9c74a-expect1"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}test)">
      <xsl:context-item use="absent"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                 as="item()*"
                 required="yes"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                 as="item()*"
                 required="yes"/>
      <xsl:message>Not yet implemented</xsl:message>
      <xsl:variable xmlns:x="http://www.jenitennison.com/xslt/xspec"
                    name="Q{urn:x-xspec:compile:impl}expect-d59e65"
                    select="'Not yet implemented'"><!--expected result--></xsl:variable>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}successful"
                    as="Q{http://www.w3.org/2001/XMLSchema}boolean"
                    select="Q{urn:x-xspec:common:deep-equal}deep-equal($Q{urn:x-xspec:compile:impl}expect-d59e65, $Q{http://www.jenitennison.com/xslt/xspec}result, '')"/>
      <xsl:if test="not($Q{urn:x-xspec:compile:impl}successful)">
         <xsl:message>      FAILED</xsl:message>
      </xsl:if>
      <xsl:element name="test" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">x8f5ab7e9-27b7-35c5-9c46-662859f9c74a-expect1</xsl:attribute>
         <xsl:attribute name="successful"
                        namespace=""
                        select="$Q{urn:x-xspec:compile:impl}successful"/>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>Not yet implemented</xsl:text>
         </xsl:element>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence" select="$Q{urn:x-xspec:compile:impl}expect-d59e65"/>
            <xsl:with-param name="report-name" select="'expect'"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}xd5341b0b-0dc2-3aa9-899f-ae8296367d1a"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}scenario)">
      <xsl:context-item use="absent"/>
      <xsl:message>Scenario for testing template with match 'rdg/text()</xsl:message>
      <xsl:element name="scenario" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">xd5341b0b-0dc2-3aa9-899f-ae8296367d1a</xsl:attribute>
         <xsl:attribute name="xspec" namespace="">file:/C:/Users/Jessie/Documents/Github/collateX-Testing/xslt/postProcessing.xspec</xsl:attribute>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>Scenario for testing template with match 'rdg/text()</xsl:text>
         </xsl:element>
         <xsl:element name="input-wrap" namespace="">
            <xsl:element name="x:context" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:attribute name="href" namespace="">file:/C:/Users/Jessie/Documents/Github/collateX-Testing/simpleOutput/Collation_C14_b.xml</xsl:attribute>
               <xsl:attribute name="select" namespace="">rdg/text()</xsl:attribute>
            </xsl:element>
         </xsl:element>
         <xsl:variable name="Q{urn:x-xspec:compile:impl}context-d101e0-doc"
                       as="document-node()"
                       select="doc('file:/C:/Users/Jessie/Documents/Github/collateX-Testing/simpleOutput/Collation_C14_b.xml')"/>
         <xsl:variable xmlns:x="http://www.jenitennison.com/xslt/xspec"
                       name="Q{urn:x-xspec:compile:impl}context-d101e0"
                       select="$Q{urn:x-xspec:compile:impl}context-d101e0-doc ! ( rdg/text() )"/>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}context"
                       as="item()*"
                       select="$Q{urn:x-xspec:compile:impl}context-d101e0"/>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}result" as="item()*">
            <xsl:apply-templates select="$Q{urn:x-xspec:compile:impl}context-d101e0"/>
         </xsl:variable>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            <xsl:with-param name="report-name" select="'result'"/>
         </xsl:call-template>
         <!-- invoke each compiled x:expect -->
         <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}xd5341b0b-0dc2-3aa9-899f-ae8296367d1a-expect1">
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}context"/>
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}xd5341b0b-0dc2-3aa9-899f-ae8296367d1a-expect1"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}test)">
      <xsl:context-item use="absent"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                 as="item()*"
                 required="yes"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                 as="item()*"
                 required="yes"/>
      <xsl:message>Not yet implemented</xsl:message>
      <xsl:variable xmlns:x="http://www.jenitennison.com/xslt/xspec"
                    name="Q{urn:x-xspec:compile:impl}expect-d59e68"
                    select="'Not yet implemented'"><!--expected result--></xsl:variable>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}successful"
                    as="Q{http://www.w3.org/2001/XMLSchema}boolean"
                    select="Q{urn:x-xspec:common:deep-equal}deep-equal($Q{urn:x-xspec:compile:impl}expect-d59e68, $Q{http://www.jenitennison.com/xslt/xspec}result, '')"/>
      <xsl:if test="not($Q{urn:x-xspec:compile:impl}successful)">
         <xsl:message>      FAILED</xsl:message>
      </xsl:if>
      <xsl:element name="test" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">xd5341b0b-0dc2-3aa9-899f-ae8296367d1a-expect1</xsl:attribute>
         <xsl:attribute name="successful"
                        namespace=""
                        select="$Q{urn:x-xspec:compile:impl}successful"/>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>Not yet implemented</xsl:text>
         </xsl:element>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence" select="$Q{urn:x-xspec:compile:impl}expect-d59e68"/>
            <xsl:with-param name="report-name" select="'expect'"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}xee3396ba-0f4a-3f13-b4d0-2a446a848210"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}scenario)">
      <xsl:context-item use="absent"/>
      <xsl:message>Scenario for testing template with match 'rdgGrp</xsl:message>
      <xsl:element name="scenario" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">xee3396ba-0f4a-3f13-b4d0-2a446a848210</xsl:attribute>
         <xsl:attribute name="xspec" namespace="">file:/C:/Users/Jessie/Documents/Github/collateX-Testing/xslt/postProcessing.xspec</xsl:attribute>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>Scenario for testing template with match 'rdgGrp</xsl:text>
         </xsl:element>
         <xsl:element name="input-wrap" namespace="">
            <xsl:element name="x:context" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:attribute name="href" namespace="">file:/C:/Users/Jessie/Documents/Github/collateX-Testing/simpleOutput/Collation_C14_b.xml</xsl:attribute>
               <xsl:attribute name="select" namespace="">rdgGrp</xsl:attribute>
            </xsl:element>
         </xsl:element>
         <xsl:variable name="Q{urn:x-xspec:compile:impl}context-d109e0-doc"
                       as="document-node()"
                       select="doc('file:/C:/Users/Jessie/Documents/Github/collateX-Testing/simpleOutput/Collation_C14_b.xml')"/>
         <xsl:variable xmlns:x="http://www.jenitennison.com/xslt/xspec"
                       name="Q{urn:x-xspec:compile:impl}context-d109e0"
                       select="$Q{urn:x-xspec:compile:impl}context-d109e0-doc ! ( rdgGrp )"/>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}context"
                       as="item()*"
                       select="$Q{urn:x-xspec:compile:impl}context-d109e0"/>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}result" as="item()*">
            <xsl:apply-templates select="$Q{urn:x-xspec:compile:impl}context-d109e0"/>
         </xsl:variable>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            <xsl:with-param name="report-name" select="'result'"/>
         </xsl:call-template>
         <!-- invoke each compiled x:expect -->
         <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}xee3396ba-0f4a-3f13-b4d0-2a446a848210-expect1">
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}context"/>
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}xee3396ba-0f4a-3f13-b4d0-2a446a848210-expect1"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}test)">
      <xsl:context-item use="absent"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                 as="item()*"
                 required="yes"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                 as="item()*"
                 required="yes"/>
      <xsl:message>Not yet implemented</xsl:message>
      <xsl:variable xmlns:x="http://www.jenitennison.com/xslt/xspec"
                    name="Q{urn:x-xspec:compile:impl}expect-d59e71"
                    select="'Not yet implemented'"><!--expected result--></xsl:variable>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}successful"
                    as="Q{http://www.w3.org/2001/XMLSchema}boolean"
                    select="Q{urn:x-xspec:common:deep-equal}deep-equal($Q{urn:x-xspec:compile:impl}expect-d59e71, $Q{http://www.jenitennison.com/xslt/xspec}result, '')"/>
      <xsl:if test="not($Q{urn:x-xspec:compile:impl}successful)">
         <xsl:message>      FAILED</xsl:message>
      </xsl:if>
      <xsl:element name="test" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">xee3396ba-0f4a-3f13-b4d0-2a446a848210-expect1</xsl:attribute>
         <xsl:attribute name="successful"
                        namespace=""
                        select="$Q{urn:x-xspec:compile:impl}successful"/>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>Not yet implemented</xsl:text>
         </xsl:element>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence" select="$Q{urn:x-xspec:compile:impl}expect-d59e71"/>
            <xsl:with-param name="report-name" select="'expect'"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
</xsl:stylesheet>
