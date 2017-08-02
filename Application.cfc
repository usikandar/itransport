<cfcomponent>
  <cfset this.name = Hash(GetDirectoryFromPath(GetBaseTemplatePath()))&'iTransportDev'/>
  <cfset this.sessionManagement = true/>

  <cffunction name="onApplicationStart">
    <!--- <cfset Application.DSN = "Hera-iTransport"/> --->
    <cfset Application.DSN = "iTransport"/>
    <!--- //development settings --->
    <cfset Application.SiteURL = 'http://localhost:8500/itransportnew/'/>
    <cfset Application.AppEnvironment = 'development'/>
    <!--- //live settings --->
    <!--- <cfset Application.SiteURL = 'http://dev.creationnext.com/itransport/'/>
    <cfset Application.AppEnvironment = 'production'/> --->
  </cffunction>

  <cffunction name="onError">
    <cfargument name="exception"/>
    <cfargument name="event"/>
    <cfif Application.AppEnvironment EQ 'development'>
      <cfdump var="#exception#"/>
    </cfif>
    <cfabort/>
  </cffunction>

  <cffunction name="onRequestStart">
    <cfargument name="targetPath"/>
    <cfif isDefined('URL.reinit') AND URL.reinit EQ 1>
      <cfset onApplicationStart()/>
      <cfset onSessionStart()/>
    </cfif>
    <cfreturn true />
  </cffunction>

  <cffunction name="onSessionStart">
    <cfreturn true />
  </cffunction>

</cfcomponent>