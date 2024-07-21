rightPosition = { x = 1450, y = 100 }
leftPosition = { x = 0, y = 100 }
menuPosition = { x = 0, y = 200 }

if DPc.MenuPosition then
    if DPc.MenuPosition == "left" then
        menuPosition = leftPosition
    elseif DPc.MenuPosition == "right" then
        menuPosition = rightPosition
    end
end

if DPc.CustomMenuEnabled then
    local RuntimeTXD = CreateRuntimeTxd('Custom_Menu_Head')
    local Object = CreateDui(DPc.MenuImage, 512, 128)
    _G.Object = Object
    local TextureThing = GetDuiHandle(Object)
    local Texture = CreateRuntimeTextureFromDuiHandle(RuntimeTXD, 'Custom_Menu_Head', TextureThing)
    Menuthing = "Custom_Menu_Head"
else
    Menuthing = "shopui_title_sm_hangar"
end

_menuPool = NativeUI.CreatePool()
mainMenu = NativeUI.CreateMenu(DPc.MenuTitle or "", "", menuPosition["x"], menuPosition["y"], Menuthing, Menuthing)
_menuPool:Add(mainMenu)

function ShowNotification(text)
    if DPc.NotificationsAsChatMessage then
        TriggerEvent("chat:addMessage", { color = { 255, 255, 255 }, args = { tostring(text) } })
    else
        BeginTextCommandThefeedPost("STRING")
        AddTextComponentSubstringPlayerName(text)
        EndTextCommandThefeedPostTicker(false, false)
    end
end

local EmoteTable = {}
local FavEmoteTable = {}
local KeyEmoteTable = {}
local DanceTable = {}
local AnimalTable = {}
local PropETable = {}
local WalkTable = {}
local FaceTable = {}
local ShareTable = {}
local FavoriteEmote = ""

if DPc.FavKeybindEnabled then
    RegisterCommand('emotefav', function(source, args, raw) FavKeybind() end)

    RegisterKeyMapping("emotefav", "Execute your favorite emote", "keyboard", DPc.FavKeybind)

    local doingFavoriteEmote = false
        function FavKeybind()
            if doingFavoriteEmote == false then
                    doingFavoriteEmote = true
                    if not IsPedSittingInAnyVehicle(PlayerPedId()) then
                        if FavoriteEmote ~= "" and (not CanUseFavKeyBind or CanUseFavKeyBind()) then
                            EmoteCommandStart(nil, { FavoriteEmote, 0 })
                            Wait(500)
                        end
                    end
            else
                EmoteCancel()
                doingFavoriteEmote = false
            end
    end
end

lang = DPc.MenuLanguage

