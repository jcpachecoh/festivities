<html>
<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
 <link rel="stylesheet" type="text/css" media="screen" href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.1/css/bootstrap.min.css" />
        <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">
  <script type="text/javascript" src="//code.jquery.com/jquery-2.1.1.min.js"></script>
  <script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
   <script src="//cdn.datatables.net/1.10.12/js/jquery.dataTables.min.js"></script>
   <link rel="stylesheet" href="//cdn.datatables.net/1.10.12/css/jquery.dataTables.min.css">
    <link href="//cdn.rawgit.com/Eonasdan/bootstrap-datetimepicker/e8bddc60e73c1ec2475f827be36e1957af72e2ea/build/css/bootstrap-datetimepicker.css" rel="stylesheet">
   <script type="text/javascript" src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.1/js/bootstrap.min.js"></script>
			<script src="//cdnjs.cloudflare.com/ajax/libs/moment.js/2.9.0/moment-with-locales.js"></script>
   <script src="//cdn.rawgit.com/Eonasdan/bootstrap-datetimepicker/e8bddc60e73c1ec2475f827be36e1957af72e2ea/src/js/bootstrap-datetimepicker.js"></script>
  
  <style>
.tableF {
    border-collapse: collapse;
    width: 100%;
}

.tableF th, td {
    text-align: left;
    padding: 8px;
}

