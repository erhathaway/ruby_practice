$(document).ready(function() {
	if($('div').is('.meetup_group')){
		var group_id = $('#group_name').data( "groupId" )
		$.ajax({
		    type: "GET",
		  	data: { group_id: group_id },
		    url: "/data",
		    dataType: "json",
		    success: function(data) {groupPageLoad(data)},
		    error: function() {alert("Error!")}
	  	});
	};
})


function groupPageLoad(data){
	var group_id = $('#group_name').data("groupId")
	var group_status = data.group_status;
	var group = data.group;
	var users = data.users;
	var group_events = data.group_events;

	  // return { status: 'joined', group: group, users: users, events: events }.json
	var group_user_status = $('#group_user_status');
	var group_summary = $('#group_summary');
	var group_users = $('#group_users');

	$('#group_events').empty()
	group_events.forEach(function(group_event){
		if (group_event.date ===  null){group_event.date = 'TBA'}
		if (group_event.description ===  null){group_event.description = ''}
		// debugger

		$('#group_events').append('<div class="group_event_item">'+
			'<div class="remove_event">x</div>'+
			'<div id="group_event_name"><h3>'+group_event.event_name+'</h3></div>'+
			'<div id="group_event_location">'+'Location: '+group_event.location+'</div>'+
			'<div id="group_event_date">'+'On: '+group_event.date+'</div>'+
			'<div id="group_event_description">'+group_event.description+'</div>'+
			'</div');
	});

	$('#group_users').empty()
	users.forEach(function(user){
		$('#group_users').append('<div><h5>'+user.username+'</h5></div>');
	});
	// debugger

	if (group_status === 'joined'){
		$("#group_status_button").text("Leave Group"); 
		$("#group_status_button").attr('onClick', 'leaveGroup()'); 
	};
	if (group_status === 'visitor'){
		$("#group_status_button").text("Join Group");
		$("#group_status_button").attr('onClick', 'joinGroup()');
	};
};


function joinGroup(){
	var group_id = $('#group_name').data("groupId")
	$.ajax({
	    type: "POST",
	    url: "/group/join",
	    data: { group_id: group_id },
	    dataType: "json",
	   	success: function(data){groupPageLoad(data);},
	    error: function() {alert("Sorry something went wrong");}
	});
};

function leaveGroup(){
  	var group_id = $('#group_name').data( "groupId" )
	$.ajax({
	    type: "POST",
	    url: "/group/leave",
	    data: { group_id: group_id },
	    dataType: "json",
	   	success: function(data){groupPageLoad(data);},
	    error: function() {
	      alert("Sorry something went wrong");
	    }
	});
};

function eventCreate(){
	$("#add_event").css("display", "block");
};

function eventCancel(){
	$("#add_event").css("display", "none");
};

function eventSubmit(){
	var event_name = $('#event_name').val()
	var event_description = $('#event_description').val()
	var event_location = $('#event_location').val()
	var event_date = $('#event_date').val()

	$("#add_event").css("display", "none");

 	var group_id = $('#group_name').data( "groupId" )
	$.ajax({
	    type: "POST",
	    url: "/event/new",
	    data: { group_id: group_id, 
	    	event_name: event_name, 
	    	event_location: event_location, 
	    	event_description: event_description,
	    	event_date: event_date },
	    dataType: "json",
	   	success: function(data){groupPageLoad(data);},
	    error: function() {alert("Something went wrong");}
	});
};

// $(document).ready(function() {
//   $.ajax({
//     type: "GET",
//     url: "/tasks.json",
//     dataType: "json",
//     success: function(data) {
//       var tasks = data.tasks;
//       var importantUrgent = $('.important-urgent');
//       var importantNotUrgent = $('.important-not-urgent');
//       var notImportantUrgent = $('.not-important-urgent');
//       var notImportantNotUrgent = $('.not-important-not-urgent');

//       tasks.forEach(function(task) {
//         var text = "<li>" + task.text + "</li>";
//         if (task.important === true && task.urgent === true){
//           importantUrgent.append(text);
//         }
//         else if (task.important === true && task.urgent === false) {
//           importantNotUrgent.append(text);
//         }
//         else if (task.important === false && task.urgent === true) {
//           notImportantUrgent.append(text);
//         }
//         else if (task.important === false && task.urgent === false) {
//           notImportantNotUrgent.append(text);
//         }
//       });
//     },
//     error: function() {
//       alert("in the error block :( ")
//       // do something else
//     }
//   });

//   $("#new-task-button").click(function(e) {
//     e.preventDefault();

//     var text = $('#task-text-field').val();
//     var important = $('#important').val();
//     var urgent = $('#urgent').val();
//     var importantUrgent = $('.important-urgent');
//     var importantNotUrgent = $('.important-not-urgent');
//     var notImportantUrgent = $('.not-important-urgent');
//     var notImportantNotUrgent = $('.not-important-not-urgent');

//     $.ajax({
//     type: "POST",
//     url: "/tasks",
//     data: { text: text, important: important, urgent: urgent },
//     dataType: "json",
//     success: function(task) {
//       var text = "<li>" + task.text + "</li>";
//       if (task.important === true && task.urgent === true){
//         importantUrgent.append(text);
//       }
//       else if (task.important === true && task.urgent === false) {
//         importantNotUrgent.append(text);
//       }
//       else if (task.important === false && task.urgent === true) {
//         notImportantUrgent.append(text);
//       }
//       else if (task.important === false && task.urgent === false) {
//         notImportantNotUrgent.append(text);
//       }
//     },
//     error: function() {
//       alert("Sorry something went wrong");
//     }
//     });
//   });