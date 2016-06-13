<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<title>Festivity Edit</title>
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
$(function(){
	$( "#startDateCalendar" ).datetimepicker();
	$( "#endDateCalendar" ).datetimepicker({
		useCurrent: false //Important! See issue #1075
	});
	 $("#startDateCalendar").on("dp.change", function (e) {
         $('#endDateCalendar').data("DateTimePicker").minDate(e.date);
     });
	var qs = (function(a) {
	    if (a == "") return {};
	    var b = {};
	    for (var i = 0; i < a.length; ++i)
	    {
	        var p=a[i].split('=', 2);
	        if (p.length == 1)
	            b[p[0]] = "";
	        else
	            b[p[0]] = decodeURIComponent(p[1].replace(/\+/g, " "));
	    }
	    return b;
	})(window.location.search.substr(1).split('&'));
	$("#id").val(qs["id"]);
	
$.getJSON('http://localhost:8080/festivities/webapi/festivities/'+qs["id"], function(result) {	
	 $.each(result, function(i, field){
         $("table").append("<td>"+field + "</td>>");
     });

	}); 
	
  
});
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
function updateFestivity(){
	if(!valiteFields()){
	// get inputs
	var id=$("#id").val();
    var festivity = new Object();
	festivity.name = $('#name').val();
	festivity.place = $('#place').val();
	festivity.start = $('#startDate').val();
	festivity.end = $('#endDate').val();
	
    $.ajax({
        url: "http://localhost:8080/festivities/webapi/festivities/"+id,
        type: 'PUT',
        dataType: 'json',
        data: JSON.stringify(festivity),
        contentType: 'application/json',
        mimeType: 'application/json',
 
        success: function (data) {
            $.each(data, function (index, elementA) {
            	
            	  $(".newValues").text('Successfully edited values');
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

</script>
</head>
<body>
<h1>Festivity Edit</h1>
<table class="tableF">
<tr>
<th>Start</th>
<th>Id</th>
<th>Name</th>
<th>Place</th>
<th>End</th>
</tr>
</table>
<div>
 <label for="fname">Name</label>
 <input type="hidden" id="id" name="id">
    <input type="text" id="name" name="name">

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
   
    <input type="button" value="Submit" onclick="javascript:updateFestivity()">
    <input type="button" value="Return" onclick="javascript:window.location='../festivities'">
    <span class="newValues"></span>
</div>
</body>
</html>