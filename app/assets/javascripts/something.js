$(document).ready(function() {

  $(".pull-request").on("click", function(){
    $("#commits").addClass('hidden')
    $("#repos").addClass('hidden')
    $("#issues").addClass('hidden')
    $("#pull-requests").removeClass('hidden');
  });

  $(".issues").on("click", function(){
    $("#pull-requests").addClass('hidden')
    $("#repos").addClass('hidden')
    $("#commits").addClass('hidden');
    $("#issues").removeClass('hidden');
  });

  $(".repos").on("click", function(){
    $("#pull-requests").addClass('hidden')
    $("#commits").addClass('hidden');
    $("#issues").addClass('hidden');
    $("#repos").removeClass('hidden');$("#pull-requests").addClass('hidden')
  });
});
