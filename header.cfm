<cfsetting enablecfoutputonly="no"><!DOCTYPE html>
<html lang="en" class="no-js">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">

<head>
	<cfoutput>
	<meta http-equiv="X-UA-Compatible" name="viewport" content="width=device-width, initial-scale=1.0">

	<link rel="stylesheet"  href="../../theme/css/framework.css?#Application.revision#" />

	<!-- Google Font: Open Sans -->
	<link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Open+Sans:400,400italic,600,600italic,800,800italic">
	<link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Oswald:400,300,700">

	<!-- Font Awesome CSS -->
	<link rel="stylesheet" href="../../theme/css/font-awesome.min.css">

	<!-- Bootstrap CSS -->
	<link rel="stylesheet" href="../../theme/css/bootstrap.min.css">
	
	<!-- Bootstrap Vendors -->
	<link href="../../theme/js/libs/bootstrap-datepicker/css/datepicker.css" rel="stylesheet">
	<link href="../../theme/js/libs/bootstrap-timepicker/css/bootstrap-timepicker.min.css" rel="stylesheet">

	<!-- App CSS -->
	<link rel="stylesheet" href="../../theme/css/mvpready-admin-webtour.css">
	<link rel="stylesheet" href="../../theme/css/mvpready-flat.css">
	<link rel="stylesheet" href="../../theme/css/animate.min.css">
	<link href="../../theme/css/custom.css" rel="stylesheet">
	<link href="../../theme/css/flatui-colors.min.css" rel="stylesheet">
	<link rel="stylesheet" href="../../theme/css/grad.css">

	<!--- custom templates for different systems --->
	<link rel="stylesheet" href="../../theme/css/#Application.vm_system.name#.css">

	<!-- Favicon -->
	<link rel="Shortcut Icon" href="../../favicon.ico" type="image/x-icon" />


  	<script src="../../theme/js/libs/jquery-1.10.2.min.js"></script>
	<script src="../../scripts/framework<cfif Application.developer>.debug</cfif>.js?#Application.revision#" type="text/javascript"></script>
	<cfif Application.debug><script src="../../scripts/console<cfif Application.developer>.debug</cfif>.js?#Application.revision#" type="text/javascript"></script></cfif>
	<script src="../../common/user_edit.js"></script>

	<cfif StructKeyExists(Variables, "nav_title")>
		<title><cfif ListLen(nav_title) GT 1>#ListChangeDelims(ListRest(nav_title), " - ")#<cfelse>#nav_title#</cfif></title>
	<cfelse>
		<title>#ml.get_label('vehicle_management')#</title>
	</cfif>
	</cfoutput>

	<!--- //get avatar folder --->
	<cfset avatar_folder = ExpandPath("../../images/avatars")>
	<!--- Accounter Authentication--->
	<cfif StructKeyExists(Session, "user_id")>
		<cfquery name="roles" datasource="#Application.DSN#">
			SELECT * FROM sys_user_roles WHERE userid = '#session.user_id#' AND role_name = 'Accounter'
		</cfquery>
	</cfif>




	<cfscript>
		if (roles.recordcount){
			if (roles.role_name EQ 'Accounter' and roles.negative EQ False){
				account = 1;
			}else{
				account = 0;
			}
		}else{
			account = 0;
		}
		//Superuser has Accounter Authentication
		if (StructKeyExists(Session, "user_id")){
			if (session.user_id EQ 'superuser'){
				account = 1;
			}
		}
		//Check if Accounter Authentication is enabled in application. If false always authenticate
		if (StructKeyExists(Application, "serviceInvSec")){
			if (Application.serviceInvSec EQ "false"){
				account = 1;
			}
		}

		//handle avatar
			avXml = XmlParse(fileRead(avatar_folder & '/adm_users.xml'));

		if ( avXml.XmlRoot.XmlName NEQ "settings" ) {	// Upgrade 0.9 to 1.0
			xmlSrc = ToString(avXml);
			xmlSrc = Replace(xmlSrc, "<avatars>", '<settings version="1.0"><avatars>');
			xmlSrc = Replace(xmlSrc, "</avatars>", '</avatars></settings>');
			xmlSrc = Replace(xmlSrc, "<avatars/>", '<settings version="1.0"><avatars/></settings>');
			avXml = XmlParse(xmlSrc);

			if ( StructKeyExists(avXml.XmlRoot.avatars, "item") ) {
				avatars = avXml.XmlRoot.avatars.item;

				for ( i=1; i LTE ArrayLen(avatars); i=i+1 ) {
					ArrayAppend(avatars[i].XmlChildren, XmlElemNew(avXml, 'timestamp'));
					avatars[i].timestamp.XmlText = timestamp(fileLastModified( avatar_folder & '/' & avatars[i].file.XmlText ));
				}
			}

			fileWrite(avatar_folder & '/adm_users.xml', ToString(avXml));
	}
	</cfscript>
