var container = document.getElementById("instbuttons");
var inputId = 0;
var keyMap = {
    44: [0, "Q.png", 2, "rb.png"],
    46: [0, "E.png", 2, "dirr.png"],
    49: [0, "F", 2, "y.png"],
    134: [0, "D", 2, "rb.png"],
    139: [0, "S", 0, "RT"],
    176: [0, "176_pc.png", 2, "a.png"],
    177: [1, "177_pc.png", 2, "b.png"],
    187: [0, "187.png", 2, "dird.png"],
    188: [0, "188.png", 2, "diru.png"],
    189: [0, "189_pc.png", 2, "dirl.png"],
    190: [0, "190_pc.png", 2, "dirr.png"],
    193: [0, "193_pc.png", 2, "x.png"],
    201: [0, "176_pc.png", 2, "a.png"],
    202: [0, "Esc.png", 2, "b.png"],
    203: [0, "193_pc.png", 2, "x.png"],
    204: [0, "Tab.png", 2, "y.png"],
    206: [0, "E.png", 2, "rb.png"],
    207: [1, "207.png", 0, "LT"],
    208: [1, "208.png", 0, "RT"],
    210: [1, "LCtrl.png", 2, "r.png"],
    237: [2, "237.png", 2, "237.png"],
    238: [2, "238.png", 2, "238.png"],
};

function CreateKey(keyType, keyContent) {
    if (keyType == 0) {
        // square key small
        var o = document.createElement("span");
        o.className = "key keySmall";

        if (keyContent.includes(".png")) {
            o.innerHTML = "<img src='./keys/" + keyContent + "' style='width:100%;height:100%'>";
        }
        else {
            o.innerHTML = keyContent;
        }
        return o;
    }
    else if (keyType == 1) {
        //square key large
        // square key small
        var o = document.createElement("span");
        o.className = "key keyBig";

        if (keyContent.includes(".png")) {
            o.innerHTML = "<img src='./keys/" + keyContent + "' style='width:100%;height:100%'>";
        }
        else {
            o.innerHTML = keyContent;
        }
        return o;
    }
    else if (keyType == 2) {
        //no square, just img
        var o = document.createElement("span");
        o.className = "keyCustom";

        o.innerHTML = "<img src='./keys/" + keyContent + "' style='width:100%;height:100%'>";
        return o;
    }
}


function AppendKey(keyCode, keyCaption, extraKey) {
    var keyType = keyMap[keyCode][inputId];
    var keyContent = keyMap[keyCode][inputId + 1]

    var c = document.createElement("p");
    c.innerHTML = keyCaption;
    c.className = "justText";
    container.appendChild(c);

    container.appendChild(CreateKey(keyType, keyContent));

    if (extraKey) {
        keyType = keyMap[extraKey][inputId];
        keyContent = keyMap[extraKey][inputId + 1]

        var o = CreateKey(keyType, keyContent);
        o.style.marginLeft = "-0.00vh";
        container.appendChild(o);
    }
}

window.addEventListener('message', (event) => {
    let action = event.data.action;

    if (action == "drawInstButtons") {
        container.innerHTML = "";
        var buttons = event.data.buttons;
        
        inputId = event.data.isGamepad == true ? 2 : 0;

        container.style.display = (buttons && buttons.length > 0 ? "flex" : "none");

        if (buttons) {
            for (let index = buttons.length - 1; index >= 0; index--) {
                const el = buttons[index];
                AppendKey(el.key, el.title, el.extraKey)
            }
        }
    }

    if (action == "chipshud") {
        document.getElementById("nuichipsvalue").innerHTML = event.data.chips;
        document.getElementById("nuichips").style.display = event.data.chips != -1 ? "block" : "none";
    }
})