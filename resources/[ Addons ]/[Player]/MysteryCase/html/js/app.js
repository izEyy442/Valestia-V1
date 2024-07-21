var selectedUnique;
var caseOpeningSound = null;
var collectedSound = null;
var fastOpenSound = null;
var sellItemSound = null;
var premiumCases = [];
var translate = [];
var lastItems = [];
var standardCases = [];
var sellCoins = [];
var webSiteLink = null;
var discordLink = null;
var firstOpen = true;
var profilePhoto = "";
var escUsable = true;

$(document).ready(function () {
    if (caseOpeningSound != null) {
        caseOpeningSound.pause();
    }
    if (collectedSound != null) {
        collectedSound.pause();
    }
    if (fastOpenSound != null) {
        fastOpenSound.pause();
    }
    if (sellItemSound != null) {
        sellItemSound.pause();
    }
    caseOpeningSound = new Howl({ src: ["sounds/caseOpening.mp3"] });
    caseOpeningSound.volume(1.0);

    fastOpenSound = new Howl({ src: ["sounds/fastOpen.mp3"] });
    fastOpenSound.volume(1.0);

    collectedSound = new Howl({ src: ["sounds/collected.mp3"] });
    collectedSound.volume(0.8);

    sellItemSound = new Howl({ src: ["sounds/sellItem.mp3"] });
    sellItemSound.volume(0.1);
});

$(document).on("click", ".openCaseButton", function () {
    var selectedDiv = this;
    var stringInfo = $(selectedDiv).attr("data-caseInfo");
    var parseInfo = JSON.parse(stringInfo);

    $(".caseOpeningInCaseItems").empty();
    var selectedCaseItems = parseInfo.items;

    var current = document.getElementsByClassName("openinOpenCaseButton");
    if (current.length > 0) {
        current[0].className = "openinOpenCaseButton";
    }

    $(".openinOpenCaseButton").addClass(parseInfo.caseTheme);

    $("#currentCaseName").html(parseInfo.label);
    $(".openingCreditCountText").html(parseInfo.price);
    $(".openingCreditText").html(parseInfo.priceType);

    var caseImg = "nudeCase.png";
    if (parseInfo.caseTheme === "orange") caseImg = "yellowCase.png";
    if (parseInfo.caseTheme === "red") caseImg = "redCase.png";
    if (parseInfo.caseTheme === "blue") caseImg = "blueCase.png";
    if (parseInfo.caseTheme === "green") caseImg = "greenCase.png";
    if (parseInfo.caseTheme === "purple") caseImg = "purpleCase.png";
    $(".openingCaseImageX").attr("src", `./images/src/${caseImg}`);

    var coinImg = "./images/src/silverCoin.png";
    if (parseInfo.priceType == "GC") coinImg = "./images/src/goldCoin.png";
    $(".openingGoldIconImg").attr("src", coinImg);

    var caseType = "null";
    if (parseInfo.caseType == "premium") caseType = "premium";
    selectedUnique = parseInfo.uniqueId;
    $(".openinOpenCaseButton").attr("data-unique", selectedUnique);
    $(".openinOpenFastButton").attr("data-unique", selectedUnique);
    $(".openinOpenCaseButton").attr("data-premium", caseType);
    $(".openinOpenFastButton").attr("data-premium", caseType);

    $("#caseItemsCount").html(selectedCaseItems.length);
    selectedCaseItems.forEach((element) => {
        itemBg = "blueItemBg.png";
        if (element.itemType === "uncommon") itemBg = "greenItemBg.png";
        if (element.itemType === "rare") itemBg = "purpleItemBg.png";
        if (element.itemType === "mythical") itemBg = "redItemBg.png";
        if (element.itemType === "legendary") itemBg = "yellowItemBg.png";
        $(".caseOpeningInCaseItems").append(`
            <div class="inCaseItem">
                <img src="./images/src/${itemBg}" alt="" />
                <div class="incaseItemImageArea">
                    <img src=${element.image} alt="" />
                </div>
                <div class="incaseItemItemName">${element.label}</div>
                <div class="incaseCurrentCase">${parseInfo.label}</div>
            </div>
        `);
    });
});

