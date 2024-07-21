/*!
 * Copyright (c) 2021 Karl Saunders (Mobius1)
 * Licensed under GPLv3
 * 
 * Version: 1.1.9
 *
 *  ! Edit it if you want, but don't re-release this without my permission, and never claim it to be yours !
*/

/*!
 * Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"),
 * to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

 * The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
    
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 * WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

const BulletinContainers = {};
const audio = document.createElement("audio");
let MaxQueue = 5
let styled = false;
let pinned = {};
 

const Text_color = {
    "w": "white",
    "s": "white",
    "u": "black",
    "r": "red",
    "o": "orange",
    "y": "yellow",
    "g": "green",
    "c": "cyan",
    "b": "blue",
    "m": "darkgray",
    "c" : "rgba(255, 255, 255, 255)",
    "HUD_COLOUR_PM_WEAPONS_PURCHASABLE" : "rgba(45, 110, 185, 255)",
    "HUD_COLOUR_PURE_WHITE" : "rgba(255, 255, 255, 255)",
    "HUD_COLOUR_WHITE" : "rgba(255, 255, 255, 255)",
    "HUD_COLOUR_BLACK" : "rgba(0, 0, 0, 255)",
    "HUD_COLOUR_GREY" : "rgba(127, 127, 127, 255)",
    "HUD_COLOUR_GREYLIGHT" : "rgba(190, 190, 190, 255)",
    "HUD_COLOUR_GREYDARK" : "rgba(64, 64, 64, 255)",
    "HUD_COLOUR_RED" : "rgba(255, 0, 0, 255)",
    "HUD_COLOUR_REDLIGHT" : "rgba(255, 102, 102, 255)",
    "HUD_COLOUR_REDDARK" : "rgba(153, 0, 0, 255)",
    "HUD_COLOUR_BLUE" : "rgba(255, 0, 0, 255)",
    "HUD_COLOUR_BLUELIGHT" : "rgba(102, 102, 255, 255)",
    "HUD_COLOUR_BLUEDARK" : "rgba(0, 0, 153, 255)",
    "HUD_COLOUR_YELLOW" : "rgba(255, 255, 0, 255)",
    "HUD_COLOUR_YELLOWLIGHT" : "rgba(255, 255, 102, 255)",
    "HUD_COLOUR_YELLOWDARK" : "rgba(153, 153, 0, 255)",
    "HUD_COLOUR_ORANGE" : "rgba(255, 128, 0, 255)",
    "HUD_COLOUR_ORANGELIGHT" : "rgba(255, 178, 102, 255)",
    "HUD_COLOUR_ORANGEDARK" : "rgba(153, 76, 0, 255)",
    "HUD_COLOUR_GREEN" : "rgba(255, 0, 0, 255)",
    "HUD_COLOUR_GREENLIGHT" : "rgba(102, 255, 102, 255)",
    "HUD_COLOUR_GREENDARK" : "rgba(0, 153, 0, 255)",
    "HUD_COLOUR_PURPLE" : "rgba(153, 0, 153, 255)",
    "HUD_COLOUR_PURPLELIGHT" : "rgba(204, 102, 255, 255)",
    "HUD_COLOUR_PURPLEDARK" : "rgba(102, 0, 102, 255)",
    "HUD_COLOUR_PINK" : "rgba(255, 0, 255, 255)",
    "HUD_COLOUR_RADAR_HEALTH" : "rgba(114, 204, 114, 255)",
    "HUD_COLOUR_RADAR_ARMOUR" : "rgba(159, 159, 255, 255)",
    "HUD_COLOUR_RADAR_DAMAGE" : "rgba(214, 93, 14, 255)",
    "HUD_COLOUR_NET_PLAYER1" : "rgba(159, 212, 104, 255)",
    "HUD_COLOUR_NET_PLAYER2" : "rgba(159, 159, 255, 255)",
    "HUD_COLOUR_NET_PLAYER3" : "rgba(255, 212, 104, 255)",
    "HUD_COLOUR_NET_PLAYER4" : "rgba(255, 159, 104, 255)",
    "HUD_COLOUR_NET_PLAYER5" : "rgba(255, 104, 159, 255)",
    "HUD_COLOUR_NET_PLAYER6" : "rgba(212, 104, 159, 255)",
    "HUD_COLOUR_NET_PLAYER7" : "rgba(159, 104, 212, 255)",
    "HUD_COLOUR_NET_PLAYER8" : "rgba(104, 159, 212, 255)",
    "HUD_COLOUR_NET_PLAYER9" : "rgba(104, 212, 159, 255)",
    "HUD_COLOUR_NET_PLAYER10" : "rgba(212, 159, 104, 255)",
    "HUD_COLOUR_NET_PLAYER11" : "rgba(212, 104, 104, 255)",
    "HUD_COLOUR_NET_PLAYER12" : "rgba(104, 212, 104, 255)",
    "HUD_COLOUR_NET_PLAYER13" : "rgba(104, 104, 212, 255)",
    "HUD_COLOUR_NET_PLAYER14" : "rgba(159, 212, 159, 255)",
    "HUD_COLOUR_NET_PLAYER15" : "rgba(159, 159, 212, 255)",
    "HUD_COLOUR_NET_PLAYER16" : "rgba(212, 159, 159, 255)",
    "HUD_COLOUR_NET_PLAYER17" : "rgba(212, 212, 104, 255)",
    "HUD_COLOUR_NET_PLAYER18" : "rgba(212, 104, 212, 255)",
    "HUD_COLOUR_NET_PLAYER19" : "rgba(104, 212, 212, 255)",
    "HUD_COLOUR_NET_PLAYER20" : "rgba(159, 104, 104, 255)",
    "HUD_COLOUR_NET_PLAYER21" : "rgba(104, 159, 104, 255)",
    "HUD_COLOUR_NET_PLAYER22" : "rgba(104, 104, 159, 255)",
    "HUD_COLOUR_NET_PLAYER23" : "rgba(206, 169, 13, 255)",
    "HUD_COLOUR_NET_PLAYER24" :	"rgba(71, 99, 173, 255)",
    "HUD_COLOUR_NET_PLAYER25" :	"rgba(42, 166, 185, 255)",
    "HUD_COLOUR_NET_PLAYER26" :	"rgba(186, 157, 125, 255)",
    "HUD_COLOUR_NET_PLAYER27" :	"rgba(201, 225, 255, 255)",
    "HUD_COLOUR_NET_PLAYER28" :	"rgba(240, 240, 150, 255)",
    "HUD_COLOUR_NET_PLAYER29" :	"rgba(237, 140, 161, 255)",
    "HUD_COLOUR_NET_PLAYER30" :	"rgba(249, 138, 138, 255)",
    "HUD_COLOUR_NET_PLAYER31" :	"rgba(252, 239, 166, 255)",
    "HUD_COLOUR_NET_PLAYER32" :	"rgba(240, 240, 240, 255)",
    "HUD_COLOUR_SIMPLEBLIP_DEFAULT" : "rgba(159, 201, 166, 255)",
    "HUD_COLOUR_MENU_BLUE" : "rgba(140, 140, 140, 255)",
    "HUD_COLOUR_MENU_BLUE_EXTRA_DARK" : "rgba(40, 40, 40, 255)",
    "HUD_COLOUR_MENU_YELLOW" : "rgba(240, 160, 0, 255)",
    "HUD_COLOUR_MENU_GREY" : "rgba(140, 140, 140, 255)",
    "HUD_COLOUR_MENU_GREY_DARK" : "rgba(60, 60, 60, 255)",
    "HUD_COLOUR_MENU_HIGHLIGHT" : "rgba(30, 30, 30, 255)",
    "HUD_COLOUR_MENU_STANDARD" : "rgba(140, 140, 140, 255)",
    "HUD_COLOUR_MENU_DIMMED" : "rgba(75, 75, 75, 255)",
    "HUD_COLOUR_MENU_EXTRA_DIMMED" : "rgba(50, 50, 50, 255)",
    "HUD_COLOUR_BRIEF_TITLE" : "rgba(95, 95, 95, 255)",
    "HUD_COLOUR_MID_GREY_MP" : "rgba(100, 100, 100, 255)",
    "HUD_COLOUR_NET_PLAYER1_DARK" : "rgba(93, 39, 39, 255)",
    "HUD_COLOUR_NET_PLAYER2_DARK" : "rgba(77, 55, 89, 255)",
    "HUD_COLOUR_NET_PLAYER3_DARK" : "rgba(124, 62, 99, 255)",
    "HUD_COLOUR_NET_PLAYER4_DARK" : "rgba(120, 80, 80, 255)",
    "HUD_COLOUR_NET_PLAYER5_DARK" : "rgba(87, 72, 66, 255)",
    "HUD_COLOUR_NET_PLAYER6_DARK" : "rgba(74, 103, 83, 255)",
    "HUD_COLOUR_NET_PLAYER7_DARK" : "rgba(60, 85, 88, 255)",
    "HUD_COLOUR_NET_PLAYER8_DARK" : "rgba(105, 105, 64, 255)",
    "HUD_COLOUR_NET_PLAYER9_DARK" : "rgba(72, 63, 76, 255)",
    "HUD_COLOUR_NET_PLAYER10_DARK" : "rgba(53, 98, 95, 255)",
    "HUD_COLOUR_NET_PLAYER11_DARK" : "rgba(107, 98, 76, 255)",
    "HUD_COLOUR_NET_PLAYER12_DARK" : "rgba(117, 71, 40, 255)",
    "HUD_COLOUR_NET_PLAYER13_DARK" : "rgba(76, 101, 117, 255)",
    "HUD_COLOUR_NET_PLAYER14_DARK" : "rgba(65, 35, 47, 255)",
    "HUD_COLOUR_NET_PLAYER15_DARK" : "rgba(72, 71, 61, 255)",
    "HUD_COLOUR_NET_PLAYER16_DARK" : "rgba(85, 58, 47, 255)",
    "HUD_COLOUR_NET_PLAYER17_DARK" : "rgba(87, 84, 84, 255)",
    "HUD_COLOUR_NET_PLAYER18_DARK" : "rgba(116, 71, 77, 255)",
    "HUD_COLOUR_NET_PLAYER19_DARK" : "rgba(93, 107, 45, 255)",
    "HUD_COLOUR_NET_PLAYER20_DARK" : "rgba(6, 61, 43, 255)",
    "HUD_COLOUR_NET_PLAYER21_DARK" : "rgba(61, 98, 127, 255)",
    "HUD_COLOUR_NET_PLAYER22_DARK" : "rgba(85, 30, 115, 255)",
    "HUD_COLOUR_NET_PLAYER23_DARK" : "rgba(103, 84, 6, 255)",
    "HUD_COLOUR_NET_PLAYER24_DARK" : "rgba(35, 49, 86, 255)",
    "HUD_COLOUR_NET_PLAYER25_DARK" : "rgba(21, 83, 92, 255)",
    "HUD_COLOUR_NET_PLAYER26_DARK" : "rgba(93, 98, 62, 255)",
    "HUD_COLOUR_NET_PLAYER27_DARK" : "rgba(100, 112, 127, 255)",
    "HUD_COLOUR_NET_PLAYER28_DARK" : "rgba(120, 120, 75, 255)",
    "HUD_COLOUR_NET_PLAYER29_DARK" : "rgba(152, 76, 93, 255)",
    "HUD_COLOUR_NET_PLAYER30_DARK" : "rgba(124, 69, 69, 255)",
    "HUD_COLOUR_NET_PLAYER31_DARK" : "rgba(10, 43, 50, 255)",
    "HUD_COLOUR_NET_PLAYER32_DARK" : "rgba(95, 95, 10, 255)",
    "HUD_COLOUR_BRONZE" : "rgba(180, 130, 97, 255)",
    "HUD_COLOUR_SILVER" : "rgba(150, 153, 161, 255)",
    "HUD_COLOUR_GOLD" : "rgba(214, 181, 99, 255)",
    "HUD_COLOUR_PLATINUM" : "rgba(166, 221, 190, 255)",
    "HUD_COLOUR_GANG1" : "rgba(29, 100, 153, 255)",
    "HUD_COLOUR_GANG2" : "rgba(214, 116, 15, 255)",
    "HUD_COLOUR_GANG3" : "rgba(135, 125, 142, 255)",
    "HUD_COLOUR_GANG4" : "rgba(229, 119, 185, 255)",
    "HUD_COLOUR_SAME_CREW" : "rgba(252, 239, 166, 255)",
    "HUD_COLOUR_FREEMODE" : "rgba(45, 110, 185, 255)",
    "HUD_COLOUR_PAUSE_BG" : "rgba(0, 0, 0, 186)",
    "HUD_COLOUR_FRIENDLY" : "rgba(93, 182, 229, 255)",
    "HUD_COLOUR_ENEMY" : "rgba(194, 80, 80, 255)",
    "HUD_COLOUR_FREEMODE_DARK" : "rgba(22, 55, 92, 255)",
    "HUD_COLOUR_INACTIVE_MISSION" : "rgba(154, 154, 154, 255)",
    "HUD_COLOUR_DAMAGE" : "rgba(255,255,255, 255)",
    "HUD_COLOUR_PINKLIGHT" : "rgba(252, 115, 201, 255)",
    "HUD_COLOUR_PM_MITEM_HIGHLIGHT" : "rgba(252, 177, 49, 255)",
    "HUD_COLOUR_SCRIPT_VARIABLE" : "rgba(0, 0, 0, 255)",
    "HUD_COLOUR_YOGA" : "rgba(109, 247, 204, 255)",
    "HUD_COLOUR_TENNIS" : "rgba(241, 101, 34, 255)",
    "HUD_COLOUR_GOLF" : "rgba(214, 189, 97, 255)",
    "HUD_COLOUR_SOCIAL_CLUB" : "rgba(234, 153, 28, 255)",
    "HUD_COLOUR_PLATFORM_BLUE" : "rgba(11, 55, 123, 255)",
    "HUD_COLOUR_PLATFORM_GREEN" : "rgba(146, 200, 62, 255)",
    "HUD_COLOUR_PLATFORM_GREY" : "rgba(234, 153, 28, 255)",
    "HUD_COLOUR_FACEBOOK_BLUE" : "rgba(66, 89, 148, 255)",
    "HUD_COLOUR_INGAME_BG" : "rgba(0, 0, 0, 186)",
    "HUD_COLOUR_WAYPOINT" : "rgba(164, 76, 242, 255)",
    "HUD_COLOUR_MICHAEL" : "rgba(101, 180, 212, 255)",
    "HUD_COLOUR_FRANKLIN" : "rgba(171, 237, 171, 255)",
    "HUD_COLOUR_TREVOR" : "rgba(255, 163, 87, 255)",
    "HUD_COLOUR_GOLF_P2" : "rgba(235, 239, 30, 255)",
    "HUD_COLOUR_GOLF_P3" : "rgba(255, 149, 14, 255)",
    "HUD_COLOUR_GOLF_P4" : "rgba(246, 60, 161, 255)",
    "HUD_COLOUR_WAYPOINTLIGHT" : "rgba(210, 166, 249, 255)",
    "HUD_COLOUR_WAYPOINTDARK" : "rgba(82, 38, 121, 255)",
    "HUD_COLOUR_PANEL_LIGHT" : "rgba(0, 0, 0, 77)",
    "HUD_COLOUR_MICHAEL_DARK" : "rgba(72, 103, 116, 255)",
    "HUD_COLOUR_FRANKLIN_DARK" : "rgba(85, 118, 85, 255)",
    "HUD_COLOUR_TREVOR_DARK" : "rgba(127, 81, 43, 255)",
    "HUD_COLOUR_PAUSEMAP_TINT" : "rgba(0, 0, 0, 215)",
    "HUD_COLOUR_PAUSE_DESELECT" : "rgba(100, 100, 100, 127)",
    "HUD_COLOUR_PM_WEAPONS_LOCKED" : "rgba(240, 240, 240, 191)",
    "HUD_COLOUR_PAUSEMAP_TINT_HALF" : "rgba(0, 0, 0, 215)",
    "HUD_COLOUR_NORTH_BLUE_OFFICIAL" : "rgba(0, 71, 133, 255)",
    "HUD_COLOUR_SCRIPT_VARIABLE_2" : "rgba(0, 0, 0, 255)",
    "HUD_COLOUR_NET_PLAYER4" : "rgba(255,255,255, 255)",
    "HUD_COLOUR_NET_PLAYER4DARK" : "rgba(37, 102, 40, 255)",
    "HUD_COLOUR_T" : "rgba(234, 153, 28, 255)",
    "HUD_COLOUR_TDARK" : "rgba(225, 140, 8, 255)",
    "HUD_COLOUR_NET_PLAYER4SHARD" : "rgba(20, 40, 0, 255)",
    "HUD_COLOUR_CONTROLLER_MICHAEL" : "rgba(48, 255, 255, 255)",
    "HUD_COLOUR_CONTROLLER_FRANKLIN" : "rgba(48, 255, 0, 255)",
    "HUD_COLOUR_CONTROLLER_TREVOR" : "rgba(176, 80, 0, 255)",
    "HUD_COLOUR_CONTROLLER_CHOP" : "rgba(127, 0, 0, 255)",
    "HUD_COLOUR_VIDEO_EDITOR_VIDEO" : "rgba(53, 166, 224, 255)",
    "HUD_COLOUR_VIDEO_EDITOR_AUDIO" : "rgba(162, 79, 157, 255)",
    "HUD_COLOUR_VIDEO_EDITOR_TEXT" : "rgba(104, 192, 141, 255)",
    "HUD_COLOUR_NET_PLAYER4B_BLUE" : "rgba(29, 100, 153, 255)",
    "HUD_COLOUR_NET_PLAYER4B_YELLOW" : "rgba(234, 153, 28, 255)",
    "HUD_COLOUR_VIDEO_EDITOR_SCORE" : "rgba(240, 160, 1, 255)",
    "HUD_COLOUR_VIDEO_EDITOR_AUDIO_FADEOUT" : "rgba(59, 34, 57, 255)",
    "HUD_COLOUR_VIDEO_EDITOR_TEXT_FADEOUT" : "rgba(41, 68, 53, 255)",
    "HUD_COLOUR_VIDEO_EDITOR_SCORE_FADEOUT" : "rgba(82, 58, 10, 255)",
    "HUD_COLOUR_NET_PLAYER4EIST_BACKGROUND" : "rgba(37, 102, 40, 186)",
    "HUD_COLOUR_VIDEO_EDITOR_AMBIENT_FADEOUT" : "rgba(80, 70, 34, 255)",
    "HUD_COLOUR_G1" : "rgba(255,255,255, 255)",
    "HUD_COLOUR_G2" : "rgba(226, 134, 187, 255)",
    "HUD_COLOUR_G3" : "rgba(239, 238, 151, 255)",
    "HUD_COLOUR_G4" : "rgba(113, 169, 175, 255)",
    "HUD_COLOUR_G5" : "rgba(160, 140, 193, 255)",
    "HUD_COLOUR_G6" : "rgba(141, 206, 167, 255)",
    "HUD_COLOUR_G7" : "rgba(181, 214, 234, 255)",
    "HUD_COLOUR_G8" : "rgba(178, 144, 132, 255)",
    "HUD_COLOUR_G9" : "rgba(0, 132, 114, 255)",
    "HUD_COLOUR_G10" : "rgba(216, 85, 117, 255)",
    "HUD_COLOUR_G11" : "rgba(30, 100, 152, 255)",
    "HUD_COLOUR_G12" : "rgba(43, 181, 117, 255)",
    "HUD_COLOUR_G13" : "rgba(233, 141, 79, 255)",
    "HUD_COLOUR_G14" : "rgba(137, 210, 215, 255)",
    "HUD_COLOUR_G15" : "rgba(134, 125, 141, 255)",
    "HUD_COLOUR_ADVERSARY" : "rgba(109, 34, 33, 255)",
    "~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~" : "rgba(255, 0, 0, 255)",
    "HUD_COLOUR_DEGEN_YELLOW" : "rgba(255, 255, 0, 255)",
    "HUD_COLOUR_DEGEN_GREEN" : "rgba(255, 0, 0, 255)",
    "HUD_COLOUR_DEGEN_CYAN" : "rgba(0, 255, 255, 255)",
    "HUD_COLOUR_DEGEN_BLUE" : "rgba(255, 0, 0, 255)",
    "HUD_COLOUR_DEGEN_MAGENTA" : "rgba(255, 0, 255, 255)",
    "HUD_COLOUR_STUNT_1" : "rgba(38, 136, 234, 255)",
    "HUD_COLOUR_SPECIAL_RACE_SERIES" : "rgba(154, 178, 54, 255)",
    "HUD_COLOUR_SPECIAL_RACE_SERIES_DARK" : "rgba(93, 107, 45, 255)",
    "HUD_COLOUR_CS" : "rgba(206, 169, 13, 255)",
    "HUD_COLOUR_CS_DARK" : "rgba(103, 84, 6, 255)",
    "HUD_COLOUR_TECH_GREEN" : "rgba(0, 151, 151, 255)",
    "HUD_COLOUR_TECH_GREEN_DARK" : "rgba(5, 119, 113, 255)",
    "HUD_COLOUR_TECH_RED" : "rgba(151, 0, 0, 255)",
    "HUD_COLOUR_TECH_GREEN_VERY_DARK" : "rgba(0, 40, 40, 255)",
    "HUD_COLOUR_PLACEHOLDER_01" : "rgba(255, 255, 255, 255)",
    "HUD_COLOUR_PLACEHOLDER_02" : "rgba(255, 255, 255, 255)",
    "HUD_COLOUR_PLACEHOLDER_03" : "rgba(255, 255, 255, 255)",
    "HUD_COLOUR_PLACEHOLDER_04" : "rgba(255, 255, 255, 255)",
    "HUD_COLOUR_PLACEHOLDER_05" : "rgba(255, 255, 255, 255)",
    "HUD_COLOUR_PLACEHOLDER_06" : "rgba(255, 255, 255, 255)",
    "HUD_COLOUR_PLACEHOLDER_07" : "rgba(255, 255, 255, 255)",
    "HUD_COLOUR_PLACEHOLDER_08" : "rgba(255, 255, 255, 255)",
    "HUD_COLOUR_PLACEHOLDER_09" : "rgba(255, 255, 255, 255)",
    "HUD_COLOUR_PLACEHOLDER_10" : "rgba(255, 255, 255, 255)",
}

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
            if (isDefined(Text_color[INFO])){
                currentColor = Text_color[INFO];
                if (!everColoring) {
                    finalText += "<span style=\"color: " + currentColor + "\">";
                    everColoring = true;
                } else {
                    finalText += "</span><span style=\"color: " + currentColor + "\">";
                }
            } else if(isDefined(Fonts_modifiers[INFO])){
                currentColor = Fonts_modifiers[INFO];
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

/**
 *
 *
 * @class NotificationContainer
 */
