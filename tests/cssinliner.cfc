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

	<cffunction name="testSetThresholdIncorrectly">
		<cftry>
			<cfscript>
				var newTarget = createObject( 'component', 'com.awayken.cssinliner' ).init();
				newTarget.setThreshold( 'fail' );
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

</cfcomponent>