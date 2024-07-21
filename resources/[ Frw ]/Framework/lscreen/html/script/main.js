let audio = new Audio();
var request = new XMLHttpRequest();
var count = 0;

function Main(){
    return{
        DiscordGuildId: '1212499983446573128', // Also know as Discord server ID [ENABLE DISCORD WIDGET ON YOUR DISCORD SERVER!]
        DiscordInviteLink: 'https://discord.gg/valestiarp', // Insert your Discord invite link here.
        // FacebookLink: 'https://discord.com/invite/XdNwNF4AsK', // Insert your Facebook page link here.
        // InstagramLink: 'https://discord.com/invite/XdNwNF4AsK', // Insert your Instagram page link here.
        TikTokLink: 'https://www.tiktok.com/@valestiafivem', // Insert your TikTok page link here.
        memberCount: 0,
        musicAutoplay: true, // Set this to true if you want the music to autoplay
        musicVolume: 0.1, // Set the volume that you like (0 = 0% ; 0.5 = 50% ; 1 = 100%)
        buttons:[
            {label: 'Accueil', selected: true},
            {label: 'Créateur', selected: false},
            // {label: 'Informations', selected: false},
            // {label: 'Règles', selected: false},
        ],
        musicList: [
            {label: 'On est trop', author: 'JuL (feat. Ghetto Phénomène)', src: 'audio/JulGhetto.mp3'},
            {label: 'Mauvaise', author: 'Werenoi', src: 'audio/WerenoiMauvaise.mp3'},
        ],
        team:[
            {discord: 'ZxnKa', role: 'Fondateur', img: 'img/member1.png'},
            {discord: 'iZeyy', role: 'Fondateur', img: 'img/member2.png'},
        ],
        feed:[
            {
                date: '13-04-2024 18:00', 
                label: 'Ouverture du serveur', 
                desc: 'Suite a de nombreuse heures de travail, Valestia RP vous ouvre enfin ses portes !', 
                img: 'img/news.png',
                author: '@Fondateur', 
            },
        ],
        "list": [
            {
                "number": "1.",
                "desc": "Respectez tous les joueurs et membres du staff. Traitez les autres comme vous aimeriez être traité et maintenez une atmosphère amicale et accueillante."
              },
              {
                "number": "2.",
                "desc": "Pas de métagaming. N'utilisez pas d'informations ou de connaissances hors de votre personnage pour influencer vos actions ou vos décisions."
              },
              {
                "number": "3.",
                "desc": "Le jeu de rôle est essentiel. Restez dans le personnage à tout moment et privilégiez les interactions immersives et réalistes avec les autres joueurs."
              },
              {
                "number": "4.",
                "desc": "Suivez les règles et directives spécifiques au serveur. Chaque serveur peut avoir des règles et des mécanismes uniques, alors assurez-vous de les comprendre et de les respecter."
              },
              {
                "number": "5.",
                "desc": "Pas de harcèlement ni de discrimination. Traitez tous les joueurs avec respect et ne vous livrez à aucune forme de discrimination, de discours de haine ou d'intimidation."
              },
          ],
        // No touching here!!!!
        isMusicPlaying: false,
        musicOpen: false,
        currentSong: 0,
        listen(){
            if(this.musicAutoplay){
                setTimeout(() => { this.play();}, 100);
            }
            request.open('GET', 'https://discordapp.com/api/guilds/'+this.DiscordGuildId+'/widget.json', true);
            request.onload = function() {
            if (request.status >= 200 && request.status < 400) {
                var data = JSON.parse(request.responseText);
                count = data.presence_count;
            }
            };    
            request.onerror = function() {
            };
            request.send();   
            setTimeout(() => { this.memberCount = count; }, 1000);
        },
        selectBtn(select){
            this.buttons.forEach(function(button){
                button.selected = false;
            });
            return true;
        },
        play(){
           audio.src = this.musicList[this.currentSong].src;
            audio.load();
            audio.play();
            audio.volume = this.musicVolume;
            this.isMusicPlaying = true; 
        },
        pause(){
            audio.pause()
            this.isMusicPlaying = false;
        },
        next(){
            if(this.isMusicPlaying){
                audio.pause()
            }
            if(this.currentSong < this.musicList.length-1){
                this.currentSong++;
            }else{
                this.currentSong = 0;
            }
            audio.src = this.musicList[this.currentSong].src;
            audio.load();
            audio.play();
            this.isMusicPlaying = true;
        },
        prev(){
            if(this.isMusicPlaying){
                audio.pause()
            }
            if(this.currentSong != 0){
                this.currentSong = this.currentSong-1;
            }else{
                this.currentSong = this.musicList.length-1;
            }
            audio.src = this.musicList[this.currentSong].src;
            audio.load();
            audio.play();
            this.isMusicPlaying = true;
        },
    }
}

function copyToClipboard(text) {
    const input = document.createElement('input');
    input.value = text;
    document.body.appendChild(input);
    input.select();
    document.execCommand('copy');
    document.body.removeChild(input);
  
    const notification = document.createElement('div');
    notification.classList.add('notification');
    notification.textContent = `Discord de ${text} copié dans le presse-papier !`;
    document.body.appendChild(notification);
    notification.style.opacity = 1;
    setTimeout(() => {
      notification.style.opacity = 0;
      setTimeout(() => {
        document.body.removeChild(notification);
      }, 300);
    }, 3000);
}
  

$(document).ready(function() {
    var movementStrength = 25;
    var height = movementStrength / $(window).height();
    var width = movementStrength / $(window).width();
    $(document).mousemove(function(e){
        var pageX = e.pageX - ($(window).width() / 2);
        var pageY = e.pageY - ($(window).height() / 2);
        var newvalueX = width * pageX * -1 - 25;
        var newvalueY = height * pageY * -1 - 50;
        $('.bg1').css("background-position", newvalueX+"px     "+newvalueY+"px");
    });

    const moveCursor = (e)=> {
        const mouseY = e.pageY;
        const mouseX = e.pageX;
         
        $('#cursor').css('transform', `translate3d(${mouseX}px, ${mouseY}px, 0)`)
       
    }
    window.addEventListener('mousemove', moveCursor)
});