class NotificationContainer {
    /**
     * Creates an instance of NotificationContainer.
     * @param {string} position
     * @memberof NotificationContainer
     */
    constructor(position) {
        this.container = document.getElementById("bulletin_container");
        this.el = document.createElement("div");
        this.el.classList.add("bulletin-notification-container", `notification-container-${position}`);
        this.notifications = [];
        this.offset = 0;
        this.running = false;
        this.spacing = 10;
        this.queue = 0;
        this.maxQueue = MaxQueue;
        this.canAdd = true;
    }

    /**
     *
     *
     * @param {object} notification
     * @memberof NotificationContainer
     */
    addNotification(notification) {

        if (!notification.pin_id) {
            this.queue++;
        }

        this.el.appendChild(notification.el);

        this.notifications.unshift(notification);

        if ( this.queue >= this.maxQueue ) {
            this.canAdd = false;
        }
    }

    /**
     *
     *
     * @param {object} notification
     * @memberof NotificationContainer
     */
    removeNotification(notification) {

        PostData("removed", {
            id: notification.id
        });

        this.el.removeChild(notification.el);

        const index = this.notifications.indexOf(notification);

        if (index > -1) {
            this.notifications.splice(index, 1);
        }

        this.queue--;

        if (this.queue == 0) {
            this.canAdd = true;
        }
    }

