var type = "normal";
var disabled = false;
var idcard = null;
var idcardType = null;
var idcardOpen = false;
var inventoryVisible = false;

let totalSlots = 25;

const maxWeightBarValue = 28.2;

window.postMessage({ action: "open:Inv", type: "someType" }, "*");

window.addEventListener("message", function(event) {
    const weightBar = $('#weightBar')
    const weightText = $('#weight');
    const hudCss = $('#hudSetting')
    const weightCoffre = $('#weightCoffre');
    const weightBarCoffre = $('#weightBarCoffre')
    const textCoffre = $('#plate')

    if (event.data.action == "open:Inv") {

        // ██╗███╗   ██╗██╗   ██╗███████╗███╗   ██╗████████╗ ██████╗ ██████╗ ██╗   ██╗
        // ██║████╗  ██║██║   ██║██╔════╝████╗  ██║╚══██╔══╝██╔═══██╗██╔══██╗╚██╗ ██╔╝
        // ██║██╔██╗ ██║██║   ██║█████╗  ██╔██╗ ██║   ██║   ██║   ██║██████╔╝ ╚████╔╝ 
        // ██║██║╚██╗██║╚██╗ ██╔╝██╔══╝  ██║╚██╗██║   ██║   ██║   ██║██╔══██╗  ╚██╔╝  
        // ██║██║ ╚████║ ╚████╔╝ ███████╗██║ ╚████║   ██║   ╚██████╔╝██║  ██║   ██║   
        // ╚═╝╚═╝  ╚═══╝  ╚═══╝  ╚══════╝╚═╝  ╚═══╝   ╚═╝    ╚═════╝ ╚═╝  ╚═╝   ╚═╝   
                                                                                   
        type = event.data.type

        disabled = false;
        $(".form-inv").fadeIn();
        
        inventoryVisible = true;
    } else if (event.data.action == "close:Inv") {

        $("#dialog").dialog("close");
        
        $(".form-inv").fadeOut(100);
        inventoryVisible = false;

        $(".item").remove();
        $(".menu").hide();

        
        weightBarCoffre.css("width", 0 + "vw");     
        weightCoffre.text('');
        textCoffre.text('');


    } else if (event.data.action == "Inv:WeightBarText") {
        

        let maxBarValue = (maxWeightBarValue * event.data.weight) / event.data.maxWeight; 
        weightBar.css("width", maxBarValue + "vw");     
        weightText.text(event.data.text); 

    } else if (event.data.action == "setItems") {
        
        inventorySetup(event.data.itemList, event.data.fastItems, event.data.crMenu, event.data.itemTrunk);

        maxWeight = event.data.maxWeight
        totalWeight = event.data.weight
        let maxBarValue = maxWeightBarValue / maxWeight * totalWeight//Math.floor(fillPercentage);
        weightBar.css("width", maxBarValue + "vw");     
        weightText.text(event.data.text);

        // $('.info_ui').attr('data-html', 'false').attr('title', _U('help_interfaces')
        // ).tooltip({

        //     classes: {
        //         'ui-tooltip': 'custom-tooltip' // Classe CSS personnalisée pour l'info-bulle
        //     }
        // });

        
        $('.item').draggable({
            helper: 'clone',
            appendTo: 'body',
            zIndex: 99999,
            revert: 'invalid',
            start: function(event, ui) {
                if (disabled) {
                    return false;
                }
                itemData = $(this).data("item");

                if (itemData !== undefined) { 
                    $(this).css('background-image', 'none');
                    $("#drop").addClass("disabled");
                    $("#give").addClass("disabled");
                    $("#rename").addClass("disabled");
                    $("#use").addClass("disabled");
                }
            },
            stop: function() {
                itemData = $(this).data("item");

                if (itemData !== undefined) { 
                    image = itemData.image;
                    $(this).css('background-image', 'url(' + image + ')');
                    // $(this).css('background-image', itemData.image);
                    $("#drop").removeClass("disabled");
                    $("#use").removeClass("disabled");
                    $("#rename").removeClass("disabled");
                    $("#give").removeClass("disabled");
                }

            }
        }); 

    } else if (event.data.action == "setSecondInventoryItems") {

        secondInventorySetup(event.data.itemList);

    } else if (event.data.action == "updateSlot") {

        // ███████╗██╗      ██████╗ ████████╗    
        // ██╔════╝██║     ██╔═══██╗╚══██╔══╝    
        // ███████╗██║     ██║   ██║   ██║       
        // ╚════██║██║     ██║   ██║   ██║       
        // ███████║███████╗╚██████╔╝   ██║       
        // ╚══════╝╚══════╝ ╚═════╝    ╚═╝       
                                      
        updateSlot(event.data.fastItems, event.data.crMenu);
    

    } else if (event.data.action == "InvNotify") {

        // ███╗   ██╗ ██████╗ ████████╗██╗███████╗
        // ████╗  ██║██╔═══██╗╚══██╔══╝██║██╔════╝
        // ██╔██╗ ██║██║   ██║   ██║   ██║█████╗  
        // ██║╚██╗██║██║   ██║   ██║   ██║██╔══╝  
        // ██║ ╚████║╚██████╔╝   ██║   ██║██║     
        // ╚═╝  ╚═══╝ ╚═════╝    ╚═╝   ╚═╝╚═╝     
                                       
        msg = format(event.data.message);
        NotifyDefault(msg, event.data.timeout)

    } else if (event.data.action == "ItemNotify") {

        NotifyItem(event.data.message, event.data.icon, event.data.count)

    } else if (event.data.action == "InvHud") {

        // ██╗  ██╗██╗   ██╗██████╗ 
        // ██║  ██║██║   ██║██╔══██╗
        // ███████║██║   ██║██║  ██║
        // ██╔══██║██║   ██║██║  ██║
        // ██║  ██║╚██████╔╝██████╔╝
        // ╚═╝  ╚═╝ ╚═════╝ ╚═════╝ 
                         
        // if (config.activeHud) {

        //     HealthIndicator.animate(event.data.hp / 100);
        //     ArmorIndicator.animate(event.data.armor / 100);
        //     HungerIndicator.animate(event.data.hunger / 100);
        //     ThirstIndicator.animate(event.data.thirst / 100);
        // } else {

        //     hudCss.css("display","none");     

        // }
    } else if (event.data.action == "open:Input") {

        // ██╗███╗   ██╗██████╗ ██╗   ██╗████████╗
        // ██║████╗  ██║██╔══██╗██║   ██║╚══██╔══╝
        // ██║██╔██╗ ██║██████╔╝██║   ██║   ██║   
        // ██║██║╚██╗██║██╔═══╝ ██║   ██║   ██║   
        // ██║██║ ╚████║██║     ╚██████╔╝   ██║   
        // ╚═╝╚═╝  ╚═══╝╚═╝      ╚═════╝    ╚═╝   
                                       
        $(".title").text(event.data.title);
        $("#textArea").val("");
        $("#keyboard-input").show();
        setTimeout(()=>{
            $("#textArea").focus();
        },10);
        
    } else if (event.data.action == "close:Input") {

        $.post("http://izeyy-inventory/cancel", JSON.stringify({}));
        document.getElementById("textArea").value = "";
        $("#keyboard-input").hide();

    } else if (event.data.action == "open:MenuIdCard") {

        // ███╗   ███╗███████╗███╗   ██╗██╗   ██╗    ██╗██████╗      ██████╗ █████╗ ██████╗ ██████╗ 
        // ████╗ ████║██╔════╝████╗  ██║██║   ██║    ██║██╔══██╗    ██╔════╝██╔══██╗██╔══██╗██╔══██╗
        // ██╔████╔██║█████╗  ██╔██╗ ██║██║   ██║    ██║██║  ██║    ██║     ███████║██████╔╝██║  ██║
        // ██║╚██╔╝██║██╔══╝  ██║╚██╗██║██║   ██║    ██║██║  ██║    ██║     ██╔══██║██╔══██╗██║  ██║
        // ██║ ╚═╝ ██║███████╗██║ ╚████║╚██████╔╝    ██║██████╔╝    ╚██████╗██║  ██║██║  ██║██████╔╝
        // ╚═╝     ╚═╝╚══════╝╚═╝  ╚═══╝ ╚═════╝     ╚═╝╚═════╝      ╚═════╝╚═╝  ╚═╝╚═╝  ╚═╝╚═════╝ 
                                                                                         
        idcard = event.data.info
        idcardType = event.data.type
        $(".menu").show();
      
    } else if (event.data.action == "close:MenuIdCard") {

        $(".menu").hide();

    } else if (event.data.action == "open:idCard") {

        // ██╗██████╗      ██████╗ █████╗ ██████╗ ██████╗ 
        // ██║██╔══██╗    ██╔════╝██╔══██╗██╔══██╗██╔══██╗
        // ██║██║  ██║    ██║     ███████║██████╔╝██║  ██║
        // ██║██║  ██║    ██║     ██╔══██║██╔══██╗██║  ██║
        // ██║██████╔╝    ╚██████╗██║  ██║██║  ██║██████╔╝
        // ╚═╝╚═════╝      ╚═════╝╚═╝  ╚═╝╚═╝  ╚═╝╚═════╝ 
                                               

        idcardOpen = true;
        var userData    = event.data.information;
        var sex         = event.data.sex;
        var title       = event.data.title;
        var mugshot     = event.data.image;
        var icon        = event.data.icon;
        var color         = event.data.color;
    
        $('#type').text(title);
        $('#name').text(userData.firstname + ' ' + userData.lastname);
        $('#dob').text(userData.dateofbirth);
        $('#height').text(userData.height + ' cm' );
        $('#sex').text(sex);
        $('#icon').attr('src', icon);
        $('#picture').attr('src', mugshot || 'assets/icons/picture.png');
        $('#signature').text( userData.lastname);

        // $('#id-card-setting').css('border-top', '0.154vw solid ' + color);*
        var style = document.createElement('style');
        style.innerHTML = '.idcard-container:after { border-bottom: 0.154vw solid ' + color + '; }';
        document.head.appendChild(style);

        $('#picture-box-setting').css('border', '0.104vw solid ' + color);
        $("#right-inventory").html("");
        $('#id-card').show();
    } else if (event.data.action == "close:idCard") {
        $('#id-card').hide();
        idcardOpen = false;


    } else if (event.data.action == "trunk:WeightBarText") {


        let maxBarValue = maxWeightBarValue * event.data.weightTrunk / event.data.maxWeightTrunk//Math.floor(fillPercentage);
        
        weightBarCoffre.css("width", maxBarValue + "vw");     
        weightCoffre.text(event.data.textTrunk);
        textCoffre.text(event.data.plate);

    }
});

