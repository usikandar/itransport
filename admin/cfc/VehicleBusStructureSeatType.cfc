<cfcomponent name="VehicleBusStructureSeatType" hint="Vehicle__BUS__Structure__SeatType__CRUD functions">

  <cffunction name="init" access="public" returntype="VehicleBusStructureSeatType">
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
            @action = N'#Form.Action#',
            @version_id   =#Form.VersionID#,
            @VechicleTypeID   =#Form.VechicleTypeID#,
            <cfif Form.VehicleVirtualVersionID NEQ "">
              @virtualversion_id = #Form.VehicleVirtualVersionID#,
            <cfelse>
              @virtualversion_id = NULL,
            </cfif>
            @BusSeatType__XML = N'#Form.XMLDATA#'

      SELECT  'Return Value' = @return_value
    </cfquery>

    <cfreturn qCreate/>

  </cffunction>

  <!--- <cffunction name="list" returntype="query" output="no" access="public">
    
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

  </cffunction> --->

  <cffunction name="getPreviousSeats" returntype="query" output="yes" access="public">
    
    <cfargument name="VersionID" type="string" default=""/>
    <cfargument name="VechicleTypeID" type="string" default=""/>
    <cfargument name="VehicleVirtualVersionID" type="string" default=""/>

    <cfset dsnName = getMyDSNName() />

    <cfquery name="qList" datasource="#dsnName#" >
      DECLARE @return_value int

      EXEC  @return_value = [dbo].[#variables.myProcedureName#]
            @action = N'L',
            @version_id = #arguments.VersionID#,
            @VechicleTypeID = #arguments.VechicleTypeID#,
            <cfif arguments.VehicleVirtualVersionID NEQ "">
              @virtualversion_id = #arguments.VehicleVirtualVersionID#,
            <cfelse>
              @virtualversion_id = NULL,
            </cfif>
            @BusSeatType__XML = NULL

      SELECT  'Return Value' = @return_value
    </cfquery>
    
    <cfreturn qList>

  </cffunction>

  <cffunction name="deleteBus" output="false" access="public" returntype="any">


    <cfargument name="VersionID" type="string" default=""/>
    <cfargument name="VechicleTypeID" type="string" default=""/>
    <cfargument name="VehicleVirtualVersionID" type="string" default=""/>

    <cfset dsnName = getMyDSNName() />

    <cfquery name="dList" datasource="#dsnName#">

      DECLARE @return_value int

      EXEC  @return_value = [dbo].[#variables.myProcedureName#]
          @action = 'D',
          @version_id = #arguments.VersionID#,
          @VechicleTypeID = #arguments.VechicleTypeID#,
          <cfif arguments.VehicleVirtualVersionID NEQ ''>
            @virtualversion_id = #arguments.VehicleVirtualVersionID#,
          <cfelse>
            @virtualversion_id = NULL,
          </cfif>
          @BusSeatType__XML = NULL

      SELECT  'Return Value' = @return_value
      
    </cfquery>

    <cfreturn dList/>
  </cffunction>

</cfcomponent>