    /**
     *
     *
     * @memberof NotificationContainer
     */
    add() {
        if (!this.container.contains(this.el)) {
            this.container.appendChild(this.el);
        }
    }

    /**
     *
     *
     * @memberof NotificationContainer
     */
    remove() {
        this.container.removeChild(this.el);
    }

    /**
     *
     *
     * @return {boolean} 
     * @memberof NotificationContainer
     */
    empty() {
        return this.el.children.length < 1;
    }
}

/**
 *
 *
 * @class Notification
 */
class Notification {
    constructor(cfg, id, message, interval, position, progress = false, theme = "default", exitAnim = "fadeOut", flash = false, pin_id = false, title, subject, icon) {
        this.cfg = cfg
        this.id = id;
        this.message = message;
        this.interval = interval;
        this.position = position;
        this.title = title;
        this.subject = subject;
        this.message = message;
        this.icon = icon;
        this.progress = progress;
        this.offset = 0;
        this.theme = theme;
        this.exitAnim = exitAnim;
        this.flash = flash;
        this.count = 1;

        if ( pin_id ) {
            this.pin_id = pin_id;
            pinned[pin_id] = this;
        }

        this.el = document.createElement("div");
        this.el.classList.add("bulletin-notification");
        this.el.classList.toggle("flash", this.flash);
        this.el.classList.toggle("pinned", this.pin_id != undefined);
        this.el.classList.add(this.theme);      

        this.init();
    }

