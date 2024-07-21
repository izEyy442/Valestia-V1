const Scoreboard = document.getElementById("Scoreboard")
const ScoreboardGridHole = document.getElementById("Scoreboard-grid-hole")
const ScoreboardGridScore = document.getElementById("Scoreboard-grid-score")
const Bar = document.getElementById("Bar")
const BarContent = document.getElementById("PowerBar")

let baseWidth = 0

window.addEventListener('message', function (event) {
    const item = event.data;
	const status = item.status;
    const ui = item.ui

    if (ui === 'Scoreboard'){
        Scoreboard.style.display = (status ? "block" : "none");

        if (item.data == undefined) return;

        const deleteIfDivExist = function(className){
            const divs = document.getElementsByClassName(className);

            if (divs == null) return;

            for (var i = divs.length-1; i >= 0; i--) {
                divs[i].remove();
            }
        }

        deleteIfDivExist("Scoreboard-grid-hole-hole")
        deleteIfDivExist("Scoreboard-grid-score-score")

        for (let index = 0; index < item.data.length; index++) {
            const element = item.data[index];
    
            ScoreboardGridHole.innerHTML = ScoreboardGridHole.innerHTML + `<div id="hole" class="Scoreboard-grid-hole-hole">
                <p>${element.hole}</p>
            </div>`;

            ScoreboardGridScore.innerHTML = ScoreboardGridScore.innerHTML + `<div id="score" class="Scoreboard-grid-score-score">
                <p>${element.stroke}</p>
            </div>`;
        };
    }else{
        Bar.style.display = (status ? "block" : "none");

        if (item.data == undefined) return;
        if (item.data > 100) return;

        BarContent.setAttribute('style', `width:${item.data}%`)
    }
})