// ██╗     ███████╗███████╗████████╗    ██╗███╗   ██╗██╗   ██╗
// ██║     ██╔════╝██╔════╝╚══██╔══╝    ██║████╗  ██║██║   ██║
// ██║     █████╗  █████╗     ██║       ██║██╔██╗ ██║██║   ██║
// ██║     ██╔══╝  ██╔══╝     ██║       ██║██║╚██╗██║╚██╗ ██╔╝
// ███████╗███████╗██║        ██║       ██║██║ ╚████║ ╚████╔╝ 
// ╚══════╝╚══════╝╚═╝        ╚═╝       ╚═╝╚═╝  ╚═══╝  ╚═══╝  
                                                       


function inventorySetup(items, fastItems, crMenu, itemTrunk) {
    $("#left-inventory").html("");
    if (itemTrunk == 'no') {
        $("#right-inventory").html("");
    }


    if (Array.isArray(items)) {
      let itemsCount = items.length;
      
      $.each(items, function(index, item) {
        count = setCount(item);
        
        if (item.image == undefined) {
          item.image = 'https://cdn.discordapp.com/attachments/1008837979894198413/1129138995301994606/togo_box.png';
        }
      
        $("#left-inventory").append('<div class="item-info"><div id="item-' + index + '" class="item" style="background-image: url(' + item.image + ')"><div class="item-count">' + count + '</div><div class="item-name">' + item.label + '</div></div><div class="item-name-bg"></div></div>');
      
        $('#item-' + index).data('item', item);
        $('#item-' + index).data('inventory', 'main');
      });
      
      for (let i = 0; i < totalSlots - itemsCount; i++) {
        let currentIndex = itemsCount + i;
        $("#left-inventory").append('<div class="item-info"><div id="item-' + currentIndex + '" class="item"></div><div class="item-name-bg"></div></div>');
      }
      if (idcardOpen == false) {
        if (itemTrunk == 'no') {

            for (let i = 0; i < totalSlots; i++) {
                $("#right-inventory").append('<div class="item-info"><div id="item-' + i + '" class="item"></div><div class="item-name-bg"></div></div>');
            }
        }
      }
      
    } else {
      // Gérer le cas où items n'est pas un tableau
    //   console.error("items n'est pas un tableau");
    }
    
        $(".middle-bottom-slots").html("");
        if (crMenu == 'item') {
            $("#drop");
            var i;
            image = 'https://cdn.discordapp.com/attachments/979486375218937946/1133070614022852608/image_2023-07-24_181738854-removebg-preview.png'

            for (i = 1; i < 6; i++) {
                $(".middle-bottom-slots").append(
                    '<div class="middle-slot-box" id"itemDescr-' + i + '">'+
                        // '<div class="slot-count"> ' + i + '</div>'+
                        '<img class="slot-count" src="assets/icons/' + i + '_key.png" alt="">'+
                        // '<div class="slot-name"></div>'+
                        '<div id="itemFast-' + i + '" class="item" style = "background-image: url(' + image + ')">' +
                        '</div >'+
                    // '<div class="item-name-bg"></div>'+
                    '</div>'
                );
            }


            $.each(fastItems, function(index, item) {
                count = setCount(item);
                if (item.image == undefined ) {
                    item.image = 'https://cdn.discordapp.com/attachments/1008837979894198413/1129138995301994606/togo_box.png'
                }
                // $('#itemFast-' + item.slot).html('<div class="slot-name">' + item.label + '</div>');
                // $('#itemFast-' + item.slot).html('<div class="slot-name">' + item.label + '</div> <div class="item-name-bg"></div>');
                $('#itemFast-' + item.slot).css("background-image", 'url(' + item.image + ')');
                $('#itemFast-' + item.slot).data('item', item);
                $('#itemFast-' + item.slot).data('inventory', "fast");
            });
        }


    if (crMenu == 'clothe') {
        $("#drop");
    }
    makeDraggables()
    if (crMenu == 'item') {
        $("#drop");
    }
}