    /**
     *
     *
     * @memberof Notification
     */
    show() {
        this.bottom = this.position.toLowerCase().includes("bottom");

        if (this.position in BulletinContainers) {
            this.container = BulletinContainers[this.position];
        } else {
            this.container = new NotificationContainer(this.position);
            BulletinContainers[this.position] = this.container;
        }

        if (!this.container.running && this.container.canAdd) {

            if (this.cfg.SoundFile && audio.paused) {
                audio.setAttribute("src", `audio/${this.cfg.SoundFile}`);
                audio.volume        = this.cfg.SoundVolume;
                audio.currentTime   = 0;
                audio.play();
            }

            this.container.add();

            this.container.addNotification(this);

            this.el.classList.add("active");

            if (this.bottom) {
                this.el.style.bottom = `${this.container.offset}px`;
            } else {
                this.el.style.top = `${this.container.offset}px`;
            }

            if (this.progress) {
                this.el.classList.add("progress");
                this.barEl.style.animationDuration = `${this.interval}ms`;
            }

            const r = this.el.getBoundingClientRect();

            for (const n of this.container.notifications) {
                if (n != this) {
                    if (this.bottom) {
                        n.moveUp(r.height, true);
                    } else {
                        n.moveDown(r.height, true);
                    }
                }
            }

            if ( !this.pin_id ) {
                this.hide();
            }
        } else {
            setTimeout(() => {
                this.show();
            }, 250);
        }
    }

