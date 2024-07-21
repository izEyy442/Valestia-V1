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
		if ConfigIpls.iplsCustomizable then
			if ConfigIpls.nightClubs then
				RequestIpl("ba_int_placement_ba_interior_0_dlc_int_01_ba_milo_")
				if ConfigIpls.pinInteriorInMemory then
					PinInteriorInMemory(ConfigIpls.nightClubsId)
				end
				RefreshInterior(ConfigIpls.nightClubsId)
			end
			if ConfigIpls.planeCrash then
				RequestIpl("Plane_crash_trench")
			end
			if ConfigIpls.simeonIpl then
				RequestIpl("shr_int")
				if ConfigIpls.pinInteriorInMemory then
					PinInteriorInMemory(ConfigIpls.simeonId)
				end
				RefreshInterior(ConfigIpls.simeonId)
			end
			if ConfigIpls.trevorsTrailerTrash then
				RequestIpl("TrevorsTrailerTrash")
				if ConfigIpls.pinInteriorInMemory then
					PinInteriorInMemory(ConfigIpls.trevorsTrailerId)
				end
				RefreshInterior(ConfigIpls.trevorsTrailerId)
			elseif ConfigIpls.trevorsTrailerTidy then
				RequestIpl("TrevorsTrailerTidy")
				if ConfigIpls.pinInteriorInMemory then
					PinInteriorInMemory(ConfigIpls.trevorsTrailerId)
				end
				RefreshInterior(ConfigIpls.trevorsTrailerId)
			end
			if ConfigIpls.vangelicoJewelry then
				RequestIpl("post_hiest_unload")
				if ConfigIpls.pinInteriorInMemory then
					PinInteriorInMemory(ConfigIpls.vangelicoJewelryId)
				end
				RefreshInterior(ConfigIpls.vangelicoJewelryId)
			end
			if ConfigIpls.maxRenda then
				RequestIpl("refit_unload")
			end
			if ConfigIpls.unionDepository then
				RequestIpl("FINBANK")
				if ConfigIpls.pinInteriorInMemory then
					PinInteriorInMemory(ConfigIpls.unionDepositoryId)
				end
				RefreshInterior(ConfigIpls.unionDepositoryId)
			end
			if ConfigIpls.morgue then
				RequestIpl("Coroner_Int_on")
				RequestIpl("coronertrash")
				if ConfigIpls.pinInteriorInMemory then
					PinInteriorInMemory(ConfigIpls.morgueId)
				end
				RefreshInterior(ConfigIpls.morgueId)
			end
			if ConfigIpls.cluckinBell then
				RequestIpl("CS1_02_cf_onmission1")
				RequestIpl("CS1_02_cf_onmission2")
				RequestIpl("CS1_02_cf_onmission3")
				RequestIpl("CS1_02_cf_onmission4")
				RemoveIpl("CS1_02_cf_offmission")
				if ConfigIpls.pinInteriorInMemory then
					PinInteriorInMemory(ConfigIpls.cluckinBellId)
				end
				RefreshInterior(ConfigIpls.cluckinBellId)
			end
			if ConfigIpls.oneilsFarm then
				RequestIpl("farm")
				RequestIpl("farmint")
				RequestIpl("farm_lod")
				RequestIpl("farm_props")
				RequestIpl("des_farmhouse")
				if ConfigIpls.pinInteriorInMemory then
					PinInteriorInMemory(ConfigIpls.oneilsFarmId)
				end
				RefreshInterior(ConfigIpls.oneilsFarmId)
			elseif ConfigIpls.oneilsFarmBurnt then
				RequestIpl("farm_burnt")
				RequestIpl("farmint")
				RequestIpl("farm_lod")
				RequestIpl("farm_burnt_props")
				RequestIpl("des_farmhs_	endimap")
				RequestIpl("des_farmhs_	end_occl")
				if ConfigIpls.pinInteriorInMemory then
					PinInteriorInMemory(ConfigIpls.oneilsFarmId)
				end
				RefreshInterior(ConfigIpls.oneilsFarmId)
			end
			if ConfigIpls.fbiLobby then
				RequestIpl("FIBlobby")
				if ConfigIpls.pinInteriorInMemory then
					PinInteriorInMemory(ConfigIpls.FIBLobbyId)
				end
				RefreshInterior(ConfigIpls.FIBLobbyId)
			end
			if ConfigIpls.iFruitBillboard then
				RequestIpl("FruitBB")
				RequestIpl("sc1_01_newbill")
				RequestIpl("hw1_02_newbill")
				RequestIpl("hw1_emissive_newbill")
				RequestIpl("sc1_14_newbill")
				RequestIpl("dt1_17_newbill")
			end
			if ConfigIpls.lesterFactory then
				RequestIpl("id2_14_during_door")
				RequestIpl("id2_14_during1")
				if ConfigIpls.pinInteriorInMemory then
					PinInteriorInMemory(ConfigIpls.lesterFactoryId)
				end
				RefreshInterior(ConfigIpls.lesterFactoryId)
			end
			if ConfigIpls.lifeInvader then
				RequestIpl("facelobby")
				if ConfigIpls.pinInteriorInMemory then
					PinInteriorInMemory(ConfigIpls.lifeInvaderId)
				end
				RefreshInterior(ConfigIpls.lifeInvaderId)
			end
			if ConfigIpls.tunnels then
				RequestIpl("v_tunnel_hole")
			end
			if ConfigIpls.carWash then
				RequestIpl("Carwash_with_spinners")
			end
			if ConfigIpls.fameOrShame then
				RequestIpl("sp1_10_real_interior")
				RequestIpl("sp1_10_real_interior_lod")
				if ConfigIpls.pinInteriorInMemory then
					PinInteriorInMemory(ConfigIpls.fameOrShameId)
				end
				RefreshInterior(ConfigIpls.fameOrShameId)
			end
			if ConfigIpls.banhamCanyonHouse then
				RequestIpl("ch1_02_open")
			end
			if ConfigIpls.laMesaGarage then
				RequestIpl("bkr_bi_id1_23_door")
			end
			if ConfigIpls.hillValleyChurch then
				RequestIpl("lr_cs6_08_grave_closed")
			end
			if ConfigIpls.lostTrailerPark then
				RequestIpl("methtrailer_grp1")
			end
			if ConfigIpls.lostSafeHouse then
				RequestIpl("bkr_bi_hw1_13_int")
			end
			if ConfigIpls.ratonCanyonRiver then
				RequestIpl("CanyonRvrShallow")
			end
			if ConfigIpls.zancudoGates then
				RequestIpl("CS3_07_MPGates")
			end
			if ConfigIpls.zancudoRiver then
				RequestIpl("cs3_05_water_grp1")
				RequestIpl("cs3_05_water_grp1_lod")
				RequestIpl("cs3_05_water_grp2")
				RequestIpl("cs3_05_water_grp2_lod")
			end
			if ConfigIpls.joshsHouse then
				RequestIpl("bh1_47_joshhse_unburnt")
				RequestIpl("bh1_47_joshhse_unburnt_lod")
			end
			if ConfigIpls.cassidyCreek then
				RequestIpl("canyonriver01")
				RequestIpl("canyonriver01_lod")
			end
			if ConfigIpls.cassidyCreek then
				RequestIpl("ch3_rd2_bishopschickengraffiti")
				RequestIpl("cs5_04_mazebillboardgraffiti")
				RequestIpl("cs5_roads_ronoilgraffiti")
			end
			if ConfigIpls.graffiti then
				RequestIpl("ch3_rd2_bishopschickengraffiti")
				RequestIpl("cs5_04_mazebillboardgraffiti")
				RequestIpl("cs5_roads_ronoilgraffiti")
			end
			if ConfigIpls.ussLuxington then
				RequestIpl("hei_carrier")
				RequestIpl("hei_carrier_distantlights")
				RequestIpl("hei_Carrier_int1")
				RequestIpl("hei_Carrier_int2")
				RequestIpl("hei_Carrier_int3")
				RequestIpl("hei_Carrier_int4")
				RequestIpl("hei_Carrier_int5")
				RequestIpl("hei_Carrier_int6")
				RequestIpl("hei_carrier_lodlights")
				RequestIpl("hei_carrier_slod")
			end
			if ConfigIpls.gunrunningHeistYacht then
				RequestIpl("gr_heist_yacht2")
	        	RequestIpl("gr_heist_yacht2_bar")
	        	RequestIpl("gr_heist_yacht2_bedrm")
	        	RequestIpl("gr_heist_yacht2_bridge")
	        	RequestIpl("gr_heist_yacht2_enginrm")
	        	RequestIpl("gr_heist_yacht2_lounge")
			end
			if ConfigIpls.dignityHeistYacht then
				RequestIpl("hei_yacht_heist")
	        	RequestIpl("hei_yacht_heist_enginrm")
	        	RequestIpl("hei_yacht_heist_Lounge")
	        	RequestIpl("hei_yacht_heist_Bridge")
	        	RequestIpl("hei_yacht_heist_Bar")
	        	RequestIpl("hei_yacht_heist_Bedrm")
	        	RequestIpl("hei_yacht_heist_DistantLights")
	        	RequestIpl("hei_yacht_heist_LODLights")
	        	RequestIpl("smboat")
	        	RequestIpl("smboat_lod")
			end
			if ConfigIpls.galaxySuperYacht then
				RequestIpl("hei_yacht_heist")
	        	RequestIpl("hei_yacht_heist_Bar")
	        	RequestIpl("hei_yacht_heist_Bedrm")
	        	RequestIpl("hei_yacht_heist_Bridge")
	        	RequestIpl("hei_yacht_heist_DistantLights")
	        	RequestIpl("hei_yacht_heist_enginrm")
	        	RequestIpl("hei_yacht_heist_LODLights")
	        	RequestIpl("hei_yacht_heist_Lounge")
			end
			if ConfigIpls.bahamaMamas then
				RequestIpl("hei_sm_16_interior_v_bahama_milo_")
				if ConfigIpls.pinInteriorInMemory then
					PinInteriorInMemory(ConfigIpls.bahamaMamas)
				end
				RefreshInterior(ConfigIpls.bahamaMamas)
			end
			if ConfigIpls.ufo then
				RequestIpl("ufo")
				RequestIpl("ufo_eye")
				RequestIpl("ufo_lod")
			end
			if ConfigIpls.ceoOffices then
				if ConfigIpls.arcadiusOldSpiceWarm then
					RequestIpl("ex_dt1_02_office_01a")
					if ConfigIpls.pinInteriorInMemory then
						PinInteriorInMemory(ConfigIpls.arcadiusOldSpiceWarmId)
					end
					RefreshInterior(ConfigIpls.arcadiusOldSpiceWarmId)
				elseif ConfigIpls.arcadiusOldSpiceVintage then
					RequestIpl("ex_dt1_02_office_01c")
					if ConfigIpls.pinInteriorInMemory then
						PinInteriorInMemory(ConfigIpls.arcadiusOldSpiceVintageId)
					end
					RefreshInterior(ConfigIpls.arcadiusOldSpiceVintageId)
				elseif ConfigIpls.arcadiusOldSpiceClassical then
					RequestIpl("ex_dt1_02_office_01b")
					if ConfigIpls.pinInteriorInMemory then
						PinInteriorInMemory(ConfigIpls.arcadiusOldSpiceClassicalId)
					end
					RefreshInterior(ConfigIpls.arcadiusOldSpiceClassicalId)
				elseif ConfigIpls.arcadiusExecutiveContrast then
					RequestIpl("ex_dt1_02_office_02a")
					if ConfigIpls.pinInteriorInMemory then
						PinInteriorInMemory(ConfigIpls.arcadiusExecutiveContrastId)
					end
					RefreshInterior(ConfigIpls.arcadiusExecutiveContrastId)
				elseif ConfigIpls.arcadiusExecutiveRich then
					RequestIpl("ex_dt1_02_office_02b")
					if ConfigIpls.pinInteriorInMemory then
						PinInteriorInMemory(ConfigIpls.arcadiusExecutiveRichId)
					end
					RefreshInterior(ConfigIpls.arcadiusExecutiveRichId)
				elseif ConfigIpls.arcadiusExecutiveCool then
					RequestIpl("ex_dt1_02_office_02c")
					if ConfigIpls.pinInteriorInMemory then
						PinInteriorInMemory(ConfigIpls.arcadiusExecutiveCoolId)
					end
					RefreshInterior(ConfigIpls.arcadiusExecutiveCoolId)
				elseif ConfigIpls.arcadiusPowerBrokerIce then
					RequestIpl("ex_dt1_02_office_03a")
					if ConfigIpls.pinInteriorInMemory then
						PinInteriorInMemory(ConfigIpls.arcadiusPowerBrokerIceId)
					end
					RefreshInterior(ConfigIpls.arcadiusPowerBrokerIceId)
				elseif ConfigIpls.arcadiusPowerBrokerConservative then
					RequestIpl("ex_dt1_02_office_03b")
					if ConfigIpls.pinInteriorInMemory then
						PinInteriorInMemory(ConfigIpls.arcadiusPowerBrokerConservativeId)
					end
					RefreshInterior(ConfigIpls.arcadiusPowerBrokerConservativeId)
				elseif ConfigIpls.arcadiusPowerBrokerPolished then
					RequestIpl("ex_dt1_02_office_03c")
					if ConfigIpls.pinInteriorInMemory then
						PinInteriorInMemory(ConfigIpls.arcadiusPowerBrokerPolishedId)
					end
					RefreshInterior(ConfigIpls.arcadiusPowerBrokerPolishedId)
				end
				if ConfigIpls.mazeBankOldSpiceWarm then
					RequestIpl("ex_dt1_11_office_01a")
					if ConfigIpls.pinInteriorInMemory then
						PinInteriorInMemory(ConfigIpls.mazeBankOldSpiceWarmId)
					end
					RefreshInterior(ConfigIpls.mazeBankOldSpiceWarmId)
				elseif ConfigIpls.mazeBankOldSpiceClassical then
					RequestIpl("ex_dt1_11_office_01b")
					if ConfigIpls.pinInteriorInMemory then
						PinInteriorInMemory(ConfigIpls.mazeBankOldSpiceClassicalId)
					end
					RefreshInterior(ConfigIpls.mazeBankOldSpiceClassicalId)
				elseif ConfigIpls.mazeBankOldSpiceVintage then
					RequestIpl("ex_dt1_11_office_01c")
					if ConfigIpls.pinInteriorInMemory then
						PinInteriorInMemory(ConfigIpls.mazeBankOldSpiceVintageId)
					end
					RefreshInterior(ConfigIpls.mazeBankOldSpiceVintageId)
				elseif ConfigIpls.mazeBankExecutiveRich then
					RequestIpl("ex_dt1_11_office_02b")
					if ConfigIpls.pinInteriorInMemory then
						PinInteriorInMemory(ConfigIpls.mazeBankExecutiveRichId)
					end
					RefreshInterior(ConfigIpls.mazeBankExecutiveRichId)
				elseif ConfigIpls.mazeBankExecutiveCool then
					RequestIpl("ex_dt1_11_office_02c")
					if ConfigIpls.pinInteriorInMemory then
						PinInteriorInMemory(ConfigIpls.mazeBankExecutiveCoolId)
					end
					RefreshInterior(ConfigIpls.mazeBankExecutiveCoolId)
				elseif ConfigIpls.mazeBankExecutiveContrast then
					RequestIpl("ex_dt1_11_office_02a")
					if ConfigIpls.pinInteriorInMemory then
						PinInteriorInMemory(ConfigIpls.mazeBankExecutiveContrastId)
					end
					RefreshInterior(ConfigIpls.mazeBankExecutiveContrastId)
				elseif ConfigIpls.mazeBankPowerBrokerIce then
					RequestIpl("ex_dt1_11_office_03a")
					if ConfigIpls.pinInteriorInMemory then
						PinInteriorInMemory(ConfigIpls.mazeBankPowerBrokerIceId)
					end
					RefreshInterior(ConfigIpls.mazeBankPowerBrokerIceId)
				elseif ConfigIpls.mazeBankPowerBrokerConservative then
					RequestIpl("ex_dt1_11_office_03b")
					if ConfigIpls.pinInteriorInMemory then
						PinInteriorInMemory(ConfigIpls.mazeBankPowerBrokerConservativeId)
					end
					RefreshInterior(ConfigIpls.mazeBankPowerBrokerConservativeId)
				elseif ConfigIpls.mazeBankPowerBrokerPolished then
					RequestIpl("ex_dt1_11_office_03c")
				if ConfigIpls.pinInteriorInMemory then
						PinInteriorInMemory(ConfigIpls.mazeBankPowerBrokerPolishedId)
					end
					RefreshInterior(ConfigIpls.mazeBankPowerBrokerPolishedId)
				end
				if ConfigIpls.mazeWestOldSpiceWarm then
					RequestIpl("ex_sm_15_office_01a")
					if ConfigIpls.pinInteriorInMemory then
						PinInteriorInMemory(ConfigIpls.mazeWestOldSpiceWarmId)
					end
					RefreshInterior(ConfigIpls.mazeWestOldSpiceWarmId)
				elseif ConfigIpls.mazeWestOldSpiceClassical then
					RequestIpl("ex_sm_15_office_01b")
					if ConfigIpls.pinInteriorInMemory then
						PinInteriorInMemory(ConfigIpls.mazeWestOldSpiceClassicalId)
					end
					RefreshInterior(ConfigIpls.mazeWestOldSpiceClassicalId)
				elseif ConfigIpls.mazeWestOldSpiceVintage then
					RequestIpl("ex_sm_15_office_01c")
					if ConfigIpls.pinInteriorInMemory then
						PinInteriorInMemory(ConfigIpls.mazeWestOldSpiceVintageId)
					end
					RefreshInterior(ConfigIpls.mazeWestOldSpiceVintageId)
				elseif ConfigIpls.mazeWestExecutiveRich then
					RequestIpl("ex_sm_15_office_02b")
					if ConfigIpls.pinInteriorInMemory then
						PinInteriorInMemory(ConfigIpls.mazeWestExecutiveRichId)
					end
					RefreshInterior(ConfigIpls.mazeWestExecutiveRichId)
				elseif ConfigIpls.mazeWestExecutiveCool then
					RequestIpl("ex_sm_15_office_02c")
					if ConfigIpls.pinInteriorInMemory then
						PinInteriorInMemory(ConfigIpls.mazeWestExecutiveCoolId)
					end
					RefreshInterior(ConfigIpls.mazeWestExecutiveCoolId)
				elseif ConfigIpls.mazeWestExecutiveContrast then
					RequestIpl("ex_sm_15_office_02a")
					if ConfigIpls.pinInteriorInMemory then
						PinInteriorInMemory(ConfigIpls.mazeWestExecutiveContrastId)
					end
					RefreshInterior(ConfigIpls.mazeWestExecutiveContrastId)
				elseif ConfigIpls.mazeWestPowerBrokerIce then
					RequestIpl("ex_sm_15_office_03a")
					if ConfigIpls.pinInteriorInMemory then
						PinInteriorInMemory(ConfigIpls.mazeWestPowerBrokerIceId)
					end
					RefreshInterior(ConfigIpls.mazeWestPowerBrokerIceId)
				elseif ConfigIpls.mazeWestPowerBrokerConservative then
					RequestIpl("ex_sm_15_office_03b")
					if ConfigIpls.pinInteriorInMemory then
						PinInteriorInMemory(ConfigIpls.mazeWestPowerBrokerConservativeId)
					end
					RefreshInterior(ConfigIpls.mazeWestPowerBrokerConservativeId)
				elseif ConfigIpls.mazeWestPowerBrokerPolished then
					RequestIpl("ex_sm_15_office_03c")
					if ConfigIpls.pinInteriorInMemory then
						PinInteriorInMemory(ConfigIpls.mazeWestPowerBrokerPolishedId)
					end
					RefreshInterior(ConfigIpls.mazeWestPowerBrokerPolishedId)
				end
				if ConfigIpls.lomBankOldSpiceWarm then
					RequestIpl("ex_sm_13_office_01a")
					if ConfigIpls.pinInteriorInMemory then
						PinInteriorInMemory(ConfigIpls.lomBankOldSpiceWarmId)
					end
					RefreshInterior(ConfigIpls.lomBankOldSpiceWarmId)
				elseif ConfigIpls.lomBankOldSpiceClassical then
					RequestIpl("ex_sm_13_office_01b")
					if ConfigIpls.pinInteriorInMemory then
						PinInteriorInMemory(ConfigIpls.lomBankOldSpiceClassicalId)
					end
					RefreshInterior(ConfigIpls.lomBankOldSpiceClassicalId)
				elseif ConfigIpls.lomBankOldSpiceVintage then
					RequestIpl("ex_sm_13_office_01c")
					if ConfigIpls.pinInteriorInMemory then
						PinInteriorInMemory(ConfigIpls.lomBankOldSpiceVintageId)
					end
					RefreshInterior(ConfigIpls.lomBankOldSpiceVintageId)
				elseif ConfigIpls.lomBankExecutiveRich then
					RequestIpl("ex_sm_13_office_02b")
					if ConfigIpls.pinInteriorInMemory then
						PinInteriorInMemory(ConfigIpls.lomBankExecutiveRichId)
					end
					RefreshInterior(ConfigIpls.lomBankExecutiveRichId)
				elseif ConfigIpls.lomBankExecutiveCool then
					RequestIpl("ex_sm_13_office_02c")
					if ConfigIpls.pinInteriorInMemory then
						PinInteriorInMemory(ConfigIpls.lomBankExecutiveCoolId)
					end
					RefreshInterior(ConfigIpls.lomBankExecutiveCoolId)
				elseif ConfigIpls.lomBankExecutiveContrast then
					RequestIpl("ex_sm_13_office_02a")
					if ConfigIpls.pinInteriorInMemory then
						PinInteriorInMemory(ConfigIpls.lomBankExecutiveContrastId)
					end
					RefreshInterior(ConfigIpls.lomBankExecutiveContrastId)
				elseif ConfigIpls.lomBankPowerBrokerIce then
					RequestIpl("ex_sm_13_office_03a")
					if ConfigIpls.pinInteriorInMemory then
						PinInteriorInMemory(ConfigIpls.lomBankPowerBrokerIceId)
					end
					RefreshInterior(ConfigIpls.lomBankPowerBrokerIceId)
				elseif ConfigIpls.lomBankPowerBrokerConservative then
					RequestIpl("ex_sm_13_office_03b")
					if ConfigIpls.pinInteriorInMemory then
						PinInteriorInMemory(ConfigIpls.lomBankPowerBrokerConservativeId)
					end
					RefreshInterior(ConfigIpls.lomBankPowerBrokerConservativeId)
				elseif ConfigIpls.lomBankPowerBrokerPolished then
					RequestIpl("ex_sm_13_office_03c")
					if ConfigIpls.pinInteriorInMemory then
						PinInteriorInMemory(ConfigIpls.lomBankPowerBrokerPolishedId)
					end
					RefreshInterior(ConfigIpls.lomBankPowerBrokerPolishedId)
				end
			end
			if ConfigIpls.apartmentOneModern then
				RequestIpl("apa_v_mp_h_01_a")
				if ConfigIpls.pinInteriorInMemory then
					PinInteriorInMemory(ConfigIpls.apartmentOneModernId)
				end
				RefreshInterior(ConfigIpls.apartmentOneModernId)
			elseif ConfigIpls.apartmentOneMoody then
				RequestIpl("apa_v_mp_h_02_a")
				if ConfigIpls.pinInteriorInMemory then
					PinInteriorInMemory(ConfigIpls.apartmentOneMoodyId)
				end
				RefreshInterior(ConfigIpls.apartmentOneMoodyId)
			elseif ConfigIpls.apartmentOneVibrant then
				RequestIpl("apa_v_mp_h_03_a")
				if ConfigIpls.pinInteriorInMemory then
					PinInteriorInMemory(ConfigIpls.apartmentOneVirbrantId)
				end
				RefreshInterior(ConfigIpls.apartmentOneVirbrantId)
			elseif ConfigIpls.apartmentOneSharp then
				RequestIpl("apa_v_mp_h_04_a")
				if ConfigIpls.pinInteriorInMemory then
					PinInteriorInMemory(ConfigIpls.apartmentOneSharpId)
				end
				RefreshInterior(ConfigIpls.apartmentOneSharpId)
			elseif ConfigIpls.apartmentOneMonochrome then
				RequestIpl("apa_v_mp_h_05_a")
				if ConfigIpls.pinInteriorInMemory then
					PinInteriorInMemory(ConfigIpls.apartmentOneMonochromeId)
				end
				RefreshInterior(ConfigIpls.apartmentOneMonochromeId)
			elseif ConfigIpls.apartmentOneSeductive then
				RequestIpl("apa_v_mp_h_06_a")
				if ConfigIpls.pinInteriorInMemory then
					PinInteriorInMemory(ConfigIpls.apartmentOneSeductiveId)
				end
				RefreshInterior(ConfigIpls.apartmentOneSeductiveId)
			elseif ConfigIpls.apartmentOneRegal then
				RequestIpl("apa_v_mp_h_07_a")
				if ConfigIpls.pinInteriorInMemory then
					PinInteriorInMemory(ConfigIpls.apartmentOneRegalId)
				end
				RefreshInterior(ConfigIpls.apartmentOneRegalId)
			elseif ConfigIpls.apartmentOneAqua then
				RequestIpl("apa_v_mp_h_08_a")
				if ConfigIpls.pinInteriorInMemory then
					PinInteriorInMemory(ConfigIpls.apartmentOneAquaId)
				end
				RefreshInterior(ConfigIpls.apartmentOneAquaId)
			end
			if ConfigIpls.apartmentTwoModern then
				RequestIpl("apa_v_mp_h_01_c")
				if ConfigIpls.pinInteriorInMemory then
					PinInteriorInMemory(ConfigIpls.apartmentTwoModernId)
				end
				RefreshInterior(ConfigIpls.apartmentTwoModernId)
			elseif ConfigIpls.apartmentTwoMoody then
				RequestIpl("apa_v_mp_h_02_c")
				if ConfigIpls.pinInteriorInMemory then
					PinInteriorInMemory(ConfigIpls.apartmentTwoMoodyId)
				end
				RefreshInterior(ConfigIpls.apartmentTwoMoodyId)
			elseif ConfigIpls.apartmentTwoVibrant then
				RequestIpl("apa_v_mp_h_03_c")
				if ConfigIpls.pinInteriorInMemory then
					PinInteriorInMemory(ConfigIpls.apartmentTwoVirbrantId)
				end
				RefreshInterior(ConfigIpls.apartmentTwoVirbrantId)
			elseif ConfigIpls.apartmentTwoSharp then
				RequestIpl("apa_v_mp_h_04_c")
				if ConfigIpls.pinInteriorInMemory then
					PinInteriorInMemory(ConfigIpls.apartmentTwoSharpId)
				end
				RefreshInterior(ConfigIpls.apartmentTwoSharpId)
			elseif ConfigIpls.apartmentTwoMonochrome then
				RequestIpl("apa_v_mp_h_05_c")
				if ConfigIpls.pinInteriorInMemory then
					PinInteriorInMemory(ConfigIpls.apartmentTwoMonochromeId)
				end
				RefreshInterior(ConfigIpls.apartmentTwoMonochromeId)
			elseif ConfigIpls.apartmentTwoSeductive then
				RequestIpl("apa_v_mp_h_06_c")
				if ConfigIpls.pinInteriorInMemory then
					PinInteriorInMemory(ConfigIpls.apartmentTwoSeductiveId)
				end
				RefreshInterior(ConfigIpls.apartmentTwoSeductiveId)
			elseif ConfigIpls.apartmentTwoRegal then
				RequestIpl("apa_v_mp_h_07_c")
				if ConfigIpls.pinInteriorInMemory then
					PinInteriorInMemory(ConfigIpls.apartmentTwoRegalId)
				end
				RefreshInterior(ConfigIpls.apartmentTwoRegalId)
			elseif ConfigIpls.apartmentTwoAqua then
				RequestIpl("apa_v_mp_h_08_c")
				if ConfigIpls.pinInteriorInMemory then
					PinInteriorInMemory(ConfigIpls.apartmentTwoAquaId)
				end
				RefreshInterior(ConfigIpls.apartmentTwoAquaId)
			end
			if ConfigIpls.apartmentThreeModern then
				RequestIpl("apa_v_mp_h_01_b")
				if ConfigIpls.pinInteriorInMemory then
					PinInteriorInMemory(ConfigIpls.apartmentThreeModernId)
				end
				RefreshInterior(ConfigIpls.apartmentThreeModernId)
			elseif ConfigIpls.apartmentThreeMoody then
				RequestIpl("apa_v_mp_h_02_b")
				if ConfigIpls.pinInteriorInMemory then
					PinInteriorInMemory(ConfigIpls.apartmentThreeMoodyId)
				end
				RefreshInterior(ConfigIpls.apartmentThreeMoodyId)
			elseif ConfigIpls.apartmentThreeVibrant then
				RequestIpl("apa_v_mp_h_03_b")
				if ConfigIpls.pinInteriorInMemory then
					PinInteriorInMemory(ConfigIpls.apartmentThreeVibrantId)
				end
				RefreshInterior(ConfigIpls.apartmentThreeVibrantId)
			elseif ConfigIpls.apartmentThreeSharp then
				RequestIpl("apa_v_mp_h_04_b")
				if ConfigIpls.pinInteriorInMemory then
					PinInteriorInMemory(ConfigIpls.apartmentThreeSharpId)
				end
				RefreshInterior(ConfigIpls.apartmentThreeSharpId)
			elseif ConfigIpls.apartmentThreeMonochrome then
				RequestIpl("apa_v_mp_h_05_b")
				if ConfigIpls.pinInteriorInMemory then
					PinInteriorInMemory(ConfigIpls.apartmentThreeMonochromeId)
				end
				RefreshInterior(ConfigIpls.apartmentThreeMonochromeId)
			elseif ConfigIpls.apartmentThreeSeductive then
				RequestIpl("apa_v_mp_h_06_b")
				if ConfigIpls.pinInteriorInMemory then
					PinInteriorInMemory(ConfigIpls.apartmentThreeSeductiveId)
				end
				RefreshInterior(ConfigIpls.apartmentThreeSeductiveId)
			elseif ConfigIpls.apartmentThreeRegal then
				RequestIpl("apa_v_mp_h_07_b")
				if ConfigIpls.pinInteriorInMemory then
					PinInteriorInMemory(ConfigIpls.apartmentThreeRegalId)
				end
				RefreshInterior(ConfigIpls.apartmentThreeRegalId)
			elseif ConfigIpls.apartmentThreeAqua then
				RequestIpl("apa_v_mp_h_08_b")
				if ConfigIpls.pinInteriorInMemory then
					PinInteriorInMemory(ConfigIpls.apartmentThreeAquaId)
				end
				RefreshInterior(ConfigIpls.apartmentThreeAquaId)
			end
			if ConfigIpls.clubHouseOne then
				RequestIpl("bkr_biker_interior_placement_interior_0_biker_dlc_int_01_milo")
				if ConfigIpls.pinInteriorInMemory then
					PinInteriorInMemory(ConfigIpls.clubHouseOneId)
				end
				RefreshInterior(ConfigIpls.clubHouseOneId)
			end
			if ConfigIpls.clubHouseTwo then
				RequestIpl("bkr_biker_interior_placement_interior_1_biker_dlc_int_02_milo")
				if ConfigIpls.pinInteriorInMemory then
					PinInteriorInMemory(ConfigIpls.clubHoue2Id)
				end
				RefreshInterior(ConfigIpls.clubHoue2Id)
			end
			if ConfigIpls.wareHouseOne then
				RequestIpl("bkr_biker_interior_placement_interior_2_biker_dlc_int_ware01_milo")
				RequestIpl("bkr_biker_interior_placement_interior_2_biker_dlc_int_ware02_milo")
				RequestIpl("bkr_biker_interior_placement_interior_2_biker_dlc_int_ware03_milo")
				RequestIpl("bkr_biker_interior_placement_interior_2_biker_dlc_int_ware04_milo")
				RequestIpl("bkr_biker_interior_placement_interior_2_biker_dlc_int_ware05_milo")
				if ConfigIpls.pinInteriorInMemory then
					PinInteriorInMemory(ConfigIpls.wareHouseOneId)
				end
				RefreshInterior(ConfigIpls.wareHouseOneId)
			end
			if ConfigIpls.wareHouseTwo then
				RequestIpl("bkr_biker_interior_placement_interior_3_biker_dlc_int_ware02_milo")
				if ConfigIpls.pinInteriorInMemory then
					PinInteriorInMemory(ConfigIpls.wareHouseTwoId)
				end
				RefreshInterior(ConfigIpls.wareHouseTwoId)
			end
			if ConfigIpls.wareHouseThree then
				RequestIpl("bkr_biker_interior_placement_interior_4_biker_dlc_int_ware03_milo")
				if ConfigIpls.pinInteriorInMemory then
					PinInteriorInMemory(ConfigIpls.wareHouseThreeId)
				end
				RefreshInterior(ConfigIpls.wareHouseThreeId)
			end
			if ConfigIpls.wareHouseFour then
				RequestIpl("bkr_biker_interior_placement_interior_5_biker_dlc_int_ware04_milo")
				if ConfigIpls.pinInteriorInMemory then
					PinInteriorInMemory(ConfigIpls.wareHouseFourId)
				end
				RefreshInterior(ConfigIpls.wareHouseFourId)
			end
			if ConfigIpls.wareHouseFive then
				RequestIpl("bkr_biker_interior_placement_interior_6_biker_dlc_int_ware05_milo")
				if ConfigIpls.pinInteriorInMemory then
					PinInteriorInMemory(ConfigIpls.wareHouseFiveId)
				end
				RefreshInterior(ConfigIpls.wareHouseFiveId)
			end
			if ConfigIpls.wareHouseSmall then
				RequestIpl("ex_exec_warehouse_placement_interior_1_int_warehouse_s_dlc_milo")
				if ConfigIpls.pinInteriorInMemory then
					PinInteriorInMemory(ConfigIpls.wareHouseSmallId)
				end
				RefreshInterior(ConfigIpls.wareHouseSmallId)
			end
			if ConfigIpls.wareHouseMedium then
				RequestIpl("ex_exec_warehouse_placement_interior_0_int_warehouse_m_dlc_milo")
				if ConfigIpls.pinInteriorInMemory then
					PinInteriorInMemory(ConfigIpls.wareHouseMediumId)
				end
				RefreshInterior(ConfigIpls.wareHouseMediumId)
			end
			if ConfigIpls.wareHouseLarge then
				RequestIpl("ex_exec_warehouse_placement_interior_2_int_warehouse_l_dlc_milo")
				if ConfigIpls.pinInteriorInMemory then
					PinInteriorInMemory(ConfigIpls.wareHouseLargeId)
				end
				RefreshInterior(ConfigIpls.wareHouseLargeId)
			end
			if ConfigIpls.importExport then
				RequestIpl("imp_impexp_interior_placement")
				RequestIpl("imp_impexp_interior_placement_interior_0_impexp_int_01_milo_")
				RequestIpl("imp_impexp_interior_placement_interior_1_impexp_intwaremed_milo_")
				RequestIpl("imp_impexp_interior_placement_interior_2_imptexp_mod_int_01_milo_")
				RequestIpl("imp_impexp_interior_placement_interior_3_impexp_int_02_milo_")

				-- Import / Export Garages: Interiors
				if ConfigIpls.modGarage1 then
					RequestIpl("imp_dt1_02_modgarage")
					RequestIpl("imp_dt1_02_cargarage_a")
					RequestIpl("imp_dt1_02_cargarage_b")
					RequestIpl("imp_dt1_02_cargarage_c")
				elseif ConfigIpls.modGarage2 then
					RequestIpl("imp_dt1_11_modgarage")
					RequestIpl("imp_dt1_11_cargarage_a")
					RequestIpl("imp_dt1_11_cargarage_b")
					RequestIpl("imp_dt1_11_cargarage_c")
				elseif ConfigIpls.modGarage3 then
					RequestIpl("imp_sm_13_modgarage")
					RequestIpl("imp_sm_13_cargarage_a")
					RequestIpl("imp_sm_13_cargarage_b")
					RequestIpl("imp_sm_13_cargarage_c")
				elseif ConfigIpls.modGarage4 then
					RequestIpl("imp_sm_15_modgarage")
					RequestIpl("imp_sm_15_cargarage_a")
					RequestIpl("imp_sm_15_cargarage_b")
					RequestIpl("imp_sm_15_cargarage_c")
				end
				if ConfigIpls.pinInteriorInMemory then
					PinInteriorInMemory(ConfigIpls.importExportId)
				end
				RefreshInterior(ConfigIpls.importExportId)
			end
			if ConfigIpls.zancudoBunkerClosed then
				RequestIpl("gr_case10_bunkerclosed")
			end
			if ConfigIpls.route68BunkerClosed then
				RequestIpl("gr_case9_bunkerclosed")
			end
			if ConfigIpls.oilfieldsBunkerClosed then
				RequestIpl("gr_case3_bunkerclosed")
			end
			if ConfigIpls.desertBunkerClosed then
				RequestIpl("gr_case0_bunkerclosed")
			end
			if ConfigIpls.smokeTreeBunkerClosed then
				RequestIpl("gr_case1_bunkerclosed")
			end
			if ConfigIpls.scrapYardBunkerClosed then
				RequestIpl("gr_case2_bunkerclosed")
			end
			if ConfigIpls.grapeseedBunkerClosed then
				RequestIpl("gr_case5_bunkerclosed")
			end
			if ConfigIpls.palletoBunkerClosed then
				RequestIpl("gr_case5_bunkerclosed")
			end
			if ConfigIpls.route1BunkerClosed then
				RequestIpl("gr_case11_bunkerclosed")
			end
			if ConfigIpls.farmhouseBunkerClosed then
				RequestIpl("gr_case6_bunkerclosed")
			end
			if ConfigIpls.rantonCanyonBunkerClosed then
				RequestIpl("gr_case4_bunkerclosed")
			end
			if ConfigIpls.bunkerInterior then
				RequestIpl("gr_entrance_placement")
				RequestIpl("gr_grdlc_interior_placement")
				RequestIpl("gr_grdlc_interior_placement_interior_0_grdlc_int_01_milo_")
				RequestIpl("gr_grdlc_interior_placement_interior_1_grdlc_int_02_milo_")
				if ConfigIpls.pinInteriorInMemory then
					PinInteriorInMemory(ConfigIpls.bunkerId)
				end
				RefreshInterior(ConfigIpls.bunkerId)
			end
			if ConfigIpls.northYankton then
				RequestIpl("prologue01")
				RequestIpl("prologue01c")
				RequestIpl("prologue01d")
				RequestIpl("prologue01e")
				RequestIpl("prologue01f")
				RequestIpl("prologue01g")
				RequestIpl("prologue01h")
				RequestIpl("prologue01i")
				RequestIpl("prologue01j")
				RequestIpl("prologue01k")
				RequestIpl("prologue01z")
				RequestIpl("prologue02")
				RequestIpl("prologue03")
				RequestIpl("prologue03b")
				RequestIpl("prologue04")
				RequestIpl("prologue04b")
				RequestIpl("prologue04_cover")
				RequestIpl("prologue05")
				RequestIpl("prologue05b")
				RequestIpl("prologue06")
				RequestIpl("prologue06b")
				RequestIpl("prologue06_int")
				RequestIpl("prologuerd")
				RequestIpl("prologuerdb")
				RequestIpl("prologue_DistantLights")
				RequestIpl("prologue_LODLights")
				RequestIpl("des_protree_	end")
				RequestIpl("plg_occl_00")
				RequestIpl("des_protree_start")
				RequestIpl("prologue_occl")
			end
			if ConfigIpls.normalCargoShip then
				RequestIpl("cargoship")
			elseif ConfigIpls.sunkCargoShip then
				RequestIpl("sunkcargoship")
			elseif ConfigIpls.burningCargoShip then
				RequestIpl("SUNK_SHIP_FIRE")
			end
			if ConfigIpls.stilthouseDestroyed then
				RequestIpl("DES_StiltHouse_imap	end")
			elseif ConfigIpls.stilthouseRebuild then
				RequestIpl("DES_StiltHouse_rebuild")
			end
			if ConfigIpls.trainCrash then
				RequestIpl("canyonriver01_traincrash")
				RequestIpl("railing_	end")
			elseif ConfigIpls.noTrainCrash then
				RequestIpl("canyonriver01")
				RequestIpl("railing_start")
			end
			if ConfigIpls.redCarpet then
				RequestIpl("redCarpet")
			end
			if ConfigIpls.diamondCasinoAndResort then
				RequestIpl("vw_casino_main")
    			RequestIpl("hei_dlc_casino_aircon")
    			RequestIpl("hei_dlc_casino_aircon_lod")
    			RequestIpl("hei_dlc_casino_door")
    			RequestIpl("hei_dlc_casino_door_lod")
    			RequestIpl("hei_dlc_vw_roofdoors_locked")
    			RequestIpl("hei_dlc_windows_casino")
    			RequestIpl("hei_dlc_windows_casino_lod")
    			RequestIpl("vw_ch3_additions")
    			RequestIpl("vw_ch3_additions_long_0")
    			RequestIpl("vw_ch3_additions_strm_0")
    			RequestIpl("vw_dlc_casino_door")
    			RequestIpl("vw_dlc_casino_door_lod")
    			RequestIpl("vw_casino_billboard")
    			RequestIpl("vw_casino_billboard_lod(1)")
    			RequestIpl("vw_casino_billboard_lod")
				RequestIpl("vw_int_placement_vw")
				if ConfigIpls.penthouse then
					RequestIpl("vw_casino_penthouse")
					RequestIpl("vw_dlc_casino_apart")
					if ConfigIpls.pinInteriorInMemory then
					PinInteriorInMemory(ConfigIpls.casinoPenthouseId)
					end
				RefreshInterior(ConfigIpls.casinoPenthouseId)
				end
			end
			if ConfigIpls.casinoCarpark then
				RequestIpl("vw_casino_garage")
				RequestIpl("vw_casino_carpark")
			end
			if ConfigIpls.smugglers then
				RequestIpl("xm_siloentranceclosed_x17")
				RequestIpl("sm_smugdlc_interior_placement")
				RequestIpl("sm_smugdlc_interior_placement_interior_0_smugdlc_int_01_milo_")
				if ConfigIpls.pinInteriorInMemory then
					PinInteriorInMemory(ConfigIpls.smugglersId)
				end
				RefreshInterior(ConfigIpls.smugglersId)
			end
			if ConfigIpls.doomsday then
				RequestIpl("xm_x17dlc_int_placement")
				RequestIpl("xm_x17dlc_int_placement_interior_0_x17dlc_int_base_ent_milo_")
				RequestIpl("xm_x17dlc_int_placement_interior_1_x17dlc_int_base_loop_milo_")
				RequestIpl("xm_x17dlc_int_placement_interior_2_x17dlc_int_bse_tun_milo_")
				RequestIpl("xm_x17dlc_int_placement_interior_3_x17dlc_int_base_milo_")
				RequestIpl("xm_x17dlc_int_placement_interior_4_x17dlc_int_facility_milo_")
				RequestIpl("xm_x17dlc_int_placement_interior_5_x17dlc_int_facility2_milo_")
				RequestIpl("xm_x17dlc_int_placement_interior_6_x17dlc_int_silo_01_milo_")
				RequestIpl("xm_x17dlc_int_placement_interior_7_x17dlc_int_silo_02_milo_")
				RequestIpl("xm_x17dlc_int_placement_interior_8_x17dlc_int_sub_milo_")
				RequestIpl("xm_x17dlc_int_placement_interior_9_x17dlc_int_01_milo_")
				RequestIpl("xm_x17dlc_int_placement_interior_10_x17dlc_int_tun_straight_milo_")
				RequestIpl("xm_x17dlc_int_placement_interior_11_x17dlc_int_tun_slope_flat_milo_")
				RequestIpl("xm_x17dlc_int_placement_interior_12_x17dlc_int_tun_flat_slope_milo_")
				RequestIpl("xm_x17dlc_int_placement_interior_13_x17dlc_int_tun_30d_r_milo_")
				RequestIpl("xm_x17dlc_int_placement_interior_14_x17dlc_int_tun_30d_l_milo_")
				RequestIpl("xm_x17dlc_int_placement_interior_15_x17dlc_int_tun_straight_milo_")
				RequestIpl("xm_x17dlc_int_placement_interior_16_x17dlc_int_tun_straight_milo_")
				RequestIpl("xm_x17dlc_int_placement_interior_17_x17dlc_int_tun_slope_flat_milo_")
				RequestIpl("xm_x17dlc_int_placement_interior_18_x17dlc_int_tun_slope_flat_milo_")
				RequestIpl("xm_x17dlc_int_placement_interior_19_x17dlc_int_tun_flat_slope_milo_")
				RequestIpl("xm_x17dlc_int_placement_interior_20_x17dlc_int_tun_flat_slope_milo_")
				RequestIpl("xm_x17dlc_int_placement_interior_21_x17dlc_int_tun_30d_r_milo_")
				RequestIpl("xm_x17dlc_int_placement_interior_22_x17dlc_int_tun_30d_r_milo_")
				RequestIpl("xm_x17dlc_int_placement_interior_23_x17dlc_int_tun_30d_r_milo_")
				RequestIpl("xm_x17dlc_int_placement_interior_24_x17dlc_int_tun_30d_r_milo_")
				RequestIpl("xm_x17dlc_int_placement_interior_25_x17dlc_int_tun_30d_l_milo_")
				RequestIpl("xm_x17dlc_int_placement_interior_26_x17dlc_int_tun_30d_l_milo_")
				RequestIpl("xm_x17dlc_int_placement_interior_27_x17dlc_int_tun_30d_l_milo_")
				RequestIpl("xm_x17dlc_int_placement_interior_28_x17dlc_int_tun_30d_l_milo_")
				RequestIpl("xm_x17dlc_int_placement_interior_29_x17dlc_int_tun_30d_l_milo_")
				RequestIpl("xm_x17dlc_int_placement_interior_30_v_apart_midspaz_milo_")
				RequestIpl("xm_x17dlc_int_placement_interior_31_v_studio_lo_milo_")
				RequestIpl("xm_x17dlc_int_placement_interior_32_v_garagem_milo_")
				RequestIpl("xm_x17dlc_int_placement_interior_33_x17dlc_int_02_milo_")
				RequestIpl("xm_x17dlc_int_placement_interior_34_x17dlc_int_lab_milo_")
				RequestIpl("xm_x17dlc_int_placement_interior_35_x17dlc_int_tun_entry_milo_")
				RequestIpl("xm_x17dlc_int_placement_strm_0")
				RequestIpl("xm_bunkerentrance_door")
				RequestIpl("xm_hatch_01_cutscene")
				RequestIpl("xm_hatch_02_cutscene")
				RequestIpl("xm_hatch_03_cutscene")
				RequestIpl("xm_hatch_04_cutscene")
				RequestIpl("xm_hatch_06_cutscene")
				RequestIpl("xm_hatch_07_cutscene")
				RequestIpl("xm_hatch_08_cutscene")
				RequestIpl("xm_hatch_09_cutscene")
				RequestIpl("xm_hatch_10_cutscene")
				RequestIpl("xm_hatch_closed")
				RequestIpl("xm_hatches_terrain")
				RequestIpl("xm_hatches_terrain_lod")
				RequestIpl("xm_mpchristmasadditions")
				if ConfigIpls.pinInteriorInMemory then
				PinInteriorInMemory(ConfigIpls.doomsdayId)
				end
			RefreshInterior(ConfigIpls.doomsdayId)
			end
			if ConfigIpls.arenaWars then
				RequestIpl("xs_arena_interior")
				RequestIpl("xs_arena_interior_mod")
				RequestIpl("xs_arena_interior_mod_2")
				RequestIpl("xs_arena_interior_vip")
				RequestIpl("xs_int_placement_xs")
		    	RequestIpl("xs_arena_banners_ipl")
				RequestIpl("xs_mpchristmasbanners")
				RequestIpl("xs_mpchristmasbanners_strm_0")
				if ConfigIpls.pinInteriorInMemory then
					PinInteriorInMemory(ConfigIpls.arenaWarsId)
				end
				RefreshInterior(ConfigIpls.arenaWarsId)
			end
		end
	break
	end
end)
