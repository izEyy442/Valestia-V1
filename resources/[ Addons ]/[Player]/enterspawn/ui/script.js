
function Validate() {
    $.post("https://enterspawn/CloseUI", JSON.stringify({}))
}

$(function() {
    $('body').hide();
   window.addEventListener('message', function(event) {
       var data = event.data;

       if (data.action == 'showConnexion') {
           $('body').fadeIn(500);
       } else {
            $("body").fadeOut(500);
       }
   });
});

$('#btn').click(function() {
    $("body").fadeOut(500);
    Validate()
})