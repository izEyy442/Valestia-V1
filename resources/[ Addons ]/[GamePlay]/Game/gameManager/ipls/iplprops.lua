--[[
  This file is part of Valestia RolePlay.
  Copyright (c) Valestia RolePlay - All Rights Reserved
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]

Citizen.CreateThread(function()
	OnEnterMp(1)
	while true do
        Citizen.Wait(0)
		-- Meth Lab
		-- bkr_biker_interior_placement_interior_2_biker_dlc_int_ware01_milo
		if ConfigIpls.methLabBasic then
			if ConfigIpls.wareHouseOne then
				ActivateInteriorEntitySet(ConfigIpls.wareHouseOneId, "meth_lab_basic")
		
			end
		end
		if ConfigIpls.methLabEmpty then
			if ConfigIpls.wareHouseOne then
			ActivateInteriorEntitySet(ConfigIpls.wareHouseOneId, "meth_lab_empty")
			end
		end
		if ConfigIpls.methLabProduction then
			if ConfigIpls.wareHouseOne then
				ActivateInteriorEntitySet(ConfigIpls.wareHouseOneId, "meth_lab_production")
			end
		end
		if ConfigIpls.methLabSecurityHigh then
			if ConfigIpls.wareHouseOne then
				ActivateInteriorEntitySet(ConfigIpls.wareHouseOneId, "meth_lab_security_high")
			end
		end
		if ConfigIpls.methLabSetup then
			if ConfigIpls.wareHouseOne then
				ActivateInteriorEntitySet(ConfigIpls.wareHouseOneId, "meth_lab_setup")
			end
		end
		if ConfigIpls.methLabUpgrade then
			if ConfigIpls.wareHouseOne then
				ActivateInteriorEntitySet(ConfigIpls.wareHouseOneId, "meth_lab_upgrade")
			end
		end
			-- Weed Lab
        if ConfigIpls.weedDrying then
            if ConfigIpls.wareHouseTwo then
                ActivateInteriorEntitySet(ConfigIpls.wareHouseTwoId, "weed_drying")
            end
        end
        if ConfigIpls.weedProduction then
            if ConfigIpls.wareHouseTwo then
                ActivateInteriorEntitySet(ConfigIpls.wareHouseTwoId, "weed_production")
            end
        end
        if ConfigIpls.weedSetup then
            if ConfigIpls.wareHouseTwo then
                ActivateInteriorEntitySet(ConfigIpls.wareHouseTwoId, "weed_set_up")
            end
        end
        if ConfigIpls.weedStandardEquip then
            if ConfigIpls.wareHouseTwo then
                ActivateInteriorEntitySet(ConfigIpls.wareHouseTwoId, "weed_standard_equip")
            end
        end
        if ConfigIpls.weedUpgradeEquip then
            if ConfigIpls.wareHouseTwo then
                ActivateInteriorEntitySet(ConfigIpls.wareHouseTwoId, "weed_upgrade_equip")
            end
        end
        if ConfigIpls.weedGrowthAStage1 then
            if ConfigIpls.wareHouseTwo then
                ActivateInteriorEntitySet(ConfigIpls.wareHouseTwoId, "weed_growtha_stage1")
            end
        end
        if ConfigIpls.weedGrowthAStage2 then
            if ConfigIpls.wareHouseTwo then
                ActivateInteriorEntitySet(ConfigIpls.wareHouseTwoId, "weed_growtha_stage2")
            end
        end
        if ConfigIpls.weedGrowthAStage3 then
            if ConfigIpls.wareHouseTwo then
                ActivateInteriorEntitySet(ConfigIpls.wareHouseTwoId, "weed_growtha_stage3")
            end
        end
        if ConfigIpls.weedGrowthBStage1 then
            if ConfigIpls.wareHouseTwo then
                ActivateInteriorEntitySet(ConfigIpls.wareHouseTwoId, "weed_growthb_stage1")
            end
        end
        if ConfigIpls.weedGrowthBStage2 then
            if ConfigIpls.wareHouseTwo then
                ActivateInteriorEntitySet(ConfigIpls.wareHouseTwoId, "weed_growthb_stage2")
            end
        end
        if ConfigIpls.weedGrowthBStage3 then
            if ConfigIpls.wareHouseTwo then
                ActivateInteriorEntitySet(ConfigIpls.wareHouseTwoId, "weed_growthb_stage3")
            end
        end
        if ConfigIpls.weedGrowthCStage1 then
            if ConfigIpls.wareHouseTwo then
                ActivateInteriorEntitySet(ConfigIpls.wareHouseTwoId, "weed_growthc_stage1")
            end
        end
        if ConfigIpls.weedGrowthCStage2 then
            if ConfigIpls.wareHouseTwo then
                ActivateInteriorEntitySet(ConfigIpls.wareHouseTwoId, "weed_growthc_stage2")
            end
        end
        if ConfigIpls.weedGrowthCStage3 then
            if ConfigIpls.wareHouseTwo then
                ActivateInteriorEntitySet(ConfigIpls.wareHouseTwoId, "weed_growthc_stage3")
            end
        end
        if ConfigIpls.weedGrowthDStage1 then
            if ConfigIpls.wareHouseTwo then
                ActivateInteriorEntitySet(ConfigIpls.wareHouseTwoId, "weed_growthd_stage1")
            end
        end
        if ConfigIpls.weedGrowthDStage2 then
            if ConfigIpls.wareHouseTwo then
                ActivateInteriorEntitySet(ConfigIpls.wareHouseTwoId, "weed_growthd_stage2")
            end
        end
        if ConfigIpls.weedGrowthDStage3 then
            if ConfigIpls.wareHouseTwo then
                ActivateInteriorEntitySet(ConfigIpls.wareHouseTwoId, "weed_growthd_stage3")
            end
        end
        if ConfigIpls.weedGrowthEStage1 then
            if ConfigIpls.wareHouseTwo then
                ActivateInteriorEntitySet(ConfigIpls.wareHouseTwoId, "weed_growthe_stage1")
            end
        end
        if ConfigIpls.weedGrowthEStage2 then
            if ConfigIpls.wareHouseTwo then
                ActivateInteriorEntitySet(ConfigIpls.wareHouseTwoId, "weed_growthe_stage2")
            end
        end
        if ConfigIpls.weedGrowthEStage3 then
            if ConfigIpls.wareHouseTwo then
                ActivateInteriorEntitySet(ConfigIpls.wareHouseTwoId, "weed_growthe_stage3")
            end
        end
        if ConfigIpls.weedGrowthFStage1 then
            if ConfigIpls.wareHouseTwo then
                ActivateInteriorEntitySet(ConfigIpls.wareHouseTwoId, "weed_growthf_stage1")
            end
        end
        if ConfigIpls.weedGrowthFStage2 then
            if ConfigIpls.wareHouseTwo then
                ActivateInteriorEntitySet(ConfigIpls.wareHouseTwoId, "weed_growthf_stage2")
            end
        end
        if ConfigIpls.weedGrowthFStage3 then
            if ConfigIpls.wareHouseTwo then
                ActivateInteriorEntitySet(ConfigIpls.wareHouseTwoId, "weed_growthf_stage3")
            end
        end
        if ConfigIpls.weedGrowthGStage1 then
            if ConfigIpls.wareHouseTwo then
                ActivateInteriorEntitySet(ConfigIpls.wareHouseTwoId, "weed_growthg_stage1")
            end
        end
        if ConfigIpls.weedGrowthGStage2 then
            if ConfigIpls.wareHouseTwo then
                ActivateInteriorEntitySet(ConfigIpls.wareHouseTwoId, "weed_growthg_stage2")
            end
        end
        if ConfigIpls.weedGrowthGStage3 then
            if ConfigIpls.wareHouseTwo then
                ActivateInteriorEntitySet(ConfigIpls.wareHouseTwoId, "weed_growthg_stage3")
            end
        end
        if ConfigIpls.weedGrowthHStage1 then
            if ConfigIpls.wareHouseTwo then
                ActivateInteriorEntitySet(ConfigIpls.wareHouseTwoId, "weed_growthh_stage1")
            end
        end
        if ConfigIpls.weedGrowthHStage2 then
            if ConfigIpls.wareHouseTwo then
                ActivateInteriorEntitySet(ConfigIpls.wareHouseTwoId, "weed_growthh_stage2")
            end
        end
        if ConfigIpls.weedGrowthHStage3 then
            if ConfigIpls.wareHouseTwo then
                ActivateInteriorEntitySet(ConfigIpls.wareHouseTwoId, "weed_growthh_stage3")
            end
        end
        if ConfigIpls.weedGrowthIStage1 then
            if ConfigIpls.wareHouseTwo then
                ActivateInteriorEntitySet(ConfigIpls.wareHouseTwoId, "weed_growthi_stage1")
            end
        end
        if ConfigIpls.weedGrowthIStage2 then
            if ConfigIpls.wareHouseTwo then
                ActivateInteriorEntitySet(ConfigIpls.wareHouseTwoId, "weed_growthi_stage2")
            end
        end
        if ConfigIpls.weedGrowthIStage3 then
            if ConfigIpls.wareHouseTwo then
                ActivateInteriorEntitySet(ConfigIpls.wareHouseTwoId, "weed_growthi_stage3")
            end
        end
        if ConfigIpls.weedHoseA then
            if ConfigIpls.wareHouseTwo then
                ActivateInteriorEntitySet(ConfigIpls.wareHouseTwoId, "weed_hosea")
            end
        end
        if ConfigIpls.weedHoseB then
            if ConfigIpls.wareHouseTwo then
                ActivateInteriorEntitySet(ConfigIpls.wareHouseTwoId, "weed_hoseb")
            end
        end
        if ConfigIpls.weedHoseC then
            if ConfigIpls.wareHouseTwo then
                ActivateInteriorEntitySet(ConfigIpls.wareHouseTwoId, "weed_hosec")
            end
        end
        if ConfigIpls.weedHoseD then
            if ConfigIpls.wareHouseTwo then
                ActivateInteriorEntitySet(ConfigIpls.wareHouseTwoId, "weed_hosed")
            end
        end
        if ConfigIpls.weedHoseE then
            if ConfigIpls.wareHouseTwo then
                ActivateInteriorEntitySet(ConfigIpls.wareHouseTwoId, "weed_hosee")
            end
        end
        if ConfigIpls.weedHoseF then
            if ConfigIpls.wareHouseTwo then
                ActivateInteriorEntitySet(ConfigIpls.wareHouseTwoId, "weed_hosef")
            end
        end
        if ConfigIpls.weedHoseG then
            if ConfigIpls.wareHouseTwo then
                ActivateInteriorEntitySet(ConfigIpls.wareHouseTwoId, "weed_hoseg")
            end
        end
        if ConfigIpls.weedHoseH then
            if ConfigIpls.wareHouseTwo then
                ActivateInteriorEntitySet(ConfigIpls.wareHouseTwoId, "weed_hoseh")
            end
        end
        if ConfigIpls.weedHoseI then
            if ConfigIpls.wareHouseTwo then
                ActivateInteriorEntitySet(ConfigIpls.wareHouseTwoId, "weed_hosei")
            end
        end
        if ConfigIpls.weedlightGrowthAStage23Standard then
            if ConfigIpls.wareHouseTwo then
                ActivateInteriorEntitySet(ConfigIpls.wareHouseTwoId, "light_growtha_stage23_standard")
            end
        end
        if ConfigIpls.weedlightGrowthBStage23Standard then
            if ConfigIpls.wareHouseTwo then
                ActivateInteriorEntitySet(ConfigIpls.wareHouseTwoId, "light_growthb_stage23_standard")
            end
        end
        if ConfigIpls.weedlightGrowthCStage23Standard then
            if ConfigIpls.wareHouseTwo then
                ActivateInteriorEntitySet(ConfigIpls.wareHouseTwoId, "light_growthc_stage23_standard")
            end
        end
        if ConfigIpls.weedlightGrowthDStage23Standard then
            if ConfigIpls.wareHouseTwo then
                ActivateInteriorEntitySet(ConfigIpls.wareHouseTwoId, "light_growthd_stage23_standard")
            end
        end
        if ConfigIpls.weedlightGrowthEStage23Standard then
            if ConfigIpls.wareHouseTwo then
                ActivateInteriorEntitySet(ConfigIpls.wareHouseTwoId, "light_growthe_stage23_standard")
            end
        end
        if ConfigIpls.weedlightGrowthFStage23Standard then
            if ConfigIpls.wareHouseTwo then
                ActivateInteriorEntitySet(ConfigIpls.wareHouseTwoId, "light_growthf_stage23_standard")
            end
        end
        if ConfigIpls.weedlightGrowthHStage23Standard then
            if ConfigIpls.wareHouseTwo then
                ActivateInteriorEntitySet(ConfigIpls.wareHouseTwoId, "light_growthg_stage23_standard")
            end
        end
        if ConfigIpls.weedlightGrowthIStage23Standard then
            if ConfigIpls.wareHouseTwo then
                ActivateInteriorEntitySet(ConfigIpls.wareHouseTwoId, "light_growthh_stage23_standard")
            end
        end
        if ConfigIpls.weedlightGrowthJStage23Standard then
            if ConfigIpls.wareHouseTwo then
                ActivateInteriorEntitySet(ConfigIpls.wareHouseTwoId, "light_growthi_stage23_standard")
            end
        end
        if ConfigIpls.weedlightGrowthAStage23Upgrade then
            if ConfigIpls.wareHouseTwo then
                ActivateInteriorEntitySet(ConfigIpls.wareHouseTwoId, "light_growtha_stage23_upgrade")
            end
        end
        if ConfigIpls.weedlightGrowthBStage23Upgrade then
            if ConfigIpls.wareHouseTwo then
                ActivateInteriorEntitySet(ConfigIpls.wareHouseTwoId, "light_growthb_stage23_upgrade")
            end
        end
        if ConfigIpls.weedlightGrowthCStage23Upgrade then
            if ConfigIpls.wareHouseTwo then
                ActivateInteriorEntitySet(ConfigIpls.wareHouseTwoId, "light_growthc_stage23_upgrade")
            end
        end
        if ConfigIpls.weedlightGrowthDStage23Upgrade then
            if ConfigIpls.wareHouseTwo then
                ActivateInteriorEntitySet(ConfigIpls.wareHouseTwoId, "light_growthd_stage23_upgrade")
            end
        end
        if ConfigIpls.weedlightGrowthEStage23Upgrade then
            if ConfigIpls.wareHouseTwo then
                ActivateInteriorEntitySet(ConfigIpls.wareHouseTwoId, "light_growthe_stage23_upgrade")
            end
        end
        if ConfigIpls.weedlightGrowthFStage23Upgrade then
            if ConfigIpls.wareHouseTwo then
                ActivateInteriorEntitySet(ConfigIpls.wareHouseTwoId, "light_growthf_stage23_upgrade")
            end
        end
        if ConfigIpls.weedlightGrowthGStage23Upgrade then
            if ConfigIpls.wareHouseTwo then
                ActivateInteriorEntitySet(ConfigIpls.wareHouseTwoId, "light_growthg_stage23_upgrade")
            end
        end
        if ConfigIpls.weedlightGrowthHStage23Upgrade then
            if ConfigIpls.wareHouseTwo then
                ActivateInteriorEntitySet(ConfigIpls.wareHouseTwoId, "light_growthh_stage23_upgrade")
            end
        end
        if ConfigIpls.weedlightGrowthIStage23Upgrade then
            if ConfigIpls.wareHouseTwo then
                ActivateInteriorEntitySet(ConfigIpls.wareHouseTwoId, "light_growthi_stage23_upgrade")
            end
        end
        if ConfigIpls.weedLowSecurity then
            if ConfigIpls.wareHouseTwo then
                ActivateInteriorEntitySet(ConfigIpls.wareHouseTwoId, "weed_low_security")
            end
        end
        if ConfigIpls.weedSecurityUpgrade then
            if ConfigIpls.wareHouseTwo then
                ActivateInteriorEntitySet(ConfigIpls.wareHouseTwoId, "weed_security_upgrade")
            end
        end
        if ConfigIpls.weedChairs then
            if ConfigIpls.wareHouseTwo then
                ActivateInteriorEntitySet(ConfigIpls.wareHouseTwoId, "weed_chairs")
            end
        end
		-- Cocain Lab
        if ConfigIpls.cocainSecurityLow then
            if ConfigIpls.wareHouseThree then
			    ActivateInteriorEntitySet(ConfigIpls.wareHouseThreeId, "security_low")
            end
        end
        if ConfigIpls.cocainSecurityHigh then
            if ConfigIpls.wareHouseThree then
			    ActivateInteriorEntitySet(ConfigIpls.wareHouseThreeId, "security_high")
            end
        end
        if ConfigIpls.cocainequipmentBasic then
            if ConfigIpls.wareHouseThree then
			    ActivateInteriorEntitySet(ConfigIpls.wareHouseThreeId, "equipment_basic")
            end
        end
        if ConfigIpls.cocainequipmentUpgrade then
            if ConfigIpls.wareHouseThree then
			    ActivateInteriorEntitySet(ConfigIpls.wareHouseThreeId, "equipment_upgrade")
            end
        end
        if ConfigIpls.cocainSetup then
            if ConfigIpls.wareHouseThree then
			    ActivateInteriorEntitySet(ConfigIpls.wareHouseThreeId, "set_up")
            end
        end
        if ConfigIpls.cocainProductionBasic then
            if ConfigIpls.wareHouseThree then
			    ActivateInteriorEntitySet(ConfigIpls.wareHouseThreeId, "production_basic")
            end
        end
        if ConfigIpls.cocainProductionUpgrade then
            if ConfigIpls.wareHouseThree then
			    ActivateInteriorEntitySet(ConfigIpls.wareHouseThreeId, "production_upgrade")
            end
        end
        if ConfigIpls.cocainTableEquipmentUpgeade then
            if ConfigIpls.wareHouseThree then
			    ActivateInteriorEntitySet(ConfigIpls.wareHouseThreeId, "table_equipment")
            end
        end
        if ConfigIpls.cocainCokePressBasic then
            if ConfigIpls.wareHouseThree then
			    ActivateInteriorEntitySet(ConfigIpls.wareHouseThreeId, "table_equipment_upgrade")
            end
        end
        if ConfigIpls.cocainCokePressUpgrade then
            if ConfigIpls.wareHouseThree then
			    ActivateInteriorEntitySet(ConfigIpls.wareHouseThreeId, "coke_press_basic")
            end
        end
        if ConfigIpls.cocainCokeCut01 then
            if ConfigIpls.wareHouseThree then
			    ActivateInteriorEntitySet(ConfigIpls.wareHouseThreeId, "coke_press_upgrade")
            end
        end
        if ConfigIpls.cocainCokeCut02 then
            if ConfigIpls.wareHouseThree then
			    ActivateInteriorEntitySet(ConfigIpls.wareHouseThreeId, "coke_cut_01")
            end
        end
        if ConfigIpls.cocainCokeCut03 then
            if ConfigIpls.wareHouseThree then
			    ActivateInteriorEntitySet(ConfigIpls.wareHouseThreeId, "coke_cut_02")
            end
        end
        if ConfigIpls.cocainCokeCut04 then
            if ConfigIpls.wareHouseThree then
			    ActivateInteriorEntitySet(ConfigIpls.wareHouseThreeId, "coke_cut_03")
            end
        end
        if ConfigIpls.cocainCokeCut05 then
            if ConfigIpls.wareHouseThree then
			    ActivateInteriorEntitySet(ConfigIpls.wareHouseThreeId, "coke_cut_04")
            end
        end
			-- Bunkers
		if ConfigIpls.bunkerStyleA then
			if ConfigIpls.bunkerInterior then
				ActivateInteriorEntitySet(ConfigIpls.bunkerId, "Bunker_Style_A")
			end
		end
		if ConfigIpls.bunkerStyleB then
			if ConfigIpls.bunkerInterior then
				ActivateInteriorEntitySet(ConfigIpls.bunkerId, "Bunker_Style_B")
			end
		end
		if ConfigIpls.bunkerStyleC then
			if ConfigIpls.bunkerInterior then
				ActivateInteriorEntitySet(ConfigIpls.bunkerId, "Bunker_Style_C")
			end
		end
		if ConfigIpls.bunkerStandardSet then
			if ConfigIpls.bunkerInterior then
				ActivateInteriorEntitySet(ConfigIpls.bunkerId, "standard_bunker_set")
			end
		end
		if ConfigIpls.bunkerUpgradeSet then
			if ConfigIpls.bunkerInterior then
				ActivateInteriorEntitySet(ConfigIpls.bunkerId, "upgrade_bunker_set")
			end
		end
		if ConfigIpls.bunkerStandardSecuritySet then
			if ConfigIpls.bunkerInterior then
				ActivateInteriorEntitySet(ConfigIpls.bunkerId, "standard_security_set")
			end
		end
		if ConfigIpls.bunkerUpgradeSecuritySet then
			if ConfigIpls.bunkerInterior then
				ActivateInteriorEntitySet(ConfigIpls.bunkerId, "security_upgrade")
			end
		end
		if ConfigIpls.bunkerOfficeBlockerSet then
			if ConfigIpls.bunkerInterior then
				ActivateInteriorEntitySet(ConfigIpls.bunkerId, "Office_blocker_set")
			end
		end
		if ConfigIpls.bunkerOfficeUpgradeSet then
			if ConfigIpls.bunkerInterior then
				ActivateInteriorEntitySet(ConfigIpls.bunkerId, "Office_Upgrade_set")
			end
		end
		if ConfigIpls.bunkerGunRangeBlockerSet then
			if ConfigIpls.bunkerInterior then
				ActivateInteriorEntitySet(ConfigIpls.bunkerId, "gun_range_blocker_set")
			end
		end
		if ConfigIpls.bunkerWallBlocker then
			if ConfigIpls.bunkerInterior then
				ActivateInteriorEntitySet(ConfigIpls.bunkerId, "gun_wall_blocker")
			end
		end
		if ConfigIpls.bunkerGunRangeLights then
			if ConfigIpls.bunkerInterior then
				ActivateInteriorEntitySet(ConfigIpls.bunkerId, "gun_range_lights")
			end
		end
		if ConfigIpls.bunkerGunLockerUpgrade then
			if ConfigIpls.bunkerInterior then
				ActivateInteriorEntitySet(ConfigIpls.bunkerId, "gun_locker_upgrade")
			end
		end
		if ConfigIpls.bunkerGunSchematicSet then
			if ConfigIpls.bunkerInterior then
				ActivateInteriorEntitySet(ConfigIpls.bunkerId, "Gun_schematic_set")
			end
		end
			-- FIB Lobby
		if ConfigIpls.fibProps then
			if ConfigIpls.fbiLobby then
				ActivateInteriorEntitySet(ConfigIpls.FIBId, "V_FIB03_door_light")
				ActivateInteriorEntitySet(ConfigIpls.FIBId, "V_FIB02_set_AH3b")
				ActivateInteriorEntitySet(ConfigIpls.FIBId, "V_FIB03_set_AH3b")
				ActivateInteriorEntitySet(ConfigIpls.FIBId, "V_FIB04_set_AH3b")
			end
		end
		-- Counterfeit Cash Factory
		if ConfigIpls.cfcCashPile10a then
			if ConfigIpls.wareHouseFour then
				ActivateInteriorEntitySet(ConfigIpls.wareHouseFourId, "counterfeit_cashpile10a")
			end
		end
		if ConfigIpls.cfcCashPile10b then
			if ConfigIpls.wareHouseFour then
				ActivateInteriorEntitySet(ConfigIpls.wareHouseFourId, "counterfeit_cashpile10b")
			end
		end
		if ConfigIpls.cfcCashPile10c then
			if ConfigIpls.wareHouseFour then
				ActivateInteriorEntitySet(ConfigIpls.wareHouseFourId, "counterfeit_cashpile10c")
			end
		end
		if ConfigIpls.cfcCashPile10D then
			if ConfigIpls.wareHouseFour then
				ActivateInteriorEntitySet(ConfigIpls.wareHouseFourId, "counterfeit_cashpile10d")
			end
		end
		if ConfigIpls.cfcCashPile20a then
			if ConfigIpls.wareHouseFour then
				ActivateInteriorEntitySet(ConfigIpls.wareHouseFourId, "counterfeit_cashpile20a")
			end
		end
		if ConfigIpls.cfcCashPile20b then
			if ConfigIpls.wareHouseFour then
				ActivateInteriorEntitySet(ConfigIpls.wareHouseFourId, "counterfeit_cashpile20b")
			end
		end
		if ConfigIpls.cfcCashPile20c then
			if ConfigIpls.wareHouseFour then
				ActivateInteriorEntitySet(ConfigIpls.wareHouseFourId, "counterfeit_cashpile20c")
			end
		end
		if ConfigIpls.cfcCashPile20d then
			if ConfigIpls.wareHouseFour then
				ActivateInteriorEntitySet(ConfigIpls.wareHouseFourId, "counterfeit_cashpile20d")
			end
		end
		if ConfigIpls.cfcCashPile100a then
			if ConfigIpls.wareHouseFour then
				ActivateInteriorEntitySet(ConfigIpls.wareHouseFourId, "counterfeit_cashpile100a")
			end
		end
		if ConfigIpls.cfcCashPile100b then
			if ConfigIpls.wareHouseFour then
				ActivateInteriorEntitySet(ConfigIpls.wareHouseFourId, "counterfeit_cashpile100b")
			end
		end
		if ConfigIpls.cfcCashPile100c then
			if ConfigIpls.wareHouseFour then
				ActivateInteriorEntitySet(ConfigIpls.wareHouseFourId, "counterfeit_cashpile100c")
			end
		end
		if ConfigIpls.cfcCashPile100d then
			if ConfigIpls.wareHouseFour then
				ActivateInteriorEntitySet(ConfigIpls.wareHouseFourId, "counterfeit_cashpile100d")
			end
		end
		if ConfigIpls.cfcLowSecurity then
			if ConfigIpls.wareHouseFour then
				ActivateInteriorEntitySet(ConfigIpls.wareHouseFourId, "counterfeit_low_security")
			end
		end
		if ConfigIpls.cfcSecurity then
			if ConfigIpls.wareHouseFour then
				ActivateInteriorEntitySet(ConfigIpls.wareHouseFourId, "counterfeit_security")
			end
		end
		if ConfigIpls.cfcSetup then
			if ConfigIpls.wareHouseFour then
				ActivateInteriorEntitySet(ConfigIpls.wareHouseFourId, "counterfeit_setup")
			end
		end
		if ConfigIpls.cfcStandardEquipment then
			if ConfigIpls.wareHouseFour then
				ActivateInteriorEntitySet(ConfigIpls.wareHouseFourId, "counterfeit_standard_equip")
			end
		end
		if ConfigIpls.cfcStandardNoProd then
			if ConfigIpls.wareHouseFour then
				ActivateInteriorEntitySet(ConfigIpls.wareHouseFourId, "counterfeit_standard_equip_no_prod")
			end
		end
		if ConfigIpls.cfcUpgradeEquip then
			if ConfigIpls.wareHouseFour then
				ActivateInteriorEntitySet(ConfigIpls.wareHouseFourId, "counterfeit_upgrade_equip")
			end
		end
		if ConfigIpls.cfcUpgradeEquipNoProd then
			if ConfigIpls.wareHouseFour then
				ActivateInteriorEntitySet(ConfigIpls.wareHouseFourId, "counterfeit_upgrade_equip_no_prod")
			end
		end
		if ConfigIpls.cfcMoneyCutter then
			if ConfigIpls.wareHouseFour then
				ActivateInteriorEntitySet(ConfigIpls.wareHouseFourId, "money_cutter")
			end
		end
		if ConfigIpls.cfcSpecialChairs then
			if ConfigIpls.wareHouseFour then
				ActivateInteriorEntitySet(ConfigIpls.wareHouseFourId, "special_chairs")
			end
		end
		if ConfigIpls.cfcDryerAOff then
			if ConfigIpls.wareHouseFour then
				ActivateInteriorEntitySet(ConfigIpls.wareHouseFourId, "dryera_off")
			end
		end
		if ConfigIpls.cfcDryerAOn then
			if ConfigIpls.wareHouseFour then
				ActivateInteriorEntitySet(ConfigIpls.wareHouseFourId, "dryera_on")
			end
		end
		if ConfigIpls.cfcDryerAOpen then
			if ConfigIpls.wareHouseFour then
				ActivateInteriorEntitySet(ConfigIpls.wareHouseFourId, "dryera_open")
			end
		end
		if ConfigIpls.cfcDryerBOff then
			if ConfigIpls.wareHouseFour then
				ActivateInteriorEntitySet(ConfigIpls.wareHouseFourId, "dryerb_off")
			end
		end
		if ConfigIpls.cfcDryerBOn then
			if ConfigIpls.wareHouseFour then
				ActivateInteriorEntitySet(ConfigIpls.wareHouseFourId, "dryerb_on")
			end
		end
		if ConfigIpls.cfcDryerBOpen then
			if ConfigIpls.wareHouseFour then
				ActivateInteriorEntitySet(ConfigIpls.wareHouseFourId, "dryerb_open")
			end
		end
		if ConfigIpls.cfcDryerCOff then
			if ConfigIpls.wareHouseFour then
				ActivateInteriorEntitySet(ConfigIpls.wareHouseFourId, "dryerc_off")
			end
		end
		if ConfigIpls.cfcDryerCOn then
			if ConfigIpls.wareHouseFour then
				ActivateInteriorEntitySet(ConfigIpls.wareHouseFourId, "dryerc_on")
			end
		end
		if ConfigIpls.cfcDryerCOpen then
			if ConfigIpls.wareHouseFour then
				ActivateInteriorEntitySet(ConfigIpls.wareHouseFourId, "dryerc_open")
			end
		end
		if ConfigIpls.cfcDryerDOff then
			if ConfigIpls.wareHouseFour then
				ActivateInteriorEntitySet(ConfigIpls.wareHouseFourId, "dryerd_off")
			end
		end
		if ConfigIpls.cfcDryerDOn then
			if ConfigIpls.wareHouseFour then
				ActivateInteriorEntitySet(ConfigIpls.wareHouseFourId, "dryerd_on")
			end
		end
		if ConfigIpls.cfcDryerDOpen then
			if ConfigIpls.wareHouseFour then
				ActivateInteriorEntitySet(ConfigIpls.wareHouseFourId, "dryerd_open")
			end
		end
			-- Clubhouse 1
        if ConfigIpls.clubhouse1CashStash1 then
            if ConfigIpls.clubHouseOne then
                ActivateInteriorEntitySet(ConfigIpls.clubHouseOneId, "cash_stash1")
            end
        end
        if ConfigIpls.clubhouse1CashStash2 then
            if ConfigIpls.clubHouseOne then
                ActivateInteriorEntitySet(ConfigIpls.clubHouseOneId, "cash_stash2")
            end
        end
        if ConfigIpls.clubhouse1CashStash3 then
            if ConfigIpls.clubHouseOne then
                ActivateInteriorEntitySet(ConfigIpls.clubHouseOneId, "cash_stash3")
            end
        end
        if ConfigIpls.clubhouse1CokeStash1 then
            if ConfigIpls.clubHouseOne then
                ActivateInteriorEntitySet(ConfigIpls.clubHouseOneId, "coke_stash1")
            end
        end
        if ConfigIpls.clubhouse1CokeStash2 then
            if ConfigIpls.clubHouseOne then
                ActivateInteriorEntitySet(ConfigIpls.clubHouseOneId, "coke_stash2")
            end
        end
        if ConfigIpls.clubhouse1CokeStash3 then
            if ConfigIpls.clubHouseOne then
                ActivateInteriorEntitySet(ConfigIpls.clubHouseOneId, "coke_stash3")
            end
        end
        if ConfigIpls.clubhouse1CounterfeitStash1 then
            if ConfigIpls.clubHouseOne then
                ActivateInteriorEntitySet(ConfigIpls.clubHouseOneId, "counterfeit_stash1")
            end
        end
        if ConfigIpls.clubhouse1CounterfeitStash2 then
            if ConfigIpls.clubHouseOne then
                ActivateInteriorEntitySet(ConfigIpls.clubHouseOneId, "counterfeit_stash2")
            end
        end
        if ConfigIpls.clubhouse1CounterfeitStash3 then
            if ConfigIpls.clubHouseOne then
                ActivateInteriorEntitySet(ConfigIpls.clubHouseOneId, "counterfeit_stash3")
            end
        end
        if ConfigIpls.clubhouse1WeedStash1 then
            if ConfigIpls.clubHouseOne then
                ActivateInteriorEntitySet(ConfigIpls.clubHouseOneId, "weed_stash1")
            end
        end
        if ConfigIpls.clubhouse1WeedStash2 then
            if ConfigIpls.clubHouseOne then
                ActivateInteriorEntitySet(ConfigIpls.clubHouseOneId, "weed_stash2")
            end
        end
        if ConfigIpls.clubhouse1WeedStash3 then
            if ConfigIpls.clubHouseOne then
                ActivateInteriorEntitySet(ConfigIpls.clubHouseOneId, "weed_stash3")
            end
        end
        if ConfigIpls.clubhouse1IDStash1 then
            if ConfigIpls.clubHouseOne then
                ActivateInteriorEntitySet(ConfigIpls.clubHouseOneId, "id_stash1")
            end
        end
        if ConfigIpls.clubhouse1IDStash2 then
            if ConfigIpls.clubHouseOne then
                ActivateInteriorEntitySet(ConfigIpls.clubHouseOneId, "id_stash2")
            end
        end
        if ConfigIpls.clubhouse1IDStash3 then
            if ConfigIpls.clubHouseOne then
                ActivateInteriorEntitySet(ConfigIpls.clubHouseOneId, "id_stash3")
            end
        end
        if ConfigIpls.clubhouse1MethStash1 then
            if ConfigIpls.clubHouseOne then
                ActivateInteriorEntitySet(ConfigIpls.clubHouseOneId, "meth_stash1")
            end
        end
        if ConfigIpls.clubhouse1MethStash2 then
            if ConfigIpls.clubHouseOne then
                ActivateInteriorEntitySet(ConfigIpls.clubHouseOneId, "meth_stash2")
            end
        end
        if ConfigIpls.clubhouse1MethStash3 then
            if ConfigIpls.clubHouseOne then
                ActivateInteriorEntitySet(ConfigIpls.clubHouseOneId, "meth_stash3")
            end
        end
        if ConfigIpls.clubhouse1Decorative1 then
            if ConfigIpls.clubHouseOne then
                ActivateInteriorEntitySet(ConfigIpls.clubHouseOneId, "decorative_01")
            end
        end
        if ConfigIpls.clubhouse1Decorative2 then
            if ConfigIpls.clubHouseOne then
                ActivateInteriorEntitySet(ConfigIpls.clubHouseOneId, "decorative_02")
            end
        end
        if ConfigIpls.clubhouse1Furnishings1 then
            if ConfigIpls.clubHouseOne then
                ActivateInteriorEntitySet(ConfigIpls.clubHouseOneId, "furnishings_01")
            end
        end
        if ConfigIpls.clubhouse1Furnishings2 then
            if ConfigIpls.clubHouseOne then
                ActivateInteriorEntitySet(ConfigIpls.clubHouseOneId, "furnishings_02")
            end
        end
        if ConfigIpls.clubhouse1Walls1 then
            if ConfigIpls.clubHouseOne then
                ActivateInteriorEntitySet(ConfigIpls.clubHouseOneId, "walls_01")
            end
        end
        if ConfigIpls.clubhouse1Walls2 then
            if ConfigIpls.clubHouseOne then
                ActivateInteriorEntitySet(ConfigIpls.clubHouseOneId, "walls_02")
            end
        end
        if ConfigIpls.clubhouse1Murals1 then
            if ConfigIpls.clubHouseOne then
                ActivateInteriorEntitySet(ConfigIpls.clubHouseOneId, "mural_01")
            end
        end
        if ConfigIpls.clubhouse1Murals2 then
            if ConfigIpls.clubHouseOne then
                ActivateInteriorEntitySet(ConfigIpls.clubHouseOneId, "mural_02")
            end
        end
        if ConfigIpls.clubhouse1Murals3 then
            if ConfigIpls.clubHouseOne then
                ActivateInteriorEntitySet(ConfigIpls.clubHouseOneId, "mural_03")
            end
        end
        if ConfigIpls.clubhouse1Murals4 then
            if ConfigIpls.clubHouseOne then
                ActivateInteriorEntitySet(ConfigIpls.clubHouseOneId, "mural_04")
            end
        end
        if ConfigIpls.clubhouse1Murals5 then
            if ConfigIpls.clubHouseOne then
                ActivateInteriorEntitySet(ConfigIpls.clubHouseOneId, "mural_05")
            end
        end
        if ConfigIpls.clubhouse1Murals6 then
            if ConfigIpls.clubHouseOne then
                ActivateInteriorEntitySet(ConfigIpls.clubHouseOneId, "mural_06")
            end
        end
        if ConfigIpls.clubhouse1Murals7 then
            if ConfigIpls.clubHouseOne then
                ActivateInteriorEntitySet(ConfigIpls.clubHouseOneId, "mural_07")
            end
        end
        if ConfigIpls.clubhouse1Murals8 then
            if ConfigIpls.clubHouseOne then
                ActivateInteriorEntitySet(ConfigIpls.clubHouseOneId, "mural_08")
            end
        end
        if ConfigIpls.clubhouse1Murals9 then
            if ConfigIpls.clubHouseOne then
                ActivateInteriorEntitySet(ConfigIpls.clubHouseOneId, "mural_09")
            end
        end
        if ConfigIpls.clubhouse1GunLocker then
            if ConfigIpls.clubHouseOne then
                ActivateInteriorEntitySet(ConfigIpls.clubHouseOneId, "gun_locker")
            end
        end
        if ConfigIpls.clubhouse1ModBooth then
            if ConfigIpls.clubHouseOne then
                ActivateInteriorEntitySet(ConfigIpls.clubHouseOneId, "mod_booth")
            end
        end
        if ConfigIpls.clubhouse1NoGunLocker then
            if ConfigIpls.clubHouseOne then
                ActivateInteriorEntitySet(ConfigIpls.clubHouseOneId, "no_gun_locker")
            end
        end
        if ConfigIpls.clubhouse1NoModBooth then
            if ConfigIpls.clubHouseOne then
                ActivateInteriorEntitySet(ConfigIpls.clubHouseOneId, "no_mod_booth")
            end
        end
			-- Clubhouse 2
		if ConfigIpls.clubhouse2CashLarge then
			if ConfigIpls.clubHouse2 then
				ActivateInteriorEntitySet(ConfigIpls.clubHoue2Id, "cash_large")
			end
		end
		if ConfigIpls.clubhouse2CashMedium then
			if ConfigIpls.clubHouse2 then
				ActivateInteriorEntitySet(ConfigIpls.clubHoue2Id, "cash_medium")
			end
		end
		if ConfigIpls.clubhouse2Cashsmall then
			if ConfigIpls.clubHouse2 then
				ActivateInteriorEntitySet(ConfigIpls.clubHoue2Id, "cash_small")
			end
		end
		if ConfigIpls.clubhouse2CokeLarge then
			if ConfigIpls.clubHouse2 then
				ActivateInteriorEntitySet(ConfigIpls.clubHoue2Id, "coke_large")
			end
		end
		if ConfigIpls.clubhouse2CokeMedium then
			if ConfigIpls.clubHouse2 then
				ActivateInteriorEntitySet(ConfigIpls.clubHoue2Id, "coke_medium")
			end
		end
		if ConfigIpls.clubhouse2CashSmall then
			if ConfigIpls.clubHouse2 then
				ActivateInteriorEntitySet(ConfigIpls.clubHoue2Id, "coke_small")
			end
		end
		if ConfigIpls.clubhouse2CounterfeitLarge then
			if ConfigIpls.clubHouse2 then
				ActivateInteriorEntitySet(ConfigIpls.clubHoue2Id, "counterfeit_large")
			end
		end
		if ConfigIpls.clubhouse2CounterfeitMedium then
			if ConfigIpls.clubHouse2 then
				ActivateInteriorEntitySet(ConfigIpls.clubHoue2Id, "counterfeit_medium")
			end
		end
		if ConfigIpls.clubhouse2CounterfeitSmall then
			if ConfigIpls.clubHouse2 then
				ActivateInteriorEntitySet(ConfigIpls.clubHoue2Id, "counterfeit_small")
			end
		end
		if ConfigIpls.clubhouse2IDLarge then
			if ConfigIpls.clubHouse2 then
				ActivateInteriorEntitySet(ConfigIpls.clubHoue2Id, "id_large")
			end
		end
		if ConfigIpls.clubhouse2IDMedium then
			if ConfigIpls.clubHouse2 then
				ActivateInteriorEntitySet(ConfigIpls.clubHoue2Id, "id_medium")
			end
		end
		if ConfigIpls.clubhouse2IDSmall then
			if ConfigIpls.clubHouse2 then
				ActivateInteriorEntitySet(ConfigIpls.clubHoue2Id, "id_small")
			end
		end
		if ConfigIpls.clubhouse2MethLarge then
			if ConfigIpls.clubHouse2 then
				ActivateInteriorEntitySet(ConfigIpls.clubHoue2Id, "meth_large")
			end
		end
		if ConfigIpls.clubhouse2MethMedium then
			if ConfigIpls.clubHouse2 then
				ActivateInteriorEntitySet(ConfigIpls.clubHoue2Id, "meth_medium")
			end
		end
		if ConfigIpls.clubhouse2MethSmall then
			if ConfigIpls.clubHouse2 then
				ActivateInteriorEntitySet(ConfigIpls.clubHoue2Id, "meth_small")
			end
		end
		if ConfigIpls.clubhouse2WeedLarge then
			if ConfigIpls.clubHouse2 then
				ActivateInteriorEntitySet(ConfigIpls.clubHoue2Id, "weed_large")
			end
		end
		if ConfigIpls.clubhouse2WeedMedium then
			if ConfigIpls.clubHouse2 then
				ActivateInteriorEntitySet(ConfigIpls.clubHoue2Id, "weed_medium")
			end
		end
		if ConfigIpls.clubhouse2WeedSmall then
			if ConfigIpls.clubHouse2 then
				ActivateInteriorEntitySet(ConfigIpls.clubHoue2Id, "weed_small")
			end
		end
		if ConfigIpls.clubhouse2Decorative1 then
			if ConfigIpls.clubHouse2 then
				ActivateInteriorEntitySet(ConfigIpls.clubHoue2Id, "decorative_01")
			end
		end
		if ConfigIpls.clubhouse2Decorative2 then
			if ConfigIpls.clubHouse2 then
				ActivateInteriorEntitySet(ConfigIpls.clubHoue2Id, "decorative_02")
			end
		end
		if ConfigIpls.clubhouse2Furnishings1 then
			if ConfigIpls.clubHouse2 then
				ActivateInteriorEntitySet(ConfigIpls.clubHoue2Id, "furnishings_01")
			end
		end
		if ConfigIpls.clubhouse2Furnishings2 then
			if ConfigIpls.clubHouse2 then
				ActivateInteriorEntitySet(ConfigIpls.clubHoue2Id, "furnishings_02")
			end
		end
		if ConfigIpls.clubhouse2Walls1 then
			if ConfigIpls.clubHouse2 then
				ActivateInteriorEntitySet(ConfigIpls.clubHoue2Id, "walls_01")
			end
		end
		if ConfigIpls.clubhouse2Walls2 then
			if ConfigIpls.clubHouse2 then
				ActivateInteriorEntitySet(ConfigIpls.clubHoue2Id, "walls_02")
			end
		end
		if ConfigIpls.clubhouse2LowerWallsDefault then
			if ConfigIpls.clubHouse2 then
				ActivateInteriorEntitySet(ConfigIpls.clubHoue2Id, "lower_walls_default")
			end
		end
		if ConfigIpls.clubhouse2GunLocker then
			if ConfigIpls.clubHouse2 then
				ActivateInteriorEntitySet(ConfigIpls.clubHoue2Id, "gun_locker")
			end
		end
		if ConfigIpls.clubhouse2ModBooth then
			if ConfigIpls.clubHouse2 then
				ActivateInteriorEntitySet(ConfigIpls.clubHoue2Id, "mod_booth")
			end
		end
		if ConfigIpls.clubhouse2NoGunLocker then
			if ConfigIpls.clubHouse2 then
				ActivateInteriorEntitySet(ConfigIpls.clubHoue2Id, "no_gun_locker")
			end
		end
		if ConfigIpls.clubhouse2NoModBooth then
			if ConfigIpls.clubHouse2 then
				ActivateInteriorEntitySet(ConfigIpls.clubHoue2Id, "no_mod_booth")
			end
		end
		-- Import/Export
		if ConfigIpls.importExportDecor1 then
    		if ConfigIpls.importExport then
        		ActivateInteriorEntitySet(ConfigIpls.importExportId, "garage_decor_01")
		    end
		end
		if ConfigIpls.importExportDecor2 then
    		if ConfigIpls.importExport then
        		ActivateInteriorEntitySet(ConfigIpls.importExportId, "garage_decor_02")
		    end
		end
		if ConfigIpls.importExportDecor3 then
    		if ConfigIpls.importExport then
        		ActivateInteriorEntitySet(ConfigIpls.importExportId, "garage_decor_03")
		    end
		end
		if ConfigIpls.importExportDecor4 then
    		if ConfigIpls.importExport then
        		ActivateInteriorEntitySet(ConfigIpls.importExportId, "garage_decor_04")
		    end
		end
		if ConfigIpls.importExportLightingOptions1 then
    		if ConfigIpls.importExport then
        		ActivateInteriorEntitySet(ConfigIpls.importExportId, "lighting_option01")
		    end
		end
		if ConfigIpls.importExportLightingOptions2 then
    		if ConfigIpls.importExport then
        		ActivateInteriorEntitySet(ConfigIpls.importExportId, "lighting_option02")
		    end
		end
		if ConfigIpls.importExportLightingOptions3 then
    		if ConfigIpls.importExport then
        		ActivateInteriorEntitySet(ConfigIpls.importExportId, "lighting_option03")
		    end
		end
		if ConfigIpls.importExportLightingOptions4 then
    		if ConfigIpls.importExport then
        		ActivateInteriorEntitySet(ConfigIpls.importExportId, "lighting_option04")
		    end
		end
		if ConfigIpls.importExportLightingOptions5 then
    		if ConfigIpls.importExport then
        		ActivateInteriorEntitySet(ConfigIpls.importExportId, "lighting_option05")
		    end
		end
		if ConfigIpls.importExportLightingOptions6 then
    		if ConfigIpls.importExport then
        		ActivateInteriorEntitySet(ConfigIpls.importExportId, "lighting_option06")
		    end
		end
		if ConfigIpls.importExportLightingOptions7 then
    		if ConfigIpls.importExport then
        		ActivateInteriorEntitySet(ConfigIpls.importExportId, "lighting_option07")
		    end
		end
		if ConfigIpls.importExportLightingOptions8 then
    		if ConfigIpls.importExport then
        		ActivateInteriorEntitySet(ConfigIpls.importExportId, "lighting_option08")
		    end
		end
		if ConfigIpls.importExportLightingOptions9 then
    		if ConfigIpls.importExport then
        		ActivateInteriorEntitySet(ConfigIpls.importExportId, "lighting_option09")
		    end
		end
		if ConfigIpls.importExportNumberStyle1N1 then
    		if ConfigIpls.importExport then
        		ActivateInteriorEntitySet(ConfigIpls.importExportId, "numbering_style01_n1")
		    end
		end
		if ConfigIpls.importExportNumberStyle1N2 then
    		if ConfigIpls.importExport then
        		ActivateInteriorEntitySet(ConfigIpls.importExportId, "numbering_style01_n2")
		    end
		end
		if ConfigIpls.importExportNumberStyle1N3 then
    		if ConfigIpls.importExport then
        		ActivateInteriorEntitySet(ConfigIpls.importExportId, "numbering_style01_n3")
		    end
		end
		if ConfigIpls.importExportNumberStyle2N1 then
    		if ConfigIpls.importExport then
        		ActivateInteriorEntitySet(ConfigIpls.importExportId, "numbering_style02_n1")
		    end
		end
		if ConfigIpls.importExportNumberStyle2N2 then
    		if ConfigIpls.importExport then
        		ActivateInteriorEntitySet(ConfigIpls.importExportId, "numbering_style02_n2")
		    end
		end
		if ConfigIpls.importExportNumberStyle2N3 then
    		if ConfigIpls.importExport then
        		ActivateInteriorEntitySet(ConfigIpls.importExportId, "numbering_style02_n3")
		    end
		end
		if ConfigIpls.importExportNumberStyle3N1 then
    		if ConfigIpls.importExport then
        		ActivateInteriorEntitySet(ConfigIpls.importExportId, "numbering_style03_n1")
		    end
		end
		if ConfigIpls.importExportNumberStyle3N2 then
    		if ConfigIpls.importExport then
        		ActivateInteriorEntitySet(ConfigIpls.importExportId, "numbering_style03_n2")
		    end
		end
		if ConfigIpls.importExportNumberStyle3N3 then
    		if ConfigIpls.importExport then
        		ActivateInteriorEntitySet(ConfigIpls.importExportId, "numbering_style03_n3")
		    end
		end
		if ConfigIpls.importExportNumberStyle4N1 then
    		if ConfigIpls.importExport then
        		ActivateInteriorEntitySet(ConfigIpls.importExportId, "numbering_style04_n1")
		    end
		end
		if ConfigIpls.importExportNumberStyle4N2 then
    		if ConfigIpls.importExport then
        		ActivateInteriorEntitySet(ConfigIpls.importExportId, "numbering_style04_n2")
		    end
		end
		if ConfigIpls.importExportNumberStyle4N3 then
    		if ConfigIpls.importExport then
        		ActivateInteriorEntitySet(ConfigIpls.importExportId, "numbering_style04_n3")
		    end
		end
		if ConfigIpls.importExportNumberStyle5N1 then
    		if ConfigIpls.importExport then
        		ActivateInteriorEntitySet(ConfigIpls.importExportId, "numbering_style05_n1")
		    end
		end
		if ConfigIpls.importExportNumberStyle5N2 then
    		if ConfigIpls.importExport then
        		ActivateInteriorEntitySet(ConfigIpls.importExportId, "numbering_style05_n2")
		    end
		end
		if ConfigIpls.importExportNumberStyle5N3 then
    		if ConfigIpls.importExport then
        		ActivateInteriorEntitySet(ConfigIpls.importExportId, "numbering_style05_n3")
		    end
		end
		if ConfigIpls.importExportNumberStyle6N1 then
    		if ConfigIpls.importExport then
        		ActivateInteriorEntitySet(ConfigIpls.importExportId, "numbering_style06_n1")
		    end
		end
		if ConfigIpls.importExportNumberStyle6N2 then
    		if ConfigIpls.importExport then
        		ActivateInteriorEntitySet(ConfigIpls.importExportId, "numbering_style06_n2")
		    end
		end
		if ConfigIpls.importExportNumberStyle6N3 then
    		if ConfigIpls.importExport then
        		ActivateInteriorEntitySet(ConfigIpls.importExportId, "numbering_style06_n3")
		    end
		end
		if ConfigIpls.importExportNumberStyle7N1 then
    		if ConfigIpls.importExport then
        		ActivateInteriorEntitySet(ConfigIpls.importExportId, "numbering_style07_n1")
		    end
		end
		if ConfigIpls.importExportNumberStyle7N2 then
    		if ConfigIpls.importExport then
        		ActivateInteriorEntitySet(ConfigIpls.importExportId, "numbering_style07_n2")
		    end
		end
		if ConfigIpls.importExportNumberStyle7N3 then
    		if ConfigIpls.importExport then
        		ActivateInteriorEntitySet(ConfigIpls.importExportId, "numbering_style07_n3")
		    end
		end
		if ConfigIpls.importExportNumberStyle8N1 then
    		if ConfigIpls.importExport then
        		ActivateInteriorEntitySet(ConfigIpls.importExportId, "numbering_style08_n1")
		    end
		end
		if ConfigIpls.importExportNumberStyle8N2 then
    		if ConfigIpls.importExport then
        		ActivateInteriorEntitySet(ConfigIpls.importExportId, "numbering_style08_n2")
		    end
		end
		if ConfigIpls.importExportNumberStyle8N3 then
    		if ConfigIpls.importExport then
        		ActivateInteriorEntitySet(ConfigIpls.importExportId, "numbering_style08_n3")
		    end
		end
		if ConfigIpls.importExportNumberStyle9N1 then
    		if ConfigIpls.importExport then
        		ActivateInteriorEntitySet(ConfigIpls.importExportId, "numbering_style09_n1")
		    end
		end
		if ConfigIpls.importExportNumberStyle9N2 then
    		if ConfigIpls.importExport then
        		ActivateInteriorEntitySet(ConfigIpls.importExportId, "numbering_style09_n2")
		    end
		end
		if ConfigIpls.importExportNumberStyle9N3 then
    		if ConfigIpls.importExport then
        		ActivateInteriorEntitySet(ConfigIpls.importExportId, "numbering_style09_n3")
		    end
		end
		if ConfigIpls.importExportFloorVinyl1 then
    		if ConfigIpls.importExport then
        		ActivateInteriorEntitySet(ConfigIpls.importExportId, "floor_vinyl_01")
		    end
		end
		if ConfigIpls.importExportFloorVinyl2 then
    		if ConfigIpls.importExport then
        		ActivateInteriorEntitySet(ConfigIpls.importExportId, "floor_vinyl_02")
		    end
		end
		if ConfigIpls.importExportFloorVinyl3 then
    		if ConfigIpls.importExport then
        		ActivateInteriorEntitySet(ConfigIpls.importExportId, "floor_vinyl_03")
		    end
		end
		if ConfigIpls.importExportFloorVinyl4 then
    		if ConfigIpls.importExport then
        		ActivateInteriorEntitySet(ConfigIpls.importExportId, "floor_vinyl_04")
		    end
		end
		if ConfigIpls.importExportFloorVinyl5 then
    		if ConfigIpls.importExport then
        		ActivateInteriorEntitySet(ConfigIpls.importExportId, "floor_vinyl_05")
		    end
		end
		if ConfigIpls.importExportFloorVinyl6 then
    		if ConfigIpls.importExport then
        		ActivateInteriorEntitySet(ConfigIpls.importExportId, "floor_vinyl_06")
		    end
		end
		if ConfigIpls.importExportFloorVinyl7 then
    		if ConfigIpls.importExport then
        		ActivateInteriorEntitySet(ConfigIpls.importExportId, "floor_vinyl_07")
		    end
		end
		if ConfigIpls.importExportFloorVinyl8 then
    		if ConfigIpls.importExport then
        		ActivateInteriorEntitySet(ConfigIpls.importExportId, "floor_vinyl_08")
		    end
		end
		if ConfigIpls.importExportFloorVinyl9 then
    		if ConfigIpls.importExport then
        		ActivateInteriorEntitySet(ConfigIpls.importExportId, "floor_vinyl_09")
		    end
		end
		if ConfigIpls.importExportFloorVinyl10 then
    		if ConfigIpls.importExport then
        		ActivateInteriorEntitySet(ConfigIpls.importExportId, "floor_vinyl_10")
		    end
		end
		if ConfigIpls.importExportFloorVinyl11 then
    		if ConfigIpls.importExport then
        		ActivateInteriorEntitySet(ConfigIpls.importExportId, "floor_vinyl_11")
		    end
		end
		if ConfigIpls.importExportFloorVinyl12 then
    		if ConfigIpls.importExport then
        		ActivateInteriorEntitySet(ConfigIpls.importExportId, "floor_vinyl_12")
		    end
		end
		if ConfigIpls.importExportFloorVinyl13 then
    		if ConfigIpls.importExport then
        		ActivateInteriorEntitySet(ConfigIpls.importExportId, "floor_vinyl_13")
		    end
		end
		if ConfigIpls.importExportFloorVinyl14 then
    		if ConfigIpls.importExport then
        		ActivateInteriorEntitySet(ConfigIpls.importExportId, "floor_vinyl_14")
		    end
		end
		if ConfigIpls.importExportFloorVinyl15 then
    		if ConfigIpls.importExport then
        		ActivateInteriorEntitySet(ConfigIpls.importExportId, "floor_vinyl_15")
		    end
		end
		if ConfigIpls.importExportFloorVinyl16 then
    		if ConfigIpls.importExport then
        		ActivateInteriorEntitySet(ConfigIpls.importExportId, "floor_vinyl_16")
		    end
		end
		if ConfigIpls.importExportFloorVinyl17 then
    		if ConfigIpls.importExport then
        		ActivateInteriorEntitySet(ConfigIpls.importExportId, "floor_vinyl_17")
		    end
		end
		if ConfigIpls.importExportFloorVinyl18 then
    		if ConfigIpls.importExport then
        		ActivateInteriorEntitySet(ConfigIpls.importExportId, "floor_vinyl_18")
		    end
		end
		if ConfigIpls.importExportFloorVinyl19 then
    		if ConfigIpls.importExport then
        		ActivateInteriorEntitySet(ConfigIpls.importExportId, "floor_vinyl_19")
		    end
		end
		if ConfigIpls.importExportBasicStyleSet then
    		if ConfigIpls.importExport then
        		ActivateInteriorEntitySet(ConfigIpls.importExportId, "basic_style_set")
		    end
		end
		if ConfigIpls.importExportBrandedStyleSet then
    		if ConfigIpls.importExport then
        		ActivateInteriorEntitySet(ConfigIpls.importExportId, "branded_style_set")
		    end
		end
		if ConfigIpls.importExportUrbanStyleSet then
    		if ConfigIpls.importExport then
        		ActivateInteriorEntitySet(ConfigIpls.importExportId, "urban_style_set")
		    end
		end
		if ConfigIpls.importExportCarFloorHatch then
    		if ConfigIpls.importExport then
        		ActivateInteriorEntitySet(ConfigIpls.importExportId, "car_floor_hatch")
		    end
		end
		if ConfigIpls.importExportDoorBlocker then
    		if ConfigIpls.importExport then
        		ActivateInteriorEntitySet(ConfigIpls.importExportId, "door_blocker")
			end
		end
		-- CEO Offices

		if ConfigIpls.ceoOffices then

			arcadiusId     = {}
			mazeBankId     = {}
			mazeBankWestId = {}
			lomBankId      = {}
		
			if ConfigIpls.arcadiusOldSpiceWarm then
				arcadiusId = ConfigIpls.arcadiusOldSpiceWarmId
			elseif ConfigIpls.arcadiusOldSpiceVintage then
				arcadiusId = ConfigIpls.arcadiusOldSpiceVintageId
			elseif ConfigIpls.arcadiusOldSpiceClassical then
				arcadiusId = ConfigIpls.arcadiusOldSpiceClassicalId
			elseif ConfigIpls.arcadiusExecutiveContrast then
				arcadiusId = ConfigIpls.arcadiusExecutiveContrastId
			elseif ConfigIpls.arcadiusExecutiveRich then
				arcadiusId = ConfigIpls.arcadiusExecutiveRichId
			elseif ConfigIpls.arcadiusExecutiveCool then
				arcadiusId = ConfigIpls.arcadiusExecutiveCoolId
			elseif ConfigIpls.arcadiusPowerBrokerIce then
				arcadiusId = ConfigIpls.arcadiusPowerBrokerIceId
			elseif ConfigIpls.arcadiusPowerBrokerConservative then
				arcadiusId = ConfigIpls.arcadiusPowerBrokerConservativeId
			elseif ConfigIpls.arcadiusPowerBrokerPolished then
				arcadiusId = ConfigIpls.arcadiusPowerBrokerPolishedId
				if ConfigIpls.ceoCashSet1 then
					ActivateInteriorEntitySet(ConfigIpls.arcadiusId, "cash_set_01")
				end
				if ConfigIpls.ceoCashSet2 then
					ActivateInteriorEntitySet(ConfigIpls.arcadiusId, "cash_set_02")
				end
				if ConfigIpls.ceoCashSet3 then
					ActivateInteriorEntitySet(ConfigIpls.arcadiusId, "cash_set_03")
				end
				if ConfigIpls.ceoCashSet4 then
					ActivateInteriorEntitySet(ConfigIpls.arcadiusId, "cash_set_04")
				end
				if ConfigIpls.ceoCashSet5 then
					ActivateInteriorEntitySet(ConfigIpls.arcadiusId, "cash_set_05")
				end
				if ConfigIpls.ceoCashSet6 then
					ActivateInteriorEntitySet(ConfigIpls.arcadiusId, "cash_set_06")
				end
				if ConfigIpls.ceoCashSet7 then
					ActivateInteriorEntitySet(ConfigIpls.arcadiusId, "cash_set_07")
				end
				if ConfigIpls.ceoCashSet8 then
					ActivateInteriorEntitySet(ConfigIpls.arcadiusId, "cash_set_08")
				end
				if ConfigIpls.ceoCashSet9 then
					ActivateInteriorEntitySet(ConfigIpls.arcadiusId, "cash_set_09")
				end
				if ConfigIpls.ceoCashSet10 then
					ActivateInteriorEntitySet(ConfigIpls.arcadiusId, "cash_set_10")
				end
				if ConfigIpls.ceoCashSet11 then
					ActivateInteriorEntitySet(ConfigIpls.arcadiusId, "cash_set_11")
				end
				if ConfigIpls.ceoCashSet12 then
					ActivateInteriorEntitySet(ConfigIpls.arcadiusId, "cash_set_12")
				end
				if ConfigIpls.ceoCashSet13 then
					ActivateInteriorEntitySet(ConfigIpls.arcadiusId, "cash_set_13")
				end
				if ConfigIpls.ceoCashSet14 then
					ActivateInteriorEntitySet(ConfigIpls.arcadiusId, "cash_set_14")
				end
				if ConfigIpls.ceoCashSet15 then
					ActivateInteriorEntitySet(ConfigIpls.arcadiusId, "cash_set_15")
				end
				if ConfigIpls.ceoCashSet16 then
					ActivateInteriorEntitySet(ConfigIpls.arcadiusId, "cash_set_16")
				end
				if ConfigIpls.ceoCashSet17 then
					ActivateInteriorEntitySet(ConfigIpls.arcadiusId, "cash_set_17")
				end
				if ConfigIpls.ceoCashSet18 then
					ActivateInteriorEntitySet(ConfigIpls.arcadiusId, "cash_set_18")
				end
				if ConfigIpls.ceoCashSet19 then
					ActivateInteriorEntitySet(ConfigIpls.arcadiusId, "cash_set_19")
				end
				if ConfigIpls.ceoCashSet20 then
					ActivateInteriorEntitySet(ConfigIpls.arcadiusId, "cash_set_20")
				end
				if ConfigIpls.ceoCashSet21 then
					ActivateInteriorEntitySet(ConfigIpls.arcadiusId, "cash_set_21")
				end
				if ConfigIpls.ceoCashSet22 then
					ActivateInteriorEntitySet(ConfigIpls.arcadiusId, "cash_set_22")
				end
				if ConfigIpls.ceoCashSet23 then
					ActivateInteriorEntitySet(ConfigIpls.arcadiusId, "cash_set_23")
				end
				if ConfigIpls.ceoCashSet24 then
					ActivateInteriorEntitySet(ConfigIpls.arcadiusId, "cash_set_24")
				end
				if ConfigIpls.ceoOfficeBooze then
					ActivateInteriorEntitySet(ConfigIpls.arcadiusId, "office_booze")
				end
				if ConfigIpls.ceoOfficeChairs then
					ActivateInteriorEntitySet(ConfigIpls.arcadiusId, "office_chairs")
				end
				if ConfigIpls.ceoSwagArt1 then
					ActivateInteriorEntitySet(ConfigIpls.arcadiusId, "swag_art")
				end
				if ConfigIpls.ceoSwagArt2 then
					ActivateInteriorEntitySet(ConfigIpls.arcadiusId, "swag_art2")
				end
				if ConfigIpls.ceoSwagArt3 then
					ActivateInteriorEntitySet(ConfigIpls.arcadiusId, "swag_art3")
				end
				if ConfigIpls.ceoBoozeCigs then
					ActivateInteriorEntitySet(ConfigIpls.arcadiusId, "swag_booze_cigs")
				end
				if ConfigIpls.ceoBoozeCigs2 then
					ActivateInteriorEntitySet(ConfigIpls.arcadiusId, "swag_booze_cigs2")
				end
				if ConfigIpls.ceoBoozeCigs3 then
					ActivateInteriorEntitySet(ConfigIpls.arcadiusId, "swag_booze_cigs3")
				end
				if ConfigIpls.ceoSwagCounterfeit then
					ActivateInteriorEntitySet(ConfigIpls.arcadiusId, "swag_counterfeit")
				end
				if ConfigIpls.ceoSwagCounterfeit2 then
					ActivateInteriorEntitySet(ConfigIpls.arcadiusId, "swag_counterfeit2")
				end
				if ConfigIpls.ceoSwagCounterfeit3 then
					ActivateInteriorEntitySet(ConfigIpls.arcadiusId, "swag_counterfeit3")
				end
				if ConfigIpls.ceoSwagDrugBags then
					ActivateInteriorEntitySet(ConfigIpls.arcadiusId, "swag_drugbags")
				end
				if ConfigIpls.ceoSwagDrugBags2 then
					ActivateInteriorEntitySet(ConfigIpls.arcadiusId, "swag_drugbags2")
				end
				if ConfigIpls.ceoSwagDrugBags3 then
					ActivateInteriorEntitySet(ConfigIpls.arcadiusId, "swag_drugbags3")
				end
				if ConfigIpls.ceoDrugStatue then
					ActivateInteriorEntitySet(ConfigIpls.arcadiusId, "swag_drugstatue")
				end
				if ConfigIpls.ceoDrugStatue2 then
					ActivateInteriorEntitySet(ConfigIpls.arcadiusId, "swag_drugstatue2")
				end
				if ConfigIpls.ceoDrugStatue3 then
					ActivateInteriorEntitySet(ConfigIpls.arcadiusId, "swag_drugstatue3")
				end
				if ConfigIpls.ceoElectronic then
					ActivateInteriorEntitySet(ConfigIpls.arcadiusId, "swag_electronic")
				end
				if ConfigIpls.ceoElectronic2 then
					ActivateInteriorEntitySet(ConfigIpls.arcadiusId, "swag_electronic2")
				end
				if ConfigIpls.ceoElectronic3 then
					ActivateInteriorEntitySet(ConfigIpls.arcadiusId, "swag_electronic3")
				end
				if ConfigIpls.ceoFurCoats then
					ActivateInteriorEntitySet(ConfigIpls.arcadiusId, "swag_furcoats")
				end	
				if ConfigIpls.ceoFurCoats2 then
					ActivateInteriorEntitySet(ConfigIpls.arcadiusId, "swag_furcoats2")
				end
				if ConfigIpls.ceoFurCoats3 then
					ActivateInteriorEntitySet(ConfigIpls.arcadiusId, "swag_furcoats3")
				end
				if ConfigIpls.ceoSwagGems then
					ActivateInteriorEntitySet(ConfigIpls.arcadiusId, "swag_gems")
				end
				if ConfigIpls.ceoSwagGems2 then
					ActivateInteriorEntitySet(ConfigIpls.arcadiusId, "swag_gems2")
				end
				if ConfigIpls.ceoSwagGems3 then
					ActivateInteriorEntitySet(ConfigIpls.arcadiusId, "swag_gems3")
				end
				if ConfigIpls.ceoSwagGuns then
					ActivateInteriorEntitySet(ConfigIpls.arcadiusId, "swag_guns")
				end
				if ConfigIpls.ceoSwagGuns2 then
					ActivateInteriorEntitySet(ConfigIpls.arcadiusId, "swag_guns2")
				end
				if ConfigIpls.ceoSwagGuns3 then
					ActivateInteriorEntitySet(ConfigIpls.arcadiusId, "swag_guns3")
				end
				if ConfigIpls.ceoSwagIvory then
					ActivateInteriorEntitySet(ConfigIpls.arcadiusId, "swag_ivory")
				end
				if ConfigIpls.ceoSwagIvory2 then
					ActivateInteriorEntitySet(ConfigIpls.arcadiusId, "swag_ivory2")
				end
				if ConfigIpls.ceoSwagIvory3 then
					ActivateInteriorEntitySet(ConfigIpls.arcadiusId, "swag_ivory3")
				end
				if ConfigIpls.ceoSwagJewelWatch then
					ActivateInteriorEntitySet(ConfigIpls.arcadiusId, "swag_jewelwatch")
				end
				if ConfigIpls.ceoSwagJewelWatch2 then
					ActivateInteriorEntitySet(ConfigIpls.arcadiusId, "swag_jewelwatch2")
				end
				if ConfigIpls.ceoSwagJewelWatch3 then
					ActivateInteriorEntitySet(ConfigIpls.arcadiusId, "swag_jewelwatch3")
				end
				if ConfigIpls.ceoSwagMed then
					ActivateInteriorEntitySet(ConfigIpls.arcadiusId, "swag_med")
				end
				if ConfigIpls.ceoSwagMed2 then
					ActivateInteriorEntitySet(ConfigIpls.arcadiusId, "swag_med2")
				end
				if ConfigIpls.ceoSwagMed3 then
					ActivateInteriorEntitySet(ConfigIpls.arcadiusId, "swag_med3")
				end
				if ConfigIpls.ceoSwagPills then
					ActivateInteriorEntitySet(ConfigIpls.arcadiusId, "swag_pills")
				end
				if ConfigIpls.ceoSwagPills2 then
					ActivateInteriorEntitySet(ConfigIpls.arcadiusId, "swag_pills2")
				end
				if ConfigIpls.ceoSwagPills3 then
					ActivateInteriorEntitySet(ConfigIpls.arcadiusId, "swag_pills3")
				end
				if ConfigIpls.ceoSwagSilver then
					ActivateInteriorEntitySet(ConfigIpls.arcadiusId, "swag_silver")
				end
				if ConfigIpls.ceoSwagSilver2 then
					ActivateInteriorEntitySet(ConfigIpls.arcadiusId, "swag_silver2")
				end
				if ConfigIpls.ceoSwagSilver3 then
					ActivateInteriorEntitySet(ConfigIpls.arcadiusId, "swag_silver3")
				end
			end
			if ConfigIpls.mazeBankOldSpiceWarm then
				mazeBankId = ConfigIpls.mazeBankOldSpiceWarmId
			elseif ConfigIpls.mazeBankOldSpiceVintage then
				mazeBankId = ConfigIpls.mazeBankOldSpiceVintageId
			elseif ConfigIpls.mazeBankOldSpiceClassical then
				mazeBankId = ConfigIpls.mazeBankOldSpiceClassicalId
			elseif ConfigIpls.mazeBankExecutiveContrast then
				mazeBankId = ConfigIpls.mazeBankExecutiveContrastId
			elseif ConfigIpls.mazeBankExecutiveRich then
				mazeBankId = ConfigIpls.mazeBankExecutiveRichId
			elseif ConfigIpls.mazeBankExecutiveCool then
				mazeBankId = ConfigIpls.mazeBankExecutiveCoolId
			elseif ConfigIpls.mazeBankPowerBrokerIce then
				mazeBankId = ConfigIpls.mazeBankPowerBrokerIceId
			elseif ConfigIpls.mazeBankPowerBrokerConservative then
				mazeBankId = ConfigIpls.mazeBankPowerBrokerConservativeId
			elseif ConfigIpls.mazeBankPowerBrokerPolished then
				mazeBankId = ConfigIpls.mazeBankPowerBrokerPolishedId
				if ConfigIpls.ceoCashSet1 then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankId, "cash_set_01")
				end
				if ConfigIpls.ceoCashSet2 then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankId, "cash_set_02")
				end
				if ConfigIpls.ceoCashSet3 then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankId, "cash_set_03")
				end
				if ConfigIpls.ceoCashSet4 then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankId, "cash_set_04")
				end
				if ConfigIpls.ceoCashSet5 then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankId, "cash_set_05")
				end
				if ConfigIpls.ceoCashSet6 then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankId, "cash_set_06")
				end
				if ConfigIpls.ceoCashSet7 then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankId, "cash_set_07")
				end
				if ConfigIpls.ceoCashSet8 then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankId, "cash_set_08")
				end
				if ConfigIpls.ceoCashSet9 then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankId, "cash_set_09")
				end
				if ConfigIpls.ceoCashSet10 then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankId, "cash_set_10")
				end
				if ConfigIpls.ceoCashSet11 then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankId, "cash_set_11")
				end
				if ConfigIpls.ceoCashSet12 then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankId, "cash_set_12")
				end
				if ConfigIpls.ceoCashSet13 then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankId, "cash_set_13")
				end
				if ConfigIpls.ceoCashSet14 then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankId, "cash_set_14")
				end
				if ConfigIpls.ceoCashSet15 then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankId, "cash_set_15")
				end
				if ConfigIpls.ceoCashSet16 then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankId, "cash_set_16")
				end
				if ConfigIpls.ceoCashSet17 then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankId, "cash_set_17")
				end
				if ConfigIpls.ceoCashSet18 then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankId, "cash_set_18")
				end
				if ConfigIpls.ceoCashSet19 then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankId, "cash_set_19")
				end
				if ConfigIpls.ceoCashSet20 then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankId, "cash_set_20")
				end
				if ConfigIpls.ceoCashSet21 then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankId, "cash_set_21")
				end
				if ConfigIpls.ceoCashSet22 then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankId, "cash_set_22")
				end
				if ConfigIpls.ceoCashSet23 then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankId, "cash_set_23")
				end
				if ConfigIpls.ceoCashSet24 then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankId, "cash_set_24")
				end
				if ConfigIpls.ceoOfficeBooze then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankId, "office_booze")
				end
				if ConfigIpls.ceoOfficeChairs then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankId, "office_chairs")
				end
				if ConfigIpls.ceoSwagArt1 then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankId, "swag_art")
				end
				if ConfigIpls.ceoSwagArt2 then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankId, "swag_art2")
				end
				if ConfigIpls.ceoSwagArt3 then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankId, "swag_art3")
				end
				if ConfigIpls.ceoBoozeCigs then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankId, "swag_booze_cigs")
				end
				if ConfigIpls.ceoBoozeCigs2 then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankId, "swag_booze_cigs2")
				end
				if ConfigIpls.ceoBoozeCigs3 then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankId, "swag_booze_cigs3")
				end
				if ConfigIpls.ceoSwagCounterfeit then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankId, "swag_counterfeit")
				end
				if ConfigIpls.ceoSwagCounterfeit2 then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankId, "swag_counterfeit2")
				end
				if ConfigIpls.ceoSwagCounterfeit3 then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankId, "swag_counterfeit3")
				end
				if ConfigIpls.ceoSwagDrugBags then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankId, "swag_drugbags")
				end
				if ConfigIpls.ceoSwagDrugBags2 then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankId, "swag_drugbags2")
				end
				if ConfigIpls.ceoSwagDrugBags3 then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankId, "swag_drugbags3")
				end
				if ConfigIpls.ceoDrugStatue then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankId, "swag_drugstatue")
				end
				if ConfigIpls.ceoDrugStatue2 then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankId, "swag_drugstatue2")
				end
				if ConfigIpls.ceoDrugStatue3 then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankId, "swag_drugstatue3")
				end
				if ConfigIpls.ceoElectronic then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankId, "swag_electronic")
				end
				if ConfigIpls.ceoElectronic2 then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankId, "swag_electronic2")
				end
				if ConfigIpls.ceoElectronic3 then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankId, "swag_electronic3")
				end
				if ConfigIpls.ceoFurCoats then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankId, "swag_furcoats")
				end	
				if ConfigIpls.ceoFurCoats2 then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankId, "swag_furcoats2")
				end
				if ConfigIpls.ceoFurCoats3 then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankId, "swag_furcoats3")
				end
				if ConfigIpls.ceoSwagGems then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankId, "swag_gems")
				end
				if ConfigIpls.ceoSwagGems2 then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankId, "swag_gems2")
				end
				if ConfigIpls.ceoSwagGems3 then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankId, "swag_gems3")
				end
				if ConfigIpls.ceoSwagGuns then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankId, "swag_guns")
				end
				if ConfigIpls.ceoSwagGuns2 then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankId, "swag_guns2")
				end
				if ConfigIpls.ceoSwagGuns3 then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankId, "swag_guns3")
				end
				if ConfigIpls.ceoSwagIvory then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankId, "swag_ivory")
				end
				if ConfigIpls.ceoSwagIvory2 then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankId, "swag_ivory2")
				end
				if ConfigIpls.ceoSwagIvory3 then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankId, "swag_ivory3")
				end
				if ConfigIpls.ceoSwagJewelWatch then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankId, "swag_jewelwatch")
				end
				if ConfigIpls.ceoSwagJewelWatch2 then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankId, "swag_jewelwatch2")
				end
				if ConfigIpls.ceoSwagJewelWatch3 then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankId, "swag_jewelwatch3")
				end
				if ConfigIpls.ceoSwagMed then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankId, "swag_med")
				end
				if ConfigIpls.ceoSwagMed2 then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankId, "swag_med2")
				end
				if ConfigIpls.ceoSwagMed3 then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankId, "swag_med3")
				end
				if ConfigIpls.ceoSwagPills then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankId, "swag_pills")
				end
				if ConfigIpls.ceoSwagPills2 then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankId, "swag_pills2")
				end
				if ConfigIpls.ceoSwagPills3 then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankId, "swag_pills3")
				end
				if ConfigIpls.ceoSwagSilver then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankId, "swag_silver")
				end
				if ConfigIpls.ceoSwagSilver2 then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankId, "swag_silver2")
				end
				if ConfigIpls.ceoSwagSilver3 then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankId, "swag_silver3")
				end
			end
			if ConfigIpls.mazeBankWestOldSpiceWarm then
				mazeBankWestId = ConfigIpls.mazeBankWestOldSpiceWarmId
			elseif ConfigIpls.mazeBankWestOldSpiceVintage then
				mazeBankWestId = ConfigIpls.mazeBankWestOldSpiceVintageId
			elseif ConfigIpls.mazeBankWestOldSpiceClassical then
				mazeBankWestId = ConfigIpls.mazeBankWestOldSpiceClassicalId
			elseif ConfigIpls.mazeBankWestExecutiveContrast then
				mazeBankWestId = ConfigIpls.mazeBankWestExecutiveContrastId
			elseif ConfigIpls.mazeBankWestExecutiveRich then
				mazeBankWestId = ConfigIpls.mazeBankWestExecutiveRichId
			elseif ConfigIpls.mazeBankWestExecutiveCool then
				mazeBankWestId = ConfigIpls.mazeBankWestExecutiveCoolId
			elseif ConfigIpls.mazeBankWestPowerBrokerIce then
				mazeBankWestId = ConfigIpls.mazeBankWestPowerBrokerIceId
			elseif ConfigIpls.mazeBankWestPowerBrokerConservative then
				mazeBankWestId = ConfigIpls.mazeBankWestPowerBrokerConservativeId
			elseif ConfigIpls.mazeBankWestPowerBrokerPolished then
				mazeBankWestId = ConfigIpls.mazeBankWestPowerBrokerPolishedId
				if ConfigIpls.ceoCashSet1 then
						ActivateInteriorEntitySet(ConfigIpls.mazeBankWestId, "cash_set_01")
				   end
				if ConfigIpls.ceoCashSet2 then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankWestId, "cash_set_02")
				end
				if ConfigIpls.ceoCashSet3 then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankWestId, "cash_set_03")
				end
				if ConfigIpls.ceoCashSet4 then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankWestId, "cash_set_04")
				end
				if ConfigIpls.ceoCashSet5 then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankWestId, "cash_set_05")
				end
				if ConfigIpls.ceoCashSet6 then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankWestId, "cash_set_06")
				end
				if ConfigIpls.ceoCashSet7 then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankWestId, "cash_set_07")
				end
				if ConfigIpls.ceoCashSet8 then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankWestId, "cash_set_08")
				end
				if ConfigIpls.ceoCashSet9 then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankWestId, "cash_set_09")
				end
				if ConfigIpls.ceoCashSet10 then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankWestId, "cash_set_10")
				end
				if ConfigIpls.ceoCashSet11 then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankWestId, "cash_set_11")
				end
				if ConfigIpls.ceoCashSet12 then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankWestId, "cash_set_12")
				end
				if ConfigIpls.ceoCashSet13 then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankWestId, "cash_set_13")
				end
				if ConfigIpls.ceoCashSet14 then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankWestId, "cash_set_14")
				end
				if ConfigIpls.ceoCashSet15 then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankWestId, "cash_set_15")
				end
				if ConfigIpls.ceoCashSet16 then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankWestId, "cash_set_16")
				end
				if ConfigIpls.ceoCashSet17 then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankWestId, "cash_set_17")
				end
				if ConfigIpls.ceoCashSet18 then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankWestId, "cash_set_18")
				end
				if ConfigIpls.ceoCashSet19 then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankWestId, "cash_set_19")
				end
				if ConfigIpls.ceoCashSet20 then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankWestId, "cash_set_20")
				end
				if ConfigIpls.ceoCashSet21 then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankWestId, "cash_set_21")
				end
				if ConfigIpls.ceoCashSet22 then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankWestId, "cash_set_22")
				end
				if ConfigIpls.ceoCashSet23 then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankWestId, "cash_set_23")
				end
				if ConfigIpls.ceoCashSet24 then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankWestId, "cash_set_24")
				end
				if ConfigIpls.ceoOfficeBooze then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankWestId, "office_booze")
				end
				if ConfigIpls.ceoOfficeChairs then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankWestId, "office_chairs")
				end
				if ConfigIpls.ceoSwagArt1 then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankWestId, "swag_art")
				end	
				if ConfigIpls.ceoSwagArt2 then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankWestId, "swag_art2")
				end
				if ConfigIpls.ceoSwagArt3 then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankWestId, "swag_art3")
				end
				if ConfigIpls.ceoBoozeCigs then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankWestId, "swag_booze_cigs")
				end
				if ConfigIpls.ceoBoozeCigs2 then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankWestId, "swag_booze_cigs2")
				end
				if ConfigIpls.ceoBoozeCigs3 then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankWestId, "swag_booze_cigs3")
				end
				if ConfigIpls.ceoSwagCounterfeit then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankWestId, "swag_counterfeit")
				end
				if ConfigIpls.ceoSwagCounterfeit2 then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankWestId, "swag_counterfeit2")
				end
				if ConfigIpls.ceoSwagCounterfeit3 then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankWestId, "swag_counterfeit3")
				end
				if ConfigIpls.ceoSwagDrugBags then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankWestId, "swag_drugbags")
				end
				if ConfigIpls.ceoSwagDrugBags2 then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankWestId, "swag_drugbags2")
				end
				if ConfigIpls.ceoSwagDrugBags3 then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankWestId, "swag_drugbags3")
				end
				if ConfigIpls.ceoDrugStatue then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankWestId, "swag_drugstatue")
				end
				if ConfigIpls.ceoDrugStatue2 then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankWestId, "swag_drugstatue2")
				end
				if ConfigIpls.ceoDrugStatue3 then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankWestId, "swag_drugstatue3")
				end
				if ConfigIpls.ceoElectronic then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankWestId, "swag_electronic")
				end
				if ConfigIpls.ceoElectronic2 then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankWestId, "swag_electronic2")
				end
				if ConfigIpls.ceoElectronic3 then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankWestId, "swag_electronic3")
				end
				if ConfigIpls.ceoFurCoats then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankWestId, "swag_furcoats")
				end	
				if ConfigIpls.ceoFurCoats2 then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankWestId, "swag_furcoats2")
				end
				if ConfigIpls.ceoFurCoats3 then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankWestId, "swag_furcoats3")
				end
				if ConfigIpls.ceoSwagGems then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankWestId, "swag_gems")
				end
				if ConfigIpls.ceoSwagGems2 then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankWestId, "swag_gems2")
				end
				if ConfigIpls.ceoSwagGems3 then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankWestId, "swag_gems3")
				end
				if ConfigIpls.ceoSwagGuns then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankWestId, "swag_guns")
				end
				if ConfigIpls.ceoSwagGuns2 then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankWestId, "swag_guns2")
				end
				if ConfigIpls.ceoSwagGuns3 then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankWestId, "swag_guns3")
				end
				if ConfigIpls.ceoSwagIvory then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankWestId, "swag_ivory")
				end
				if ConfigIpls.ceoSwagIvory2 then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankWestId, "swag_ivory2")
				end
				if ConfigIpls.ceoSwagIvory3 then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankWestId, "swag_ivory3")
				end
				if ConfigIpls.ceoSwagJewelWatch then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankWestId, "swag_jewelwatch")
				end
				if ConfigIpls.ceoSwagJewelWatch2 then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankWestId, "swag_jewelwatch2")
				end
				if ConfigIpls.ceoSwagJewelWatch3 then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankWestId, "swag_jewelwatch3")
				end
				if ConfigIpls.ceoSwagMed then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankWestId, "swag_med")
				end
				if ConfigIpls.ceoSwagMed2 then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankWestId, "swag_med2")
				end
				if ConfigIpls.ceoSwagMed3 then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankWestId, "swag_med3")
				end
				if ConfigIpls.ceoSwagPills then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankWestId, "swag_pills")
				end
				if ConfigIpls.ceoSwagPills2 then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankWestId, "swag_pills2")
				end
				if ConfigIpls.ceoSwagPills3 then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankWestId, "swag_pills3")
				end
				if ConfigIpls.ceoSwagSilver then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankWestId, "swag_silver")
				end
				if ConfigIpls.ceoSwagSilver2 then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankWestId, "swag_silver2")
				end
				if ConfigIpls.ceoSwagSilver3 then
					ActivateInteriorEntitySet(ConfigIpls.mazeBankWestId, "swag_silver3")
				end
			end
			if ConfigIpls.lomBankOldSpiceWarm then
				lomBankId = ConfigIpls.lomBankOldSpiceWarmId
			elseif ConfigIpls.lomBankOldSpiceVintage then
				lomBankId = ConfigIpls.lomBankOldSpiceVintageId
			elseif ConfigIpls.lomBankOldSpiceClassical then
				lomBankId = ConfigIpls.lomBankOldSpiceClassicalId
			elseif ConfigIpls.lomBankExecutiveContrast then
				lomBankId = ConfigIpls.lomBankExecutiveContrastId
			elseif ConfigIpls.lomBankExecutiveRich then
				lomBankId = ConfigIpls.lomBankExecutiveRichId
			elseif ConfigIpls.lomBankExecutiveCool then
				lomBankId = ConfigIpls.lomBankExecutiveCoolId
			elseif ConfigIpls.lomBankPowerBrokerIce then
				lomBankId = ConfigIpls.lomBankPowerBrokerIceId
			elseif ConfigIpls.lomBankPowerBrokerConservative then
				lomBankId = ConfigIpls.lomBankPowerBrokerConservativeId
			elseif ConfigIpls.lomBankPowerBrokerPolished then
				lomBankId = ConfigIpls.lomBankPowerBrokerPolishedId
				if ConfigIpls.ceoCashSet1 then
					ActivateInteriorEntitySet(ConfigIpls.lomBankId, "cash_set_01")
				end
				if ConfigIpls.ceoCashSet2 then
					ActivateInteriorEntitySet(ConfigIpls.lomBankId, "cash_set_02")
				end
				if ConfigIpls.ceoCashSet3 then
					ActivateInteriorEntitySet(ConfigIpls.lomBankId, "cash_set_03")
				end
				if ConfigIpls.ceoCashSet4 then
					ActivateInteriorEntitySet(ConfigIpls.lomBankId, "cash_set_04")
				end
				if ConfigIpls.ceoCashSet5 then
					ActivateInteriorEntitySet(ConfigIpls.lomBankId, "cash_set_05")
				end
				if ConfigIpls.ceoCashSet6 then
					ActivateInteriorEntitySet(ConfigIpls.lomBankId, "cash_set_06")
				end
				if ConfigIpls.ceoCashSet7 then
					ActivateInteriorEntitySet(ConfigIpls.lomBankId, "cash_set_07")
				end
				if ConfigIpls.ceoCashSet8 then
					ActivateInteriorEntitySet(ConfigIpls.lomBankId, "cash_set_08")
				end
				if ConfigIpls.ceoCashSet9 then
					ActivateInteriorEntitySet(ConfigIpls.lomBankId, "cash_set_09")
				end
				if ConfigIpls.ceoCashSet10 then
					ActivateInteriorEntitySet(ConfigIpls.lomBankId, "cash_set_10")
				end
				if ConfigIpls.ceoCashSet11 then
					ActivateInteriorEntitySet(ConfigIpls.lomBankId, "cash_set_11")
				end
				if ConfigIpls.ceoCashSet12 then
					ActivateInteriorEntitySet(ConfigIpls.lomBankId, "cash_set_12")
				end
				if ConfigIpls.ceoCashSet13 then
					ActivateInteriorEntitySet(ConfigIpls.lomBankId, "cash_set_13")
				end
				if ConfigIpls.ceoCashSet14 then
					ActivateInteriorEntitySet(ConfigIpls.lomBankId, "cash_set_14")
				end
				if ConfigIpls.ceoCashSet15 then
					ActivateInteriorEntitySet(ConfigIpls.lomBankId, "cash_set_15")
				end
				if ConfigIpls.ceoCashSet16 then
					ActivateInteriorEntitySet(ConfigIpls.lomBankId, "cash_set_16")
				end
				if ConfigIpls.ceoCashSet17 then
					ActivateInteriorEntitySet(ConfigIpls.lomBankId, "cash_set_17")
				end
				if ConfigIpls.ceoCashSet18 then
					ActivateInteriorEntitySet(ConfigIpls.lomBankId, "cash_set_18")
				end
				if ConfigIpls.ceoCashSet19 then
					ActivateInteriorEntitySet(ConfigIpls.lomBankId, "cash_set_19")
				end
				if ConfigIpls.ceoCashSet20 then
					ActivateInteriorEntitySet(ConfigIpls.lomBankId, "cash_set_20")
				end
				if ConfigIpls.ceoCashSet21 then
					ActivateInteriorEntitySet(ConfigIpls.lomBankId, "cash_set_21")
				end
				if ConfigIpls.ceoCashSet22 then
					ActivateInteriorEntitySet(ConfigIpls.lomBankId, "cash_set_22")
				end
				if ConfigIpls.ceoCashSet23 then
					ActivateInteriorEntitySet(ConfigIpls.lomBankId, "cash_set_23")
				end
				if ConfigIpls.ceoCashSet24 then
					ActivateInteriorEntitySet(ConfigIpls.lomBankId, "cash_set_24")
				end
				if ConfigIpls.ceoOfficeBooze then
					ActivateInteriorEntitySet(ConfigIpls.lomBankId, "office_booze")
				end
				if ConfigIpls.ceoOfficeChairs then
					ActivateInteriorEntitySet(ConfigIpls.lomBankId, "office_chairs")
				end
				if ConfigIpls.ceoSwagArt1 then
					ActivateInteriorEntitySet(ConfigIpls.lomBankId, "swag_art")
				end
				if ConfigIpls.ceoSwagArt2 then
					ActivateInteriorEntitySet(ConfigIpls.lomBankId, "swag_art2")
				end
				if ConfigIpls.ceoSwagArt3 then
					ActivateInteriorEntitySet(ConfigIpls.lomBankId, "swag_art3")
				end
				if ConfigIpls.ceoBoozeCigs then
					ActivateInteriorEntitySet(ConfigIpls.lomBankId, "swag_booze_cigs")
				end
				if ConfigIpls.ceoBoozeCigs2 then
					ActivateInteriorEntitySet(ConfigIpls.lomBankId, "swag_booze_cigs2")
				end
				if ConfigIpls.ceoBoozeCigs3 then
					ActivateInteriorEntitySet(ConfigIpls.lomBankId, "swag_booze_cigs3")
				end
				if ConfigIpls.ceoSwagCounterfeit then
					ActivateInteriorEntitySet(ConfigIpls.lomBankId, "swag_counterfeit")
				end
				if ConfigIpls.ceoSwagCounterfeit2 then
					ActivateInteriorEntitySet(ConfigIpls.lomBankId, "swag_counterfeit2")
				end
				if ConfigIpls.ceoSwagCounterfeit3 then
					ActivateInteriorEntitySet(ConfigIpls.lomBankId, "swag_counterfeit3")
				end
				if ConfigIpls.ceoSwagDrugBags then
					ActivateInteriorEntitySet(ConfigIpls.lomBankId, "swag_drugbags")
				end
				if ConfigIpls.ceoSwagDrugBags2 then
					ActivateInteriorEntitySet(ConfigIpls.lomBankId, "swag_drugbags2")
				end
				if ConfigIpls.ceoSwagDrugBags3 then
					ActivateInteriorEntitySet(ConfigIpls.lomBankId, "swag_drugbags3")
				end
				if ConfigIpls.ceoDrugStatue then
					ActivateInteriorEntitySet(ConfigIpls.lomBankId, "swag_drugstatue")
				end
				if ConfigIpls.ceoDrugStatue2 then
					ActivateInteriorEntitySet(ConfigIpls.lomBankId, "swag_drugstatue2")
				end
				if ConfigIpls.ceoDrugStatue3 then
					ActivateInteriorEntitySet(ConfigIpls.lomBankId, "swag_drugstatue3")
				end
				if ConfigIpls.ceoElectronic then
					ActivateInteriorEntitySet(ConfigIpls.lomBankId, "swag_electronic")
				end
				if ConfigIpls.ceoElectronic2 then
					ActivateInteriorEntitySet(ConfigIpls.lomBankId, "swag_electronic2")
				end
				if ConfigIpls.ceoElectronic3 then
					ActivateInteriorEntitySet(ConfigIpls.lomBankId, "swag_electronic3")
				end
				if ConfigIpls.ceoFurCoats then
					ActivateInteriorEntitySet(ConfigIpls.lomBankId, "swag_furcoats")
				end	
				if ConfigIpls.ceoFurCoats2 then
					ActivateInteriorEntitySet(ConfigIpls.lomBankId, "swag_furcoats2")
				end
				if ConfigIpls.ceoFurCoats3 then
					ActivateInteriorEntitySet(ConfigIpls.lomBankId, "swag_furcoats3")
				end
				if ConfigIpls.ceoSwagGems then
					ActivateInteriorEntitySet(ConfigIpls.lomBankId, "swag_gems")
				end
				if ConfigIpls.ceoSwagGems2 then
					ActivateInteriorEntitySet(ConfigIpls.lomBankId, "swag_gems2")
				end
				if ConfigIpls.ceoSwagGems3 then
					ActivateInteriorEntitySet(ConfigIpls.lomBankId, "swag_gems3")
				end
				if ConfigIpls.ceoSwagGuns then
					ActivateInteriorEntitySet(ConfigIpls.lomBankId, "swag_guns")
				end
				if ConfigIpls.ceoSwagGuns2 then
					ActivateInteriorEntitySet(ConfigIpls.lomBankId, "swag_guns2")
				end
				if ConfigIpls.ceoSwagGuns3 then
					ActivateInteriorEntitySet(ConfigIpls.lomBankId, "swag_guns3")
				end
				if ConfigIpls.ceoSwagIvory then
					ActivateInteriorEntitySet(ConfigIpls.lomBankId, "swag_ivory")
				end
				if ConfigIpls.ceoSwagIvory2 then
					ActivateInteriorEntitySet(ConfigIpls.lomBankId, "swag_ivory2")
				end
				if ConfigIpls.ceoSwagIvory3 then
					ActivateInteriorEntitySet(ConfigIpls.lomBankId, "swag_ivory3")
				end
				if ConfigIpls.ceoSwagJewelWatch then
					ActivateInteriorEntitySet(ConfigIpls.lomBankId, "swag_jewelwatch")
				end
				if ConfigIpls.ceoSwagJewelWatch2 then
					ActivateInteriorEntitySet(ConfigIpls.lomBankId, "swag_jewelwatch2")
				end
				if ConfigIpls.ceoSwagJewelWatch3 then
					ActivateInteriorEntitySet(ConfigIpls.lomBankId, "swag_jewelwatch3")
				end
				if ConfigIpls.ceoSwagMed then
					ActivateInteriorEntitySet(ConfigIpls.lomBankId, "swag_med")
				end
				if ConfigIpls.ceoSwagMed2 then
					ActivateInteriorEntitySet(ConfigIpls.lomBankId, "swag_med2")
				end
				if ConfigIpls.ceoSwagMed3 then
					ActivateInteriorEntitySet(ConfigIpls.lomBankId, "swag_med3")
				end
				if ConfigIpls.ceoSwagPills then
					ActivateInteriorEntitySet(ConfigIpls.lomBankId, "swag_pills")
				end
				if ConfigIpls.ceoSwagPills2 then
					ActivateInteriorEntitySet(ConfigIpls.lomBankId, "swag_pills2")
				end
				if ConfigIpls.ceoSwagPills3 then
					ActivateInteriorEntitySet(ConfigIpls.lomBankId, "swag_pills3")
				end
				if ConfigIpls.ceoSwagSilver then
					ActivateInteriorEntitySet(ConfigIpls.lomBankId, "swag_silver")
				end
				if ConfigIpls.ceoSwagSilver2 then
					ActivateInteriorEntitySet(ConfigIpls.lomBankId, "swag_silver2")
				end
				if ConfigIpls.ceoSwagSilver3 then
					ActivateInteriorEntitySet(ConfigIpls.lomBankId, "swag_silver3")
				end
			end
		end
		-- CEO Garages
		if ConfigIpls.ceoGaragesDecor1 then
    		ActivateInteriorEntitySet(ConfigIpls.ceoGarageId, "garage_decor_01")
		end
		if ConfigIpls.ceoGaragesDecor2 then
    		ActivateInteriorEntitySet(ConfigIpls.ceoGarageId, "garage_decor_02")
		end
		if ConfigIpls.ceoGaragesDecor3 then
    		ActivateInteriorEntitySet(ConfigIpls.ceoGarageId, "garage_decor_03")
		end
		if ConfigIpls.ceoGaragesDecor4 then
    		ActivateInteriorEntitySet(ConfigIpls.ceoGarageId, "garage_decor_04")
		end
		if ConfigIpls.ceoGaragesLightingOptions1 then
    		ActivateInteriorEntitySet(ConfigIpls.ceoGarageId, "lighting_option01")
		end
		if ConfigIpls.ceoGaragesLightingOptions2 then
    		ActivateInteriorEntitySet(ConfigIpls.ceoGarageId, "lighting_option02")
		end
		if ConfigIpls.ceoGaragesLightingOptions3 then
    		ActivateInteriorEntitySet(ConfigIpls.ceoGarageId, "lighting_option03")
		end
		if ConfigIpls.ceoGaragesLightingOptions4 then
    		ActivateInteriorEntitySet(ConfigIpls.ceoGarageId, "lighting_option04")
		end
		if ConfigIpls.ceoGaragesLightingOptions5 then
    		ActivateInteriorEntitySet(ConfigIpls.ceoGarageId, "lighting_option05")
		end
		if ConfigIpls.ceoGaragesLightingOptions6 then
    		ActivateInteriorEntitySet(ConfigIpls.ceoGarageId, "lighting_option06")
		end
		if ConfigIpls.ceoGaragesLightingOptions7 then
    		ActivateInteriorEntitySet(ConfigIpls.ceoGarageId, "lighting_option07")
		end
		if ConfigIpls.ceoGaragesLightingOptions8 then
    		ActivateInteriorEntitySet(ConfigIpls.ceoGarageId, "lighting_option08")
		end
		if ConfigIpls.ceoGaragesLightingOptions9 then
    		ActivateInteriorEntitySet(ConfigIpls.ceoGarageId, "lighting_option09")
		end
		if ConfigIpls.ceoGaragesNumberingStyle1n1 then
    		ActivateInteriorEntitySet(ConfigIpls.ceoGarageId, "numbering_style01_n1")
		end
		if ConfigIpls.ceoGaragesNumberingStyle1n2 then
    		ActivateInteriorEntitySet(ConfigIpls.ceoGarageId, "numbering_style01_n2")
		end
		if ConfigIpls.ceoGaragesNumberingStyle1n3 then
    		ActivateInteriorEntitySet(ConfigIpls.ceoGarageId, "numbering_style01_n3")
		end
		if ConfigIpls.ceoGaragesNumberingStyle2n1 then
    		ActivateInteriorEntitySet(ConfigIpls.ceoGarageId, "numbering_style02_n1")
		end
		if ConfigIpls.ceoGaragesNumberingStyle2n2 then
    		ActivateInteriorEntitySet(ConfigIpls.ceoGarageId, "numbering_style02_n2")
		end
		if ConfigIpls.ceoGaragesNumberingStyle2n3 then
    		ActivateInteriorEntitySet(ConfigIpls.ceoGarageId, "numbering_style02_n3")
		end
		if ConfigIpls.ceoGaragesNumberingStyle3n1 then
    		ActivateInteriorEntitySet(ConfigIpls.ceoGarageId, "numbering_style03_n1")
		end
		if ConfigIpls.ceoGaragesNumberingStyle3n2 then
    		ActivateInteriorEntitySet(ConfigIpls.ceoGarageId, "numbering_style03_n2")
		end
		if ConfigIpls.ceoGaragesNumberingStyle3n3 then
    		ActivateInteriorEntitySet(ConfigIpls.ceoGarageId, "numbering_style03_n3")
		end
		if ConfigIpls.ceoGaragesNumberingStyle4n1 then
    		ActivateInteriorEntitySet(ConfigIpls.ceoGarageId, "numbering_style04_n1")
		end
		if ConfigIpls.ceoGaragesNumberingStyle4n2 then
    		ActivateInteriorEntitySet(ConfigIpls.ceoGarageId, "numbering_style04_n2")
		end
		if ConfigIpls.ceoGaragesNumberingStyle4n3 then
    		ActivateInteriorEntitySet(ConfigIpls.ceoGarageId, "numbering_style04_n3")
		end
		if ConfigIpls.ceoGaragesNumberingStyle5n1 then
    		ActivateInteriorEntitySet(ConfigIpls.ceoGarageId, "numbering_style05_n1")
		end
		if ConfigIpls.ceoGaragesNumberingStyle5n2 then
    		ActivateInteriorEntitySet(ConfigIpls.ceoGarageId, "numbering_style05_n2")
		end
		if ConfigIpls.ceoGaragesNumberingStyle5n3 then
    		ActivateInteriorEntitySet(ConfigIpls.ceoGarageId, "numbering_style05_n3")
		end
		if ConfigIpls.ceoGaragesNumberingStyle6n1 then
    		ActivateInteriorEntitySet(ConfigIpls.ceoGarageId, "numbering_style06_n1")
		end
		if ConfigIpls.ceoGaragesNumberingStyle6n2 then
    		ActivateInteriorEntitySet(ConfigIpls.ceoGarageId, "numbering_style06_n2")
		end
		if ConfigIpls.ceoGaragesNumberingStyle6n3 then
    		ActivateInteriorEntitySet(ConfigIpls.ceoGarageId, "numbering_style06_n3")
		end
		if ConfigIpls.ceoGaragesNumberingStyle7n1 then
    		ActivateInteriorEntitySet(ConfigIpls.ceoGarageId, "numbering_style07_n1")
		end
		if ConfigIpls.ceoGaragesNumberingStyle7n2 then
    		ActivateInteriorEntitySet(ConfigIpls.ceoGarageId, "numbering_style07_n2")
		end
		if ConfigIpls.ceoGaragesNumberingStyle7n3 then
    		ActivateInteriorEntitySet(ConfigIpls.ceoGarageId, "numbering_style07_n3")
		end
		if ConfigIpls.ceoGaragesNumberingStyle8n1 then
    		ActivateInteriorEntitySet(ConfigIpls.ceoGarageId, "numbering_style08_n1")
		end
		if ConfigIpls.ceoGaragesNumberingStyle8n2 then
    		ActivateInteriorEntitySet(ConfigIpls.ceoGarageId, "numbering_style08_n2")
		end
		if ConfigIpls.ceoGaragesNumberingStyle8n3 then
    		ActivateInteriorEntitySet(ConfigIpls.ceoGarageId, "numbering_style08_n3")
		end
		if ConfigIpls.ceoGaragesNumberingStyle9n1 then
    		ActivateInteriorEntitySet(ConfigIpls.ceoGarageId, "numbering_style09_n1")
		end
		if ConfigIpls.ceoGaragesNumberingStyle9n2 then
    		ActivateInteriorEntitySet(ConfigIpls.ceoGarageId, "numbering_style09_n2")
		end
		if ConfigIpls.ceoGaragesNumberingStyle9n3 then
    		ActivateInteriorEntitySet(ConfigIpls.ceoGarageId, "numbering_style09_n3")
		end
		if ConfigIpls.ceoGaragesBasicStyleSet then
    		ActivateInteriorEntitySet(ConfigIpls.ceoGarageId, "basic_style_set")
		end