function setPremiumCases() {
    $(".premiumCasesList").empty();
    $("#premiumCaseCount").html(premiumCases.length);
    premiumCases.forEach((element) => {
        itemBg = "blueBg.png";
        itemCase = "blueCase.png";
        itemClass = "blue";
        if (element.caseTheme === "green") {
            itemBg = "greenBg.png";
            itemCase = "greenCase.png";
            itemClass = "green";
        }
        if (element.caseTheme === "purple") {
            itemBg = "purpleBg.png";
            itemCase = "purpleCase.png";
            itemClass = "purple";
        }
        if (element.caseTheme === "red") {
            itemBg = "redBg.png";
            itemCase = "redCase.png";
            itemClass = "red";
        }
        if (element.caseTheme === "orange") {
            itemBg = "yellowBg.png";
            itemCase = "yellowCase.png";
            itemClass = "yellow";
        }
        isNew = "";
        if (element.isNew) isNew = `<div class="premiumCasesNewIcon">${translate.new}</div>`;
        $(".premiumCasesList").append(`
        <div class="caseItem">
            <div class="premiumCaseBackgroundArea">
                <img src="./images/src/${itemBg}" alt="" />
            </div>
            <div class="premiumCaseImgArea">
                <img src="./images/src/${itemCase}" alt="" />
            </div>
                ${isNew}
            <div class="caseInfoArea">
                <div class="caseName">${element.label}</div>
                <div class="caseCreditArea">
                    <div class="inCaseCreditAmount">${element.price}</div>
                    <div class="inCaseCreditType">${element.priceType}</div>
                </div>
            </div>
            <div class="openCaseButton ${itemClass}" data-caseInfo='${JSON.stringify(element)}'>${translate.openCase}</div>
        </div>
        `);
    });
}

function setStandardCases() {
    $(".standardCasesList").empty();
    $("#standardCaseCount").html(standardCases.length);
    standardCases.forEach((element) => {
        var isNew = "";
        if (element.isNew) isNew = `<div class="premiumCasesNewIcon">${translate.new}</div>`;
        $(".standardCasesList").append(`
            <div class="caseItem">
                <div class="premiumCaseImgArea">
                    <img src="./images/src/nudeCase.png" alt="" />
                </div>
                    ${isNew}
                <div class="caseInfoArea">
                    <div class="caseName">${element.label}</div>
                    <div class="caseCreditArea">
                        <div class="inCaseCreditAmount">${element.price}</div>
                        <div class="inCaseCreditType">${element.priceType}</div>
                    </div>
                </div>
                <div class="openCaseButton nude" data-caseInfo='${JSON.stringify(element)}'>${translate.openCase}</div>
            </div>
        `);
    });
}

function setItemsIntoRollArea(itemsData, selectedItem) {
    $(".caseItemRollArea")
        .css(
            {
                transition: "sdf",
                "margin-left": "0px",
            },
            10
        )
        .html("");
    $(".caseItemRollArea").empty();
    var array = [];
    for (var i = 0; i < itemsData.length; i++) {
        var item = itemsData[i];
        var chance = Math.round(item.chance / 1);
        for (var j = 0; j < chance; j++) {
            array.push(item);
            if (j > 200) return;
        }
    }
    if (array.length < 200) {
        for (var i = 0; i < itemsData.length; i++) {
            var item = itemsData[i];
            var chance = Math.round(item.chance / 1);
            for (var j = 0; j < chance; j++) {
                array.push(item);
            }
        }
    }
    var tempArray = shuffle(array);
    tempArray.forEach((element, index) => {
        itemBg = "blueItemBg.png";
        if (element.itemType === "uncommon") itemBg = "greenItemBg.png";
        if (element.itemType === "rare") itemBg = "purpleItemBg.png";
        if (element.itemType === "mythical") itemBg = "redItemBg.png";
        if (element.itemType === "legendary") itemBg = "yellowItemBg.png";
        var selected = "";
        var html = ``;
        if (index === 128) selected = "selected";
        html = `
            <div class="caseRollItem" id="caseItem-${index}">
                <img class="itemBg${selected}" src="./images/src/${itemBg}" alt="" />
                <div class="rollItemImageArea">
                    <img class="itemImage${index}" src=${element.image} alt="" />
                </div>
                <div class="rollItemItemName" id="rollItemName-${index}">${element.label}</div>
            </div>
        `;
        $(".caseItemRollArea").append(html);
        if (index > 200) {
            return true;
        }
    });
}