</head>

<body>
	<div id="wrapper">
	
	<cfif StructKeyExists(Session, "user_id")>
		<cfquery name="uinfo" datasource="#Application.DSN#">SELECT fullname AS name FROM sys_users WHERE userid = '#session.user_id#'</cfquery>
	</cfif>
	
	<header  class="navbar navbar-inverse">
		<div class="container">
			<!--- mobile --->
			<div class="navbar-header">
			<cfoutput>
				<button  class="navbar-toggle" type="button" data-toggle="collapse" data-target=".navbar-collapse">
				    <span class="sr-only">Toggle navigation</span><i class="fa fa-cog"></i>
			    </button>
			    <!--- LOGO --->
				<!--- <a href="#application.url##application.path#/index.cfm" href="../" class="navbar-brand navbar-brand-img"> --->
				<a href="http://venus.weblogic.gr/rezglobus/index.cfm" class="navbar-brand navbar-brand-img">
				   <!--- <img src="#application.url##application.path#/images/resources/webrental.png" height="55" alt="web hotel"> --->
				   <h1>RezGloBus</h1>
			    </a>
			</cfoutput>
			</div> <!-- /.navbar-header -->
        
			<nav class="collapse navbar-collapse" role="navigation">
				<ul class="nav navbar-nav noticebar navbar-left">
				 	<li>
	          			<a href="<cfoutput>#application.url##application.path#</cfoutput>/<cfoutput>adm</cfoutput>/" <!--- ?action=vm" ---> class="dropdown-toggle"><i class="<cfoutput>#Application.vm_system.icon#</cfoutput>"></i> <cfoutput>Bus Builder</cfoutput></span></a> 
	         		</li>

					  	<!--- <cfif Session.logged>
				          <li class="dropdown">
				            <a href="javascript:;" class="dropdown-toggle" data-toggle="dropdown">
				              <i class="fa fa-bell"></i>
				              <span class="navbar-visible-collapsed">&nbsp;Notifications&nbsp;</span>
				              <span class="badge badge-primary">3</span>
				            </a>

				            <ul class="dropdown-menu noticebar-menu noticebar-hoverable" role="menu">
				              <li class="nav-header">
				                <div class="pull-left">
				                  Notifications
				                </div>

				                <div class="pull-right">
				                  <a href="javascript:;">Mark as Read</a>
				                </div>
				              </li>

				              <li>
				                <a href="javascript:;" class="noticebar-item">
				                  <span class="noticebar-item-image">
				                    <i class="fa fa-cloud-upload text-success"></i>
				                  </span>
				                  <span class="noticebar-item-body">
				                    <strong class="noticebar-item-title">Templates Synced</strong>
				                    <span class="noticebar-item-text">20 Templates have been synced to the Mashon Demo instance.</span>
				                    <span class="noticebar-item-time"><i class="fa fa-clock-o"></i> 12 minutes ago</span>
				                  </span>
				                </a>
				              </li>

				              <li>
				                <a href="javascript:;" class="noticebar-item">
				                  <span class="noticebar-item-image">
				                    <i class="fa fa-ban text-danger"></i>
				                  </span>
				                  <span class="noticebar-item-body">
				                    <strong class="noticebar-item-title">Sync Error</strong>
				                    <span class="noticebar-item-text">5 Designs have been failed to be synced to the Mashon Demo instance.</span>
				                    <span class="noticebar-item-time"><i class="fa fa-clock-o"></i> 20 minutes ago</span>
				                  </span>
				                </a>
				              </li>

				              <li class="noticebar-menu-view-all">
				                <a href="javascript:;">View All Notifications</a>
				              </li>
				            </ul>
				          </li>


				          <li class="dropdown">
				            <a href="javascript:;" class="dropdown-toggle" data-toggle="dropdown">
				              <i class="fa fa-exclamation-triangle"></i>
				              <span class="navbar-visible-collapsed">&nbsp;Alerts&nbsp;</span>
				            </a>

				            <ul class="dropdown-menu noticebar-menu noticebar-hoverable" role="menu">                
				              <li class="nav-header">
				                <div class="pull-left">
				                  Alerts
				                </div>
				              </li>

				              <li class="noticebar-empty">                  
				                <h4 class="noticebar-empty-title">No alerts here.</h4>
				                <p class="noticebar-empty-text">Check out what other makers are doing on Explore!</p>                
				              </li>
				            </ul>
				          </li>
		          		</cfif> --->
		        </ul>

		        <cfif Session.logged>
		        	
					<ul class="nav navbar-nav navbar-right">    
		          		<li class="dropdown navbar-profile">
		            		<a class="dropdown-toggle" data-toggle="dropdown" href="javascript:;">
					            <cfscript>
								avatar = XmlSearch(avXml, "/settings/avatars/item[username='#session.user_id#']");
								if ( NOT ArrayLen(avatar) ) {
									WriteOutput(' <span><img src="../../images/user.gif" class="navbar-profile-avatar" alt="" class="navbar-profile-avatar"></span>');
								} else {
									WriteOutput('<span><img src="../../images/avatars/#avatar[1].file.XmlText#?#avatar[1].timestamp.XmlText#" alt="" class="navbar-profile-avatar" ></span>');
								}
								</cfscript>
								<span class="clear"><i class="fa fa-caret-down"></i></span>
				            </a>

				           	<ul class="dropdown-menu" role="menu">
			                	<cfif StructKeyExists(uinfo, "name")>
				             	<li>
				               		<a href="javascript:;" onclick="Usersel();">
				                  		<i class="fa fa-user"></i>&nbsp;&nbsp;
						           		<cfif Len(uinfo.name)>
						                	<cfoutput><input id="user_id" type="hidden" value="#session.user_id#"></cfoutput>
											<strong class="font-bold"><cfoutput>&nbsp;#uinfo.name#</cfoutput></strong>
										<cfelse>
											<strong class="font-bold"><cfoutput>&nbsp;user</cfoutput></strong>
											<!---  <strong class="font-bold">&nbsp;#uinfo.fullname#</strong> --->
										</cfif>
				               		</a>
				              	</li>
				            	</cfif>

					            <li>
					                <!---<a href="./page-settings.html">--->
				                    <a href="javascript:;" onclick="">
					                	<i class="fa fa-cogs"></i>&nbsp;&nbsp;<cfoutput>#ml.get_label('Settings')#</cfoutput>
					                </a>
				              	</li>

					            <li class="divider"></li>

					            <li>
					                <a href="../logout.cfm">
					                  	<i class="fa fa-sign-out"></i>&nbsp;&nbsp;<cfoutput>#ml.get_label('Logout')#</cfoutput>
					                </a>
					            </li>
				            </ul>
			            </li>

			            <li>
				           	<cfoutput>	
					        <div>
					        	<br>
						        <div class="selectContainer">
									<select name="current_lang" id="lang" onchange="ml.change_lang(this)" data-lang="#session.lang#" class="btn dropdown-toggle selectpicker btn-secondary form-control">
										<cfloop query="request.available_langs">
											<option name="switch_lang_#code#" value="#code#" <cfif code eq session.lang>selected="selected"</cfif>>#code#&nbsp;-&nbsp;#name#</option>
										</cfloop>
									</select>
								</div>
							</div>
					    	</cfoutput>
			            </li>
			   		</ul>
		    	</cfif>
		        </ul>
			</nav><!-- /.collapse -->
		</div><!-- /.container -->
	</header>

	<cfif Session.logged>
		<!--- <cfinclude template="sidebar.cfm" /> --->

		<div class="mainnav">
		    <div class="container">
		      	<nav class="collapse mainnav-collapse" role="navigation">
		        	<ul class="mainnav-menu">
			          	<cfoutput>
			          	<li>	
				          	<a href="#application.url##application.path#/#session.app#/main.cfm" class="dropdown-toggle"><i class="fa fa-home"></i> Home</span></a>
			         	</li>
			          	
		          		<cfloop index="i" from="1" to="#ListLen(nav_title)-1#">
		          			<li>
							<a class="dropdown-toggle" href="#ListGetAt(nav_url, i)#"><i class="fa fa-caret-right"></i> #ListGetAt(nav_title, i)#</a>
							</li> 
						</cfloop>

						<li>
							<a href="javascript:;" class="dropdown-toggle"><i class="fa fa-caret-right"></i> #ListLast(nav_title)#</span></a>
						</li>
			            </cfoutput>	 
			        </ul>
			    </nav>
		    </div> <!-- /.container -->
		</div><!-- /.mainnav -->
	</cfif>
	
	<div class="content">
		<div class="page">
			<div class="container">
	            <div class="row">