// ██████╗ ██╗ ██████╗ ██╗  ██╗████████╗    ██╗███╗   ██╗██╗   ██╗
// ██╔══██╗██║██╔════╝ ██║  ██║╚══██╔══╝    ██║████╗  ██║██║   ██║
// ██████╔╝██║██║  ███╗███████║   ██║       ██║██╔██╗ ██║██║   ██║
// ██╔══██╗██║██║   ██║██╔══██║   ██║       ██║██║╚██╗██║╚██╗ ██╔╝
// ██║  ██║██║╚██████╔╝██║  ██║   ██║       ██║██║ ╚████║ ╚████╔╝ 
// ╚═╝  ╚═╝╚═╝ ╚═════╝ ╚═╝  ╚═╝   ╚═╝       ╚═╝╚═╝  ╚═══╝  ╚═══╝  
                                                               

function secondInventorySetup(items) {
    $("#right-inventory").html("");


    if (Array.isArray(items)) {
        let itemsCount = items.length;
        
        $.each(items, function(index, item) {
          count = setCount(item);
          
          if (item.image == undefined) {
            item.image = 'https://cdn.discordapp.com/attachments/1008837979894198413/1129138995301994606/togo_box.png';
          }
        
          $("#right-inventory").append('<div class="item-info"><div id="itemOther-' + index + '" class="item" style = "background-image: url(' + item.image + ')"><div class="item-count">' + count + '</div><div class="item-name">' + item.label + '</div></div><div class="item-name-bg"></div></div>');

          $('#itemOther-' + index).data('item', item);
          $('#itemOther-' + index).data('inventory', "second");
        });
        
        for (let i = 0; i < totalSlots - itemsCount; i++) {
            let currentIndex = itemsCount + i;
            $("#right-inventory").append('<div class="item-info"><div id="itemOther-' + currentIndex + '" class="item"></div><div class="item-name-bg"></div></div>');
        }

      } else {
        // Gérer le cas où items n'est pas un tableau
        // console.error("items n'est pas un tableau");
      }


}

