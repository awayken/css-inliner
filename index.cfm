<cfsilent>
	<cfset cssinliner = createObject( 'component', 'com.awayken.cssinliner' ).init()>
</cfsilent>
<!DOCTYPE html>
<html lang="en">
<head>
	<title>CSS Inliner Demo</title>
<cfscript>
	cssinliner.showCSS('css/small.css');
	cssinliner.showCSS('css/big.css');
</cfscript>
</head>
<body>
	<h1>CSS Inliner Demo</h1>
	<p>This page includes two calls to the CSS Inliner's <code>showCSS()</code> method:</p>
	<ol>
		<li><code>small.css</code> &mdash; a CSS file smaller than 4KB</li>
		<li><code>big.css</code> &mdash; a CSS file larger than 4KB</li>
	</ol>
	<p>View source to see how the CSS files were handled.</p>
	<p>To inline multiple files at the same time, pass in an array:</p>
	<pre><code>cssinliner.showCSS([
	'css/small.css',
	'css/big.css'
]);</pre></code>
</body>
</html>
