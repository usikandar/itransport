<cfoutput>
  
  <cfif isDefined('Request.successMsg') AND Request.successMsg NEQ ''>
    
    <div class="alert alert-success">
    #Request.successMsg#
    </div>

  </cfif>

  <cfif isDefined('Request.warningMsg') AND Request.warningMsg NEQ ''>
  
    <div class="alert alert-warning">
      #Request.warningMsg#
    </div>

  </cfif>
  
  <cfif isDefined('Request.dangerMsg') AND Request.dangerMsg NEQ ''>
  
    <div class="alert alert-danger">
      #Request.dangerMsg#
    </div>

  </cfif>

</cfoutput>