    /**
     *
     *
     * @memberof Notification
     */
    hide() {
        const r = this.el.getBoundingClientRect();

        this.timeout = setTimeout(() => {
            this.el.classList.remove("active");
            this.el.classList.add("hiding");
            this.hiding = true;
            
            if ( this.exitAnim ) {
                this.el.style.animationName = this.exitAnim;
            }

            setTimeout(() => {
                const index = this.container.notifications.indexOf(this);

                for (var i = this.container.notifications.length - 1; i > index; i--) {
                    const n = this.container.notifications[i];

                    if (this.bottom) {
                        n.moveDown(r.height);
                    } else {
                        n.moveUp(r.height);
                    }
                }

                setTimeout(() => {
                    this.container.removeNotification(this);
                }, 100);
            }, this.cfg.AnimationTime);
        }, this.interval);
    }

    /**
     *
     *
     * @memberof Notification
     */
    unpin() {
        const r = this.el.getBoundingClientRect();

        this.el.classList.remove("active");
        this.el.classList.add("hiding");
        this.hiding = true;
        
        if ( this.exitAnim ) {
            this.el.style.animationName = this.exitAnim;
        }

        setTimeout(() => {
            const index = this.container.notifications.indexOf(this);

            for (var i = this.container.notifications.length - 1; i > index; i--) {
                const n = this.container.notifications[i];

                if (this.bottom) {
                    n.moveDown(r.height);
                } else {
                    n.moveUp(r.height);
                }
            }

            setTimeout(() => {
                this.container.removeNotification(this);

                delete pinned[this.pin_id];
            }, 100);
        }, this.cfg.AnimationTime);
    }

