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

  <cffunction name="create" returntype="any" output="no" access="public">

    <cfargument name="Form" type="struct" default=""/>
    <cfset dsnName = getMyDSNName() />

    <cfquery name="qCreate" datasource="#dsnName#" >
      DECLARE @return_value int
      
      EXEC  @return_value = [dbo].[#variables.myProcedureName#]
            @action = N'I',
            @VechicleID   =#Form.vehicleID#,
            @VechicleTypeID   =#Form.VechicleTypeID#,
            @BusSeatType__XML = N'#Form.XMLDATA#'

      SELECT  'Return Value' = @return_value
    </cfquery>

    <cfreturn qCreate/>

  </cffunction>

  <cffunction name="list" returntype="query" output="no" access="public">
    
    <cfargument name="getID" type="string" default=""/>
    <cfset dsnName = getMyDSNName() />
    
    <cfstoredproc datasource="#dsnName#" procedure="#variables.myProcedureName#">
      <cfprocparam type="in" cfsqltype="cf_sql_char" dbvarname="@action" value="K">
      <cfif arguments.getID NEQ ''>
        <cfprocparam type="in" cfsqltype="cf_sql_integer" dbvarname="@SeatTypeID" value="#arguments.getID#">
      </cfif>
      <cfprocresult name="qList"/>
    </cfstoredproc>
    
    <cfreturn qList>

  </cffunction>

  <cffunction name="getPreviousSeats" returntype="query" output="yes" access="public">
    
    <cfargument name="VehicleID" type="string" default=""/>
    <cfargument name="VehicleTypeID" type="string" default=""/>
    <cfset dsnName = getMyDSNName() />

    <cfquery name="qUpdate" datasource="#dsnName#" >
      DECLARE @return_value int

      EXEC  @return_value = [dbo].[#variables.myProcedureName#]
            @action = N'L',
            @VechicleID = #arguments.VehicleID#,
            @VechicleTypeID = #arguments.VehicleTypeID#,
            @BusSeatType__XML = NULL

      SELECT  'Return Value' = @return_value
    </cfquery>

    <cfoutput>
      DECLARE @return_value int

      EXEC  @return_value = [dbo].[#variables.myProcedureName#]
            @action = N'L',
            @VechicleID = #arguments.VehicleID#,
            @VechicleTypeID = #arguments.VehicleTypeID#,
            @BusSeatType__XML = NULL

      SELECT  'Return Value' = @return_value
    </cfoutput>
    
    <cfreturn qList>

  </cffunction>

</cfcomponent>