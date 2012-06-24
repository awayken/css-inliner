<cfcomponent name="CSS Inliner">
	<cfproperty name="threshold" type="numeric" required="no" default="4096" hint="This is the filesize that the system should consider when deciding whether to inline or not." />

	<cfset this.threshold = 4096 />

	<cffunction name="init" returnType="cssinliner">
		<cfargument name="threshold" type="numeric" required="no" default="4096" />

		<cfinvoke method="setThreshold" threshold="#Val(arguments.threshold)#" />

		<cfreturn this />
	</cffunction>

	<cffunction name="setThreshold" access="public" returnType="void">
		<cfargument name="threshold" type="numeric" required="yes" />

		<cfset this.threshold = Val(arguments.threshold) />

		<cfreturn />
	</cffunction>

	<cffunction name="getThreshold" access="public" returnType="numeric">
		<cfreturn this.threshold />
	</cffunction>

</cfcomponent>