// ███████╗██╗      ██████╗ ████████╗    
// ██╔════╝██║     ██╔═══██╗╚══██╔══╝    
// ███████╗██║     ██║   ██║   ██║       
// ╚════██║██║     ██║   ██║   ██║       
// ███████║███████╗╚██████╔╝   ██║       
// ╚══════╝╚══════╝ ╚═════╝    ╚═╝       
                                      

function updateSlot(fastItems, crMenu) {
    $(".middle-bottom-slots").html("");
    if (crMenu == 'item') {
        $("#drop");
        var i;
        image = 'https://cdn.discordapp.com/attachments/979486375218937946/1133070614022852608/image_2023-07-24_181738854-removebg-preview.png'

        for (i = 1; i < 6; i++) {
            $(".middle-bottom-slots").append(
                '<div class="middle-slot-box" id"itemDescr-' + i + '">'+
                    '<img class="slot-count" src="assets/icons/' + i + '_key.png" alt="">'+

                    // '<div class="slot-count">' + i + '</div>'+
                    // '<div class="slot-name"></div>'+
                    '<div id="itemFast-' + i + '" class="item" style = "background-image: url(' + image + ')">' +
                    '</div >'+
                // '<div class="item-name-bg"></div>'+
                '</div>'
            );
        }


        $.each(fastItems, function(index, item) {
            count = setCount(item);
            if (item.image == undefined ) {
                item.image = 'https://cdn.discordapp.com/attachments/1008837979894198413/1129138995301994606/togo_box.png'
            }
            // $('#itemFast-' + item.slot).html('<div class="slot-name">' + item.label + '</div>');
            // $('#itemFast-' + item.slot).html('<div class="slot-name">' + item.label + '</div> <div class="item-name-bg"></div>');
            $('#itemFast-' + item.slot).css("background-image", 'url(' + item.image + ')');
            $('#itemFast-' + item.slot).data('item', item);
            $('#itemFast-' + item.slot).data('inventory', "fast");
        });
    }

    if (crMenu == 'clothe') {
        $("#drop");
    }
    makeDraggables()
    if (crMenu == 'item') {
        $("#drop");
    }
}