    /**
     *
     *
     * @memberof Notification
     */
    stack() {
        clearTimeout(this.timeout);

        const r = this.el.getBoundingClientRect();

        this.el.classList.remove("progress");
        void this.el.offsetWidth;
        this.el.classList.add("progress");

        this.count += 1;

        if ( this.cfg.ShowStackedCount ) {
            this.el.classList.add("stacked");
            this.el.dataset.count = this.count;
        }

        this.hide();
    }

    /**
     *
     *
     * @param {float} h
     * @param {boolean} [run=false]
     * @memberof Notification
     */
    moveUp(h, run = false) {
        const offset = h + this.container.spacing;

        if (this.bottom) {
            this.offset += offset;
        } else {
            this.offset -= offset;
        }
        this.el.style.transition = `transform 250ms ease 0ms`;
        this.el.style.transform = `translate3d(0px, ${-offset}px, 0px)`;

        this.container.running = run;

        setTimeout(() => {
            if (run) {
                this.container.running = false;
            }
            this.el.style.transition = ``;
            this.el.style.transform = ``;
            if (this.bottom) {
                this.el.style.bottom = `${this.container.offset + this.offset}px`;
            } else {
                this.el.style.top = `${this.container.offset + this.offset}px`;
            }
        }, 250);
    }

