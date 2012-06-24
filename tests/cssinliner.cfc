<cfcomponent extends="mxunit.framework.TestCase">

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

</cfcomponent>