function makeDraggables() {
    $('#itemFast-1').droppable({
        drop: function(event, ui) {
            itemData = ui.draggable.data("item");
            itemInventory = ui.draggable.data("inventory");

            if (type === "normal" && (itemInventory === "main" || itemInventory === "fast")) {
                disableInventory(500);
                $.post("http://izeyy-inventory/PutIntoFast", JSON.stringify({
                    item: itemData,
                    slot: 1
                }));
            }
        }
    });
    $('#itemFast-2').droppable({
        drop: function(event, ui) {
            itemData = ui.draggable.data("item");
            itemInventory = ui.draggable.data("inventory");

            if (type === "normal" && (itemInventory === "main" || itemInventory === "fast")) {
                disableInventory(500);
                $.post("http://izeyy-inventory/PutIntoFast", JSON.stringify({
                    item: itemData,
                    slot: 2
                }));
            }
        }
    });
    $('#itemFast-3').droppable({
        drop: function(event, ui) {
            itemData = ui.draggable.data("item");
            itemInventory = ui.draggable.data("inventory");

            if (type === "normal" && (itemInventory === "main" || itemInventory === "fast")) {
                disableInventory(500);
                $.post("http://izeyy-inventory/PutIntoFast", JSON.stringify({
                    item: itemData,
                    slot: 3
                }));
            }
        }
    });
    $('#itemFast-4').droppable({
        drop: function(event, ui) {
            itemData = ui.draggable.data("item");
            itemInventory = ui.draggable.data("inventory");

            if (type === "normal" && (itemInventory === "main" || itemInventory === "fast")) {
                disableInventory(500);
                $.post("http://izeyy-inventory/PutIntoFast", JSON.stringify({
                    item: itemData,
                    slot: 4
                }));
            }
        }
    });
    $('#itemFast-5').droppable({
        drop: function(event, ui) {
            itemData = ui.draggable.data("item");
            itemInventory = ui.draggable.data("inventory");

            if (type === "normal" && (itemInventory === "main" || itemInventory === "fast")) {
                disableInventory(500);
                $.post("http://izeyy-inventory/PutIntoFast", JSON.stringify({
                    item: itemData,
                    slot: 5
                }));
            }
        }
    });
}



$(function() {

    $('#button\\.raccourci-1').click(function() {
        $.post('http://izeyy-inventory/category', JSON.stringify({
            type: 'all'
        }));
    });

    $('#button\\.raccourci-2').click(function() {
        $.post('http://izeyy-inventory/category', JSON.stringify({
            type: 'item'
        }));
    });

    $('#button\\.raccourci-3').click(function() {
        $.post('http://izeyy-inventory/category', JSON.stringify({
            type: 'weapon'
        }));
    });

    $('#button\\.raccourci-4').click(function() {
        $.post('http://izeyy-inventory/category', JSON.stringify({
            type: 'clothes'
        }));
    });
    
})



// ██████╗ ██╗   ██╗████████╗████████╗ ██████╗ ███╗   ██╗
// ██╔══██╗██║   ██║╚══██╔══╝╚══██╔══╝██╔═══██╗████╗  ██║
// ██████╔╝██║   ██║   ██║      ██║   ██║   ██║██╔██╗ ██║
// ██╔══██╗██║   ██║   ██║      ██║   ██║   ██║██║╚██╗██║
// ██████╔╝╚██████╔╝   ██║      ██║   ╚██████╔╝██║ ╚████║
// ╚═════╝  ╚═════╝    ╚═╝      ╚═╝    ╚═════╝ ╚═╝  ╚═══╝
                                                      

function disableInventory(ms) {
    disabled = true;

    setInterval(function() {
        disabled = false;
    }, ms);
}

