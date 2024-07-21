---@param Title string
---@param LeftText table
---@param RightText table
---@param Index number
---@param startAt number
function Panels:info(Title, LeftText, RightText, Index, startAt)
    local CurrentMenu = RageUI.CurrentMenu
    local LineCount = (RightText and LeftText and #LeftText >= #RightText and #LeftText or LeftText and #LeftText) or 1
    if CurrentMenu then
        if (not Index and not startAt) or ((not Index and startAt) and CurrentMenu.Index >= startAt) or ((not startAt and Index) and CurrentMenu.Index == Index) then
            if Title ~= nil then
                RenderText("~h~" .. Title .. "~h~", 330 + 20 + 100, 7, 0, 0.34, 255, 255, 255, 255, 0)
            end
            if LeftText ~= nil then
                RenderText(table.concat(LeftText, "\n"), 330 + 20 + 100, Title ~= nil and 37 or 7, 0, 0.25, 255, 255, 255, 255, 0)
            end
            if RightText ~= nil then
                RenderText(table.concat(RightText, "\n"), 330 + 342 + 80, Title ~= nil and 37 or 7, 0, 0.25, 255, 255, 255, 255, 2)
            end
            RenderRectangle(320 + 10 + 100, 0, 342, Title ~= nil and 50 + (LineCount * 20), 0, 0, 0, 160)
        end
    end
end