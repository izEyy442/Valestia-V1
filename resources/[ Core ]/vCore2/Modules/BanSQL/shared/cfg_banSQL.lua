
------------------------------------------------------------
--------------------------BANSQL----------------------------
------------------------------------------------------------
cfg_banSQL                   = {}

--GENERAL
cfg_banSQL.Permission        = "founder" --Permission need to use FiveM-BanSql commands (mod-admin-superadmin)
cfg_banSQL.ForceSteam        = false    --Set to false if you not use steam auth
cfg_banSQL.MultiServerSync   = false   --This will check if a ban is add in the sql all 30 second, use it only if you have more then 1 server (true-false)

--LANGUAGE
cfg_banSQL.TextFr = {
	start         = "La BanList et l'historique a ete charger avec succes",
	starterror    = "ERREUR : La BanList ou l'historique n'a pas ete charger nouvelle tentative.",
	banlistloaded = "La BanList a ete charger avec succes.",
	historyloaded = "La BanListHistory a ete charger avec succes.",
	loaderror     = "ERREUR : La BanList n a pas été charger.", 
	cmdban        = "/ban (ID) (Durée en heure) (Raison)",
	cmdbanoff     = "/banoff (License) (Durée en heure) (Raison)",
	cmdhistory    = "/banhistory (Steam ID) ou /banhistory 1,2,2,4......",
	noreason      = "Raison Inconnue",
	during        = " pendant : ",
	noresult      = "Il n'y a pas autant de résultats !",
	isban         = " a été ban",
	isunban       = " a été déban",
	invalidsteam  =  "Vous devriez ouvrir steam",
	invalidid     = "ID du joueur incorrect",
	nameinvalide   = "Le nom n'est pas valide",
	invalidname   = "Le ban-id est invalide",
	invalidtime   = "Duree du ban incorrecte",
	alreadyban    = " étais déja bannie pour : ",
	yourban       = "\n\n🐍 Vous avez été ban de façon temporaire de Valestia RP 💜",
	yourpermban   = "\n\n🐍 Vous avez été ban de façon permanente de Valestia RP 💜 ",
	youban        = "Vous avez banni : ",
	forr          = " heure. Pour : ",
	permban       = " de facon permanente pour : ",
	timeleft      = ". Il reste : ",
	toomanyresult = "Trop de résultats, veillez être plus précis.",
	day           = " Jours ",
	hour          = " Heures ",
	minute        = " Minutes ",
	by            = "par",
	ban           = "Bannir un joueurs qui est en ligne",
	banoff        = "Bannir un joueurs qui est hors ligne",
	bansearch     = "Trouver l'id permanent d'un joueur qui est hors ligne",
	dayhelp       = "Nombre d'heure(s)",
	reason        = "Raison du ban",
	permid        = "Trouver l'id permanent avec la commande (sqlsearch)",
	history       = "Affiche tout les bans d'un joueur",
	reload        = "Recharge la BanList et la BanListHistory",
	unban         = "Retirez un ban de la liste",
	steamname     = "(BAN ID)",
}