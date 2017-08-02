<cfoutput>
<!--- <cfif structKeyExists( session, "auth" ) && session.auth.isLoggedIn>
  <cfset isUserLoggedIn = true/>
<cfelse>
  <cfset isUserLoggedIn = false/>
</cfif> --->
<cfparam name="Request.headerHTML" default=""/>
<cfparam name="Request.activeClass" default=""/>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="../../favicon.ico">

    <title>Bus Template Shared Data</title>

    <!-- Bootstrap core CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">


    <!-- Custom styles for this template -->
    <!--- <link href="assets/css/dashboard.css" rel="stylesheet"> --->

      <!-- Google Font: Open Sans -->
    <link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Open+Sans:400,400italic,600,600italic,800,800italic">
    <link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Oswald:400,300,700">

    <!-- Font Awesome CSS -->
    <link rel="stylesheet" href="../../../theme/css/font-awesome.min.css">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="../../../theme/css/bootstrap.min.css">
    <!-- Bootstrap Vendors -->
    <link href="../../../theme/js/libs/bootstrap-datepicker/css/datepicker.css" rel="stylesheet">
    <link href="../../../theme/js/libs/bootstrap-timepicker/css/bootstrap-timepicker.min.css" rel="stylesheet">

    <!-- App CSS -->
    <link rel="stylesheet" href="../../../theme/css/mvpready-admin-webtour.css">
    <link rel="stylesheet" href="../../../theme/css/mvpready-flat.css">
    <link rel="stylesheet" href="../../../theme/css/animate.min.css">
    <link href="../../../theme/css/custom.css" rel="stylesheet">
    <link href="../../../theme/css/flatui-colors.min.css" rel="stylesheet">
    <link rel="stylesheet" href="../../../theme/css/grad.css">

    <!--- custom templates for different systems --->
    <link rel="stylesheet" href="../../../theme/css/#Application.vm_system.name#.css">


    #Request.headerHTML#
  </head>
</cfoutput>