function AddEmoteMenu(menu)
    local submenu = _menuPool:AddSubMenu(menu, DPc.Languages[lang]['emotes'], "", "", Menuthing, Menuthing)
    if DPc.Search then
        submenu:AddItem(NativeUI.CreateItem(DPc.Languages[lang]['searchemotes'], ""))
        table.insert(EmoteTable, DPc.Languages[lang]['searchemotes'])
    end
    local dancemenu = _menuPool:AddSubMenu(submenu, DPc.Languages[lang]['danceemotes'], "", "", Menuthing, Menuthing)
    local animalmenu
    if DPc.AnimalEmotesEnabled then
        animalmenu = _menuPool:AddSubMenu(submenu, DPc.Languages[lang]['animalemotes'], "", "", Menuthing, Menuthing)
        table.insert(EmoteTable, DPc.Languages[lang]['animalemotes'])
    end
    local propmenu = _menuPool:AddSubMenu(submenu, DPc.Languages[lang]['propemotes'], "", "", Menuthing, Menuthing)
    table.insert(EmoteTable, DPc.Languages[lang]['danceemotes'])
    table.insert(EmoteTable, DPc.Languages[lang]['danceemotes'])

    if DPc.SharedEmotesEnabled then
        sharemenu = _menuPool:AddSubMenu(submenu, DPc.Languages[lang]['shareemotes'],
            DPc.Languages[lang]['shareemotesinfo'], "", Menuthing, Menuthing)
        shareddancemenu = _menuPool:AddSubMenu(sharemenu, DPc.Languages[lang]['sharedanceemotes'], "", "", Menuthing,
            Menuthing)
        table.insert(ShareTable, 'none')
        table.insert(EmoteTable, DPc.Languages[lang]['shareemotes'])
    end

    local favEmotes = {}
    if not DPc.SqlKeybinding then
        unbind2item = NativeUI.CreateItem(DPc.Languages[lang]['rfavorite'], DPc.Languages[lang]['rfavorite'])
        unbinditem = NativeUI.CreateItem(DPc.Languages[lang]['prop2info'], "")
        favmenu = _menuPool:AddSubMenu(submenu, DPc.Languages[lang]['favoriteemotes'],
            DPc.Languages[lang]['favoriteinfo'], "", Menuthing, Menuthing)
        favmenu:AddItem(unbinditem)
        favmenu:AddItem(unbind2item)
        table.insert(FavEmoteTable, DPc.Languages[lang]['rfavorite'])
        table.insert(FavEmoteTable, DPc.Languages[lang]['rfavorite'])
        table.insert(EmoteTable, DPc.Languages[lang]['favoriteemotes'])
    else
        table.insert(EmoteTable, "keybinds")
        keyinfo = NativeUI.CreateItem(DPc.Languages[lang]['keybinds'],
            DPc.Languages[lang]['keybindsinfo'] .. " /emotebind [~y~num4-9~w~] [~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~emotename~w~]")
        submenu:AddItem(keyinfo)
    end

    for a, b in pairsByKeys(RP.Emotes) do
        x, y, z = table.unpack(b)
        emoteitem = NativeUI.CreateItem(z, "/e (" .. a .. ")")
        submenu:AddItem(emoteitem)
        table.insert(EmoteTable, a)
        if not DPc.SqlKeybinding then
            favEmotes[a] = z
        end
    end

    for a, b in pairsByKeys(RP.Dances) do
        x, y, z = table.unpack(b)
        danceitem = NativeUI.CreateItem(z, "/e (" .. a .. ")")
        dancemenu:AddItem(danceitem)
        if DPc.SharedEmotesEnabled then
            sharedanceitem = NativeUI.CreateItem(z, "/nearby (" .. a .. ")")
            shareddancemenu:AddItem(sharedanceitem)
        end
        table.insert(DanceTable, a)
        if not DPc.SqlKeybinding then
            favEmotes[a] = z
        end
    end

    if DPc.AnimalEmotesEnabled then
        for a, b in pairsByKeys(RP.AnimalEmotes) do
            x, y, z = table.unpack(b)
            animalitem = NativeUI.CreateItem(z, "/e (" .. a .. ")")
            animalmenu:AddItem(animalitem)
            table.insert(AnimalTable, a)
            if not DPc.SqlKeybinding then
                favEmotes[a] = z
            end
        end
    end

    if DPc.SharedEmotesEnabled then
        for a, b in pairsByKeys(RP.Shared) do
            x, y, z, otheremotename = table.unpack(b)
            if otheremotename == nil then
                shareitem = NativeUI.CreateItem(z, "/nearby (~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~" .. a .. "~w~)")
            else
                shareitem = NativeUI.CreateItem(z,
                    "/nearby (~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~" ..
                    a .. "~w~) " .. DPc.Languages[lang]['makenearby'] .. " (~y~" .. otheremotename .. "~w~)")
            end
            sharemenu:AddItem(shareitem)
            table.insert(ShareTable, a)
        end
    end

    for a, b in pairsByKeys(RP.PropEmotes) do
        x, y, z = table.unpack(b)
    
        if b.AnimationOptions.PropTextureVariations then 
            propitem = NativeUI.CreateListItem(z, b.AnimationOptions.PropTextureVariations, 1, "/e (" .. a .. ")")
            propmenu:AddItem(propitem)
        else
            propitem = NativeUI.CreateItem(z, "/e (" .. a .. ")")
            propmenu:AddItem(propitem)
        end 

        table.insert(PropETable, a)
        if not DPc.SqlKeybinding then
            favEmotes[a] = z
        end
    end

    if not DPc.SqlKeybinding then
        for emoteName, emoteLabel in pairsByKeys(favEmotes) do
            favemoteitem = NativeUI.CreateItem(emoteLabel,
                DPc.Languages[lang]['set'] .. emoteLabel .. DPc.Languages[lang]['setboundemote'])
            favmenu:AddItem(favemoteitem)
            table.insert(FavEmoteTable, emoteName)
        end

        favmenu.OnItemSelect = function(sender, item, index)
            if FavEmoteTable[index] == DPc.Languages[lang]['rfavorite'] then
                FavoriteEmote = ""
                ShowNotification(DPc.Languages[lang]['rfavorite'], 2000)
                return
            end
            if DPc.FavKeybindEnabled then
                FavoriteEmote = FavEmoteTable[index]
                ShowNotification("~o~" .. firstToUpper(FavoriteEmote) .. DPc.Languages[lang]['newsetemote'])
            end
        end
    end
    favEmotes = nil

    dancemenu.OnItemSelect = function(sender, item, index)
        EmoteMenuStart(DanceTable[index], "dances")
    end

    if DPc.AnimalEmotesEnabled then
        animalmenu.OnItemSelect = function(sender, item, index)
            EmoteMenuStart(AnimalTable[index], "animals")
        end
    end

    if DPc.SharedEmotesEnabled then
        sharemenu.OnItemSelect = function(sender, item, index)
            if ShareTable[index] ~= 'none' then
                target, distance = GetClosestPlayer()
                if (distance ~= -1 and distance < 3) then
                    _, _, rename = table.unpack(RP.Shared[ShareTable[index]])
                    TriggerServerEvent("ServerEmoteRequest", GetPlayerServerId(target), ShareTable[index])
                    SimpleNotify(DPc.Languages[lang]['sentrequestto'] .. GetPlayerName(target))
                else
                    SimpleNotify(DPc.Languages[lang]['nobodyclose'])
                end
            end
        end

        shareddancemenu.OnItemSelect = function(sender, item, index)
            target, distance = GetClosestPlayer()
            if (distance ~= -1 and distance < 3) then
                _, _, rename = table.unpack(RP.Dances[DanceTable[index]])
                TriggerServerEvent("ServerEmoteRequest", GetPlayerServerId(target), DanceTable[index], 'Dances')
                SimpleNotify(DPc.Languages[lang]['sentrequestto'] .. GetPlayerName(target))
            else
                SimpleNotify(DPc.Languages[lang]['nobodyclose'])
            end
        end
    end

    propmenu.OnItemSelect = function(sender, item, index)
        EmoteMenuStart(PropETable[index], "props")
    end
    
   propmenu.OnListSelect = function(menu, item, itemIndex, listIndex)
        EmoteMenuStart(PropETable[itemIndex], "props", item:IndexToItem(listIndex).Value)
    end

    submenu.OnItemSelect = function(sender, item, index)
        if DPc.Search and EmoteTable[index] == DPc.Languages[lang]['searchemotes'] then
            EmoteMenuSearch(submenu)
        elseif EmoteTable[index] ~= DPc.Languages[lang]['favoriteemotes'] then
            EmoteMenuStart(EmoteTable[index], "emotes")
        end
    end