function caseOpen(selectedItem) {
    $(".caseItemRollArea").css({
        transition: "all 6s cubic-bezier(.08,.6,0,1)",
    });
    itemBg = "blueItemBg.png";
    if (selectedItem.itemType === "uncommon") itemBg = "greenItemBg.png";
    if (selectedItem.itemType === "rare") itemBg = "purpleItemBg.png";
    if (selectedItem.itemType === "mythical") itemBg = "redItemBg.png";
    if (selectedItem.itemType === "legendary") itemBg = "yellowItemBg.png";

    setTimeout(() => {
        $(".itemImage128").attr("src", selectedItem.image);
        $(".itemBgselected").attr("src", `./images/src/${itemBg}`);
        $("#rollItemName-128").html(selectedItem.label);
    }, 500);
    setTimeout(() => {
        $(".congItemBGPic").attr("src", `./images/src/${itemBg}`);
        $(".congItemPic").attr("src", selectedItem.image);
        $(".congratItemName").html(selectedItem.label);
        $(".congSellCredit").html(selectedItem.sellCredit);
        $(".congratulationsSection").fadeIn(400);
    }, 6500);
    setTimeout(function () {
        $(".caseOpeningDurationArea").fadeOut(700);
        setTimeout(() => {
            $(".caseOpeningBefore").css("display", "flex");
        }, 700);
    }, 7500);
    $(".caseItemRollArea").css("margin-left", "-18780px");
}

function fastOpen(selectedItem) {
    $(".caseItemRollArea").css({
        transition: "all 0.5s cubic-bezier(.08,.6,0,1)",
    });
    itemBg = "blueItemBg.png";
    if (selectedItem.itemType === "uncommon") itemBg = "greenItemBg.png";
    if (selectedItem.itemType === "rare") itemBg = "purpleItemBg.png";
    if (selectedItem.itemType === "mythical") itemBg = "redItemBg.png";
    if (selectedItem.itemType === "legendary") itemBg = "yellowItemBg.png";
    setTimeout(() => {
        $(".itemImage128").attr("src", selectedItem.image);
        $(".itemBgselected").attr("src", `./images/src/${itemBg}`);
        $("#rollItemName-128").html(selectedItem.label);
    }, 100);
    // setTimeout(() => {
    fastOpenSound.play();
    // }, 400);
    setTimeout(() => {
        $(".congItemBGPic").attr("src", `./images/src/${itemBg}`);
        $(".congItemPic").attr("src", selectedItem.image);
        $(".congratItemName").html(selectedItem.label);
        $(".congSellCredit").html(selectedItem.sellCredit);
        $(".congratulationsSection").fadeIn(400);
    }, 600);
    setTimeout(function () {
        $(".caseOpeningDurationArea").fadeOut(700);
        setTimeout(() => {
            $(".caseOpeningBefore").css("display", "flex");
        }, 700);
    }, 1500);
    $(".caseItemRollArea").css("margin-left", "-18780px");
}

