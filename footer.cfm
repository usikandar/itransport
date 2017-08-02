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
    <p class="pull-left"><cfoutput>Bus Builder</cfoutput> v<cfoutput>#Application.version#</cfoutput></p>
  
	<ul class="nav navbar-nav navbar-right">
	  <li class="dropdown">
	    <a href="../main.cfm" >
	      <i class="fa fa-home fa-2x "></i>
	      <span class="navbar-visible">&nbsp;Dashoboard&nbsp;</span>
	    </a>
	  </li>
	  <li class="dropdown">
	    <a href="../../logout.cfm" >
	      <i class="fa fa-power-off fa-2x "></i>
	      <span class="navbar-visible">&nbsp;Logout&nbsp;</span>
	    </a>
	  </li>
	  <li class="dropdown"> 
	  	 <a href="../user_online.cfm" >
	      <i class="fa fa-user fa-2x"></i>
	      <span class="navbar-visible">&nbsp;Online&nbsp;</span>
	      <span class="badge badge-primary"><cfoutput>#recordcount#</cfoutput></span>
	   </a>
	  </li>
	</ul>
  </div>
</footer>
<!---|| Users Online: <cfoutput>#recordcount#</cfoutput>--->
<!-- Bootstrap core JavaScript
================================================== -->
<!-- Core JS -->

<script src="../../theme/js/libs/bootstrap.min.js"></script>

<!-- Plugin JS -->
<script src="../../theme/js/plugins/jquery.metisMenu.js"></script>
<script src="../../theme/js/plugins/flot/jquery.flot.js"></script>
<script src="../../theme/js/plugins/flot/jquery.flot.tooltip.min.js"></script>
<script src="../../theme/js/plugins/flot/jquery.flot.pie.js"></script>
<script src="../../theme/js/plugins/flot/jquery.flot.resize.js"></script>
<script src="../../theme/js/plugins/ios7-switch.js"></script>
<!-- App JS -->
<script src="../../theme/js/mvpready-core.js"></script>
<script src="../../theme/js/mvpready-admin.js"></script>

<!-- Plugin JS -->
<script src="../../theme/js/demos/flot/line.js"></script>
<script src="../../theme/js/demos/flot/pie.js"></script>
<script src="../../theme/js/demos/flot/auto.js"></script>
<!-- Vendor -->
<script src="../../theme/js/libs/bootstrap-datepicker/js/bootstrap-datepicker.js"></script>
<script src="../../theme/js/libs/bootstrap-timepicker/js/bootstrap-timepicker.js"></script>
<!-- Custom Script -->
<script src="../../theme/js/theme-custom.js"></script>


</body>
</html>