-- CEO Vehicle Shops
if ConfigIpls.ceoVehGaragesFloorVinyl1 then
    ActivateInteriorEntitySet(ConfigIpls.ceoVehicleShopId, "floor_vinyl_01")
end
if ConfigIpls.ceoVehGaragesFloorVinyl2 then
    ActivateInteriorEntitySet(ConfigIpls.ceoVehicleShopId, "floor_vinyl_02")
end
if ConfigIpls.ceoVehGaragesFloorVinyl3 then
    ActivateInteriorEntitySet(ConfigIpls.ceoVehicleShopId, "floor_vinyl_03")
end
if ConfigIpls.ceoVehGaragesFloorVinyl4 then
    ActivateInteriorEntitySet(ConfigIpls.ceoVehicleShopId, "floor_vinyl_04")
end
if ConfigIpls.ceoVehGaragesFloorVinyl5 then
    ActivateInteriorEntitySet(ConfigIpls.ceoVehicleShopId, "floor_vinyl_05")
end
if ConfigIpls.ceoVehGaragesFloorVinyl6 then
    ActivateInteriorEntitySet(ConfigIpls.ceoVehicleShopId, "floor_vinyl_06")
end
if ConfigIpls.ceoVehGaragesFloorVinyl7 then
    ActivateInteriorEntitySet(ConfigIpls.ceoVehicleShopId, "floor_vinyl_07")
