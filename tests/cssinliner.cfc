<cfcomponent extends="mxunit.framework.TestCase">

<!---
	Init tests
--->
	<cffunction name="testInit">
		<cfscript>
			var defaultTarget = createObject( 'component', 'com.awayken.cssinliner' ).init();

			assertIsTypeOf( defaultTarget, 'com.awayken.cssinliner' );
		</cfscript>
	</cffunction>

	<cffunction name="testGetSetThreshold">
		<cfscript>
			var defaultTarget = createObject( 'component', 'com.awayken.cssinliner' ).init();
			var newTarget = createObject( 'component', 'com.awayken.cssinliner' ).init( 1024 );

			assertEquals( defaultTarget.getThreshold(), 4096 );
			assertEquals( newTarget.getThreshold(), 1024 );
			newTarget.setThreshold( 2048 );
			assertEquals( newTarget.getThreshold(), 2048 );
		</cfscript>
	</cffunction>

	<cffunction name="testSetThresholdIncorrectly">
		<cftry>
			<cfscript>
				var newTarget = createObject( 'component', 'com.awayken.cssinliner' ).init();
				newTarget.setThreshold('fail');
				fail('Passed numeric value for threshold.');
			</cfscript>

			<cfcatch type="mxunit.exception.AssertionFailedError">
				<cfrethrow />
			</cfcatch>

			<cfcatch type="any">
				<cfscript>
					assertEquals( cfcatch.message, 'The argument THRESHOLD passed to function setthreshold() is not of type numeric', 'Function properly fails non-numeric values for threshold.' );
				</cfscript>
			</cfcatch>
		</cftry>
	</cffunction>




<!---
	getCSS tests
--->
	<cffunction name="testGetCSSLink">
		<cfscript>
			var defaultTarget = createObject( 'component', 'com.awayken.cssinliner' ).init();
			var cssURL = 'css/small.css';
			var cssLink = '';

			cssLink = defaultTarget.getCSSLink( cssURL );
			assertEquals( cssLink, '<link rel="stylesheet" href="css/small.css">' );
			cssLink = defaultTarget.getCSSLink( cssURL, 'html5' );
			assertEquals( cssLink, '<link rel="stylesheet" href="css/small.css">' );
			cssLink = defaultTarget.getCSSLink( cssURL, 'xhtml' );
			assertEquals( cssLink, '<link rel="stylesheet" type="text/css" href="css/small.css" />' );
		</cfscript>
	</cffunction>

	<cffunction name="testGetCSSContent">
		<cfscript>
			var defaultTarget = createObject( 'component', 'com.awayken.cssinliner' ).init();
			var cssURL = 'css/small.css';
			var cssContent = '';

			cssContent = defaultTarget.getCSSContent( cssURL );
			assertEquals( cssContent, 'body { color: ##000; background: ##fff; }' );
		</cfscript>
	</cffunction>

	<cffunction name="testGetCSS">
		<cfscript>
			var defaultTarget = createObject( 'component', 'com.awayken.cssinliner' ).init();
			var cssURL = 'css/small.css';
			var cssURLs = [ 'css/small.css', 'css/big.css' ];
			var css = '';

			css = defaultTarget.getCSS( cssURL );
			assertEquals( css, '<style>' & defaultTarget.getCSSContent( cssURL ) & '</style>' );
			defaultTarget.setThreshold( 1 );
			css = defaultTarget.getCSS( cssURL );
			assertEquals( css, defaultTarget.getCSSLink( cssURL ) );
		</cfscript>
	</cffunction>

</cfcomponent>