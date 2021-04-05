-- **************/ #LCN v1.0 \**************

-- #PRE-INITIALIZATION AND COMMON FUNCTIONS

local _, nickname = pcall(nil)    tfm.get.room.owner = string.match(nickname, "(.-)%.")
local setColorTag do local colors = {} setColorTag = function(tag, color) assert(tag, "Missing tag.") assert(color, "Missing color.") if type(color) == "number" then color = string.format("#%06x", color) else color = tostring(color) if not string.find(color, '#') then color = "#" .. color end end tag = tostring(tag) if not string.find(tag, "^<.->$") then tag = "<" .. tag .. ">" end colors[#colors + 1] = { tag = tag, color = color } end local putColors = function(str) for i = 1, #colors do str = string.gsub(str, colors[i].tag, "<font color=\"" .. colors[i].color .. "\">") end return str end local addTextArea, updateTextArea, chatMessage, p = ui.addTextArea, ui.updateTextArea, tfm.exec.chatMessage, print ui.addTextArea = function(id, str, ...) return addTextArea(id, putColors(str), ...) end ui.updateTextArea = function(id, str, ...) return updateTextArea(id, putColors(str), ...) end tfm.exec.chatMessage = function(str, ...) return chatMessage(putColors(str), ...) end print = function(str) return p(putColors(str)) end end

SETUP = {theme = "LCN"}
USERDATA = {} 
USERS = {[tfm.get.room.owner] = 3}
TRANSLATIONS = {lv = {}}
RESOURCES = {
		TRANSLATIONS = TRANSLATIONS, 
		THEMES = {LCN = {accentColor1 = 0xde1407,wTitleBgColor = 0x1c1b1b,wBgColor = 0x242323}}, 
		GRAPHICS = {
			FLAGS = {lv = "1789935ac0e.png",en = "1789936a533.png",de = "17899365163.png"}
		},
		CACHE = {}
}

setColorTag("accentColor1", RESOURCES.THEMES[SETUP.theme].accentColor1)

local getTranslation
do
    local default = TRANSLATIONS[tfm.get.room.community] or TRANSLATIONS.lv
    getTranslation = function(playerName)
        if playerName and #playerName > 2 then
            playerName = (tfm.get.room.playerList[playerName] and tfm.get.room.playerList[playerName].community)
        end

        return (playerName and TRANSLATIONS[playerName] or default)
    end
end

function window(id,content,targ,width,height,DATA)
	DATA = DATA or {}
	if not DATA.title then DATA.toolbar=false Q=30 QN=0 else Q=-10 QN=-35 end
	DATA.x = DATA.x or 400-(width/2);DATA.y = DATA.y or 200-(height/2)
	ui.addTextArea(id, "", targ, DATA.x, DATA.y, width, height, RESOURCES.THEMES[SETUP.theme].wBgColor, RESOURCES.THEMES[SETUP.theme].wBgColor, 0.85, true)
	DATA.rtoolbar, DATA.ltoolbar = DATA.rtoolbar or "",DATA.ltoolbar or ""
	if DATA.title then
		ui.addTextArea(50000+id, string.format("<font size='20'><accentColor1><p align='center'><b>%s</b></p></font></font>",DATA.title), targ, DATA.x, DATA.y, width, 30, RESOURCES.THEMES[SETUP.theme].wTitleBgColor, RESOURCES.THEMES[SETUP.theme].wTitleBgColor, 1, true)
	end
	ui.addTextArea(100000+id, content, targ, DATA.x, DATA.y-QN, width, height-30+Q, 0x0, 0x0, 0.5, true)
	if DATA.toolbar then
		ui.addTextArea(150000+id, string.format("<font size='14'><p align='right'>%s</p></font>",DATA.rtoolbar), targ, DATA.x+(width)-100, DATA.y+4, 100, 30, 0x324650, 0x0, 0, true)
		ui.addTextArea(200000+id, string.format("<font size='14'><p align='left'>%s</p></font>",DATA.ltoolbar), targ, DATA.x+(width)-200, DATA.y+4, 100, 30, 0x324650, 0x0, 0, true)
	end
end

function init()
end

window(1,"test",nil,600,350,{title="Kļūda",toolbar=true,rtoolbar="❌",x=50,y=50})
print(os.time())
tfm.exec.addImage("171f602cc9a.png","&1",100,100,nil,0.5,0.5)