$(document).on("click", ".openinOpenCaseButton", function () {
    var selectedDiv = this;
    var foundedUnique = $(selectedDiv).attr("data-unique");
    var caseType = $(selectedDiv).attr("data-premium");
    var arrayForFind = standardCases;
    if (caseType && caseType == "premium") arrayForFind = premiumCases;
    var selectedJson = arrayForFind.find(function (element) {
        return element.uniqueId == foundedUnique;
    });
    $.post(
        "https://MysteryCase/caseOpenSelect",
        JSON.stringify({
            selectedCase: selectedJson,
        }),
        function (data) {
            if (data) {
                escUsable = false;
                if (selectedJson.priceType == "GC") {
                    var myCoin = parseInt($(".goldCoinAmount").html());
                    $(".goldCoinAmount").html(myCoin - selectedJson.price);
                } else {
                    var myCoin = parseInt($(".silverCoinAmount").html());
                    $(".silverCoinAmount").html(myCoin - selectedJson.price);
                }
                var selectedCaseItemsParse = JSON.parse(JSON.stringify(selectedJson));
                setItemsIntoRollArea(selectedCaseItemsParse.items, data);
                $(".caseOpeningBefore").fadeOut(350);
                $("#collectButton").attr("data-wonItem", JSON.stringify(data));
                $("#sellButton").attr("data-wonItem", JSON.stringify(data));
                $("#sellButton").attr("data-sellCoin", JSON.stringify(selectedJson));
                $(".csText").html(selectedJson.priceType);
                caseOpeningSound.play();
                setTimeout(() => {
                    $(".caseOpeningDurationArea").show();
                    setTimeout(() => {
                        caseOpen(data);
                    }, 500);
                }, 400);
            } else {
                $(".upgradeTopArea").html(translate.failed);
                $(".upgradeNotifMiddle").html(translate.youDntHaveEnoughCredit);
                $(".yourAccountUpgradedGeneral").fadeIn(500);
                setTimeout(() => {
                    $(".yourAccountUpgradedGeneral").fadeOut(500);
                    setTimeout(() => {
                        $(".yourAccountUpgradedGeneral").hide();
                    }, 500);
                }, 2000);
            }
        }
    );
});

$(document).on("click", ".openinOpenFastButton", function () {
    var selectedDiv = this;
    var foundedUnique = $(selectedDiv).attr("data-unique");
    var caseType = $(selectedDiv).attr("data-premium");
    var arrayForFind = standardCases;
    if (caseType == "premium") arrayForFind = premiumCases;
    var selectedJson = arrayForFind.find(function (element) {
        return element.uniqueId == foundedUnique;
    });

    $.post(
        "https://MysteryCase/caseOpenSelect",
        JSON.stringify({
            selectedCase: selectedJson,
        }),
        function (data) {
            if (data) {
                escUsable = false;
                if (selectedJson.priceType == "GC") {
                    var myCoin = parseInt($(".goldCoinAmount").html());
                    $(".goldCoinAmount").html(myCoin - selectedJson.price);
                } else {
                    var myCoin = parseInt($(".silverCoinAmount").html());
                    $(".silverCoinAmount").html(myCoin - selectedJson.price);
                }
                var selectedCaseItemsParse = JSON.parse(JSON.stringify(selectedJson));
                setItemsIntoRollArea(selectedCaseItemsParse.items, data);
                $(".caseOpeningBefore").fadeOut(350);
                $("#collectButton").attr("data-wonItem", JSON.stringify(data));
                $("#sellButton").attr("data-wonItem", JSON.stringify(data));
                $("#sellButton").attr("data-sellCoin", JSON.stringify(selectedJson));
                $(".csText").html(selectedJson.priceType);
                setTimeout(() => {
                    $(".caseOpeningDurationArea").show();
                    setTimeout(() => {
                        fastOpen(data);
                    }, 500);
                }, 400);
            } else {
                $(".upgradeTopArea").html(translate.failed);
                $(".upgradeNotifMiddle").html(translate.youDntHaveEnoughCredit);
                $(".yourAccountUpgradedGeneral").fadeIn(500);
                setTimeout(() => {
                    $(".yourAccountUpgradedGeneral").fadeOut(500);
                    setTimeout(() => {
                        $(".yourAccountUpgradedGeneral").hide();
                    }, 500);
                }, 2000);
            }
        }
    );
});

$(document).on("click", "#collectButton", function () {
    var selectedDiv = this;
    var foundedUnique = $(selectedDiv).attr("data-wonItem");
    var parseFounded = JSON.parse(foundedUnique);
    collectedSound.play();
    $.post(
        "https://MysteryCase/collectItem",
        JSON.stringify({
            collectedItem: parseFounded,
        }),
        function (data) {
            escUsable = true;
            $(".congratulationsSection").fadeOut(400);
        }
    );
});

