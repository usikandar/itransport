<cfcomponent name="BusStructureSeatType" hint="Seat Type all functions">

  <cffunction name="init" access="public" returntype="BusStructureSeatType">
    
    <cfargument name="dsnName" type="string" required="true" hint="ColdFusion DSN Name" />
    <cfset variables.myMyDSNName = arguments.dsnName />
    <cfset variables.myProcedureName = 'Vehicle__BUS__Structure__SeatType__CRUD' />
    <cfreturn this />

  </cffunction>

  <cffunction name="getMyDSNName" output="false" access="public" returntype="string">
    <cfreturn variables.myMyDSNName />
  </cffunction>

  <cffunction name="list" returntype="query" output="true" access="public">
    <cfargument name="acfilter" type="string" required="false" default="1" />
    <cfargument name="toiletfilter" type="string" required="false" default="1" />
    <cfset dsnName = getMyDSNName() />
    
    
    <cfstoredproc datasource="#dsnName#" procedure="#variables.myProcedureName#">
      <cfprocparam type="in" cfsqltype="cf_sql_char" dbvarname="@action" value="K">
      <cfprocresult name="qList"/>
    </cfstoredproc>
    
    <!--- <cfdump var="#arguments#"/>
    <cfquery name="qList" datasource="#dsnName#">
      DECLARE @return_value int

      EXEC @return_value = [dbo].[#variables.myProcedureName#]
          @action = N'K'

      SELECT  'Return Value' = @return_value
    </cfquery> --->
    
    <cfreturn qList>

  </cffunction>

</cfcomponent>