$(document).ready(function() {

    $(document).keydown(function(event) {
        if (event.which === 9) { // 9 est le code de la touche TAB
            // Vérifier si l'inventaire est ouvert
            if (inventoryVisible) {
                $("#dialog").dialog("close");
        
                $(".form-inv").fadeOut(100);
                inventoryVisible = false;
                $.post("http://izeyy-inventory/close",JSON.stringify())

                $(".item").remove();
                $(".menu").hide();
        
                const weightCoffre = $('#weightCoffre');
                const weightBarCoffre = $('#weightBarCoffre')
                const textCoffre = $('#plate')

                weightBarCoffre.css("width", 0 + "vw");     
                weightCoffre.text('');
                textCoffre.text('');
                
            }
        }
    });

    $('.middle-clothes-part-left .item-box').off().click(function(){
        $.post("http://izeyy-inventory/removeClothes",JSON.stringify({component:$(this).attr('id')}))
    })
    $('.middle-clothes-part-right .item-box2').off().click(function(){
        $.post("http://izeyy-inventory/removeClothes",JSON.stringify({component:$(this).attr('id')}))
    })



    $('#useItem').droppable({
        hoverClass: 'hoverControl',
        drop: function(event, ui) {
            if (idcardOpen) {
                $('#id-card').hide();
            }
            itemData = ui.draggable.data("item");
            if (itemData.usable) {
                $.post("http://izeyy-inventory/useItem", JSON.stringify({
                    item: itemData,
                    // number: parseInt($("#count").val())
                }));
            }
        }
    });

    $('#giveItem').droppable({
        hoverClass: 'hoverControl',
        drop: function(event, ui) {
            itemData = ui.draggable.data("item");
            $.post("http://izeyy-inventory/giveItem", JSON.stringify({
                item: itemData,
                // number: parseInt($("#count").val())
            }));
        }
    });

    $('#renameItem').droppable({
        hoverClass: 'hoverControl',
        drop: function(event, ui) {
            itemData = ui.draggable.data("item");
            $.post("http://izeyy-inventory/renameItem", JSON.stringify({
                item: itemData,
                // number: parseInt($("#count").val())
            }));
        }
    });

    $('#deleteItem').droppable({
        hoverClass: 'hoverControl',
        drop: function(event, ui) {
            itemData = ui.draggable.data("item");
            $.post("http://izeyy-inventory/deleteItem", JSON.stringify({
                item: itemData,
                // number: parseInt($("#count").val())
            }));
        }
    });

    
    
    $('#left-inventory').droppable({
        drop: function(event, ui) {
            itemData = ui.draggable.data("item");
            itemInventory = ui.draggable.data("inventory");

            if (type === "trunk" && itemInventory === "second") {
                disableInventory(500);
                $.post("http://izeyy-inventory/TakeFromTrunk", JSON.stringify({
                    item: itemData,
                    // number: parseInt($("#count").val())
                }));
            } else if (type === "property" && itemInventory === "second") {
                disableInventory(500);
                $.post("http://izeyy-inventory/TakeFromProperty", JSON.stringify({
                    item: itemData,
                    // number: parseInt($("#count").val())
                }));
            } else if (type === "normal" && itemInventory === "fast") {
                disableInventory(500);
                $.post("http://izeyy-inventory/TakeFromFast", JSON.stringify({
                    item: itemData
                }));
            } else if (type === "vault" && itemInventory === "second") {
                disableInventory(500);
                $.post("http://izeyy-inventory/TakeFromVault", JSON.stringify({
                    item: itemData,
                    // number: parseInt($("#count").val())
                }));
            } else if (type === "player" && itemInventory === "second") {
                disableInventory(500);
                $.post("http://izeyy-inventory/TakeFromPlayer", JSON.stringify({
                    item: itemData,
                    // number: parseInt($("#count").val())
                }));
            }
        }
    });

    $('#right-inventory').droppable({
        drop: function(event, ui) {
            itemData = ui.draggable.data("item");
            itemInventory = ui.draggable.data("inventory");

            if (type === "trunk" && itemInventory === "main") {
                disableInventory(500);
                $.post("http://izeyy-inventory/PutIntoTrunk", JSON.stringify({
                    item: itemData,
                }));
            } else if (type === "property" && itemInventory === "main") {
                disableInventory(500);
                $.post("http://izeyy-inventory/PutIntoProperty", JSON.stringify({
                    item: itemData,
                }));





            } else if (type === "vault" && itemInventory === "main") {
                disableInventory(500);
                $.post("http://izeyy-inventory/PutIntoVault", JSON.stringify({
                    item: itemData,
                    // number: parseInt($("#count").val())
                }));
            } else if (type === "player" && itemInventory === "main") {
                disableInventory(500);
                $.post("http://izeyy-inventory/PutIntoPlayer", JSON.stringify({
                    item: itemData,
                }));
            }
        }
    });



    document.getElementById("textArea").addEventListener("keyup", function(event) {
        event.preventDefault();
        if (event.keyCode === 13 && $("#keyboard-input").is(":visible") && $("#textArea").is(":focus")) {
        $.post("http://izeyy-inventory/send", JSON.stringify({"text": document.getElementById("textArea").value.trim()}));
        document.getElementById("textArea").value = "";
        $("#keyboard-input").hide();
        }
        if (event.keyCode === 27 && $("#keyboard-input").is(":visible") && $("#textArea").is(":focus")) {
        $.post("http://izeyy-inventory/cancel", JSON.stringify({}));
        document.getElementById("textArea").value = "";
        $("#keyboard-input").hide();
        }
    });
    
    $('#button\\.valider').click(function() {
        $.post("http://izeyy-inventory/send", JSON.stringify({"text": document.getElementById("textArea").value.trim()}));
        document.getElementById("textArea").value = "";
        $("#keyboard-input").hide();
    });

    $('#button\\.showButton').click(function(){
        $.post("http://izeyy-inventory/giveCard", JSON.stringify({
            info: idcard,
            type: idcardType
        }));
        $(".menu").hide();
    });
    $('#button\\.chooseButton').click(function(){

        $.post("http://izeyy-inventory/lookCard", JSON.stringify({
            info: idcard,
            type: idcardType
        }));
        $(".menu").hide();
    });

    $('#button\\.closeIdCard').click(function(){
        $('#id-card').hide();
        idcardOpen = false
        for (let i = 0; i < totalSlots; i++) {
            $("#right-inventory").append('<div class="item-info"><div id="item-' + i + '" class="item"></div><div class="item-name-bg"></div></div>');
        }
    });
});





  


