<!doctype html>
<html lang="en">
  <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link href="https://fonts.googleapis.com/css?family=Roboto:300,400&display=swap" rel="stylesheet">

    <link href="https://fonts.googleapis.com/css?family=Poppins:300,400,500&display=swap" rel="stylesheet">

    
    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/fonts/icomoon/style.css">
  
    <link href='<%=request.getContextPath()%>/assets/fullcalendar/packages/core/main.css' rel='stylesheet' />
    <link href='<%=request.getContextPath()%>/assets/fullcalendar/packages/daygrid/main.css' rel='stylesheet' />
    
    
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/bootstrap.min.css">
    
    <!-- Style -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/calendarStyle.css">

    <title>Calendar #10</title>
  </head>
  <body>
  

  <div id='calendar-container'>
    <div id='calendar'></div>
  </div>
    
    

    <script src="<%=request.getContextPath()%>/assets/js/jquery-3.3.1.min.js"></script>
    <script src="<%=request.getContextPath()%>/assets/js/popper.min.js"></script>
    <script src="<%=request.getContextPath()%>/assets/js/bootstrap.min.js"></script>

    <script src='<%=request.getContextPath()%>/assets/fullcalendar/packages/core/main.js'></script>
    <script src='<%=request.getContextPath()%>/assets/fullcalendar/packages/interaction/main.js'></script>
    <script src='<%=request.getContextPath()%>/assets/fullcalendar/packages/daygrid/main.js'></script>
    <script src='<%=request.getContextPath()%>/assets/fullcalendar/packages/timegrid/main.js'></script>
    <script src='<%=request.getContextPath()%>/assets/fullcalendar/packages/list/main.js'></script>

    

    <script>
      document.addEventListener('DOMContentLoaded', function() {
    var calendarEl = document.getElementById('calendar');

    var calendar = new FullCalendar.Calendar(calendarEl, {
      plugins: [ 'interaction', 'dayGrid', 'timeGrid', 'list' ],
      height: 'parent',
      header: {
        left: 'prev,next today',
        center: 'title',
        right: 'dayGridMonth,timeGridWeek,timeGridDay,listWeek'
      },
      defaultView: 'dayGridMonth',
      defaultDate: '2022-12-12',
      navLinks: true, // can click day/week names to navigate views
      editable: true,
      eventLimit: true, // allow "more" link when too many events
      events: [
        {
          title: 'All Day Event',
          start: '2022-12-01',
        },
        {
          title: 'Long Event',
          start: '2022-12-07',
          end: '2022-12-10'
        },
        {
          groupId: 999,
          title: 'Repeating Event',
          start: '2022-12-09T16:00:00'
        },
        {
          groupId: 999,
          title: 'Repeating Event',
          start: '2022-12-16T16:00:00'
        },
        {
          title: 'Conference',
          start: '2022-12-11',
          end: '2022-12-13'
        },
        {
          title: 'Meeting',
          start: '2022-12-12T10:30:00',
          end: '2022-12-12T12:30:00'
        },
        {
          title: 'Lunch',
          start: '2022-12-12T12:00:00'
        },
        {
          title: 'Meeting',
          start: '2022-12-12T14:30:00'
        },
        {
          title: 'Happy Hour',
          start: '2022-12-12T17:30:00'
        },
        {
          title: 'Dinner',
          start: '2022-12-12T20:00:00'
        },
        {
          title: 'Birthday Party',
          start: '2022-12-13T07:00:00'
        },
        {
          title: 'Click for Google',
          url: 'http://google.com/',
          start: '2022-12-28'
        }
      ]
    });

    calendar.render();
  });

    </script>

    <script src="<%=request.getContextPath()%>/assets/js/main.js"></script>
  </body>
</html>