end
if ConfigIpls.ceoVehGaragesFloorVinyl8 then
    ActivateInteriorEntitySet(ConfigIpls.ceoVehicleShopId, "floor_vinyl_08")
end
if ConfigIpls.ceoVehGaragesFloorVinyl9 then
    ActivateInteriorEntitySet(ConfigIpls.ceoVehicleShopId, "floor_vinyl_10")
end
if ConfigIpls.ceoVehGaragesFloorVinyl10 then
    ActivateInteriorEntitySet(ConfigIpls.ceoVehicleShopId, "floor_vinyl_11")
end
if ConfigIpls.ceoVehGaragesFloorVinyl12 then
    ActivateInteriorEntitySet(ConfigIpls.ceoVehicleShopId, "floor_vinyl_12")
end
if ConfigIpls.ceoVehGaragesFloorVinyl13 then
    ActivateInteriorEntitySet(ConfigIpls.ceoVehicleShopId, "floor_vinyl_13")
end
if ConfigIpls.ceoVehGaragesFloorVinyl14 then
    ActivateInteriorEntitySet(ConfigIpls.ceoVehicleShopId, "floor_vinyl_14")
end
if ConfigIpls.ceoVehGaragesFloorVinyl15 then
    ActivateInteriorEntitySet(ConfigIpls.ceoVehicleShopId, "floor_vinyl_15")
