<cfoutput>
  <!--- <cfdump var="#Application#"/> --->
  <cfset Application.DSN = "iTransport"/>
  <cfset SeatTypeAPI = createObject("component", "cfc.SeatType").init(Application.DSN) />
  
  <cfparam name="Form.btn_submit" default=""/>
  <cfparam name="Form.name" default=""/>
  <cfparam name="Form.edit_id" default=""/>
  <cfparam name="Form.delete_id" default=""/>

  <cfif Form.btn_submit EQ 'add'>
    
    <cfif Form.name EQ ''>
      
      <cfset Request.dangerMsg = "All fields are required."/>

    <cfelse>

      <cfset result = SeatTypeAPI.create(Form)>

      <cfif result.MSG EQ 'Success'>
        <cfset Request.successMsg = "Successfully added."/>
      <cfelse>
        <cfset Request.dangerMsg = "Something went wrong. Please try again."/>
      </cfif>

    </cfif>

  <cfelseif Form.btn_submit EQ 'edit'>
    
    <cfif Form.name EQ '' OR Not isNumeric(Form.edit_id)>
      
      <cfset Request.dangerMsg = "All fields are required."/>

    <cfelse>

      <cfset result = SeatTypeAPI.update(Form)>
      
      <cfif result.MSG EQ 'Success'>
        <cfset Request.successMsg = "Successfully updated."/>
      <cfelse>
        <cfset Request.dangerMsg = "Something went wrong. Please try again."/>
      </cfif>

    </cfif>

  <cfelseif Form.btn_submit EQ 'Delete' AND isNumeric(Form.delete_id)>
    
    <cfset result = SeatTypeAPI.delete(Form)>
    
    <cfif result.MSG EQ 'Success'>
      <cfset Request.successMsg = "Successfully deleted."/>
    <cfelse> 
      <cfset Request.dangerMsg = "Sorry! An Error occured while Deleting."/>
    </cfif>

  </cfif>

  <cfset Request.allData = SeatTypeAPI.list()/>

  <cfsavecontent variable="Request.headerHTML">
    <link rel="stylesheet" href="https://cdn.datatables.net/1.10.13/css/dataTables.bootstrap.min.css">
  </cfsavecontent>
  
  <cfset Request.activeClass = 'SeatType'/>
  <cfinclude template="includes/header.cfm"/>

  <!--- body start --->
  <h2 class="sub-header">Manage Seat Types</h2>
  <div class="row">
    <cfinclude template="includes/alerts.cfm"/>
  </div>
  <div class="row">
    <ul class="nav nav-tabs">
      <li class="active"><a data-toggle="tab" href="##view">View</a></li>
      <li><a data-toggle="tab" href="##add">Add</a></li>
    </ul>

    <div class="tab-content">
      <div id="view" class="tab-pane fade in active">
        <br/>
          <div class="table-responsive">
            <table class="table table-striped" id="table_id">
              <thead>
                <tr>
                  <th>##</th>
                  <th>Name</th>
                  <th>Action</th>
                </tr>
              </thead>
              <tbody>
                <cfloop query="Request.allData">
                  <tr>
                    <td>#currentrow#</td>

                    <td>
                      #HTMLEditFormat(Request.allData.Name)#
                    </td>
                  
                    <td>
                      <cfset delete_id = Request.allData.SeatTypeID/>
                      <form method="POST" action="" enctype="multipart/form-data">
                        <button type="button" data-edit_id="#delete_id#" data-name="#Request.allData.Name#" class="btn btn-info updateDialog" data-toggle="modal" data-target="##updateModal">Edit</button>
                        <input type="hidden" name="delete_id" value="#delete_id#">
                        <input class="btn btn-warning btn-md" onclick="return confirm('Are you sure?');" type="submit" name="btn_submit" value="Delete">
                      </form>
                    </td>

                  </tr>
                </cfloop>
              </tbody>
            </table>
          </div>
      </div>
      <div id="add" class="tab-pane fade">
        <h3>Add a Seat Type</h3>
        <form method="POST" action="" enctype="multipart/form-data">
          <!--- <div class="form-group">
            <label>Seat Category Facility ID:</label>
            <input type="text" class="form-control" name="name_id">
          </div> --->
          <div class="form-group">
            <label>Name:</label>
            <input type="text" class="form-control" name="name">
          </div>
          <button type="submit" name="btn_submit" value="add" class="btn btn-success pull-right"><i class="fa fa-save"></i> <cfoutput>#ml.get_label('save')#</cfoutput></button>
        </form>
      </div>
    </div>
  </div>

  <!-- Modal -->
  <div id="updateModal" class="modal fade" role="dialog">
    <div class="modal-dialog">

      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">Update</h4>
        </div>
        <form method="POST" action="" enctype="multipart/form-data">
          <div class="modal-body">
            <div class="form-group">
              <label for="name">Name:</label>
              <input type="text" class="form-control" id="name" name="name" value="">
            </div>
            <input type="hidden" name="edit_id" id="edit_id" value="">
          </div>
          <div class="modal-footer">
            <button type="submit" name="btn_submit" value="edit" class="btn btn-success"><i class="fa fa-save"></i> <cfoutput>#ml.get_label('save_changes')#</cfoutput></button>
            <button type="button" class="btn btn-danger" data-dismiss="modal"><i class="fa fa-times"></i> <cfoutput>#ml.get_label('cancel')#</cfoutput></button>
          </div>
        </form>
      </div>

    </div>
  </div>

  <!--- body end --->

  <cfsavecontent variable="Request.footerHTML">

    <script src="https://cdn.datatables.net/1.10.13/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.10.13/js/dataTables.bootstrap.min.js"></script>

    <script>
      $(document).ready(function(){
        $('[data-toggle="tooltip"]').tooltip(); 
      });
      
      $(document).ready( function () {
        $('##table_id').DataTable();
      });

      $(document).on("click", ".updateDialog", function () {

         var name = $(this).data('name');
         $(".modal-body ##name").val( name );

         var edit_id = $(this).data('edit_id');
         $(".modal-body ##edit_id").val( edit_id );
       });

    </script>

  </cfsavecontent>
  
  <cfinclude template="includes/footer.cfm"/>

</cfoutput>