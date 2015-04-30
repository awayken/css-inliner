<cfcomponent name="CSS Inliner">
	<cfproperty name="threshold" type="numeric" required="no" default="4096"
				hint="This is the filesize that the system should consider when deciding whether to inline or not.">

	<cfset this.threshold = 4096>

	<cffunction name="init" returntype="cssinliner">

		<cfargument name="threshold" type="numeric" required="no" default="4096">

		<cfinvoke method="setThreshold" threshold="#Val( arguments.threshold )#">

		<cfreturn this>
	</cffunction>

	<cffunction name="setThreshold" access="public" returntype="void">

		<cfargument name="threshold" type="numeric" required="yes">

		<cfset this.threshold = Val( arguments.threshold )>

		<cfreturn>
	</cffunction>

	<cffunction name="getThreshold" access="public" returntype="numeric">
		<cfreturn this.threshold>
	</cffunction>

	<cffunction name="showCSS" output="yes" access="public" returntype="void">

		<cfargument name="cssInput" type="any" required="true">
		<cfargument name="doctype" type="string" required="false" default="html5">

		<cfoutput>#getCSS( argumentCollection = arguments )#</cfoutput>

		<cfreturn>
	</cffunction>

	<cffunction name="getCSS" access="public" returntype="string">

		<cfargument name="cssInput" type="any" required="true">
		<cfargument name="doctype" type="string" required="false" default="html5">

		<cfset var i = "">
		<cfset var css = "">
		<cfset var cssInputs = []>
		<cfset var cssDetails = []>
		<cfset var cssTotalSize = 0>

		<cfif !isArray( arguments.cssInput )>
			<cfset cssInputs = [ arguments.cssInput ]>
		<cfelse>
			<cfset cssInputs = arguments.cssInput>
		</cfif>

		<cfloop from="1" to="#ArrayLen( cssInputs )#" index="i">
			<cfif fileExists( ExpandPath( cssInputs[ i ] ) )>
				<cfset cssDetails[ i ] = getFileInfo( ExpandPath( cssInputs[ i ] ) )>
				<cfset cssTotalSize += cssDetails[ i ].size>
			</cfif>
		</cfloop>

		<cfif cssTotalSize GT this.threshold>
			<cfloop array="#cssInputs#" index="i">
				<cfset css &= getCSSLink( i, arguments.doctype )>
			</cfloop>
		<cfelse>
			<cfset css = "<style>">
			<cfloop array="#cssInputs#" index="i">
				<cfset css &= getCSSContent( i )>
			</cfloop>
			<cfset css &= "</style>">
		</cfif>

		<cfreturn css>
	</cffunction>

	<cffunction name="getCSSLink" access="public" returntype="string">

		<cfargument name="cssURL" type="string" required="true">
		<cfargument name="doctype" type="string" required="false" default="html5">

		<cfswitch expression="#arguments.doctype#">
			<cfcase value="html5">
				<cfreturn "<link rel=""stylesheet"" href=""#arguments.cssURL#"">">
			</cfcase>
			<cfcase value="xhtml">
				<cfreturn "<link rel=""stylesheet"" type=""text/css"" href=""#arguments.cssURL#"" />">
			</cfcase>
		</cfswitch>

	</cffunction>

	<cffunction name="getCSSContent" access="public" returntype="string">

		<cfargument name="cssURL" type="string" required="true">

		<cfscript>
			if ( !isDefined('requiest.cacheKey') ) {
				request.cacheKey = hash( cgi.http_host, 'sha1' );
			}

			var cachekey = request.cacheKey & 'cssinliner' & arguments.cssURL;
			var cssContent = cacheGet( cachekey );

			if ( isNull( cacheObject ) ) {
				if ( fileExists( expandPath( arguments.cssURL ) ) ) {
				    cssContent = fileRead( expandPath( arguments.cssURL ) );
				} else {
					cssContent = '';
				}

			    cachePut( cacheKey, cssContent, createTimespan( 0, 1, 0, 0 ) );
			}
		</cfscript>

		<cfreturn cssContent>
	</cffunction>

</cfcomponent>
