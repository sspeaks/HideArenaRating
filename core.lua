local updateMe = function(self)
    self.Arena2v2.CurrentRating:SetText("?");
    self.Arena2v2.Tier:Hide();
    self.Arena3v3.CurrentRating:SetText("?");
    self.Arena3v3.Tier:Hide();
    self.RatedBG.CurrentRating:SetText("?");
    self.RatedBG.Tier:Hide();
end

local hideInspectedRating = function(self)
    InspectPVPFrame.Arena2v2.Rating:SetText("?")
    InspectPVPFrame.Arena2v2.Record:SetText("? - ?")
    InspectPVPFrame.Arena3v3.Rating:SetText("?")
    InspectPVPFrame.Arena3v3.Record:SetText("? - ?")
    InspectPVPFrame.RatedBG.Rating:SetText("?")
    InspectPVPFrame.RatedBG.Record:SetText("? - ?")

end

local hideTooltip = function() 
    ConquestTooltip:Hide()
end

local hideTier = function()
    PVPQueueFrame.HonorInset.RatedPanel.Tier:Hide()
end

-- local hideTabContainer = function() 
--     PVPMatchResults.content.tabContainer:Hide()
--     PVPMatchResults.content.earningsContainer:Hide()
--     PVPMatchResults.content.scrollFrame.ScrollChild:Hide()
   
-- end

-- local testRowUpdateStuff = function()
--     local rows = PVPMatchResults["tableBuilder"]:GetRows()
--     for key,value in pairs(rows) do print(key,value) end
--     for i,_ in ipairs(rows) do
--         print(i)
--         for key,value in pairs(rows[i]) do print(key,value) end
--         if not not rows[i]["rowData"] then
--             rows[i]["rowData"].killingBlows = 5
--         end
--     end
--     for key,value in pairs(rows) do print(key,value["rowData"]) end
--     PVPMatchResults["tableBuilder"]:SetRows(rows)
--     PVPMatchResults["tableBuilder"]:Populate(0, table.getn(rows))
-- end

local function OnEvent(self, event, isLogin, isReload)
	if isLogin or isReload then
        
        hooksecurefunc("ConquestFrame_Update", updateMe);
        hooksecurefunc(PVPQueueFrame.HonorInset.RatedPanel, "Show", hideTier);
        hooksecurefunc("InspectPVPFrame_Update", hideInspectedRating)
        ConquestFrame.Arena2v2:HookScript("OnEnter", hideTooltip);
        ConquestFrame.Arena3v3:HookScript("OnEnter", hideTooltip);
        ConquestFrame.RatedBG:HookScript("OnEnter", hideTooltip);
        -- PVPMatchResults:HookScript("OnShow", hideTabContainer);
        -- hooksecurefunc(PVPMatchResults, "OnUpdate", testRowUpdateStuff)
        local oldOptional = PVPMatchUtil.GetOptionalCategories
        PVPMatchUtil.GetOptionalCategories = function()
            local categories = oldOptional()
            categories.ratingChange = false;
            categories.ratingPost = false;
            categories.ratingPre = false;
            return categories
        end
    end 
end
local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:SetScript("OnEvent", OnEvent)