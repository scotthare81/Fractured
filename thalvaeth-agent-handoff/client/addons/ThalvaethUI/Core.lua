local ADDON = "ThalvaethUI"
local PREFIX = "THALVAETH"

ThalvaethUI = ThalvaethUI or {}
ThalvaethUI.version = "0.1.0"

local function SendWire(opcode, payload)
    local msg = opcode
    if payload and payload ~= "" then
        msg = msg .. "~" .. payload
    end
    SendAddonMessage(PREFIX, msg, "WHISPER", UnitName("player"))
end

ThalvaethUI.Send = SendWire

local frame = CreateFrame("Frame")
frame:RegisterEvent("CHAT_MSG_ADDON")
frame:SetScript("OnEvent", function(_, event, prefix, message, channel, sender)
    if event ~= "CHAT_MSG_ADDON" or prefix ~= PREFIX then
        return
    end
    if sender ~= UnitName("player") and channel ~= "WHISPER" then
        return
    end

    local opcode, payload = message:match("^([^~]+)~?(.*)$")
    if opcode == "HELLO" then
        ThalvaethUI.ready = true
    elseif opcode == "JOURNAL" and ThalvaethUI.OnJournalUpdate then
        local entry, tier = payload:match("^(%d+)~(%w+)$")
        if entry then
            ThalvaethUI.OnJournalUpdate(tonumber(entry), tier)
        end
    end
end)