end

if DPc.Search then
    local ignoredCategories = {
        ["Walks"] = true,
        ["Expressions"] = true,
        ["Shared"] = not DPc.SharedEmotesEnabled
    }

    function EmoteMenuSearch(lastMenu)
        local favEnabled = not DPc.SqlKeybinding and DPc.FavKeybindEnabled
        AddTextEntry("PM_NAME_CHALL", DPc.Languages[lang]['searchinputtitle'])
        DisplayOnscreenKeyboard(1, "PM_NAME_CHALL", "", "", "", "", "", 30)
        while UpdateOnscreenKeyboard() == 0 do
            DisableAllControlActions(0)
            Wait(100)
        end
        local input = GetOnscreenKeyboardResult()
        if input ~= nil then
            local results = {}
            for k, v in pairs(RP) do
                if not ignoredCategories[k] then
                    for a, b in pairs(v) do
                        if string.find(string.lower(a), string.lower(input)) or (b[3] ~= nil and string.find(string.lower(b[3]), string.lower(input))) then
                            table.insert(results, {table = k, name = a, data = b})
                        end
                    end
                end
            end

            if #results > 0 then
                local searchMenu = _menuPool:AddSubMenu(lastMenu, string.format(DPc.Languages[lang]['searchmenudesc'], #results, input), "", true, Menuthing, Menuthing)
                local sharedDanceMenu
                if favEnabled then
                    local rFavorite = NativeUI.CreateItem(DPc.Languages[lang]['rfavorite'], DPc.Languages[lang]['rfavorite'])
                    searchMenu:AddItem(rFavorite)
                end

                if DPc.SharedEmotesEnabled then
                    sharedDanceMenu = _menuPool:AddSubMenu(searchMenu, DPc.Languages[lang]['sharedanceemotes'], "", true, Menuthing, Menuthing)
                end

                table.sort(results, function(a, b) return a.name < b.name end)
                for k, v in pairs(results) do
                    local desc = ""
                    if v.table == "Shared" then
                        local otheremotename = v.data[4]
                        if otheremotename == nil then
                           desc = "/nearby (~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~" .. v.name .. "~w~)"
                        else
                           desc = "/nearby (~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~" .. v.name .. "~w~) " .. DPc.Languages[lang]['makenearby'] .. " (~y~" .. otheremotename .. "~w~)"
                        end
                    else
                        desc = "/e (" .. v.name .. ")" .. (favEnabled and "\n" .. DPc.Languages[lang]['searchshifttofav'] or "")
                    end

                    if v.data.AnimationOptions and v.data.AnimationOptions.PropTextureVariations then
                        local item = NativeUI.CreateListItem(v.data[3], v.data.AnimationOptions.PropTextureVariations, 1, desc)
                        searchMenu:AddItem(item)
                    else
                        local item = NativeUI.CreateItem(v.data[3], desc)
                        searchMenu:AddItem(item)
                    end
                    
                    if v.table == "Dances" and DPc.SharedEmotesEnabled then
                        local item2 = NativeUI.CreateItem(v.data[3], "")
                        sharedDanceMenu:AddItem(item2)
                    end
                end

                if favEnabled then
                    table.insert(results, 1, DPc.Languages[lang]['rfavorite'])
                end

                searchMenu.OnItemSelect = function(sender, item, index)
                    local data = results[index]

                    if data == DPc.Languages[lang]['sharedanceemotes'] then return end
                    if data == DPc.Languages[lang]['rfavorite'] then 
                        FavoriteEmote = ""
                        ShowNotification(DPc.Languages[lang]['rfavorite'], 2000)
                        return 
                    end

                    if favEnabled and IsControlPressed(0, 21) then
                        if data.table ~= "Shared" then
                            FavoriteEmote = data.name
                            ShowNotification("~o~" .. firstToUpper(data.name) .. DPc.Languages[lang]['newsetemote'])
                        else
                            SimpleNotify(DPc.Languages[lang]['searchcantsetfav'])
                        end
                    elseif data.table == "Emotes" or data.table == "Dances" then
                        EmoteMenuStart(data.name, string.lower(data.table))
                    elseif data.table == "PropEmotes" then
                        EmoteMenuStart(data.name, "props")
                    elseif data.table == "AnimalEmotes" then
                        EmoteMenuStart(data.name, "animals")
                    elseif data.table == "Shared" then
                        target, distance = GetClosestPlayer()
                        if (distance ~= -1 and distance < 3) then
                            _, _, rename = table.unpack(RP.Shared[data.name])
                            TriggerServerEvent("ServerEmoteRequest", GetPlayerServerId(target), data.name)
                            SimpleNotify(DPc.Languages[lang]['sentrequestto'] .. GetPlayerName(target))
                        else
                            SimpleNotify(DPc.Languages[lang]['nobodyclose'])
                        end   
                    end
                end

                searchMenu.OnListSelect = function(menu, item, itemIndex, listIndex)
                    EmoteMenuStart(results[itemIndex].name, "props", item:IndexToItem(listIndex).Value)
                end

                if DPc.SharedEmotesEnabled then
                    if #sharedDanceMenu.Items > 0 then
                        table.insert(results, (favEnabled and 2 or 1), DPc.Languages[lang]['sharedanceemotes'])
                        sharedDanceMenu.OnItemSelect = function(sender, item, index)
                            local data = results[index]
                            target, distance = GetClosestPlayer()
                            if (distance ~= -1 and distance < 3) then
                                _, _, rename = table.unpack(RP.Dances[data.name])
                                TriggerServerEvent("ServerEmoteRequest", GetPlayerServerId(target), data.name, 'Dances')
                                SimpleNotify(DPc.Languages[lang]['sentrequestto'] .. GetPlayerName(target))
                            else
                                SimpleNotify(DPc.Languages[lang]['nobodyclose'])
                            end
                        end
                    else
                        sharedDanceMenu:Clear()
                        searchMenu:RemoveItemAt((favEnabled and 2 or 1))
                    end
                end

                searchMenu.OnMenuClosed = function()
                    searchMenu:Clear()
                    lastMenu:RemoveItemAt(#lastMenu.Items)
                    _menuPool:RefreshIndex()
                    results = {}
                end

                _menuPool:RefreshIndex()
                _menuPool:CloseAllMenus()
                searchMenu:Visible(true)
            else
                SimpleNotify(string.format(DPc.Languages[lang]['searchnoresult'], input))
            end
        end
    end
end

function AddCancelEmote(menu)
    local newitem = NativeUI.CreateItem(DPc.Languages[lang]['cancelemote'], DPc.Languages[lang]['cancelemoteinfo'])
    menu:AddItem(newitem)
    menu.OnItemSelect = function(sender, item, checked_)
        if item == newitem then
            EmoteCancel()
            DestroyAllProps()
        end
    end
end

function AddWalkMenu(menu)
    local submenu = _menuPool:AddSubMenu(menu, DPc.Languages[lang]['walkingstyles'], "", "", Menuthing, Menuthing)

    walkreset = NativeUI.CreateItem(DPc.Languages[lang]['normalreset'], DPc.Languages[lang]['resetdef'])
    submenu:AddItem(walkreset)
    table.insert(WalkTable, DPc.Languages[lang]['resetdef'])

    WalkInjured = NativeUI.CreateItem("Injured", "/walk (injured)")
    submenu:AddItem(WalkInjured)
    table.insert(WalkTable, "move_m@injured")

    for a, b in pairsByKeys(RP.Walks) do
        x, label = table.unpack(b)
        walkitem = NativeUI.CreateItem(label or a, "/walk (" .. string.lower(a) .. ")")
        submenu:AddItem(walkitem)
        table.insert(WalkTable, x)
    end

    submenu.OnItemSelect = function(sender, item, index)
        if item ~= walkreset then
            WalkMenuStart(WalkTable[index])
        else
            ResetPedMovementClipset(PlayerPedId())
            DeleteResourceKvp("walkstyle")
        end
    end
end

function AddFaceMenu(menu)
    local submenu = _menuPool:AddSubMenu(menu, DPc.Languages[lang]['moods'], "", "", Menuthing, Menuthing)

    facereset = NativeUI.CreateItem(DPc.Languages[lang]['normalreset'], DPc.Languages[lang]['resetdef'])
    submenu:AddItem(facereset)
    table.insert(FaceTable, "")

    for a, b in pairsByKeys(RP.Expressions) do
        x, y, z = table.unpack(b)
        faceitem = NativeUI.CreateItem(a, "")
        submenu:AddItem(faceitem)
        table.insert(FaceTable, a)
    end

    submenu.OnItemSelect = function(sender, item, index)
        if item ~= facereset then
            EmoteMenuStart(FaceTable[index], "expression")
        else
            ClearFacialIdleAnimOverride(PlayerPedId())
        end
    end
end

function OpenEmoteMenu()
    if _menuPool:IsAnyMenuOpen() then
        _menuPool:CloseAllMenus()
    else
        mainMenu:Visible(true)
        ProcessMenu()
    end
end

function firstToUpper(str)
    return (str:gsub("^%l", string.upper))
end

AddEmoteMenu(mainMenu)
AddCancelEmote(mainMenu)
if DPc.WalkingStylesEnabled then
    AddWalkMenu(mainMenu)
end
if DPc.ExpressionsEnabled then
    AddFaceMenu(mainMenu)
end

_menuPool:RefreshIndex()

local isMenuProcessing = false
function ProcessMenu()
    if isMenuProcessing then return end
    isMenuProcessing = true
    while _menuPool:IsAnyMenuOpen() do
        _menuPool:ProcessMenus()
        Wait(0)
    end
    isMenuProcessing = false
end

RegisterNetEvent("rp:RecieveMenu")
AddEventHandler("rp:RecieveMenu", function()
    OpenEmoteMenu()
end)
