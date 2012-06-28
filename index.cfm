<cfsilent>
	<cfset cssinliner = createObject( 'component', 'com.awayken.cssinliner' ).init( 100 )>
</cfsilent>
<!DOCTYPE html>
<html lang="en">
<head>
	<title>CSS Inliner Demo</title>
<cfscript>
	cssinliner.showCSS('css/small.css');
	cssinliner.showCSS('css/big.css');
	cssinliner.showCSS([
		'css/small.css',
		'css/big.css'
	]);
</cfscript>
</head>
<body>
	<h1>CSS Inliner Demo</h1>
	<p>This page includes three calls to the CSS Inliner's <code>show()</code> method:</p>
	<ol>
		<li><code>small.css</code> &mdash; a CSS file smaller than 4KB</li>
		<li><code>big.css</code> &mdash; a CSS file larger than 4KB</li>
		<li><code>[ 'small.css', 'big.css' ]</code> &mdash; both files</li>
	</ol>
</body>
</html>
