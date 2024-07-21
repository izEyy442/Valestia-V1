-------------------------------
-- DOCUMENTATION : https://docs.kaddarem.com/
--------------------------------

-------------------------------------------
-- DON'T EDIT THIS FILE
-- TO OVERWRITE CONFIG VALUE, USE overwriteConfig.lua file instead
-------------------------------------------

Config = {}

-- Display helpfull information to setup a new truck
Config.Debug = false
-- Max length of the winch
Config.MaxLengthRope = 19.0
-- Can push the car with rope ? (unrealistic but useful to get off the vehicle of the bed)
Config.pushWithRope = true
-- Duration to synchronize the rope between players 
Config.ResyncRopeFrenquency = 10000 --ms
-- Keys
Config.DefaultKeys = {
  tow = "j",
  winch = "h",
  unwind = "g"
}
-- Model name of the hook object
Config.HookModel = 'prop_rope_hook_01'

-- List of truck available for this script (you can add more)
Config.ValidModel = {
  -- Copy this array to add vehicle.
  [`flatbed3`] =  {
    -- Set bedUp & bedDown to 0 if you don't need to move the bed to use the winch
    referenceBone = "bodyshell", --optional, by default: bodyshell
    --referenceBone <-> attachVehBone is the distance to define if the bed is up or down
    bedUp = 3.7, -- Distance between bodyshell bone and attachVehBone when the bed is up
    bedDown = 8.1, -- Distance between bodyshell bone and attachVehBone when the bed is down
    ropeBone = "misc_b", -- Bone where the rope is attached
    ropeOffset = vector3(0,0,0.3), -- offset from ropeBone to adjust the position of the rope
    ropeDistancetake =  1.5, -- Max distance to take the winch
    attachVehBone = "misc_a", -- Bone where the vehicle is attached
    attachLocationOffset = vector3(0.0,0.0,0.0), --optional: offset from the attachVehBone bone
    attachOffset = vector4(0.0,0.0,0.0,0.0) -- for the vehicle location when attach (w value is the tilt)
  },
   [`slamtruck`] =  {
    bedUp = 0,
    bedDown = 0,
    ropeBone = "bodyshell",
    ropeOffset = vector3(0.0,0.7,0.5),
    ropeDistancetake = 1.5,
    attachVehBone = "bodyshell",
    attachOffset = vector4(0,0.0,0.0,10.0)
  },
}