    /**
     *
     *
     * @param {float} h
     * @param {boolean} [run=false]
     * @memberof Notification
     */
    moveDown(h, run = false) {
        const offset = h + this.container.spacing;

        if (this.bottom) {
            this.offset -= offset;
        } else {
            this.offset += offset;
        }
        this.el.style.transition = `transform 250ms ease 0ms`;
        this.el.style.transform = `translate3d(0px, ${offset}px, 0px)`;

        this.container.running = run;

        setTimeout(() => {
            if (run) {
                this.container.running = false;
            }
            this.el.style.transition = ``;
            this.el.style.transform = ``;

            if (this.bottom) {
                this.el.style.bottom = `${this.container.offset + this.offset}px`;
            } else {
                this.el.style.top = `${this.container.offset + this.offset}px`;
            }
        }, 250);
    }

    /**
     *
     *
     * @param {string} message
     * @return {string} 
     * @memberof Notification
     */
    parseMessage(message) {
        const regexColor = /~([^h])~([^~]+)/g;	
        const regexBold = /~([h])~([^~]+)/g;	
        const regexStop = /~s~/g;	
        const regexLine = /\n/g;	
    
        message = message.replace(regexColor, "<span class='$1'>$2</span>").replace(regexBold, "<span class='$1'>$2</span>").replace(regexStop, "").replace(regexLine, "<br />");
			
        return message;
    }

    update(options) {
        if ( this.type == 'advanced' ) {
            if ( options.hasOwnProperty('title') ) {
                this.title = format(options.title);
            }

            if ( options.hasOwnProperty('subject') ) {
                this.subject = format(options.subject);
            }

            if ( options.hasOwnProperty('message') ) {
                this.message = format(options.message);
            }

            if ( options.hasOwnProperty('icon') ) {
                this.iconEl.innerHTML = `<img src="images/${options.icon}" />`;
            }

            this.titleEl.innerHTML = this.title;
            this.subjectEl.innerHTML = this.subject;
            this.messageEl.innerHTML = this.message;
        } else if ( this.type == 'standard' ) {
            if ( options.hasOwnProperty('message') ) {
                this.message = format(options.message);
            }

            this.el.innerHTML = this.message;  
        }

        if ( options.hasOwnProperty('theme') ) {
            this.el.classList.remove(this.theme);

            this.theme = options.theme;
            this.el.classList.add(this.theme);
        }

        if ( options.hasOwnProperty('flash') && options.flash == true ) {
            this.el.classList.remove("flash");

            setTimeout(() => {
                this.el.classList.add("flash");
            }, 1);
        }

        this.rearrange(this.el.getBoundingClientRect().height);
    }

    rearrange(h) {
        let posY = 0;

        for (const n of this.container.notifications) {
            const rn = n.el.getBoundingClientRect();
            const offset = (rn.height - h);

            n.offset -= offset;

            if ( this.bottom ) {
                n.el.style.bottom = `${posY}px`;
            } else {
                n.el.style.top = `${posY}px`;
            }

            posY += rn.height + this.container.spacing;
        }
    }
}

/**
 *
 *
 * @class StandardNotification
 * @extends {Notification}
 */
class StandardNotification extends Notification {
    /**
     * Creates an instance of StandardNotification.
     * @param {object} cfg
     * @param {string} id
     * @param {string} message
     * @param {integer} interval
     * @param {string} position
     * @param {boolean} [progress=false]
     * @param {string} [theme="default"]
     * @param {string} [exitAnim="fadeOut"]
     * @param {boolean} [flash=false]
     * @param {boolean} [pin_id=false]
     * @memberof StandardNotification
     */
    constructor(cfg, id, message, interval, position, progress = false, theme = "default", exitAnim = "fadeOut", flash = false, pin_id = false) {
        super(cfg, id, message, interval, position, progress, theme, exitAnim, flash, pin_id);
    }

    /**
     *
     *
     * @memberof StandardNotification
     */
    init() {
        this.type = 'standard';
        this.message = format(this.message);
        this.el.innerHTML = this.message;     
        
        if (this.progress) {
            this.el.classList.add("with-progress");
            this.progressEl = document.createElement("div");
            this.progressEl.classList.add("notification-progress");

            this.barEl = document.createElement("div");
            this.barEl.classList.add("notification-bar");

            this.progressEl.appendChild(this.barEl);

            this.el.appendChild(this.progressEl);
        }  
    }
}

/**
 *
 *
 * @class AdvancedNotification
 * @extends {Notification}
 */
class AdvancedNotification extends Notification {
    /**
     * Creates an instance of AdvancedNotification.
     * @param {object} cfg
     * @param {string} id
     * @param {string} message
     * @param {string} title
     * @param {string} subject
     * @param {string} icon
     * @param {integer} interval
     * @param {string} position
     * @param {boolean} [progress=false]
     * @param {string} [theme="default"]
     * @param {string} [exitAnim="fadeOut"]
     * @param {boolean} [flash=false]
     * @param {boolean} [pin_id=false]
     * @memberof AdvancedNotification
     */
    constructor(cfg, id, message, title, subject, icon, interval, position, progress = false, theme = "default", exitAnim = "fadeOut", flash = false, pin_id = false) {
        super(cfg, id, message, interval, position, progress, theme, exitAnim, flash, pin_id, title, subject, icon);
    }

