# Collation problems from tokenized markup
2022-07-29
Updated: 2022-08-10

- [ ] For the post-processing production pipeline, we need to **move** all the solitary content-bearing witnesses either up or down to their preceding or following app elements. Here is a helpful XPath expression to isolate all the content-bearing solitary witnesses:

```
//app[count(descendant::rdg) = 1][rdgGrp/@n ! matches(., '[a-z]{2,}')]//rdg
```

- [x]  Alignment disruption across multiple apps, due to alignment of empty normalized tokens
*Solved! moved `<pb>` to inlineEmpty set in the Python collation script. The extract() function does not add newline characters around inlineEmpty set of elements.*

```xml
<app>
		<rdgGrp n="['fathers', 'account']">
			<rdg wit="fMS">fathers account </rdg>
		</rdgGrp>
		<rdgGrp n="['father’s']">
			<rdg wit="f1818">father’s </rdg>
			<rdg wit="f1823">father’s </rdg>
			<rdg wit="fThomas">father’s </rdg>
			<rdg wit="f1831">father’s </rdg>
		</rdgGrp>
	</app>
	<app>
		<rdgGrp n="['ac']">
			<rdg wit="f1818">ac </rdg>
			<rdg wit="f1823">ac </rdg>
			<rdg wit="fThomas">ac </rdg>
		</rdgGrp>
		<rdgGrp n="['account:']">
			<rdg wit="f1831">account: </rdg>
		</rdgGrp>
	</app>
	<app>
		<rdgGrp n="['']">
			<rdg wit="f1818">&lt;pb xml:id=&quot;F1818_v3_071&quot; n=&quot;067&quot;/&gt; </rdg>
			<rdg wit="f1823">&lt;pb xml:id=&quot;F1823_v2_428&quot; n=&quot;155&quot;/&gt; </rdg>
			<rdg wit="fThomas">&lt;pb xml:id=&quot;F1818_v3_071&quot; n=&quot;067&quot;/&gt; </rdg>
			<rdg wit="fMS">&lt;lb n=&quot;c57-0118__main__17&quot;/&gt; </rdg>
		</rdgGrp>
	</app>
	<app>
		<rdgGrp n="['count:']">
			<rdg wit="f1818">count: </rdg>
			<rdg wit="f1823">count: </rdg>
			<rdg wit="fThomas">count: </rdg>
		</rdgGrp>
	</app>
```	
- [x]  SGA Manuscript paragraphs only make one token at starting point, so they don't align with paragraph endings / beginnings. 
*Solved by pre-processing to add end-p tags to match across all the editions.*

```xml
<app>
		<rdgGrp n="['afterwards', 'found.', '&lt;p/&gt;']">
			<rdg wit="f1818">afterwards found. &lt;p eID=&quot;novel1_letter4_chapter20_div4_div22_p5&quot;/&gt; </rdg>
			<rdg wit="f1823">afterwards found. &lt;p eID=&quot;novel1_letter4_chapter20_div4_div21_p5&quot;/&gt; </rdg>
			<rdg wit="fThomas">afterwards found. &lt;p eID=&quot;novel1_letter4_chapter20_div4_div22_p5&quot;/&gt; </rdg>
			<rdg wit="f1831">afterwards found. &lt;p eID=&quot;novel1_letter4_chapter21_div4_div21_p5&quot;/&gt; </rdg>
			<rdg wit="fMS">afterwards found. &lt;milestone unit=&quot;tei:p&quot;/&gt; </rdg>
		</rdgGrp>
	</app>
	<app>
		<rdgGrp n="['']">
			<rdg wit="fMS">&lt;lb n=&quot;c57-0118__main__32&quot;/&gt; </rdg>
		</rdgGrp>
		<rdgGrp n="['&lt;p/&gt;']">
			<rdg wit="f1818">&lt;p sID=&quot;novel1_letter4_chapter20_div4_div22_p6&quot;/&gt; </rdg>
			<rdg wit="f1823">&lt;p sID=&quot;novel1_letter4_chapter20_div4_div21_p6&quot;/&gt; </rdg>
			<rdg wit="fThomas">&lt;p sID=&quot;novel1_letter4_chapter20_div4_div22_p6&quot;/&gt; </rdg>
			<rdg wit="f1831">&lt;p sID=&quot;novel1_letter4_chapter21_div4_div21_p6&quot;/&gt; </rdg>
		</rdgGrp>
	</app>
	<app>
		<rdgGrp n="['another', 'woman', 'confirmed', 'the']">
			<rdg wit="f1818">Another woman confirmed the </rdg>
			<rdg wit="f1823">Another woman confirmed the </rdg>
			<rdg wit="fThomas">Another woman confirmed the </rdg>
			<rdg wit="f1831">Another woman confirmed the </rdg>
			<rdg wit="fMS">Another woman confirmed the </rdg>
		</rdgGrp>
	</app>

```


