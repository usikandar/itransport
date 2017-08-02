<cfoutput>
          </div><!--container -->
      </div><!--row -->
    </div><!--page -->
  </div><!--content -->
</div><!--wrapper -->

<cfset sessions = CreateObject("java","coldfusion.runtime.SessionTracker").getSessionCollection(Application.ApplicationName)>
<cfset recordcount = 0>
<cfloop item="s" collection="#sessions#">
  <cfif structKeyExists(sessions[s],"user_id") AND structKeyExists(sessions[s],"logged")>
    <cfif sessions[s].logged EQ true>
      <cfset recordcount = recordcount + 1>
    </cfif>
  </cfif>
</cfloop>
  
<footer class="footer">
  <div class="container">
    <p class="pull-left"><cfoutput>#session.app_title#</cfoutput> v<cfoutput>#Application.version#</cfoutput></p>
  
  <ul class="nav navbar-nav navbar-right">
    <li class="dropdown">
      <a href="../../main.cfm" >
        <i class="fa fa-home fa-2x "></i>
        <span class="navbar-visible">&nbsp;Dashoboard&nbsp;</span>
      </a>
    </li>
    <li class="dropdown">
      <a href="../../../logout.cfm" >
        <i class="fa fa-power-off fa-2x "></i>
        <span class="navbar-visible">&nbsp;Logout&nbsp;</span>
      </a>
    </li>
    <li class="dropdown"> 
       <a href="../../../common/user_online.cfm" >
        <i class="fa fa-user fa-2x"></i>
        <span class="navbar-visible">&nbsp;Online&nbsp;</span>
        <span class="badge badge-primary"><cfoutput>#recordcount#</cfoutput></span>
     </a>
    </li>
  </ul>
  </div>
</footer>
<!---   <cfparam name="Request.footerHTML" default=""/>
        </div>
      </div>
    </div> --->
    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- jQuery library -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
    <!-- Latest compiled JavaScript -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    #Request.footerHTML#
  </body>

</html>
</cfoutput>