    /**
     *
     *
     * @memberof AdvancedNotification
     */
    init() {

        this.type = 'advanced';
        this.title = format(this.title);
        this.subject = format(this.subject);
        this.message = format(this.message);

        this.headerEl = document.createElement("div");
        this.headerEl.classList.add("notification-header");

        this.iconEl = document.createElement("div");
        this.iconEl.classList.add("notification-icon");

        this.titleEl = document.createElement("div");
        this.titleEl.classList.add("notification-title");

        this.subjectEl = document.createElement("div");
        this.subjectEl.classList.add("notification-subject");

        this.messageEl = document.createElement("div");
        this.messageEl.classList.add("notification-message");

        this.iconEl.innerHTML = `<img src="images/${this.icon}" />`;
        this.titleEl.innerHTML = this.title;
        this.subjectEl.innerHTML = this.subject;
        this.messageEl.innerHTML = this.message;

        this.headerEl.appendChild(this.iconEl);
        this.headerEl.appendChild(this.titleEl);
        this.headerEl.appendChild(this.subjectEl);
        this.el.appendChild(this.headerEl);
        this.el.appendChild(this.messageEl);

        if (this.progress) {
            this.el.classList.add("with-progress");
            this.progressEl = document.createElement("div");
            this.progressEl.classList.add("notification-progress");

            this.barEl = document.createElement("div");
            this.barEl.classList.add("notification-bar");

            this.progressEl.appendChild(this.barEl);

            this.el.appendChild(this.progressEl);
        }  
    }
}

/**
 *
 *
 * @param {Event} e
 */
const onData = function(e) {
    const data = e.data;
    if (data.type) {

        if ( !styled ) {
            let css = `
            .animate__animated {
                -webkit-animation-duration: ${data.config.AnimationTime};
                animation-duration: ${data.config.AnimationTime};
            }

            .bulletin-notification.active {
                opacity: 0;
                animation: fadeIn ${data.config.AnimationTime}ms ease 0ms forwards;
            }

            .bulletin-notification.active.flash {
                opacity: 1;
                animation-name: ${data.config.FlashType};
            }            
            
            .bulletin-notification.hiding {
                opacity: 1;
                animation: ${data.config.AnimationOut} ${data.config.AnimationTime}ms ease 0ms forwards;
            }`;

            if ( data.config.FlashType == "flash" ) {
                css += `
                    .bulletin-notification.active.flash {
                        animation-iteration-count: ${data.config.FlashCount};
                    }                  
                `;
            }

            document.head.insertAdjacentHTML("beforeend", `<style>${css}</style>`);

            styled = true
        }

        if (data.type == "standard") {
            MaxQueue = data.config.Queue;

            if ( data.duplicate && data.config.Stacking ) {
                stackDuplicate(data)
            } else {
                new StandardNotification(data.config, data.id, data.message, data.timeout, data.position, data.progress, data.theme, data.exitAnim, data.flash, data.pin_id).show();
            }
        } else if (data.type == "advanced") {
            MaxQueue = data.config.Queue;

            if ( data.duplicate && data.config.Stacking ) {
                stackDuplicate(data)
            } else {          
                new AdvancedNotification(data.config, data.id, data.message, data.title, data.subject, data.icon, data.timeout, data.position, data.progress, data.theme, data.exitAnim, data.flash, data.pin_id).show();
            }
        } else if (data.type == "unpin") {
            if ( Array.isArray(data.pin_id) ) { // array of pin ids
                for ( const item of data.pin_id ) {
                    if ( pinned.hasOwnProperty(item) ) {
                        pinned[item].unpin();
                    }
                }
            } else if ( typeof(data.pin_id) == 'string' ) {  // unpin single
                if ( pinned.hasOwnProperty(data.pin_id) ) {
                    pinned[data.pin_id].unpin();
                }
            } else {
                for ( let id in pinned ) { // unpin all
                    pinned[id].unpin();
                }
            }
        } else if (data.type == "update_pinned") {
            if ( pinned.hasOwnProperty(data.pin_id) ) {
                pinned[data.pin_id].update(data.options)
            }
        }
    }
};

/**
 *
 *
 * @param {table} data
 */
function stackDuplicate(data) {
    for ( const position in BulletinContainers ) {
        for ( const notification of BulletinContainers[position].notifications ) {
            if ( notification.id == data.id ) {
                if ( notification.hiding ) {
                    if (data.type == "standard") {
                        new StandardNotification(data.config, data.id, data.message, data.timeout, data.position, data.progress, data.theme, data.flash, data.pin_id).show();
                    } else if (data.type == "advanced") {
                        new AdvancedNotification(data.config, data.id, data.message, data.title, data.subject, data.icon, data.timeout, data.position, data.progress, data.theme, data.flash, data.pin_id).show();
                    }
                } else {
                    notification.stack();
                }

                break;
            }
        }
    }
}

/**
 *
 *
 * @param {string} [type=""]
 * @param {*} [data={}]
 */
function PostData(type = "", data = {}) {
    fetch(`https://${GetParentResourceName()}/nui_${type}`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json; charset=UTF-8',
        },
        body: JSON.stringify(data)
    }).then(resp => resp.json()).then(resp => resp).catch(error => console.log('BULLETIN FETCH ERROR! ' + error.message));    
}

window.onload = function(e) {
    window.addEventListener('message', onData);
};