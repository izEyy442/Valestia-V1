$('#green_safez').hide();
$('#red_safez').hide();

$(function () {
      window.addEventListener('message', function (event) {
            if (event.data.safez == "green"){
                if (event.data.show){
                    $('#green_safez').fadeIn(200);
                } else{
                    $('#green_safez').fadeOut(200);
                }
            }  
            if (event.data.safez == "red"){
                if (event.data.show){
                    $('#red_safez').fadeIn(200);
                } else{
                    $('#red_safez').fadeOut(200);
                }
            }  
      })
})