var sellButtonClickable = true;
$(document).on("click", "#sellButton", function () {
    if (!sellButtonClickable) return;
    sellButtonClickable = false;
    var selectedDiv = this;
    var wonItem = $(selectedDiv).attr("data-wonItem");
    var generalCaseData = $(selectedDiv).attr("data-sellCoin");
    var generalCaseParse = JSON.parse(generalCaseData);
    var wonItemParse = JSON.parse(wonItem);
    $.post(
        "https://MysteryCase/sellItem",
        JSON.stringify({
            sellItem: wonItemParse,
        }),
        function (data) {
            sellItemSound.play();
            escUsable = true;
            if (generalCaseParse.priceType == "GC") {
                var myCoin = parseInt($(".goldCoinAmount").html());
                $(".goldCoinAmount").html(myCoin + wonItemParse.sellCredit);
            } else {
                var myCoin = parseInt($(".silverCoinAmount").html());
                $(".silverCoinAmount").html(myCoin + wonItemParse.sellCredit);
            }
            $(".congratulationsSection").fadeOut(400);
            setTimeout(() => {
                sellButtonClickable = true;
            }, 500);
        }
    );
});

$(document).on("mouseover", ".openCaseButton", function (e) {
    var $this = this;
    var parentNode = $this.parentNode;
    var backgroundArea = parentNode.querySelector(".premiumCaseBackgroundArea");
    var caseImg = parentNode.querySelector(".premiumCaseImgArea");
    var newIcon = parentNode.querySelector(".premiumCasesNewIcon");
    var infoArea = parentNode.querySelector(".caseInfoArea");
    var openButton = parentNode.querySelector(".openCaseButton");
    $(backgroundArea).css("margin-top", -2 + "%");
    $(caseImg).css("margin-top", -2 + "%");
    $(newIcon).css("margin-top", -6 + "%");
    $(infoArea).css("margin-top", -2 + "%");
    $(openButton).css("margin-top", -2 + "%");
});

$(document).on("mouseover", ".lastItem", function (e) {
    var $this = this;
    var parentNode = $this.parentNode;
    var backgroundArea = $this.querySelector(".lastItemInfoArea");
    $(backgroundArea).show();
});

$(document).on("mouseout", ".lastItem", function (e) {
    var $this = this;
    var parentNode = $this.parentNode;
    var backgroundArea = $this.querySelector(".lastItemInfoArea");
    $(backgroundArea).hide();
});

$(document).on("mouseout", ".openCaseButton", function (e) {
    var $this = this;
    var parentNode = $this.parentNode;
    var backgroundArea = parentNode.querySelector(".premiumCaseBackgroundArea");
    var caseImg = parentNode.querySelector(".premiumCaseImgArea");
    var newIcon = parentNode.querySelector(".premiumCasesNewIcon");
    var infoArea = parentNode.querySelector(".caseInfoArea");
    var openButton = parentNode.querySelector(".openCaseButton");
    $(backgroundArea).css("margin-top", 0 + "%");
    $(caseImg).css("margin-top", 0 + "%");
    $(newIcon).css("margin-top", -4 + "%");
    $(infoArea).css("margin-top", 0 + "%");
    $(openButton).css("margin-top", 0 + "%");
    $(this).css("opacity", 1);
});

function shuffle(array) {
    let currentIndex = array.length,
        randomIndex;
    while (currentIndex != 0) {
        randomIndex = Math.floor(Math.random() * currentIndex);
        currentIndex--;
        [array[currentIndex], array[randomIndex]] = [array[randomIndex], array[currentIndex]];
    }
    return array;
}

$(document).on("click", ".premiumCasesButtonArea", function () {
    $(".caseOpeningSection").hide();
    $(".coinMarketSection").hide();
    $(".generalSection").show();
    var scrollDiv = document.getElementById("premiumCasesScroll").offsetTop;
    $(".generalSection").animate({ scrollTop: scrollDiv - 140 }, 400);
});

$(document).on("click", ".standartCasesButtonArea", function () {
    $(".caseOpeningSection").hide();
    $(".coinMarketSection").hide();
    $(".generalSection").show();
    var scrollDiv = document.getElementById("standardCases").offsetTop;
    $(".generalSection").animate({ scrollTop: scrollDiv - 140 }, 400);
});

$(document).on("click", ".caseOpeningGoBackButton", function () {
    $(".caseOpeningSection").fadeOut(100);
    $(".coinMarketSection").fadeOut(100);
    setTimeout(() => {
        $(".generalSection").fadeIn(200);
    }, 100);
});

