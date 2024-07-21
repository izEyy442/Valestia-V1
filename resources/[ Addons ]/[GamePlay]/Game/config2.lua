--[[
  This file is part of Valestia RolePlay.
  Copyright (c) Valestia RolePlay - All Rights Reserved
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]

Bras = {

    language = 'fr', --change with 'en' for english, 'fr' for french, 'cz' for czech, 'de' for german
  
  
  
  
        --Set up new line to add a table, xyz are the coordinate, model is the props used as table. The 3 tables for armwrestling are 
  
                                                      -- 'prop_arm_wrestle_01' --
                                                -- 'bkr_prop_clubhouse_arm_wrestle_01a' --
                                                -- 'bkr_prop_clubhouse_arm_wrestle_02a' --
  
    props = { 
      
  
  
      {x = -1374.67, y = -1324.18, z = 4.24, model = 'prop_arm_wrestle_01'},
      {x = -1617.14, y = -1075.89, z = 13.00, model = 'bkr_prop_clubhouse_arm_wrestle_01a'},
      {x = 284.60, y = -203.30, z = 61.57, model = 'bkr_prop_clubhouse_arm_wrestle_02a'},
      {x = 950.58, y = -122.97, z = 74.35, model = 'bkr_prop_clubhouse_arm_wrestle_02a'},
      {x = 1062.58, y = 2654.89, z = 39.55, model = 'bkr_prop_clubhouse_arm_wrestle_02a'},
      {x = 28.93, y = 3683.18, z = 39.54, model = 'bkr_prop_clubhouse_arm_wrestle_02a'},
  
  
    },
  
    showBlipOnMap = false, -- Set to true to show blip for each table
  
    blip = { --Blip info
  
      title="[Activité] Bras de fer",  
      colour=5, -- 
      id=311
  
    }
  
  }
  
  text = { 
    ['en'] = {
      ['win'] = "You win !",
      ['lose'] = "You lost",
      ['full'] = "A wrestling match is already in progress",
      ['tuto'] = "To win, quickly press ",
      ['wait'] = "Waiting for an opponent",
    },
    ['fr'] = {
      ['win'] = "Vous avez gagné !",
      ['lose'] = "Vous avez perdu",
      ['full'] = "Un bras de fer est déjà en cours",
      ['tuto'] = "Pour gagner, appuyez rapidement sur ",
      ['wait'] = "En attente d'un adversaire",
    },
    ['cz'] = {
      ['win'] = "Vyhrál jsi !",
      ['lose'] = "Prohrál jsi",
      ['full'] = "Zápasový zápas již probíhá",
      ['tuto'] = "Chcete-li vyhrát, rychle stiskněte ",
      ['wait'] = "Čekání na protivníka",
    },
    ['de'] = {
      ['win'] = "Du hast gewinnen !",
      ['lose'] = "Du hast verloren",
      ['full'] = "Ein Wrestling Match ist bereits im Gange",
      ['tuto'] = "Um zu gewinnen, drücken Sie schnell ",
      ['wait'] = "Warten auf einen Gegner",
    },
  
}




