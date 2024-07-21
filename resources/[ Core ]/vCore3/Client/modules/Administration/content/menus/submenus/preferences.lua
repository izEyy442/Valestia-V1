---
--- @author Kadir#6666
--- Create at [21/04/2023] 14:31:38
--- Current project [Valestia-V1]
--- File name [preferences]
---

local AdminStorage = Shared.Storage:Get("Administration");

---@type UIMenu
local preferences_menu = AdminStorage:Get("admin_preferences");

preferences_menu:IsVisible(function(Items)

    Items:Checkbox("Blip des joueurs", nil, Client.Admin:GetPreferenceFromName("blip"), {}, {

        onSelected = function(Checked)

            Client.Admin:SetPreferenceFromName("blip", Checked)

        end

    });

    Items:Checkbox("Gamertag des joueurs", nil, Client.Admin:GetPreferenceFromName("gamertag"), {}, {

        onSelected = function(Checked)

            Client.Admin:SetPreferenceFromName("gamertag", Checked)

        end

    });

    Items:Checkbox("Afficher le nombre de reports", nil, Client.Admin:GetPreferenceFromName("report:number"), {}, {

        onSelected = function(Checked)

            Client.Admin:SetPreferenceFromName("report:number", Checked)

        end

    });

end)