$(document).on("click", ".openCaseButton", function () {
    $(".generalSection").fadeOut(100);
    $(".coinMarketSection").fadeOut(100);
    setTimeout(() => {
        $(".caseOpeningSection").fadeIn(200);
    }, 100);
});

$(document).on("click", ".coinAddButton", function () {
    $(".generalSection").fadeOut(100);
    $(".caseOpeningSection").fadeOut(100);
    setTimeout(() => {
        $(".coinMarketSection").fadeIn(200);
    }, 100);
});

$(document).on("click", ".logoArea", function () {
    $(".coinMarketSection").fadeOut(100);
    $(".caseOpeningSection").fadeOut(100);
    setTimeout(() => {
        $(".generalSection").fadeIn(200);
    }, 100);
});

$(document).on("click", ".redeemAcceptButton", function () {
    var codeInputValue = $(".customInput").val();
    if (codeInputValue != "REDEEM CODE.." && codeInputValue.length > 0) {
        $.post(
            "https://MysteryCase/sendInput",
            JSON.stringify({
                input: codeInputValue,
            }),
            function (data) {
                if (data) {
                    $(".upgradeTopArea").html(translate.congratulations);
                    $(".upgradeNotifMiddle").html(translate.creditLoaded);
                    $(".yourAccountUpgradedGeneral").fadeIn(500);
                    setTimeout(() => {
                        $(".yourAccountUpgradedGeneral").fadeOut(500);
                        setTimeout(() => {
                            $(".yourAccountUpgradedGeneral").hide();
                        }, 500);
                    }, 2000);
                    var myCoin = parseInt($(".goldCoinAmount").html());
                    $(".goldCoinAmount").html(myCoin + parseInt(data));
                }
            }
        );
    }
});

$(document).on("keydown", function () {
    switch (event.keyCode) {
        case 27: // ESC
            if (escUsable) {
                $.post("https://MysteryCase/closeMenu", JSON.stringify());
                $(".fullBackGround").hide();
                $(".generalSection").hide();
                $(".caseOpeningSection").hide();
                $(".topBar").hide();
                $(".congratulationsSection").hide();
                $(".coinMarketSection").hide();
                break;
            }
    }
});

window.addEventListener("message", (event) => {
    if (event.data.type === "openUi") {
        if (firstOpen) {
            firstOpen = false;
            var xhr = new XMLHttpRequest();
            xhr.responseType = "text";
            xhr.open("GET", event.data.steamid, true);
            xhr.send();
            xhr.onreadystatechange = processRequest;
            function processRequest(e) {
                if (xhr.readyState == 4 && xhr.status == 200) {
                    var string = xhr.responseText.toString();
                    var array = string.split("avatarfull");
                    var array2 = array[1].toString().split('"');
                    profilePhoto = array2[2].toString();
                    $(".profilePhotoAK4Y").attr("src", profilePhoto);
                }
            }
        } else {
            $(".profilePhotoAK4Y").attr("src", profilePhoto);
        }
        translate = event.data.translate;

        $("#gcCoinShopText").html(translate.coinShopTitle);
        $(".goBackText").html(translate.goBack);
        $(".redeemAcceptButton").html(translate.accept);
        $(".congratText").html(translate.congratulations);
        $(".upgradeTopArea").html(translate.congratulations);
        $(".upgradeNotifMiddle").html(translate.creditLoaded);
        $(".congratDesc").html(translate.congDescription);
        $("#collectButton").html(translate.collect);
        $(".sellText").html(translate.sell);
        $(".premiumText").html(translate.premium);
        $(".standardText").html(translate.standard);
        $(".logoCaseText").html(translate.title1);
        $(".logoCaseShadow").html(translate.title1);
        $(".logoOpeningText").html(translate.title2);
        $("#webSiteText").html(translate.website);
        $("#discordText").html(translate.discord);
        $("#premiumCasesText").html(translate.premiumCases);
        $(".inBoxCasesText").html(translate.cases);
        $("#standardCasesText").html(translate.standardCases);
        $(".openingCaseNames").html(translate.caseItems);
        $(".openinOpenFastButton").html(translate.openFast);
        $(".openinOpenCaseButton").html(translate.openCase);
        $("#inBoxItemsText").html(translate.items);
        $(".goldCoinAmount").html(event.data.myGoldCoin);
        $(".silverCoinAmount").html(event.data.mySilverCoin);
        $(".firstName").html(event.data.myFirstName);
        $(".lastName").html(event.data.myLastName);
        premiumCases = event.data.premiumCases;
        standardCases = event.data.standardCases;
        lastItems = event.data.lastItems;
        sellCoins = event.data.sellCoins;
        webSiteLink = event.data.webSiteLink;
        discordLink = event.data.discordLink;
        setTimeout(() => {
            setPremiumCases();
            setStandardCases();
            setSellCoins();
            setLastItems();
        }, 100);
        $(".fullBackGround").show();
        $(".generalSection").show();
        $(".topBar").css("display", "flex");
    } else if (event.data.type === "setLastItems") {
        lastItems = event.data.lastItems;
        setTimeout(() => {
            setLastItems();
        }, 100);
    } else if (event.data.type === "serverNotif") {
        $(".wonItemNotifyXX").attr("src", event.data.notifInfo.itemImage);
        $(".wonNotifyCharName").html(event.data.notifInfo.firstName + " " + event.data.notifInfo.lastName);
        $(".WonItemName").html(event.data.notifInfo.itemLabel);
        $(".wonServerNotif").css("top" - 10 + "%");
        $(".wonServerNotif").animate({ top: 0 }, 200);
        $(".wonServerNotif").css("display", "flex");
        $(".wonServerNotif").animate({ opacity: 1 }, 200);
        setTimeout(() => {
            $(".wonServerNotif").animate({ opacity: 0 }, 200);
        }, 3000);
    } else if (event.data.type === "refreshcoins") {
        $(".goldCoinAmount").html(event.data.myGoldCoin);
    }
});

