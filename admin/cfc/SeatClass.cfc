<cfcomponent name="SeatClass" hint="Seat Class all functions">

  <cffunction name="init" access="public" returntype="SeatClass">
    <cfargument name="dsnName" type="string" required="true" hint="ColdFusion DSN Name" />
    <cfset variables.myMyDSNName = arguments.dsnName />
    <cfset variables.myProcedureName = 'Vehicle__BUS_DIM_SeatClass__CRUD' />
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
            @Name = N'#Form.name#',
            @ImagePath = N'#Form.filePath#'

      SELECT  'Return Value' = @return_value
    </cfquery>

    <!--- <cfstoredproc datasource="#dsnName#" procedure="#variables.myProcedureName#">
      <cfprocparam type="in" cfsqltype="cf_sql_char" dbvarname="@action" value="I">
      <cfprocparam type="in" cfsqltype="cf_sql_varchar" dbvarname="@name" value="#Form.name#">
      <cfprocresult name="qCreate"/>
    </cfstoredproc> --->

    <cfreturn qCreate/>

  </cffunction>

  <cffunction name="list" returntype="query" output="no" access="public">
    
    <cfargument name="getID" type="string" default=""/>
    
    <cfset dsnName = getMyDSNName() />
    
    <cfstoredproc datasource="#dsnName#" procedure="#variables.myProcedureName#">
      <cfprocparam type="in" cfsqltype="cf_sql_char" dbvarname="@action" value="L">
      <cfif arguments.getID NEQ ''>
        <cfprocparam type="in" cfsqltype="cf_sql_integer" dbvarname="@SeatClassID" value="#arguments.getID#">
      </cfif>
      <cfprocresult name="qRead"/>
    </cfstoredproc>
    
    <cfreturn qRead>

  </cffunction>

  <cffunction name="update" returntype="query" output="no" access="public">

    <cfargument name="Form" type="struct" default=""/>
    <cfset dsnName = getMyDSNName() />

    <cfquery name="qUpdate" datasource="#dsnName#" >
      DECLARE @return_value int

      EXEC  @return_value = [dbo].[#variables.myProcedureName#]
            @action = N'U',
            @Name = N'#Form.name#',
            @SeatClassID = #Form.edit_id#,
            @ImagePath = N'#Form.filePath#'

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
      <cfprocparam type="in" cfsqltype="cf_sql_integer" dbvarname="@SeatClassID" value="#Form.delete_id#">
      <cfprocresult name="qDelete"/>
    </cfstoredproc>

    <cfreturn qDelete/>

  </cffunction>

  

</cfcomponent>