.tableF tr:nth-child(even){background-color: #f2f2f2}

.tableF th {
    background-color: #4CAF50;
    color: white;
}
input[type=text], select {
    width: 100%;
    padding: 12px 20px;
    margin: 8px 0;
    display: inline-block;
    border: 1px solid #ccc;
    border-radius: 4px;
    box-sizing: border-box;
}

input[type=submit] {
    width: 100%;
    background-color: #4CAF50;
    color: white;
    padding: 14px 20px;
    margin: 8px 0;
    border: none;
    border-radius: 4px;
    cursor: pointer;
}

input[type=submit]:hover {
    background-color: #45a049;
}




</style>
<script type="text/javascript">
var data=new Array();
$(function(){
	$( "#tabs" ).tabs();

	$( "#startDateCalendar" ).datetimepicker();
	$( "#endDateCalendar" ).datetimepicker({
		useCurrent: false //Important! See issue #1075
	});
	 $("#startDateCalendar").on("dp.change", function (e) {
         $('#endDateCalendar').data("DateTimePicker").minDate(e.date);
     });
    
	
	/* $('#festivities').DataTable({
		 "ajax": "http://localhost:8080/festivities/webapi/festivities/"
	 });*/
	 
	 $.getJSON('http://localhost:8080/festivities/webapi/festivities', function(dataP) {
		 data=dataP;	
		 fillFestivities(dataP);
		
		});  

	 function fillFestivities(data) {
		
		   $.each(data, function(i, element) {
		  
			   $('#festivities').append("<tr><td><a href='FestivityEdit.jsp?id="+element.id+"' ><img src='images/edit.png' alt='Edit'/></a></td><td><input type='hidden' value='"+element.id+"'/> "+element.name+" </td> <td> "+element.place+" </td> <td> "+element.start+" </td>  <td> "+element.end+" </td></tr>"); 
		   });
		  
		 			  
		   
		 }
	

});
function searchFestivity(){
	var name = $('#nameS').val();
	var place = $('#placeS').val();
	$.each(data, function(i, v) {
	    if (v.name == name || v.place==place) {
	        //alert(v.place);
	        $('#festivities_query').append("<tr><td><a href='FestivityEdit.jsp?id="+v.id+"' ><img src='images/edit.png' alt='Edit'/></a></td><td><input type='hidden' value='"+v.id+"'/> "+v.name+" </td> <td> "+v.place+" </td> <td> "+v.start+" </td>  <td> "+v.end+" </td></tr>");
	        
	        return;
	    }
	});
}	
function valiteFields(){
	var name = $('#name').val();
	var place = $('#place').val();
	var start = $('#startDate').val();
	var end = $('#endDate').val();
	if(name.length==0 || place.length==0 || start.length==0 || end.length==0){
		alert('Please fill all the fields');
	return true;
	}else{
		return false;
	}
}
//Create new festivity by json post 
function addFestivity(){

	// get inputs
	if(!valiteFields()){
    if($('#startDate').val()>$('#endDate').val()){
    	alert('Start date can be greater than end date');
    }else{
    var festivity = new Object();
	festivity.name = $('#name').val();
	festivity.place = $('#place').val();
	festivity.start = $('#startDate').val();
	festivity.end = $('#endDate').val();
    $.ajax({
        url: "http://localhost:8080/festivities/webapi/festivities/",
        type: 'POST',
        dataType: 'json',
        data: JSON.stringify(festivity),
        contentType: 'application/json',
        mimeType: 'application/json',
 
        success: function (data) {
        	var td_tags = $("<td/>");
            $.each(data, function (index, elementA) {
            	var span = $('<span />').attr('className', 'folder_name').html('Values addes successfully');
            	  $(".newValues").text('Successfully added values');
            	/*var span = $("<span class='label' style='margin:4px;padding:4px'>Values addes successfully />");
                span.text(elementA);
                container.append(span);*/
            	//alert("agregado");// $('#fest_add').append('<tr><td> '+elementA.name+' </td> <td> '+elementA.place+' </td>'+' </td> <td> '+elementA.start+' </td>'+' </td> <td> '+elementA.end+' </td></tr>'); 
 
            }); 
        },
        error:function(data,status,er) {
            alert("error: "+data+" status: "+status+" er:"+er);
        }
    });
    }
	}
}



</script>

<body>
    <center><h1>Festivities Manager Application</h1></center>
  <div id="tabs">
  <ul>
  <li><a href="#tabs-1">Add Festivity</a></li>
  <li><a href="#tabs-3">Festivities List</a></li>
  <li><a href="#tabs-4">Query Festivities</a></li>
  </ul>
  <div id="tabs-1">
   
    <label for="fname">Name</label>
    <input type="text" id="name" name="name"><br>

    <label for="lname">Place</label>
    <input type="text" id="place" name="place">


    <label for="startDate">Start Date</label>
     <div class='input-group date' id='startDateCalendar'>
                    <input type='text' class="form-control" id="startDate" />
                    <span class="input-group-addon">
                        <span class="glyphicon glyphicon-calendar"></span>
                    </span>
                </div>
   
  
   <label for="endDate">End Date</label>
    <div class='input-group date' id='endDateCalendar'>
                    <input type='text' class="form-control" id="endDate" />
                    <span class="input-group-addon">
                        <span class="glyphicon glyphicon-calendar"></span>
                    </span>
                </div>

   
    <input type="button" value="Submit" onclick="javascript:addFestivity()">
    <span class="newValues"></span>
   
  </div>
  <div id="tabs-3">
    <h2>Festivities List</h2>
    <table id='festivities' class="tableF" border="1" style="height: 500px; overflow: auto;">
    <thead>
     <tr>
     <th></th>
    <th>Name</th>
    <th>Place</th>
    <th>Start</th>
    <th>End</th>
  </tr>
  </thead>
 <tfoot>
            <tr>
                <th></th>
    <th>Name</th>
    <th>Place</th>
    <th>Start</th>
    <th>End</th>
            </tr>
        </tfoot></table> 
  </div> 
  <div id="tabs-4">
  <h2>Query Festivities</h2>
   <label for="fname">Name</label>
    <input type="text" id="nameS" name="nameS"><br>

    <label for="lname">Place</label>
    <input type="text" id="placeS" name="placeS">
     <input type="button" value="Search" onclick="javascript:searchFestivity()">
     <div id="table_query">
     <table id='festivities_query' class="tableF" border="1" style="height: 500px; overflow: auto;">
    <thead>
     <tr>
     <th></th>
    <th>Name</th>
    <th>Place</th>
    <th>Start</th>
    <th>End</th>
  </tr>
  </thead>
 </table>
     </div>
  </div>
  </div>
 
</body>
</html>