<!--- //get avatar folder --->
  <cfset avatar_folder = ExpandPath("../../../images/avatars")>
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

    if ( avXml.XmlRoot.XmlName NEQ "settings" ) { // Upgrade 0.9 to 1.0
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
  <cfset session.app_name = "adm">
  <cfset session.app_title = "Settings">
  <body>

    <style type="text/css">
      .modal-content {
        background-color: rgba(102, 105, 104, 0.9);
        background-image: -webkit-radial-gradient(10% 0, farthest-side ellipse, rgba(64, 226, 172, 0.42), rgba(110, 238, 244, 0.74), rgba(125, 63, 146, 0.45));
      }
    </style>
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
                <a href="<cfoutput>#application.url##application.path#</cfoutput>/<cfoutput>#session.app_name#</cfoutput>/" <!--- ?action=vm" ---> class="dropdown-toggle"><i class="<cfoutput>#Application.vm_system.icon#</cfoutput>"></i> <cfoutput>#session.app_title#</cfoutput></span></a> 
              </li>
            </ul>

            <cfif Session.logged>
              <ul class="nav navbar-nav navbar-right">    
                <li class="dropdown navbar-profile">
                  <a class="dropdown-toggle" data-toggle="dropdown" href="javascript:;">
                    <cfscript>
                      avatar = XmlSearch(avXml, "settings/avatars/item[username='#session.user_id#']");
                      if ( NOT ArrayLen(avatar) ) {
                        WriteOutput(' <span><img src="../../../images/user.gif" class="navbar-profile-avatar" alt="" class="navbar-profile-avatar"></span>');
                      } else {
                        WriteOutput('<span><img src="../../../images/avatars/#avatar[1].file.XmlText#?#avatar[1].timestamp.XmlText#" alt="" class="navbar-profile-avatar" ></span>');
                      }
                    </cfscript>
                    <span class="clear"><i class="fa fa-caret-down"></i></span>
                  </a>

                  <ul class="dropdown-menu" role="menu">
                    <cfif StructKeyExists(uinfo, "name")>
                      <li>
                        <a href="javascript:;" onclick="Usersel();"><i class="fa fa-user"></i>&nbsp;&nbsp;
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
                      <a href="javascript:;" onclick=""><i class="fa fa-cogs"></i>&nbsp;&nbsp;<cfoutput>#ml.get_label('Settings')#</cfoutput></a>
                    </li>

                    <li class="divider"></li>

                    <li>
                      <a href="../../../logout.cfm">
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

                  <li>  
                    <a href="#application.url##application.path#/#session.app#/busbuilder/admin/seat-category-facility.cfm" class="dropdown-toggle"><i class="fa fa-caret-right"></i> Templated Shared Data</span></a>
                  </li>
                    
                  <!--- <cfloop index="i" from="1" to="#ListLen(nav_title)-1#">
                    <li>
                      <a class="dropdown-toggle" href="#ListGetAt(nav_url, i)#"><i class="fa fa-caret-right"></i> #ListGetAt(nav_title, i)#</a>
                    </li> 
                  </cfloop> --->

                  <!--- <li>
                    <a href="javascript:;" class="dropdown-toggle"><i class="fa fa-caret-right"></i> #ListLast(nav_title)#</span></a>
                  </li> --->
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
              <div class="col-md-3 <!--- sidebar --->">
              <!--- <cfif isUserLoggedIn> --->
                <ul class="list-group" style="padding-top: 55px;">
                  
                  <a class="list-group-item  " href="seat-category-facility.cfm" listgroup="true"> <i class="fa fa-cog text-primary"></i>&nbsp;&nbsp;Seat Category Facility<i class="fa fa-chevron-right list-group-chevron"></i></a>

                  <a class="list-group-item  " href="seat-facility.cfm" listgroup="true"> <i class="fa fa-cog text-primary"></i>&nbsp;&nbsp;Seat Facility<i class="fa fa-chevron-right list-group-chevron"></i></a>

                  <a class="list-group-item  " href="seat-type.cfm" listgroup="true"> <i class="fa fa-cog text-primary"></i>&nbsp;&nbsp;Seat Type<i class="fa fa-chevron-right list-group-chevron"></i></a>

                  <a class="list-group-item  " href="seat-class.cfm" listgroup="true"> <i class="fa fa-cog text-primary"></i>&nbsp;&nbsp;Seat Class<i class="fa fa-chevron-right list-group-chevron"></i></a>

                  <a class="list-group-item  " href="bus-type-template.cfm" listgroup="true"> <i class="fa fa-cog text-primary"></i>&nbsp;&nbsp;Bus Type Template<i class="fa fa-chevron-right list-group-chevron"></i></a>

                  <!--- <li <cfif Request.activeClass EQ 'SeatCategoryFacilities'>class="active"</cfif>>
                    <a href="seat-category-facility.cfm">Seat Category Facility</a>
                  </li>

                  <li <cfif Request.activeClass EQ 'SeatFacility'>class="active"</cfif>>
                    <a href="seat-facility.cfm">Seat Facility</a>
                  </li>

                  <li <cfif Request.activeClass EQ 'SeatType'>class="active"</cfif>>
                    <a href="seat-type.cfm">Seat Type</a>
                  </li>

                  <li <cfif Request.activeClass EQ 'SeatClass'>class="active"</cfif>>
                    <a href="seat-class.cfm">Seat Class</a>
                  </li>

                  <li <cfif Request.activeClass EQ 'BusTypeTemplate'>class="active"</cfif>>
                    <a href="bus-type-template.cfm">Bus Type Template</a>
                  </li>
             --->
                </ul>
              <!--- </cfif> --->
            </div>
            <div class="col-md-9">































  <!---   <nav class="navbar navbar-inverse navbar-fixed-top">
      <div class="container-fluid">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="##navbar" aria-expanded="false" aria-controls="navbar">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="##">iTransport Admin</a>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
          <ul class="nav navbar-nav navbar-right">

             <!--- <cfif isUserLoggedIn>
              <li><a href="">Dashboard</a></li>
              <li><a href="">Logout</a></li>
             </cfif> --->
          </ul>
          <form class="navbar-form navbar-right">
            <input type="text" class="form-control" placeholder="Search...">
          </form>
        </div>
      </div>
    </nav>

    <div class="container-fluid">
      <div class="row">
        <div class="col-sm-3 col-md-2 sidebar">
        <!--- <cfif isUserLoggedIn> --->
          <ul class="nav nav-sidebar">
            
            <li <cfif Request.activeClass EQ 'SeatCategoryFacilities'>class="active"</cfif>>
              <a href="seat-category-facility.cfm">Seat Category Facility</a>
            </li>

            <li <cfif Request.activeClass EQ 'SeatFacility'>class="active"</cfif>>
              <a href="seat-facility.cfm">Seat Facility</a>
            </li>

            <li <cfif Request.activeClass EQ 'SeatType'>class="active"</cfif>>
              <a href="seat-type.cfm">Seat Type</a>
            </li>

            <li <cfif Request.activeClass EQ 'SeatClass'>class="active"</cfif>>
              <a href="seat-class.cfm">Seat Class</a>
            </li>

            <li <cfif Request.activeClass EQ 'BusTypeTemplate'>class="active"</cfif>>
              <a href="bus-type-template.cfm">Bus Type Template</a>
            </li>
			
          </ul>
        <!--- </cfif> --->
      </div>
    <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
</cfoutput> --->