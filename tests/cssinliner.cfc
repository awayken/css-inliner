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
					assert( len( cfcatch.message ), 'Function properly fails non-numeric values for threshold.' );
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
			assertEquals( '<link rel="stylesheet" href="css/small.css">', cssLink );
			cssLink = defaultTarget.getCSSLink( cssURL, 'html5' );
			assertEquals( '<link rel="stylesheet" href="css/small.css">', cssLink );
			cssLink = defaultTarget.getCSSLink( cssURL, 'xhtml' );
			assertEquals( '<link rel="stylesheet" type="text/css" href="css/small.css" />', cssLink );
		</cfscript>
	</cffunction>

	<cffunction name="testGetCSSContent">
		<cfscript>
			var defaultTarget = createObject( 'component', 'com.awayken.cssinliner' ).init();
			var cssURL = '/tests/css/small.css';
			var cssContent = '';

			cssContent = defaultTarget.getCSSContent( cssURL );
			assertEquals( 'body { color: ##000; background: ##fff; }', cssContent );
		</cfscript>
	</cffunction>

	<cffunction name="testGetCSS">
		<cfscript>
			var defaultTarget = createObject( 'component', 'com.awayken.cssinliner' ).init();
			var cssURL = '/tests/css/small.css';
			var cssURLs = [ '/tests/css/small.css', '/tests/css/big.css' ];
			var css = '';

			css = defaultTarget.getCSS( cssURL );
			assertEquals( '<style>' & defaultTarget.getCSSContent( cssURL ) & '</style>', css );
			defaultTarget.setThreshold( 1 );
			css = defaultTarget.getCSS( cssURL );
			assertEquals( defaultTarget.getCSSLink( cssURL ), css );
		</cfscript>
	</cffunction>

</cfcomponent>
