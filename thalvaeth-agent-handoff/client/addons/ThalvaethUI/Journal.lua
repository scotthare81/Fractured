-- Creature journal client stub — sighted on mouseover, engaged from server

ThalvaethUI.journal = ThalvaethUI.journal or {}

local lastSighted = {}

-- WotLK 3.3.5 cannot read creature entry from GUID; server resolves target/mouseover
local function MouseoverNeedsSighted()
    return UnitExists("mouseover") and UnitCanAttack("player", "mouseover")
end

local ticker = CreateFrame("Frame")
ticker:SetScript("OnUpdate", function(_, elapsed)
    ticker.elapsed = (ticker.elapsed or 0) + elapsed
    if ticker.elapsed < 0.5 then
        return
    end
    ticker.elapsed = 0

    if not MouseoverNeedsSighted() then
        return
    end

    local guid = UnitGUID("mouseover")
    if not guid or lastSighted[guid] then
        return
    end

    lastSighted[guid] = true
    ThalvaethUI.Send("SIGHTED", guid)
end)

function ThalvaethUI.OnJournalUpdate(entry, tier)
    ThalvaethUI.journal[entry] = tier
    -- TODO: render panel (no default nameplates — silhouette + journal text only)
end