end
if ConfigIpls.ceoVehGaragesFloorVinyl16 then
    ActivateInteriorEntitySet(ConfigIpls.ceoVehicleShopId, "floor_vinyl_16")
end
if ConfigIpls.ceoVehGaragesFloorVinyl17 then
    ActivateInteriorEntitySet(ConfigIpls.ceoVehicleShopId, "floor_vinyl_17")
end
if ConfigIpls.ceoVehGaragesFloorVinyl18 then
    ActivateInteriorEntitySet(ConfigIpls.ceoVehicleShopId, "floor_vinyl_18")
end
if ConfigIpls.ceoVehGaragesFloorVinyl19 then
    ActivateInteriorEntitySet(ConfigIpls.ceoVehicleShopId, "floor_vinyl_19")
end
		
		-- Document Forgery Office
		if ConfigIpls.dfoChair1 then
			if ConfigIpls.wareHouseThree then
				ActivateInteriorEntitySet(ConfigIpls.wareHouseFiveId, "chair01")
			end
		end
		if ConfigIpls.dfoChair2 then
			if ConfigIpls.wareHouseThree then
				ActivateInteriorEntitySet(ConfigIpls.wareHouseFiveId, "chair02")
			end
		end
		if ConfigIpls.dfoChair3 then
			if ConfigIpls.wareHouseThree then
				ActivateInteriorEntitySet(ConfigIpls.wareHouseFiveId, "chair03")
			end
		end
		if ConfigIpls.dfoChair4 then
			if ConfigIpls.wareHouseThree then
				ActivateInteriorEntitySet(ConfigIpls.wareHouseFiveId, "chair04")
			end
		end
		if ConfigIpls.dfoChair5 then
			if ConfigIpls.wareHouseThree then
				ActivateInteriorEntitySet(ConfigIpls.wareHouseFiveId, "chair05")
			end
		end
		if ConfigIpls.dfoChair6 then
			if ConfigIpls.wareHouseThree then
				ActivateInteriorEntitySet(ConfigIpls.wareHouseFiveId, "chair06")
			end
		end
		if ConfigIpls.dfoChair7 then
			if ConfigIpls.wareHouseThree then
				ActivateInteriorEntitySet(ConfigIpls.wareHouseFiveId, "chair07")
			end
		end
		if ConfigIpls.dfoClutter then
			if ConfigIpls.wareHouseThree then
				ActivateInteriorEntitySet(ConfigIpls.wareHouseFiveId, "clutter")
			end
		end
		if ConfigIpls.dfoEquipmentBasic then
			if ConfigIpls.wareHouseThree then
				ActivateInteriorEntitySet(ConfigIpls.wareHouseFiveId, "equipment_basic")
			end
		end
		if ConfigIpls.dfoequipmentUpgrade then
			if ConfigIpls.wareHouseThree then
				ActivateInteriorEntitySet(ConfigIpls.wareHouseFiveId, "equipment_upgrade")
			end
		end
		if ConfigIpls.dfoInteriorBasic then
			if ConfigIpls.wareHouseThree then
				ActivateInteriorEntitySet(ConfigIpls.wareHouseFiveId, "interior_basic")
			end
		end
		if ConfigIpls.dfoInteriorUpgrade then
			if ConfigIpls.wareHouseThree then
				ActivateInteriorEntitySet(ConfigIpls.wareHouseFiveId, "interior_upgrade")
			end
		end
		if ConfigIpls.dfoProduction then
			if ConfigIpls.wareHouseThree then
				ActivateInteriorEntitySet(ConfigIpls.wareHouseFiveId, "production")
			end
		end
		if ConfigIpls.dfoSecurityHigh then
			if ConfigIpls.wareHouseThree then
				ActivateInteriorEntitySet(ConfigIpls.wareHouseFiveId, "security_high")
			end
		end
		if ConfigIpls.dfoSecurityLow then
			if ConfigIpls.wareHouseThree then
				ActivateInteriorEntitySet(ConfigIpls.wareHouseFiveId, "security_low")
			end
		end
		if ConfigIpls.dfoSetup then
			if ConfigIpls.wareHouseThree then
				ActivateInteriorEntitySet(ConfigIpls.wareHouseFiveId, "set_up")
			end
		end
		-- Doomsday Facility
		if ConfigIpls.doomsdayFacilityDecal then
			if ConfigIpls.doomsday then
				ActivateInteriorEntitySet(ConfigIpls.doomsdayId, "set_int_02_decal_01")
				SetInteriorEntitySetColor(ConfigIpls.doomsdayId, ConfigIpls.doomsdayColorDecal)
			end
		end
		if ConfigIpls.doomsdayFacilityLounge then
			if ConfigIpls.doomsday then
				ActivateInteriorEntitySet(ConfigIpls.doomsdayId, "set_int_02_lounge1")
				SetInteriorEntitySetColor(ConfigIpls.doomsdayId, ConfigIpls.doomsdayColorLounge)
			end
		end
		if ConfigIpls.doomsdayFacilityCannon then
			if ConfigIpls.doomsday then
				ActivateInteriorEntitySet(ConfigIpls.doomsdayId, "set_int_02_cannon")
				SetInteriorEntitySetColor(ConfigIpls.doomsdayId, ConfigIpls.doomsdayColorCannon)
			end
		end
		if ConfigIpls.doomsdayClutter then
			if ConfigIpls.doomsday then
				ActivateInteriorEntitySet(ConfigIpls.doomsdayId, "set_int_02_clutter1")
				SetInteriorEntitySetColor(ConfigIpls.doomsdayId, ConfigIpls.doomsdayColorClutter)
			end
		end
		if ConfigIpls.doomsdayFacilityCrewEmblem then
			if ConfigIpls.doomsday then
				ActivateInteriorEntitySet(ConfigIpls.doomsdayId, "set_int_02_crewemblem")
				SetInteriorEntitySetColor(ConfigIpls.doomsdayId, ConfigIpls.doomsdayColorCrewEmblem)
			end
		end
		if ConfigIpls.doomsdayFacilityShell then
			if ConfigIpls.doomsday then
				ActivateInteriorEntitySet(ConfigIpls.doomsdayId, "set_int_02_shell")
				SetInteriorEntitySetColor(ConfigIpls.doomsdayId, ConfigIpls.doomsdayColorShell)
			end
		end
		if ConfigIpls.doomsdayFacilitySecurity then
			if ConfigIpls.doomsday then
				ActivateInteriorEntitySet(ConfigIpls.doomsdayId, "set_int_02_security")
				SetInteriorEntitySetColor(ConfigIpls.doomsdayId, ConfigIpls.doomsdayColorSecurity)
			end
		end
		if ConfigIpls.doomsdayFacilitySleep then
			if ConfigIpls.doomsday then
				ActivateInteriorEntitySet(ConfigIpls.doomsdayId, "set_int_02_sleep")
				SetInteriorEntitySetColor(ConfigIpls.doomsdayId, ConfigIpls.doomsdayColorSleep)
			end
		end
		if ConfigIpls.doomsdayFacilityTrophy then
			if ConfigIpls.doomsday then
				ActivateInteriorEntitySet(ConfigIpls.doomsdayId, "set_int_02_trophy1")
				SetInteriorEntitySetColor(ConfigIpls.doomsdayId, ConfigIpls.doomsdayColorTrophy)
			end
		end
		if ConfigIpls.doomsdayFacilityMedicComplete then
			if ConfigIpls.doomsday then
				ActivateInteriorEntitySet(ConfigIpls.doomsdayId, "set_int_02_paramedic_complete")
				SetInteriorEntitySetColor(ConfigIpls.doomsdayId, ConfigIpls.doomsdayColorMedicComplete)
			end
		end
		if ConfigIpls.doomsdayFacilityMedicOutfit then
			if ConfigIpls.doomsday then
				ActivateInteriorEntitySet(ConfigIpls.doomsdayId, "set_Int_02_outfit_paramedic")
				SetInteriorEntitySetColor(ConfigIpls.doomsdayId, ConfigIpls.doomsdayColorMedicOutfit)
			end
		end
		if ConfigIpls.doomsdayFacilityServerFarmOutfit then
			if ConfigIpls.doomsday then
				ActivateInteriorEntitySet(ConfigIpls.doomsdayId, "set_Int_02_outfit_serverfarm")
				SetInteriorEntitySetColor(ConfigIpls.doomsdayId, ConfigIpls.doomsdayColorServerFarmOutfit)
			end
		end
		-- Smugglers Run Hangar
        if ConfigIpls.smugglersLighting then
            if ConfigIpls.smugglers then
                ActivateInteriorEntitySet(ConfigIpls.smugglersId, "set_lighting_hangar_a")
                SetInteriorEntitySetColor(ConfigIpls.smugglersId, ConfigIpls.smugglersLightTintPropsColor)
            end
        end
        if ConfigIpls.smugglersShell then
            if ConfigIpls.smugglers then
                ActivateInteriorEntitySet(ConfigIpls.smugglersId, "set_tint_shell")
                SetInteriorEntitySetColor(ConfigIpls.smugglersId, ConfigIpls.smugglersShellColor)
            end
        end
        if ConfigIpls.smugglersBedroomTint then
            if ConfigIpls.smugglers then
                ActivateInteriorEntitySet(ConfigIpls.smugglersId, "set_bedroom_tint")
                SetInteriorEntitySetColor(ConfigIpls.smugglersId, ConfigIpls.smugglerBedroomTintColor)
            end
        end
        if ConfigIpls.smugglersCraneTint then
            if ConfigIpls.smugglers then
                ActivateInteriorEntitySet(ConfigIpls.smugglersId, "set_crane_tint")
                SetInteriorEntitySetColor(ConfigIpls.smugglersId, ConfigIpls.smugglerCraneTintColor)
            end
        end
        if ConfigIpls.smugglersModerea then
            if ConfigIpls.smugglers then
                ActivateInteriorEntitySet(ConfigIpls.smugglersId, "set_modarea")
                SetInteriorEntitySetColor(ConfigIpls.smugglersId, ConfigIpls.smugglersModareaColor)
            end
        end
        if ConfigIpls.smugglersLightingTintProps then
            if ConfigIpls.smugglers then
                ActivateInteriorEntitySet(ConfigIpls.smugglersId, "set_lighting_tint_props")
                SetInteriorEntitySetColor(ConfigIpls.smugglersId, ConfigIpls.smugglersLightTintPropsColor)
            end
        end
        if ConfigIpls.smugglersFloor then
            if ConfigIpls.smugglers then
                ActivateInteriorEntitySet(ConfigIpls.smugglersId, "set_floor_1")
                SetInteriorEntitySetColor(ConfigIpls.smugglersId, ConfigIpls.smugglersFloorDecalColor)
            end
        end
        if ConfigIpls.smugglersFloorDecal then
            if ConfigIpls.smugglers then
                ActivateInteriorEntitySet(ConfigIpls.smugglersId, "set_floor_decal_1")
                SetInteriorEntitySetColor(ConfigIpls.smugglersId, ConfigIpls.smugglersFloorDecalColor)
            end
        end
        if ConfigIpls.smugglersBedroomModern then
            if ConfigIpls.smugglers then
                ActivateInteriorEntitySet(ConfigIpls.smugglersId, "set_bedroom_modern")
                SetInteriorEntitySetColor(ConfigIpls.smugglersId, ConfigIpls.smugglersBedRoomModernColor)
            end
        end
        if ConfigIpls.smugglersOfficeModern then
            if ConfigIpls.smugglers then
                ActivateInteriorEntitySet(ConfigIpls.smugglersId, "set_office_modern")
                SetInteriorEntitySetColor(ConfigIpls.smugglersId, ConfigIpls.smugglersOfficeModernColor)
            end
        end
        if ConfigIpls.smugglersBedroomBlindsOpen then
            if ConfigIpls.smugglers then
                ActivateInteriorEntitySet(ConfigIpls.smugglersId, "set_bedroom_blinds_open")
                SetInteriorEntitySetColor(ConfigIpls.smugglersId, ConfigIpls.smugglersBedRoomBlindOpenColor)
            end
        end
        if ConfigIpls.smugglersLightingWallTint then
            if ConfigIpls.smugglers then
                ActivateInteriorEntitySet(ConfigIpls.smugglersId, "set_lighting_wall_tint01")
                SetInteriorEntitySetColor(ConfigIpls.smugglersId, ConfigIpls.smugglersLightingWallTintColor)
            end
		end
		-- Penthouse
		if ConfigIpls.penthouseManagerDefault then
			if ConfigIpls.penthouse then
				if ConfigIpls.diamondCasinoAndResort then
					ActivateInteriorEntitySet(ConfigIpls.casinoPenthouseId, "casino_manager_default")
					ActivateInteriorEntitySet(ConfigIpls.casinoPenthouseId, "Set_Pent_Tint_Shell")
					SetInteriorEntitySetColor(ConfigIpls.casinoPenthouseId, "Set_Pent_Tint_Shell", ConfigIpls.penthouseTintShellColor)
					ActivateInteriorEntitySet(ConfigIpls.casinoPenthouseId, "vw_vwint02_pent_spax_shell")
					SetInteriorEntitySetColor(ConfigIpls.casinoPenthouseId, "vw_vwint02_pent_spax_shell", ConfigIpls.penthouseSpaxShellColor)
					ActivateInteriorEntitySet(ConfigIpls.casinoPenthouseId, "vw_vwint02_pent_spa_shell")
					SetInteriorEntitySetColor(ConfigIpls.casinoPenthouseId, "vw_vwint02_pent_spa_shell", ConfigIpls.penthouseSpaShellColor)
					ActivateInteriorEntitySet(ConfigIpls.casinoPenthouseId, "vw_vwint02_pent_sbt_shell")
					SetInteriorEntitySetColor(ConfigIpls.casinoPenthouseId, "vw_vwint02_pent_sbt_shell", ConfigIpls.penthouseSbtShellColor)
					ActivateInteriorEntitySet(ConfigIpls.casinoPenthouseId, "vw_vwint02_pent_mbt_shell")
					SetInteriorEntitySetColor(ConfigIpls.casinoPenthouseId, "vw_vwint02_pent_mbt_shell", ConfigIpls.penthouseMbtShellColor)
					ActivateInteriorEntitySet(ConfigIpls.casinoPenthouseId, "vw_vwint02_pent_hal_window")
					ActivateInteriorEntitySet(ConfigIpls.casinoPenthouseId, "vw_vwint02_pent_mb_window")
					ActivateInteriorEntitySet(ConfigIpls.casinoPenthouseId, "vw_vwint02_pent_lou_window")
					ActivateInteriorEntitySet(ConfigIpls.casinoPenthouseId, "vw_vwint02_pent_sb_window")
					ActivateInteriorEntitySet(ConfigIpls.casinoPenthouseId, "vw_vwint02_pent_din_window")
					ActivateInteriorEntitySet(ConfigIpls.casinoPenthouseId, "vw_vwint02_pent_bar_window")
					ActivateInteriorEntitySet(ConfigIpls.casinoPenthouseId, "vw_vwint02_pent_off_window")
					ActivateInteriorEntitySet(ConfigIpls.casinoPenthouseId, "vw_vwint02_pent_lv_window")
					ActivateInteriorEntitySet(ConfigIpls.casinoPenthouseId, "vw_vwint02_pent_ex_window")
					ActivateInteriorEntitySet(ConfigIpls.casinoPenthouseId, "vw_vwint02_pent_spax_window")
					ActivateInteriorEntitySet(ConfigIpls.casinoPenthouseId, "vw_vwint02_pent_spa_window")
				end
			end
		end
		if ConfigIpls.penthouseManagerWorkout then
			if ConfigIpls.penthouse then
				if ConfigIpls.diamondCasinoAndResort then
					ActivateInteriorEntitySet(ConfigIpls.casinoPenthouseId, "casino_manager_workout")
					ActivateInteriorEntitySet(ConfigIpls.casinoPenthouseId, "Set_Pent_Tint_Shell")
					SetInteriorEntitySetColor(ConfigIpls.casinoPenthouseId, "Set_Pent_Tint_Shell", ConfigIpls.penthouseTintShellColor)
					ActivateInteriorEntitySet(ConfigIpls.casinoPenthouseId, "vw_vwint02_pent_spax_shell")
					SetInteriorEntitySetColor(ConfigIpls.casinoPenthouseId, "vw_vwint02_pent_spax_shell", ConfigIpls.penthouseSpaxShellColor)
					ActivateInteriorEntitySet(ConfigIpls.casinoPenthouseId, "vw_vwint02_pent_spa_shell")
					SetInteriorEntitySetColor(ConfigIpls.casinoPenthouseId, "vw_vwint02_pent_spa_shell", ConfigIpls.penthouseSpaShellColor)
					ActivateInteriorEntitySet(ConfigIpls.casinoPenthouseId, "vw_vwint02_pent_sbt_shell")
					SetInteriorEntitySetColor(ConfigIpls.casinoPenthouseId, "vw_vwint02_pent_sbt_shell", ConfigIpls.penthouseSbtShellColor)
					ActivateInteriorEntitySet(ConfigIpls.casinoPenthouseId, "vw_vwint02_pent_mbt_shell")
					SetInteriorEntitySetColor(ConfigIpls.casinoPenthouseId, "vw_vwint02_pent_mbt_shell", ConfigIpls.penthouseMbtShellColor)
					ActivateInteriorEntitySet(ConfigIpls.casinoPenthouseId, "vw_vwint02_pent_hal_window")
					ActivateInteriorEntitySet(ConfigIpls.casinoPenthouseId, "vw_vwint02_pent_mb_window")
					ActivateInteriorEntitySet(ConfigIpls.casinoPenthouseId, "vw_vwint02_pent_lou_window")
					ActivateInteriorEntitySet(ConfigIpls.casinoPenthouseId, "vw_vwint02_pent_sb_window")
					ActivateInteriorEntitySet(ConfigIpls.casinoPenthouseId, "vw_vwint02_pent_din_window")
					ActivateInteriorEntitySet(ConfigIpls.casinoPenthouseId, "vw_vwint02_pent_bar_window")
					ActivateInteriorEntitySet(ConfigIpls.casinoPenthouseId, "vw_vwint02_pent_off_window")
					ActivateInteriorEntitySet(ConfigIpls.casinoPenthouseId, "vw_vwint02_pent_lv_window")
					ActivateInteriorEntitySet(ConfigIpls.casinoPenthouseId, "vw_vwint02_pent_ex_window")
					ActivateInteriorEntitySet(ConfigIpls.casinoPenthouseId, "vw_vwint02_pent_spax_window")
					ActivateInteriorEntitySet(ConfigIpls.casinoPenthouseId, "vw_vwint02_pent_spa_window")
				end
			end
		end
		if ConfigIpls.penthousePattern1 then
			if ConfigIpls.penthouse then
				if ConfigIpls.diamondCasinoAndResort then
					ActivateInteriorEntitySet(ConfigIpls.casinoPenthouseId, "Set_Pent_Pattern_01")
					SetInteriorEntitySetColor(ConfigIpls.casinoPenthouseId, "Set_Pent_Pattern_01", ConfigIpls.penthousePattern1Color)
				end
			end
		end
		if ConfigIpls.penthousePattern2 then
			if ConfigIpls.penthouse then
				if ConfigIpls.diamondCasinoAndResort then
					ActivateInteriorEntitySet(ConfigIpls.casinoPenthouseId, "Set_Pent_Pattern_02")
					SetInteriorEntitySetColor(ConfigIpls.casinoPenthouseId, "Set_Pent_Pattern_02", ConfigIpls.penthousePattern2Color)
				end
			end
		end
		if ConfigIpls.penthousePattern3 then
			if ConfigIpls.penthouse then
				if ConfigIpls.diamondCasinoAndResort then
					ActivateInteriorEntitySet(ConfigIpls.casinoPenthouseId, "Set_Pent_Pattern_03")
					SetInteriorEntitySetColor(ConfigIpls.casinoPenthouseId, "Set_Pent_Pattern_03", ConfigIpls.penthousePattern3Color)
				end
			end
		end
		if ConfigIpls.penthousePattern4 then
			if ConfigIpls.penthouse then
				if ConfigIpls.diamondCasinoAndResort then
					ActivateInteriorEntitySet(ConfigIpls.casinoPenthouseId, "Set_Pent_Pattern_04")
					SetInteriorEntitySetColor(ConfigIpls.casinoPenthouseId, "Set_Pent_Pattern_04", ConfigIpls.penthousePattern4Color)
				end
			end
		end
		if ConfigIpls.penthousePattern5 then
			if ConfigIpls.penthouse then
				if ConfigIpls.diamondCasinoAndResort then
					ActivateInteriorEntitySet(ConfigIpls.casinoPenthouseId, "Set_Pent_Pattern_05")
					SetInteriorEntitySetColor(ConfigIpls.casinoPenthouseId, "Set_Pent_Pattern_05", ConfigIpls.penthousePattern5Color)
				end
			end
		end
		if ConfigIpls.penthousePattern6 then
			if ConfigIpls.penthouse then
				if ConfigIpls.diamondCasinoAndResort then
					ActivateInteriorEntitySet(ConfigIpls.casinoPenthouseId, "Set_Pent_Pattern_06")
					SetInteriorEntitySetColor(ConfigIpls.casinoPenthouseId, "Set_Pent_Pattern_06", ConfigIpls.penthousePattern6Color)
				end
			end
		end
		if ConfigIpls.penthousePattern7 then
			if ConfigIpls.penthouse then
				if ConfigIpls.diamondCasinoAndResort then
					ActivateInteriorEntitySet(ConfigIpls.casinoPenthouseId, "Set_Pent_Pattern_07")
					SetInteriorEntitySetColor(ConfigIpls.casinoPenthouseId, "Set_Pent_Pattern_07", ConfigIpls.penthousePattern7Color)
				end
			end
		end
		if ConfigIpls.penthousePattern8 then
			if ConfigIpls.penthouse then
				if ConfigIpls.diamondCasinoAndResort then
					ActivateInteriorEntitySet(ConfigIpls.casinoPenthouseId, "Set_Pent_Pattern_08")
					SetInteriorEntitySetColor(ConfigIpls.casinoPenthouseId, "Set_Pent_Pattern_08", ConfigIpls.penthousePattern8Color)
				end
			end
		end
		if ConfigIpls.penthousePattern9 then
			if ConfigIpls.penthouse then
				if ConfigIpls.diamondCasinoAndResort then
					ActivateInteriorEntitySet(ConfigIpls.casinoPenthouseId, "Set_Pent_Pattern_09")
					SetInteriorEntitySetColor(ConfigIpls.casinoPenthouseId, "Set_Pent_Pattern_09", ConfigIpls.penthousePattern9Color)
				end
			end
		end
		if ConfigIpls.penthouseSpaBarOpen then
			if ConfigIpls.penthouse then
				if ConfigIpls.diamondCasinoAndResort then
					ActivateInteriorEntitySet(ConfigIpls.casinoPenthouseId, "Set_Pent_Spa_Bar_Open")
				end
			end
		end
		if ConfigIpls.penthouseSpaBarClosed then
			if ConfigIpls.penthouse then
				if ConfigIpls.diamondCasinoAndResort then
					ActivateInteriorEntitySet(ConfigIpls.casinoPenthouseId, "Set_Pent_Spa_Bar_Closed")
				end
			end
		end
		if ConfigIpls.penthouseMediaBarOpen then
			if ConfigIpls.penthouse then
				if ConfigIpls.diamondCasinoAndResort then
					ActivateInteriorEntitySet(ConfigIpls.casinoPenthouseId, "Set_Pent_Media_Bar_Open")
				end
			end
		end
		if ConfigIpls.penthouseMediaBarClosed then
			if ConfigIpls.penthouse then
				if ConfigIpls.diamondCasinoAndResort then
					ActivateInteriorEntitySet(ConfigIpls.casinoPenthouseId, "Set_Pent_Media_Bar_Closed")
				end
			end
		end
		if ConfigIpls.penthouseDealer then
			if ConfigIpls.penthouse then
				if ConfigIpls.diamondCasinoAndResort then
					ActivateInteriorEntitySet(ConfigIpls.casinoPenthouseId, "Set_Pent_Dealer")
				end
			end
		end
		if ConfigIpls.penthouseNoDealer then
			if ConfigIpls.penthouse then
				if ConfigIpls.diamondCasinoAndResort then
					ActivateInteriorEntitySet(ConfigIpls.casinoPenthouseId, "Set_Pent_NoDealer")
				end
			end
		end
		if ConfigIpls.penthouseArcadeModern then
			if ConfigIpls.penthouse then
				if ConfigIpls.diamondCasinoAndResort then
					ActivateInteriorEntitySet(ConfigIpls.casinoPenthouseId, "Set_Pent_Arcade_Modern")
				end
			end
		end
		if ConfigIpls.penthouseArcadeRetro then
			if ConfigIpls.penthouse then
				if ConfigIpls.diamondCasinoAndResort then
					ActivateInteriorEntitySet(ConfigIpls.casinoPenthouseId, "Set_Pent_Arcade_Retro")
				end
			end
		end
		if ConfigIpls.penthouseBarClutter then
			if ConfigIpls.penthouse then
				if ConfigIpls.diamondCasinoAndResort then
					ActivateInteriorEntitySet(ConfigIpls.casinoPenthouseId, "Set_Pent_Bar_Clutter")
				end
			end
		end
		if ConfigIpls.penthouseBarClutter1 then
			if ConfigIpls.penthouse then
				if ConfigIpls.diamondCasinoAndResort then
					ActivateInteriorEntitySet(ConfigIpls.casinoPenthouseId, "Set_Pent_Clutter_01")
				end
			end
		end
		if ConfigIpls.penthouseBarClutter2 then
			if ConfigIpls.penthouse then
				if ConfigIpls.diamondCasinoAndResort then
					ActivateInteriorEntitySet(ConfigIpls.casinoPenthouseId, "Set_Pent_Clutter_02")
				end
			end
		end
		if ConfigIpls.penthouseBarClutter3 then
			if ConfigIpls.penthouse then
				if ConfigIpls.diamondCasinoAndResort then
					ActivateInteriorEntitySet(ConfigIpls.casinoPenthouseId, "Set_Pent_Clutter_03")
				end
			end
		end
		if ConfigIpls.penthouseBarLight0 then
			if ConfigIpls.penthouse then
				if ConfigIpls.diamondCasinoAndResort then
					ActivateInteriorEntitySet(ConfigIpls.casinoPenthouseId, "set_pent_bar_light_0")
				end
			end
		end
		if ConfigIpls.penthouseBarLight1 then
			if ConfigIpls.penthouse then
				if ConfigIpls.diamondCasinoAndResort then
					ActivateInteriorEntitySet(ConfigIpls.casinoPenthouseId, "set_pent_bar_light_01")
				end
			end
		end
		if ConfigIpls.penthouseBarParty0 then
			if ConfigIpls.penthouse then
				if ConfigIpls.diamondCasinoAndResort then
					ActivateInteriorEntitySet(ConfigIpls.casinoPenthouseId, "set_pent_bar_party_0")
				end
			end
		end
		if ConfigIpls.penthouseBarParty1 then
			if ConfigIpls.penthouse then
				if ConfigIpls.diamondCasinoAndResort then
					ActivateInteriorEntitySet(ConfigIpls.casinoPenthouseId, "set_pent_bar_party_1")
				end
			end
		end
		if ConfigIpls.penthouseBarParty2 then
			if ConfigIpls.penthouse then
				if ConfigIpls.diamondCasinoAndResort then
					ActivateInteriorEntitySet(ConfigIpls.casinoPenthouseId, "set_pent_bar_party_2")
				end
			end
		end
		if ConfigIpls.penthouseBarPartyAfter then
			if ConfigIpls.penthouse then
				if ConfigIpls.diamondCasinoAndResort then
					ActivateInteriorEntitySet(ConfigIpls.casinoPenthouseId, "set_pent_bar_party_after")
				end
			end
		end
		if ConfigIpls.penthouseGuestBlocker then
			if ConfigIpls.penthouse then
				if ConfigIpls.diamondCasinoAndResort then
					ActivateInteriorEntitySet(ConfigIpls.casinoPenthouseId, "Set_Pent_GUEST_BLOCKER")
				end
			end
		end
		if ConfigIpls.penthouseOfficeBlocker then
			if ConfigIpls.penthouse then
				if ConfigIpls.diamondCasinoAndResort then
					ActivateInteriorEntitySet(ConfigIpls.casinoPenthouseId, "Set_Pent_OFFICE_BLOCKER")
				end
			end
		end
		if ConfigIpls.penthouseCineBlocker then
			if ConfigIpls.penthouse then
				if ConfigIpls.diamondCasinoAndResort then
					ActivateInteriorEntitySet(ConfigIpls.casinoPenthouseId, "Set_Pent_CINE_BLOCKER")
				end
			end
		end
		if ConfigIpls.penthouseSpaBlocker then
			if ConfigIpls.penthouse then
				if ConfigIpls.diamondCasinoAndResort then
					ActivateInteriorEntitySet(ConfigIpls.casinoPenthouseId, "Set_Pent_SPA_BLOCKER")
				end
			end
		end
		if ConfigIpls.penthouseBarBlocker then
			if ConfigIpls.penthouse then
				if ConfigIpls.diamondCasinoAndResort then
					ActivateInteriorEntitySet(ConfigIpls.casinoPenthouseId, "Set_Pent_BAR_BLOCKER")
				end
			end
		end
		if ConfigIpls.penthouseBarBlocker then
			if ConfigIpls.penthouse then
				if ConfigIpls.diamondCasinoAndResort then
					ActivateInteriorEntitySet(ConfigIpls.casinoPenthouseId, "v_ilev_garageliftdoor")
				end
			end
		end
		if ConfigIpls.penthouseBlocker then
			if ConfigIpls.penthouse then
				if ConfigIpls.diamondCasinoAndResort then
				ActivateInteriorEntitySet(ConfigIpls.casinoPenthouseId, "vw_vwint02_pent_blocker")
				end
			end
		end
		if ConfigIpls.penthouseTvs then
			if ConfigIpls.penthouse then
				if ConfigIpls.diamondCasinoAndResort then
					ActivateInteriorEntitySet(ConfigIpls.casinoPenthouseId, "prop_tv_flat_03b")
					ActivateInteriorEntitySet(ConfigIpls.casinoPenthouseId, "prop_tv_flat_michael")
					ActivateInteriorEntitySet(ConfigIpls.casinoPenthouseId, "prop_tv_flat_01")
					ActivateInteriorEntitySet(ConfigIpls.casinoPenthouseId, "vw_prop_vw_cinema_tv_01")
					ActivateInteriorEntitySet(ConfigIpls.casinoPenthouseId, "v_res_tt_tvremote")
					ActivateInteriorEntitySet(ConfigIpls.casinoPenthouseId, "vw_prop_vw_tv_rt_01a")
				end
			end
		end
		if ConfigIpls.penthouseMirrors then
			if ConfigIpls.penthouse then
				if ConfigIpls.diamondCasinoAndResort then
					ActivateInteriorEntitySet(ConfigIpls.casinoPenthouseId, "vw_vwint02_pent_mbt_mirror")
					ActivateInteriorEntitySet(ConfigIpls.casinoPenthouseId, "vw_vwint02_pent_mbx_drframe")
					ActivateInteriorEntitySet(ConfigIpls.casinoPenthouseId, "vw_vwint02_pent_loux_mirror")
    				ActivateInteriorEntitySet(ConfigIpls.casinoPenthouseId, "vw_vwint02_pent_sbt_mirror")
					ActivateInteriorEntitySet(ConfigIpls.casinoPenthouseId, "vw_vwint02_pent_wk_mirror")  
				end
			end
		end
		if ConfigIpls.penthouseEdgeBlend then
			if ConfigIpls.penthouse then
				if ConfigIpls.diamondCasinoAndResort then
					ActivateInteriorEntitySet(ConfigIpls.casinoPenthouseId, "vw_vwint02_pent_mb_edgeblend")
					ActivateInteriorEntitySet(ConfigIpls.casinoPenthouseId, "vw_vwint02_pent_hal_edgeblend")
					ActivateInteriorEntitySet(ConfigIpls.casinoPenthouseId, "vw_vwint02_pent_lou_edgeblend")
					ActivateInteriorEntitySet(ConfigIpls.casinoPenthouseId, "vw_vwint02_pent_sb_edgeblend")
					ActivateInteriorEntitySet(ConfigIpls.casinoPenthouseId, "vw_vwint02_pent_din_edgeblend")
					ActivateInteriorEntitySet(ConfigIpls.casinoPenthouseId, "vw_vwint02_pent_bar_edgeblend")
					ActivateInteriorEntitySet(ConfigIpls.casinoPenthouseId, "vw_vwint02_pent_off_edgeblend")
					ActivateInteriorEntitySet(ConfigIpls.casinoPenthouseId, "vw_vwint02_pent_wk_edgeblend")
					ActivateInteriorEntitySet(ConfigIpls.casinoPenthouseId, "vw_vwint02_pent_lv_edgeblend")
					ActivateInteriorEntitySet(ConfigIpls.casinoPenthouseId, "vw_vwint02_pent_spa_edgeblend")
					ActivateInteriorEntitySet(ConfigIpls.casinoPenthouseId, "vw_vwint02_pent_cin_edgeblend")
				end
			end
		end
		if ConfigIpls.penthouseWallArt then
			if ConfigIpls.penthouse then
				if ConfigIpls.diamondCasinoAndResort then
					ActivateInteriorEntitySet(ConfigIpls.casinoPenthouseId, "vw_prop_vw_wallart_47a")
				end
			end
		end
		if ConfigIpls.penthouseSafeDoorOfficeL then
			if ConfigIpls.penthouse then
				if ConfigIpls.diamondCasinoAndResort then
					ActivateInteriorEntitySet(ConfigIpls.casinoPenthouseId, "vw_prop_vw_safedoor_office2a_l")
				end
			end
		end
		if ConfigIpls.penthouseSafeDoorOfficeR then
			if ConfigIpls.penthouse then
				if ConfigIpls.diamondCasinoAndResort then
					ActivateInteriorEntitySet(ConfigIpls.casinoPenthouseId, "vw_prop_vw_safedoor_office2a_r")
				end
			end
		end
		if ConfigIpls.penthouseGunCase1 then
			if ConfigIpls.penthouse then
				if ConfigIpls.diamondCasinoAndResort then
					ActivateInteriorEntitySet(ConfigIpls.casinoPenthouseId, "prop_box_guncase_01a")
				end
			end
		end
		if ConfigIpls.penthouseGunCase2 then
			if ConfigIpls.penthouse then
				if ConfigIpls.diamondCasinoAndResort then
					ActivateInteriorEntitySet(ConfigIpls.casinoPenthouseId, "prop_box_guncase_02a")
				end
			end
		end
		if ConfigIpls.penthouseSpaWater1 then
			if ConfigIpls.penthouse then
				if ConfigIpls.diamondCasinoAndResort then
					ActivateInteriorEntitySet(ConfigIpls.casinoPenthouseId, "vw_vwint02_pent_spa_water_01")
				end
			end
		end
		if ConfigIpls.penthouseSpaWater2 then
			if ConfigIpls.penthouse then
				if ConfigIpls.diamondCasinoAndResort then
					ActivateInteriorEntitySet(ConfigIpls.casinoPenthouseId, "vw_vwint02_pent_spa_water_02")
				end
			end
		end
		if ConfigIpls.penthouseSpaWater3 then
			if ConfigIpls.penthouse then
				if ConfigIpls.diamondCasinoAndResort then
					ActivateInteriorEntitySet(ConfigIpls.casinoPenthouseId, "vw_vwint02_pent_spa_water_03")
				end
			end
		end
		if ConfigIpls.penthouseSigns then
			if ConfigIpls.penthouse then
				if ConfigIpls.diamondCasinoAndResort then
					ActivateInteriorEntitySet(ConfigIpls.casinoPenthouseId, "vw_vwint02_pent_signs")
				end
			end
		end
		-- Arena Wars
		if ConfigIpls.crowdA then
			if ConfigIpls.arenaWars then
				ActivateInteriorEntitySet(ConfigIpls.arenaWarsId, "Set_Crowd_A")
			end
		end
		if ConfigIpls.crowdB then
			if ConfigIpls.arenaWars then
				ActivateInteriorEntitySet(ConfigIpls.arenaWarsId, "Set_Crowd_B")
			end
		end
		if ConfigIpls.crowdC then
			if ConfigIpls.arenaWars then
				ActivateInteriorEntitySet(ConfigIpls.arenaWarsId, "Set_Crowd_C")
			end
		end
		if ConfigIpls.crowdD then
			if ConfigIpls.arenaWars then
				ActivateInteriorEntitySet(ConfigIpls.arenaWarsId, "Set_Crowd_D")
			end
		end
		if ConfigIpls.dystopianScene then
			if ConfigIpls.arenaWars then
				ActivateInteriorEntitySet(ConfigIpls.arenaWarsId, "Set_Dystopian_Scene")
				if ConfigIpls.dystopianScene1 then
					ActivateInteriorEntitySet(ConfigIpls.arenaWarsId, "Set_Dystopian_01")
				elseif ConfigIpls.dystopianScene2 then
					ActivateInteriorEntitySet(ConfigIpls.arenaWarsId, "Set_Dystopian_02")
			    elseif ConfigIpls.dystopianScene3 then
					ActivateInteriorEntitySet(ConfigIpls.arenaWarsId, "Set_Dystopian_03")
				elseif ConfigIpls.dystopianScene4 then
					ActivateInteriorEntitySet(ConfigIpls.arenaWarsId, "Set_Dystopian_04")
				elseif ConfigIpls.dystopianScene5 then
					ActivateInteriorEntitySet(ConfigIpls.arenaWarsId, "Set_Dystopian_05")
				elseif ConfigIpls.dystopianScene6 then
					ActivateInteriorEntitySet(ConfigIpls.arenaWarsId, "Set_Dystopian_06")
				elseif ConfigIpls.dystopianScene7 then
					ActivateInteriorEntitySet(ConfigIpls.arenaWarsId, "Set_Dystopian_07")
				elseif ConfigIpls.dystopianScene8 then
					ActivateInteriorEntitySet(ConfigIpls.arenaWarsId, "Set_Dystopian_08")
				elseif ConfigIpls.dystopianScene9 then
					ActivateInteriorEntitySet(ConfigIpls.arenaWarsId, "Set_Dystopian_09")
				elseif ConfigIpls.dystopianScene10 then
					ActivateInteriorEntitySet(ConfigIpls.arenaWarsId, "Set_Dystopian_10")
				elseif ConfigIpls.dystopianScene11 then
					ActivateInteriorEntitySet(ConfigIpls.arenaWarsId, "Set_Dystopian_11")
				elseif ConfigIpls.dystopianScene12 then
					ActivateInteriorEntitySet(ConfigIpls.arenaWarsId, "Set_Dystopian_12")
				elseif ConfigIpls.dystopianScene13 then
					ActivateInteriorEntitySet(ConfigIpls.arenaWarsId, "Set_Dystopian_13")
				elseif ConfigIpls.dystopianScene14 then
					ActivateInteriorEntitySet(ConfigIpls.arenaWarsId, "Set_Dystopian_14")
				elseif ConfigIpls.dystopianScene15 then
					ActivateInteriorEntitySet(ConfigIpls.arenaWarsId, "Set_Dystopian_15")
				elseif ConfigIpls.dystopianScene16 then
					ActivateInteriorEntitySet(ConfigIpls.arenaWarsId, "Set_Dystopian_16")
				elseif ConfigIpls.dystopianScene17 then
					ActivateInteriorEntitySet(ConfigIpls.arenaWarsId, "Set_Dystopian_17")
				end
			end
		end
		if ConfigIpls.scifiScene then
			if ConfigIpls.arenaWars then
				ActivateInteriorEntitySet(ConfigIpls.arenaWarsId, "Set_Scifi_Scene")
				if ConfigIpls.scifiScene1 then
					ActivateInteriorEntitySet(ConfigIpls.arenaWarsId, "Set_Scifi_01")
				elseif ConfigIpls.scifiScene2 then
					ActivateInteriorEntitySet(ConfigIpls.arenaWarsId, "Set_Scifi_02")
				elseif ConfigIpls.scifiScene3 then
					ActivateInteriorEntitySet(ConfigIpls.arenaWarsId, "Set_Scifi_03")
				elseif ConfigIpls.scifiScene4 then
					ActivateInteriorEntitySet(ConfigIpls.arenaWarsId, "Set_Scifi_04")
				elseif ConfigIpls.scifiScene5 then
					ActivateInteriorEntitySet(ConfigIpls.arenaWarsId, "Set_Scifi_05")
				elseif ConfigIpls.scifiScene6 then
					ActivateInteriorEntitySet(ConfigIpls.arenaWarsId, "Set_Scifi_06")
				elseif ConfigIpls.scifiScene7 then
					ActivateInteriorEntitySet(ConfigIpls.arenaWarsId, "Set_Scifi_07")
				elseif ConfigIpls.scifiScene8 then
					ActivateInteriorEntitySet(ConfigIpls.arenaWarsId, "Set_Scifi_08")
				elseif ConfigIpls.scifiScene9 then
					ActivateInteriorEntitySet(ConfigIpls.arenaWarsId, "Set_Scifi_09")
				elseif ConfigIpls.scifiScene10 then
					ActivateInteriorEntitySet(ConfigIpls.arenaWarsId, "Set_Scifi_10")
				end
			end
		end
		if ConfigIpls.wastelandScene then
			if ConfigIpls.arenaWars then
				ActivateInteriorEntitySet(ConfigIpls.arenaWarsId, "Set_Wasteland_Scene")
				if ConfigIpls.wastelandScene1 then
					ActivateInteriorEntitySet(ConfigIpls.arenaWarsId, "Set_Wasteland_01")
				elseif ConfigIpls.wastelandScene2 then
					ActivateInteriorEntitySet(ConfigIpls.arenaWarsId, "Set_Wasteland_02")
				elseif ConfigIpls.wastelandScene3 then
					ActivateInteriorEntitySet(ConfigIpls.arenaWarsId, "Set_Wasteland_03")
				elseif ConfigIpls.wastelandScene4 then
					ActivateInteriorEntitySet(ConfigIpls.arenaWarsId, "Set_Wasteland_04")
				elseif ConfigIpls.wastelandScene5 then
					ActivateInteriorEntitySet(ConfigIpls.arenaWarsId, "Set_Wasteland_05")
				elseif ConfigIpls.wastelandScene6 then
					ActivateInteriorEntitySet(ConfigIpls.arenaWarsId, "Set_Wasteland_06")
				elseif ConfigIpls.wastelandScene7 then
					ActivateInteriorEntitySet(ConfigIpls.arenaWarsId, "Set_Wasteland_07")
				elseif ConfigIpls.wastelandScene8 then
					ActivateInteriorEntitySet(ConfigIpls.arenaWarsId, "Set_Wasteland_08")
				elseif ConfigIpls.wastelandScene9 then
					ActivateInteriorEntitySet(ConfigIpls.arenaWarsId, "Set_Wasteland_09")
				elseif ConfigIpls.wastelandScene10 then
					ActivateInteriorEntitySet(ConfigIpls.arenaWarsId, "Set_Wasteland_10")
				end
			end
		end
		if ConfigIpls.clubNameGalaxy then
			if ConfigIpls.nightClubs then
				ActivateInteriorEntitySet(ConfigIpls.nightClubsId, "Int01_ba_clubname_01")
			end
		elseif ConfigIpls.clubNameStudioLosSantos then
			if ConfigIpls.nightClubs then
				ActivateInteriorEntitySet(ConfigIpls.nightClubsId, "Int01_ba_clubname_02")
			end
		elseif ConfigIpls.clubNameOmega then
			if ConfigIpls.nightClubs then
				ActivateInteriorEntitySet(ConfigIpls.nightClubsId, "Int01_ba_clubname_03")
			end
		elseif ConfigIpls.clubNameTechnoLogie then
			if ConfigIpls.nightClubs then
				ActivateInteriorEntitySet(ConfigIpls.nightClubsId, "Int01_ba_clubname_04")
			end
		elseif ConfigIpls.clubNameGefangnis then
			if ConfigIpls.nightClubs then
				ActivateInteriorEntitySet(ConfigIpls.nightClubsId, "Int01_ba_clubname_05")
			end
		elseif ConfigIpls.clubNameMaisonette then
			if ConfigIpls.nightClubs then
				ActivateInteriorEntitySet(ConfigIpls.nightClubsId, "Int01_ba_clubname_06")
			end
		elseif ConfigIpls.clubNameTonysFunHouse then
			if ConfigIpls.nightClubs then
				ActivateInteriorEntitySet(ConfigIpls.nightClubsId, "Int01_ba_clubname_07")
			end
		elseif ConfigIpls.clubNameThePalace then
			if ConfigIpls.nightClubs then
				ActivateInteriorEntitySet(ConfigIpls.nightClubsId, "Int01_ba_clubname_08")
			end
		elseif ConfigIpls.clubNameParadise then
			if ConfigIpls.nightClubs then
				ActivateInteriorEntitySet(ConfigIpls.nightClubsId, "Int01_ba_clubname_09")
			end
			end
		if ConfigIpls.nightClubStyle1 then
			if ConfigIpls.nightClubs then
				ActivateInteriorEntitySet(ConfigIpls.nightClubsId, "Int01_ba_Style01")
			end
		elseif ConfigIpls.nightClubStyle2 then
			if ConfigIpls.nightClubs then
				ActivateInteriorEntitySet(ConfigIpls.nightClubsId, "Int01_ba_Style02")
			end
		elseif ConfigIpls.nightClubStyle3 then
			if ConfigIpls.nightClubs then
				ActivateInteriorEntitySet(ConfigIpls.nightClubsId, "Int01_ba_Style03")
			end
		end
		if ConfigIpls.nightClubPodium1 then
			if ConfigIpls.nightClubs then
				ActivateInteriorEntitySet(ConfigIpls.nightClubsId, "Int01_ba_style01_podium")
			end
		elseif ConfigIpls.nightClubPodium2 then
			if ConfigIpls.nightClubs then
				ActivateInteriorEntitySet(ConfigIpls.nightClubsId, "Int01_ba_style02_podium")
			end
		elseif ConfigIpls.nightClubPodium3 then
			if ConfigIpls.nightClubs then
				ActivateInteriorEntitySet(ConfigIpls.nightClubsId, "Int01_ba_style03_podium")
			end
		end
		if ConfigIpls.nightClubSetup then
			if ConfigIpls.nightClubs then
				ActivateInteriorEntitySet(ConfigIpls.nightClubsId, "Int01_ba_equipment_setup")
			end
		elseif ConfigIpls.nightClubSetupUpgrade then
			if ConfigIpls.nightClubs then
				ActivateInteriorEntitySet(ConfigIpls.nightClubsId, "Int01_ba_equipment_upgrade")
			end
		end
		if ConfigIpls.nightClubSecurityUpgrade then
			if ConfigIpls.nightClubs then
				ActivateInteriorEntitySet(ConfigIpls.nightClubsId, "Int01_ba_security_upgrade")
			end
		end
		if ConfigIpls.nightClubsDjBooth1 then
			if ConfigIpls.nightClubs then
				ActivateInteriorEntitySet(ConfigIpls.nightClubsId, "Int01_ba_dj01")
			end
		elseif ConfigIpls.nightClubsDjBooth2 then
			if ConfigIpls.nightClubs then
				ActivateInteriorEntitySet(ConfigIpls.nightClubsId, "Int01_ba_dj02")
			end
		elseif ConfigIpls.nightClubsDjBooth3 then
			if ConfigIpls.nightClubs then
				ActivateInteriorEntitySet(ConfigIpls.nightClubsId, "Int01_ba_dj03")
			end
		elseif ConfigIpls.nightClubsDjBooth4 then
			if ConfigIpls.nightClubs then
				ActivateInteriorEntitySet(ConfigIpls.nightClubsId, "Int01_ba_dj04")
			end
		end
		if ConfigIpls.nightClubsLightsOne1 then
			if ConfigIpls.nightClubs then
				ActivateInteriorEntitySet(ConfigIpls.nightClubsId, "DJ_01_Lights_01")
			end
		end
		if ConfigIpls.nightClubsLightsOne2 then
			if ConfigIpls.nightClubs then
				ActivateInteriorEntitySet(ConfigIpls.nightClubsId, "DJ_02_Lights_01")
			end
		end
		if ConfigIpls.nightClubsLightsOne3 then
			if ConfigIpls.nightClubs then
				ActivateInteriorEntitySet(ConfigIpls.nightClubsId, "DJ_03_Lights_01")
			end
		end
		if ConfigIpls.nightClubsLightsOne4 then
			if ConfigIpls.nightClubs then
				ActivateInteriorEntitySet(ConfigIpls.nightClubsId, "DJ_04_Lights_01")
			end
		end
		if ConfigIpls.nightClubsLightsTwo1 then
			if ConfigIpls.nightClubs then
				ActivateInteriorEntitySet(ConfigIpls.nightClubsId, "DJ_01_Lights_02")
			end
		end
		if ConfigIpls.nightClubsLightsTwo1 then
			if ConfigIpls.nightClubs then
				ActivateInteriorEntitySet(ConfigIpls.nightClubsId, "DJ_02_Lights_02")
			end
		end
		if ConfigIpls.nightClubsLightsTwo3 then
			if ConfigIpls.nightClubs then
				ActivateInteriorEntitySet(ConfigIpls.nightClubsId, "DJ_03_Lights_02")
			end
		end
		if ConfigIpls.nightClubsLightsTwo4 then
			if ConfigIpls.nightClubs then
				ActivateInteriorEntitySet(ConfigIpls.nightClubsId, "DJ_04_Lights_02")
			end
		end
		if ConfigIpls.nightClubsLightsThree1 then
			if ConfigIpls.nightClubs then
				ActivateInteriorEntitySet(ConfigIpls.nightClubsId, "DJ_01_Lights_03")
			end
		end
		if ConfigIpls.nightClubsLightsThree2 then
			if ConfigIpls.nightClubs then
				ActivateInteriorEntitySet(ConfigIpls.nightClubsId, "DJ_02_Lights_03")
			end
		end
		if ConfigIpls.nightClubsLightsThree3 then
			if ConfigIpls.nightClubs then
				ActivateInteriorEntitySet(ConfigIpls.nightClubsId, "DJ_03_Lights_03")
			end
		end
		if ConfigIpls.nightClubsLightsThree4 then
			if ConfigIpls.nightClubs then
				ActivateInteriorEntitySet(ConfigIpls.nightClubsId, "DJ_04_Lights_03")
			end
		end
		if ConfigIpls.nightClubsLightsFour1 then
			if ConfigIpls.nightClubs then
				ActivateInteriorEntitySet(ConfigIpls.nightClubsId, "DJ_01_Lights_04")
			end
		end
		if ConfigIpls.nightClubsLightsFour2 then
			if ConfigIpls.nightClubs then
				ActivateInteriorEntitySet(ConfigIpls.nightClubsId, "DJ_02_Lights_04")
			end
		end
		if ConfigIpls.nightClubsLightsFour3 then
			if ConfigIpls.nightClubs then
				ActivateInteriorEntitySet(ConfigIpls.nightClubsId, "DJ_03_Lights_04")
			end
		end
		if ConfigIpls.nightClubsLightsFour4 then
			if ConfigIpls.nightClubs then
				ActivateInteriorEntitySet(ConfigIpls.nightClubsId, "DJ_04_Lights_04")
			end
		end
		if ConfigIpls.nightClubsBarContent then
			if ConfigIpls.nightClubs then
				ActivateInteriorEntitySet(ConfigIpls.nightClubsId, "Int01_ba_bar_content")
				if ConfigIpls.nightClubBooze1 then
					ActivateInteriorEntitySet(ConfigIpls.nightClubsId, "Int01_ba_booze_01")
				end
				if ConfigIpls.nightClubBooze2 then
					ActivateInteriorEntitySet(ConfigIpls.nightClubsId, "Int01_ba_booze_02")
				end
				if ConfigIpls.nightClubBooze3 then
					ActivateInteriorEntitySet(ConfigIpls.nightClubsId, "Int01_ba_booze_03")
				end
			end
		end
		if ConfigIpls.nightClubTrophy1 then
			if ConfigIpls.nightClubs then
				ActivateInteriorEntitySet(ConfigIpls.nightClubsId, "Int01_ba_trophy01")
			end
		end
		if ConfigIpls.nightClubTrophy2 then
			if ConfigIpls.nightClubs then
				ActivateInteriorEntitySet(ConfigIpls.nightClubsId, "Int01_ba_trophy02")
			end
		end
		if ConfigIpls.nightClubTrophy3 then
			if ConfigIpls.nightClubs then
				ActivateInteriorEntitySet(ConfigIpls.nightClubsId, "Int01_ba_trophy03")
			end
		end
		if ConfigIpls.nightClubOfficeChest then
			if ConfigIpls.nightClubs then
				ActivateInteriorEntitySet(ConfigIpls.nightClubsId, "Int01_ba_trophy04")
			end
		end
		if ConfigIpls.nightClubOfficeAmmoBoxes then
			if ConfigIpls.nightClubs then
				ActivateInteriorEntitySet(ConfigIpls.nightClubsId, "Int01_ba_trophy05")
			end
		end
		if ConfigIpls.nightClubOfficeMeth then
			if ConfigIpls.nightClubs then
				ActivateInteriorEntitySet(ConfigIpls.nightClubsId, "Int01_ba_trophy07")
			end
		end
		if ConfigIpls.nightClubOfficeFakeIds then
			if ConfigIpls.nightClubs then
				ActivateInteriorEntitySet(ConfigIpls.nightClubsId, "Int01_ba_trophy08")
			end
		end
		if ConfigIpls.nightClubOfficeWeed then
			if ConfigIpls.nightClubs then
				ActivateInteriorEntitySet(ConfigIpls.nightClubsId, "Int01_ba_trophy09")
			end
		end
		if ConfigIpls.nightClubOfficeCoke then
			if ConfigIpls.nightClubs then
				ActivateInteriorEntitySet(ConfigIpls.nightClubsId, "Int01_ba_trophy10")
			end
		end
		if ConfigIpls.nightClubOfficeCash then
			if ConfigIpls.nightClubs then
				ActivateInteriorEntitySet(ConfigIpls.nightClubsId, "Int01_ba_trophy11")
			end
		end
		if ConfigIpls.nightClubsOfficeClutter then
			if ConfigIpls.nightClubs then
				ActivateInteriorEntitySet(ConfigIpls.nightClubsId, "Int01_ba_Clutter")
			end
		end
		if ConfigIpls.nightClubsWorkLamps then
			if ConfigIpls.nightClubs then
				ActivateInteriorEntitySet(ConfigIpls.nightClubsId, "Int01_ba_Worklamps")
			end
		end
		if ConfigIpls.nightClubsDeliveryTruck then
			if ConfigIpls.nightClubs then
				ActivateInteriorEntitySet(ConfigIpls.nightClubsId, "Int01_ba_deliverytruck")
			end
		end
		if ConfigIpls.nightClubsDryIce then
			if ConfigIpls.nightClubs then
				ActivateInteriorEntitySet(ConfigIpls.nightClubsId, "Int01_ba_dry_ice")
			end
		end
		if ConfigIpls.nightClubsRigsOff then
			if ConfigIpls.nightClubs then
				ActivateInteriorEntitySet(ConfigIpls.nightClubsId, "light_rigs_off")
			end
		end
		if ConfigIpls.nightClubsLightGrid then
			if ConfigIpls.nightClubs then
				ActivateInteriorEntitySet(ConfigIpls.nightClubsId, "Int01_ba_lightgrid_01")
			end
		end
		if ConfigIpls.nightClubsTradLights then
			if ConfigIpls.nightClubs then
				ActivateInteriorEntitySet(ConfigIpls.nightClubsId, "Int01_ba_trad_lights")
			end
		end
		if ConfigIpls.nightClubsForSale then
			if ConfigIpls.nightClubs then
				ActivateInteriorEntitySet(ConfigIpls.nightClubsId, "ba_caseX_forsale")
			end
		end
		if ConfigIpls.nightClubsDixon then
			if ConfigIpls.nightClubs then
				ActivateInteriorEntitySet(ConfigIpls.nightClubsId, "ba_caseX_dixon")
			end
		end
		if ConfigIpls.nightClubsMadonna then
			if ConfigIpls.nightClubs then
				ActivateInteriorEntitySet(ConfigIpls.nightClubsId, "ba_caseX_madonna")
			end
		end
		if ConfigIpls.nightClubsSolomun then
			if ConfigIpls.nightClubs then
				ActivateInteriorEntitySet(ConfigIpls.nightClubsId, "ba_caseX_solomun")
			end
		end
		if ConfigIpls.nightClubsTaleOfUs then
			if ConfigIpls.nightClubs then
				ActivateInteriorEntitySet(ConfigIpls.nightClubsId, "ba_caseX_taleofus")
			end
		end
		if ConfigIpls.nightClubsBarriers then
			if ConfigIpls.nightClubs then
				ActivateInteriorEntitySet(ConfigIpls.nightClubsId, "ba_barriers_caseX")
			end
		end
		if ConfigIpls.nightClubsSmokeMachine then
			if ConfigIpls.nightClubs then
				ActivateInteriorEntitySet(ConfigIpls.nightClubsId, "scr_ba_club")
				UseParticleFxAsset("scr_ba_club")
				StartParticleFxLoopedAtCoord("scr_ba_club_smoke_machine", -1602.932, -3019.1, -79.99, 0.0, -10.0, 66.0, ConfigIpls.nightClubsDryIceScale, false, false, false, true)
				StartParticleFxLoopedAtCoord("scr_ba_club_smoke_machine", -1593.238, -3017.05, -79.99, 0.0, -10.0, 110.0, ConfigIpls.nightClubsDryIceScale, false, false, false, true)
				StartParticleFxLoopedAtCoord("scr_ba_club_smoke_machine", -1597.134, -3008.2, -79.99, 0.0, -10.0, -122.53, ConfigIpls.nightClubsDryIceScale, false, false, false, true)
				StartParticleFxLoopedAtCoord("scr_ba_club_smoke_machine", -1589.966, -3008.518, -79.99, 0.0, -10.0, -166.97, ConfigIpls.nightClubsDryIceScale, false, false, false, true)
			end
		end
		break
	end	
end)
