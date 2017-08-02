<cfcomponent name="BusTypeTemplate" hint="Seat Type all functions">

  <cffunction name="init" access="public" returntype="BusTypeTemplate">
    
    <cfargument name="dsnName" type="string" required="true" hint="ColdFusion DSN Name" />
    <cfset variables.myMyDSNName = arguments.dsnName />
    <cfset variables.myProcedureName = 'Vehicle__BUS__TypeTemplate__CRUD' />
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
            @VechicleTypeName = N'#Form.VechicleTypeName#',
            @SeatMIN = N'#Form.SeatMIN#',
            @SeatMAX = N'#Form.SeatMAX#',
            @SeatMaxRow = N'#Form.SeatMaxRow#',
            @BusRows = N'#Form.BusRows#',
            @Floors = N'#Form.Floors#',
            @Facility_AC = N'#Form.Facility_AC#',
            @Facility_Toilet = N'#Form.Facility_Toilet#'

      SELECT  'Return Value' = @return_value
    </cfquery>

    <!--- <cfstoredproc datasource="#dsnName#" procedure="#variables.myProcedureName#">
      <cfprocparam type="in" cfsqltype="cf_sql_char" dbvarname="@action" value="I">
      <cfprocparam type="in" cfsqltype="cf_sql_varchar" dbvarname="@name" value="#Form.name#">
      <cfprocresult name="qCreate"/>
    </cfstoredproc> --->

    <cfreturn qCreate/>

  </cffunction>

  <cffunction name="list" returntype="query" output="true" access="public">
    <cfargument name="acfilter" type="string" required="false" default="" />
    <cfargument name="toiletfilter" type="string" required="false" default="" />
    <cfargument name="vehicleTypeId" type="string" required="false" default="">

    <cfset dsnName = getMyDSNName() />
    <!--- <cfdump var="#arguments#"/> --->
    <cfquery name="qList" datasource="#dsnName#">
      DECLARE @return_value int

      EXEC @return_value = [dbo].[#variables.myProcedureName#]
          @action = N'L',
          <cfif arguments.vehicleTypeId NEQ "">
            @VechicleTypeID = #arguments.vehicleTypeId#,
          <cfelse>
            @VechicleTypeID = NULL,
          </cfif>
          @VechicleTypeName = NULL,
          @SeatMIN = NULL,
          @SeatMAX = NULL,
          @Floors = NULL,
          <cfif arguments.acfilter EQ 0 AND arguments.toiletfilter EQ 0>
            @Facility_AC = NULL,
            @Facility_Toilet = NULL
          <cfelseif arguments.acfilter EQ 1 AND arguments.toiletfilter EQ 1>
            @Facility_AC = 1,
            @Facility_Toilet = 1
          <cfelseif arguments.acfilter EQ 1 AND arguments.toiletfilter EQ 0>
            @Facility_AC = 1,
            @Facility_Toilet = NULL
          <cfelseif arguments.acfilter EQ 0 AND arguments.toiletfilter EQ 1>
            @Facility_AC = NULL,
            @Facility_Toilet = 1
          <cfelse>
            @Facility_AC = NULL,
            @Facility_Toilet = NULL
          </cfif>

      SELECT  'Return Value' = @return_value
    </cfquery>
    
    <!--- <cfstoredproc datasource="#dsnName#" procedure="#variables.myProcedureName#">
      <cfprocparam type="in" cfsqltype="cf_sql_char" dbvarname="@action" value="L">
      <cfprocparam type="in" cfsqltype="cf_sql_char" dbvarname="@Facility_AC" value="#arguments.acfilter#">
      <cfprocparam type="in" cfsqltype="cf_sql_char" dbvarname="@Facility_Toilet" value="#arguments.toiletfilter#">
      <cfprocresult name="qList"/>
    </cfstoredproc> --->
    
    <cfreturn qList>

  </cffunction>

  <cffunction name="update" returntype="query" output="no" access="public">

    <cfargument name="Form" type="struct" default=""/>
    <cfset dsnName = getMyDSNName() />

    <cfquery name="qUpdate" datasource="#dsnName#" >
      DECLARE @return_value int

      EXEC  @return_value = [dbo].[#variables.myProcedureName#]
            @action = N'U',
            @VechicleTypeName = N'#Form.VechicleTypeName#',
            @SeatMIN = N'#Form.SeatMIN#',
            @SeatMAX = N'#Form.SeatMAX#',
            @SeatMaxRow = N'#Form.SeatMaxRow#',
            @BusRows = N'#Form.BusRows#',
            @Floors = N'#Form.Floors#',
            @Facility_AC = N'#Form.Facility_AC#',
            @Facility_Toilet = N'#Form.Facility_Toilet#',
            @VechicleTypeID = #Form.edit_id#

      SELECT  'Return Value' = @return_value
    </cfquery>

    <!--- <cfstoredproc datasource="#dsnName#" procedure="#variables.myProcedureName#">
      <cfprocparam type="in" cfsqltype="cf_sql_char" dbvarname="@action" value="U">
      <cfprocparam type="in" cfsqltype="cf_sql_varchar" dbvarname="@name" value="#Form.name#">
      <cfprocparam type="in" cfsqltype="cf_sql_integer" dbvarname="@SeatClassID" value="#Form.edit_id#">
      <cfprocresult name="qUpdate"/>
    </cfstoredproc> --->

    <cfreturn qUpdate/>

  </cffunction>

  <cffunction name="delete" returntype="query" output="no" access="public">

    <cfargument name="Form" type="struct" default=""/>
    <cfset dsnName = getMyDSNName() />

    <cfstoredproc datasource="#dsnName#" procedure="#variables.myProcedureName#">
      <cfprocparam type="in" cfsqltype="cf_sql_char" dbvarname="@action" value="D">
      <cfprocparam type="in" cfsqltype="cf_sql_integer" dbvarname="@VechicleTypeID" value="#Form.delete_id#">
      <cfprocresult name="qDelete"/>
    </cfstoredproc>

    <cfreturn qDelete/>

  </cffunction>


</cfcomponent>