$.widget('ui.dialog', $.ui.dialog, {
    options: {
        // Determine if clicking outside the dialog shall close it
        clickOutside: false,
        // Element (id or class) that triggers the dialog opening 
        clickOutsideTrigger: ''
    },
    open: function() {
        console.log('ici')
        var clickOutsideTriggerEl = $(this.options.clickOutsideTrigger),
            that = this;
        if (this.options.clickOutside) {
            // Add document wide click handler for the current dialog namespace
            $(document).on('click.ui.dialogClickOutside' + that.eventNamespace, function(event) {
                var $target = $(event.target);
                if ($target.closest($(clickOutsideTriggerEl)).length === 0 &&
                    $target.closest($(that.uiDialog)).length === 0) {
                    that.close();
                }
            });
        }
        // Invoke parent open method
        this._super();
    },
    close: function() {
        // Remove document wide click handler for the current dialog
        $(document).off('click.ui.dialogClickOutside' + this.eventNamespace);
        // Invoke parent close method 
        this._super();
    },
});








// ███╗   ██╗ ██████╗ ████████╗██╗███████╗██╗ ██████╗ █████╗ ████████╗██╗ ██████╗ ███╗   ██╗
// ████╗  ██║██╔═══██╗╚══██╔══╝██║██╔════╝██║██╔════╝██╔══██╗╚══██╔══╝██║██╔═══██╗████╗  ██║
// ██╔██╗ ██║██║   ██║   ██║   ██║█████╗  ██║██║     ███████║   ██║   ██║██║   ██║██╔██╗ ██║
// ██║╚██╗██║██║   ██║   ██║   ██║██╔══╝  ██║██║     ██╔══██║   ██║   ██║██║   ██║██║╚██╗██║
// ██║ ╚████║╚██████╔╝   ██║   ██║██║     ██║╚██████╗██║  ██║   ██║   ██║╚██████╔╝██║ ╚████║
// ╚═╝  ╚═══╝ ╚═════╝    ╚═╝   ╚═╝╚═╝     ╚═╝ ╚═════╝╚═╝  ╚═╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝
                                                                                         

var currentNotification = null;

function NotifyDefault( message, timeout) {
    var count = 1;
    
    if (currentNotification == 1) {
        return;
    }
    if (currentNotification == undefined) {
        currentNotification = 1;
    }

    $(".notification").prepend(`        
        <div class="notify-without-icon" id="notifydef-${count}">
            <div class="content-notify-without-icon">
                <div class="notify-without-icon-text">
                    <span>${message}</span>
                </div>
            </div>
            <div class="progress-bar-notifi-without-icon"></div>
        </div>
    `);

    var notificationEl = $(`#notifydef-${count}`);
    
    var progressEl = notificationEl.find(`.progress-bar-notifi-without-icon`);
    var startTime = Date.now();
    
    var interval = setInterval(function() {
        var elapsedTime = Date.now() - startTime;
        var percentage = elapsedTime / timeout * 100;

        if (percentage >= 100) {
            clearInterval(interval);
			setTimeout(() => {
				notificationEl.addClass("hidden");
			}, 150);

			setTimeout(() => {
				notificationEl.remove()
                currentNotification = null;

			}, 600);
        } else {
            progressEl.css("width", `${percentage}%`);
        }
    }, 10);

    count++;
}


function NotifyItem(message, icon, number) {
    var count = 1;

    if (icon == undefined ) {
        icon = 'https://cdn.discordapp.com/attachments/1008837979894198413/1129138995301994606/togo_box.png'
    }

    $(".iconNotif").prepend(`
        <div class="notify-with-icon" id="notify-${count}"">
            <div class="content-notify-with-icon">
            <img src="${icon}" alt="">

            </div>
            <div class="notify-with-icon-text">
                <span>${message}</span>
            </div>
            <div class="notify-with-icon-count">
                <span>${number}</span>
            </div>
        </div>
    `);

    var notificationEl = $(`#notify-${count}`);
    // var progressEl = notificationEl.find(`.progress-bar-notifi-with-icon`);
    var startTime = Date.now();

    var interval = setInterval(function() {
        var elapsedTime = Date.now() - startTime;
        var percentage = elapsedTime / 3000 * 100;

        if (percentage >= 100) {
            clearInterval(interval);
			setTimeout(() => {
				notificationEl.addClass("hidden");
			}, 150);

			setTimeout(() => {
				notificationEl.remove()
			}, 600);
        } else {
            // progressEl.css("width", `${percentage}%`);
        }
    }, 10);

    count++;
}


