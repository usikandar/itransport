<cfcomponent name="CommonFunctions" hint="All common functions">

  <cffunction name="init" access="public" returntype="CommonFunctions">
    
    <cfargument name="dsnName" type="string" required="true" hint="ColdFusion DSN Name" />
    <cfset variables.myMyDSNName = arguments.dsnName />
    <cfreturn this />

  </cffunction>

  <cffunction name="getMyDSNName" output="false" access="public" returntype="string">
    <cfreturn variables.myMyDSNName />
  </cffunction>

  <cffunction name="list" returntype="query" output="no" access="public">
    <cfargument name="procedureName" type="string" required="true" />
    <cfargument name="action" type="string" default="L" required="false" />
    <cfset dsnName = getMyDSNName() />
    
    <cfstoredproc datasource="#dsnName#" procedure="#arguments.procedureName#">
      <cfprocparam type="in" cfsqltype="cf_sql_char" dbvarname="@action" value="#arguments.action#">
      <cfprocresult name="qList"/>
    </cfstoredproc>

    <cfreturn qList>

  </cffunction>

</cfcomponent>