function setLastItems() {
    $(".serverLastItemsArea").empty();
    lastItems.forEach((element) => {
        itemBg = "blueLastBg.png";
        itemClass = " blue";
        if (element.itemType && element.itemType === "uncommon") itemBg = "greenLastBg.png";
        if (element.itemType && element.itemType === "rare") itemBg = "purpleLastBg.png";
        if (element.itemType && element.itemType === "mythical") itemBg = "redLastBg.png";
        if (element.itemType && element.itemType === "legendary") itemBg = "yellowLastBg.png";

        if (element.itemType && element.itemType === "uncommon") itemClass = " green";
        if (element.itemType && element.itemType === "rare") itemClass = " purple";
        if (element.itemType && element.itemType === "mythical") itemClass = " red";
        if (element.itemType && element.itemType === "legendary") itemClass = " yellow";
        $(".serverLastItemsArea").append(`
            <div class="lastItem">
                <div class="lastItemBackgroundArea">
                    <img src="./images/src/${itemBg}" alt="" />
                </div>
                <div class="lastItemImageArea">
                    <img src=${element.itemImage} alt="" />
                </div>
                <div class="lastItemInfoArea${itemClass}">
                    <div class="lastItemCaseName">${element.caseName}</div>
                    <div class="lastItemFirstName">${element.firstname}</div>
                    <div class="lastItemLastName">${element.lastname}</div>
                </div>
            </div>
        `);
    });
}

function setSellCoins() {
    $(".marketCoinListArea").empty();
    sellCoins.forEach((element) => {
        $(".marketCoinListArea").append(`
            <div class="coinItem">
                <img src="./images/src/coinBg.png" alt="" />
                <div class="coinBuyCoinImage">
                    <img src="./images/src/coinListCoinImg.png" alt="" />
                </div>
                <div class="coinTextArea">
                    <div class="buyCoinCount">${element.coinCount}</div>
                    <div class="buyCoinText">GC</div>
                </div>
                <div class="coinBuyButton" data-directLink='${element.directLink}'>$${element.realPrice}</div>
            </div>
        `);
    });
}

$(document).on("click", ".coinBuyButton", function () {
    var selectedDiv = this;
    var directLink = $(selectedDiv).attr("data-directLink");
    window.invokeNative("openUrl", directLink);
});

$(document).on("click", "#webSiteButton", function () {
    window.invokeNative("openUrl", webSiteLink);
});

$(document).on("click", "#discordButton", function () {
    window.invokeNative("openUrl", discordLink);
});