// TEXT NOTIFIACTION



function isDefined(param) {
    return typeof param !== "undefined" && param !== null;
}

function format(text) {
    var everColoring = false;
    var currentColor = "";
    var finalText = "";
    for (var i = 0; i < text.length; i++) {
        if(text[i] === "~"){
            var INFO = '';
            i++;
            while (text[i] != "~") {
                INFO += text[i];
                i++;
            }
            if (isDefined(config_text_color[INFO])){
                currentColor = config_text_color[INFO];
                if (!everColoring) {
                    finalText += "<span style=\"color: " + currentColor + "\">";
                    everColoring = true;
                } else {
                    finalText += "</span><span style=\"color: " + currentColor + "\">";
                }
            } else if(isDefined(config_text_fonts[INFO])){
                currentColor = config_text_fonts[INFO];
                if (!everColoring) {
                    finalText += "<span style=\"" + currentColor + "\">";
                    everColoring = true;
                } else {
                    finalText += "</span><span style=\"" + currentColor + "\">";
                }
            } else if(isDefined(Keys[INFO])){
                finalText += "<span class=\"key\">" + Keys[INFO] + "</span>";
            }

        } else {
            finalText += text[i];
        }
    }
    if (everColoring) {
        finalText += "</span>";
    }
    return finalText;
}

function GTA_PICTURE(id) {
    if (isDefined(Picture[id])) {
        return "assets/images/" + Picture[id];
    } else {
        return false;
    }
}



// FUNCTION INVENTORY

// FORMAT ACCOUNT FOR ALL ITEM

function setCount(item) {
    count = item.count

    if (item.limit > 0) {
        count = item.count
    }

    if (item.type === "item_weapon") {
        if (count == 0) {
            count = "";
        } else {
            count = count;
        }
    }
    if (item.type === "item_idcard") {
        count = "";
        // if (count == 0) {
        //     count = "";
        // } else {
        //     count = '<img src="img/bullet.png" class="ammoIcon"> ' + item.ammo;
        // }
    }

    if (item.type === "item_account" || item.type === "item_money") {
        count = formatMoney(item.count);
    }

    return count;
}

// FORMAT ACCOUT 

function formatMoney(n, c, d, t) {
    var c = isNaN(c = Math.abs(c)) ? 2 : c,
        d = d == undefined ? "." : d,
        t = t == undefined ? "," : t,
        s = n < 0 ? "-" : "",
        i = String(parseInt(n = Math.abs(Number(n) || 0).toFixed(c))),
        j = (j = i.length) > 3 ? j % 3 : 0;

    return s + (j ? i.substr(0, j) + t : "") + i.substr(j).replace(/(\d{3})(?=\d)/g, "$1" + t);
};

// CLIQUE DROIT

$(document).mousedown(function(event) {

    if (event.which != 3) return

    itemData = $(event.target).data("item");

    if (itemData == undefined || itemData.usable == undefined) {
        return;
    }

    itemInventory = $(event.target).data("izeyy-inventory");

    if (itemData.usable) {

        // $(event.target).fadeIn(50)
        // setTimeout(function() {
            $.post("http://izeyy-inventory/useItem", JSON.stringify({
                item: itemData
            }));
        // }, 100);
        // $(event.target).fadeOut(50)
    }

});



// ██╗  ██╗██╗   ██╗██████╗ 
// ██║  ██║██║   ██║██╔══██╗
// ███████║██║   ██║██║  ██║
// ██╔══██║██║   ██║██║  ██║
// ██║  ██║╚██████╔╝██████╔╝
// ╚═╝  ╚═╝ ╚═════╝ ╚═════╝ 
                         

if (config.activeHud) {
    $(document).ready(function () {
        HealthIndicator = new ProgressBar.Circle("#HealthIndicator", {
        color: config.colorHud,
        trailColor: "rgb(80, 80, 80)",
        strokeWidth: 10,
        trailWidth: 10,
        duration: 2000,
        easing: "easeInOut",
        });
    
        ArmorIndicator = new ProgressBar.Circle("#ArmorIndicator", {
        color: config.colorHud,
        trailColor: "rgb(80, 80, 80)",
        strokeWidth: 10,
        trailWidth: 10,
        duration: 2000,
        easing: "easeInOut",
        });
    
        HungerIndicator = new ProgressBar.Circle("#HungerIndicator", {
        color: config.colorHud,
        trailColor: "rgb(80, 80, 80)",
        strokeWidth: 10,
        trailWidth: 10,
        duration: 2000,
        easing: "easeInOut",
        });
    
        ThirstIndicator = new ProgressBar.Circle("#ThirstIndicator", {
        color: config.colorHud,
        trailColor: "rgb(80, 80, 80)",
        strokeWidth: 10,
        trailWidth: 10,
        duration: 2000,
        easing: "easeInOut",
        });
    
    });
}
