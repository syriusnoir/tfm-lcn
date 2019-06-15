-- "Vēsture" [[v1 - oriģināls|v2 - survival sakne|v3 - !spawn koordinātu pieejamība|v4 - !bc, !bc*, !utilcore, !utilcore*|v5 - survival pabeigts|v6 - beznaglu sakne|v7 - !r, !r*|v8 - ne-dalībnieku blokāde|v9 - kļūdu reorganizācija|v10 - !md|v11 - !md*|v12 - !cname, !host, !kill|v13 - !txt, !g|v14 - utilcore palaidējs|v15 - !txt*|v16 - !rhost|v17 - !g*|v18 - !col|v19 - !s*|v20 - !cmode, !size|v21 - !ce,!ce*|v22 - !np|v23 - !meep|v24 - !rmtxt|v25 - !score, all: !s, !kill, !r, !meep, !ce|v26 - jauns interfeiss; !tfm, !tfm*, !link, !link*|v27 - all: !tfm; !hlp kodols|v28 - !hlp uzlabojumi; atjaunināts survival|v29 - !nextmap survival režīmā automātiski parāda raunda ciparu|v30 - karte pagarinās build režīmā atbilstoši spēlētaju skaitam, !clear|v.b32 - HostCore (!hc); 30-sek. challenge kodols; everyoneVerified; !d|v.b33 - HTML iekš !bc* un !utilcore; 30-sekunžu mapēs tagad rādās veidotājs]]

SETUP = {flymode = false,challengemode = "thirty",autorespawn = "true",everyoneVerified="true"}

-- [[LaChallengeNostra: LV, EN, DE]]
 
version = "v.b42.1"
title = "#LaChallengeNostra "..SETUP.challengemode
player={} helpers={}
hosts={['Syrius#8114'] = true,['Acmexitee#0000'] = true,['Ertyezz#9819'] = true,['Sanija#1187'] = true} --,['Ertyezz#9819'] = true  ,['Laimesberns#3746'] = true
contestants={}
userData={} -- Piezīme Syrius (dist 88, 292) 

-- Tulkojumi

local t = {lv={[40]=".",[70]="jā",[71]="ieslēgts",[72]="izslēgts",[73]="nē",[80]="<warn>Nav zināms.</warn>",[81]="Bez-naglu challenge",[82]="Divine challenge",[83]="Izdzīvošanas challenge",[84]="Cilts racing",[85]="Defilante sacensības",[86]="30-sekunžu challenge",[87]="Būvdarbu cīņas",[100]="LCN versija:",[101]="Esi sveicināts #LaChallengeNostra modulī!",[102]="Šis modulis tiek izmantots atvieglotai konkursu uzturēšanai.",[103]="Ja ienāc konkursa vidū, lūdzu izej no ciltsmājas.",[104]="Tūlīt notiks:",[200]="ir ienācis ciltsmājā.",[201]="Darbojas #LaChallengeNostra.",[202]="Tu neesi cilts eventa dalībnieks/vadītājs.",[203]="Iestatījumi",[204]="Interfeiss",[205]="[noņemt]",[206]="HostCore ieslēgts:",[207]="(nospied •, lai redzētu moduļa informāciju)",[208]="iestatīja krāsu tagu",[209]="TU ESI DISKVALIFICĒTS.",[210]="Konkursa vadītājs ir tevi diskvalificējis.",[211]="Drīksti pamest ciltsmāju.",[212]="ir diskvalificēts.",[213]="tagad pieder konkursa vadītāja statuss.",[214]="tagad pieder konkursa palīga statuss.",[215]="vairs nepieder konkursa vadītāja statuss.",[216]="vairs nepieder konkursa palīga statuss.",[217]="Nederīga komanda vai arī tev nav pietiekamu tiesību tās lietošanai.",[218]="Nederīgs spēles režīms: nomaini SETUP.challengemode uz atbilstošo režīmu.",[219]="pārlādēja mapi.",[220]="kursora koordinātas ir -",[221]="[SISTĒMA]",[222]="Konkursa vadītāj, esi sveicināts šajā moduļa versijā.",[223]="Versija:",[224]="Identifikators:",[225]="ir zaudējis ;(",[226]="ir zaudējis.",[227]="Izdzīvošanas challenge ir sācies!",[228]="Darbojas t.s. <i>survival challenge.</i>",[229]="raunds",[230]="Fināla raunds",[231]="uzvarēja!",[232]="raunds beidzies:",[233]="raunds -",[234]="Bez-naglu challenge ir sācies!",[235]="Asistences interfeiss ielādēts.",[236]="Īsinājumtaustiņi",[237]="NEDERĪGA AUTORIZĀCIJA.",[238]="Šis kods ir paredzēts",[239]="Tu esi diskvalificēts.",[240]="[palīdzība]",[241]="[par]",[242]="[aizvērt]",[243]="Veidoja <lbrp>Syrius#8114</font>.",[244]="<br><br>Paldies <lbrp>Sanija#1187</font>, <lbrp>Ertyezz#9819</font>, <lbrp>Acmexitee#0000</font> un citiem cilts <lbrp>La Cros Nostra</font> dalībniekiem par palīdzību moduļa veidošanas gaitā.",[245]="Atdzīvošanās (visi) -",[246]="Notīrīt -",[247]="Paldies par dalību.",[248]="Visi nomira ;(",[249]="Vai esi pārliecināts?",[250]="izgāja no ciltsmājas.",[251]="Ziņa no"}, en={[40]="th",[70]="yes",[71]="on",[72]="off",[73]="no",[80]="<warn>Unknown.</warn>",[81]="No nail challenge",[82]="Divine challenge",[83]="Survival challenge",[84]="Tribe's racing",[85]="Defilante race",[86]="30-second challenge",[87]="Builders' Battle",[100]="LCN version:",[101]="Welcome to #LaChallengeNostra module!",[102]="This module is used to simplify the hosting of contests.",[103]="If you come here in the middle of the contest, please leave the tribe house.",[104]="Will be hosted soon:",[200]="entered the tribe house.",[201]="#LaChallengeNostra is active.",[202]="You aren't a contestant or a host.",[203]="Settings",[204]="Interface",[205]="[remove]",[206]="HostCore enabled:",[207]="(press • to see the info panel)",[208]="has set color tag",[209]="YOU ARE DISQUALIFIED.",[210]="A host has disqualified you.",[211]="You may leave the tribe house.",[212]="has been disqualified.",[213]="is now a host.",[214]="is now a helper.",[215]="is no longer a host.",[216]="is no longer a helper.",[217]="Invalid command or you have insufficient permissions to use it.",[218]="Invalid game mode: change SETUP.challengemode to the corresponding mode.",[219]="reloaded the map.",[220]="'s pointer's coordinates are -",[221]="[SYSTEM]",[222]="Host, welcome to this version of the module.",[223]="Version:",[224]="Identificator:",[225]="died ;(",[226]="died.",[227]="Survival challenge has begun!",[228]="<i>Survival challenge</i> is active.",[229]="round",[230]="Final round",[231]="won!",[232]="round has ended:",[233]="round -",[234]="No nail challenge has begun!",[235]="Loaded assistance interface.", [236]="Keybinds", [237]="INVALID AUTHENTICATION.",[238]="This code is intended for",[239]="You are disqualified.",[240]="[help]",[241]="[about]",[242]="[close]",[243]="Created by <VP>Syrius#8114</VP>.",[244]="<br><br>Thanks to <VP>Sanija#1187</VP>, <VP>Ertyezz#9819</VP>, <VP>Acmexitee#0000</VP> and other members of the tribe <VP>La Cros Nostra</VP> for help in the module's development.",[245]="Respawn (all) -",[246]="Clear -",[247]="<font size='50'>Thanks for partipication.",[248]="Everyone died ;(",[249]="Are you sure?",[250]="left the tribehouse.",[251]="A message from"}, de={[40]=".",[70]="ja",[71]="auf",[72]="aus",[73]="nein",[80]="<warn>Nicht bekannt.</warn>",[81]="Ohne Nagel Herausforderung",[82]="Göttlicher Modus Herausforderung",[83]="Überlebens Herausforderung",[84]="Stamm racing",[85]="Defilante Herausforderung",[86]="30-Sekunden Herausforderung",[87]="Bauschlachten",[100]="LCN version:",[101]="Willkommen zum #LaChallengeNostra Modul!",[102]="Dieses Modul dient zur Pflege von Wettbeverben.",[103]="Wenn Sie mitten im Wettbeverb hereinkommen, bitte verlassen Sie das Stammeshaus.",[104]="Gleich passiert:",[200]="betrat das Stammeshaus.",[201]="#LaChallengeNostra ist aktiv.",[202]="Sie sind kein Teilnehmer oder Anführer des Stammesereignesses.",[203]="Einstellungen",[204]="Schnittstelle",[205]="[entfernen]",[206]="HostCore auf:",[207]="(Drück • um die Moduldetails zu sehen)",[208]="hat den Farbetikett eingestellen",[209]="DU BIST DISQUALIFIZIERT.",[210]="Der Wettbewerbs Anführer hat Sie disqualifiziert.",[211]="Du kannst das Stammeshaus verlassen.",[212]="wurde disqualifiziert.",[213]="hat jetzt den Status eines Wettbewerb Anführers.",[214]="hat jetzt den Status eines Wettbeverbasissten.",[215]="hat nicht mehr den Status eines Wettbewerb Anführers.",[216]="hat nicht mehr den Status eines Wettbeverbasissten.",[217]="Ungültiges commando oder Sie haben nicht genügend Rechte um es auszuführen.",[218]="Ungültiger Spielemodus: Ändern Sie den SETUP.challengemode in den entsprechenden Modus.",[219]="hat die mape neu gestartet.",[220]="'s Cursor Koordinaten sind -",[221]="[SYSTEM]",[222]="Anführer des Wettbewerbs, willkommen zu dieser Version des Moduls.",[223]="Version:",[224]="Identifikator:",[225]="ist gestorben ;(",[226]="ist gestorben.",[227]="Überlebens Herausforderung hat begonnen!",[228]="<i>Überlebens Herausforderung</i> ist aktiv.",[229]="runde",[230]="Letzte runde",[231]="hat gewonnen!",[232]="runde hat geendet:",[233]="runde -",[234]="Die Ohne Nagel Herausforderung hat begonnen!",[235]="Geladene Asissten Schnittstelle.",[237]="UNGÜLTIGE AUTORISIERUNG.",[238]="Dieser Code ist für",[239]="Du bist disqualifiziert.",[240]="[hilfe]",[241]="[über]",[242]="[schließen]",[243]="Erstellt von <VP>Syrius#8114</VP>.",[244]="<br><br>Danke an <VP>Sanija#1187</VP>, <VP>Ertyezz#9819</VP>, <VP>Acmexitee#0000</VP> und andere Stamm <VP>La Cros Nostra</VP> Teilnehmer für der Unterstützung beim Aufbau des Moduls.",[245]=" Wiederbelebung (alle) -",[246]="Löschen -",[247]="<font size='50'>Vielen Dank für Ihre Teilnahme.",[248]="Alle sind gestorben ;(",[249]="Bist du dir sicher?",[250]="hat das Stammeshaus verlassen.",[251]="Eine Nachricht von"}}
local trans = t[tfm.get.room.community] or t.lv

-- Konkursu parādīšanās
if SETUP.challengemode=="vanilla" then PLANNEDCONTEST=trans[81] .." / ".. trans[82]
elseif SETUP.challengemode=="survival" then PLANNEDCONTEST=trans[83]
elseif SETUP.challengemode=="pkg" then PLANNEDCONTEST=trans[84] .." / ".. trans[85]
elseif SETUP.challengemode=="thirty" then PLANNEDCONTEST=trans[86]
elseif SETUP.challengemode=="build" then PLANNEDCONTEST=trans[87]
else PLANNEDCONTEST=trans[80] end

-- Annonce
function annonce(text)
	print(text)
	ui.updateTextArea(65,text,nil)
end
function annonce2(text)
	print(text)
	ui.updateTextArea(64,text,nil)
end

-- Prefiksi
syscore = "<ROSE><b>"..trans[221].."</b>" 
infpref = "<brp><b>[<a href='event:hostmenu'>•</a>]</b><lbrp> "
miscpref = "<vi><b>[•]</b><rose> "

-- customcolortag bibliotēka
local setColorTag do local colors = { } setColorTag = function(tag, color) assert(tag, "Missing tag.") assert(color, "Missing color.") if type(color) == "number" then color = string.format("#%06x", color) else color = tostring(color) if not string.find(color, '#') then color = "#" .. color end end tag = tostring(tag) if not string.find(tag, "^<.->$") then tag = "<" .. tag .. ">" end colors[#colors + 1] = { tag = tag, color = color } end local putColors = function(str) for i = 1, #colors do str = string.gsub(str, colors[i].tag, "<font color=\"" .. colors[i].color .. "\">") end return str end local addTextArea, updateTextArea, chatMessage, p = ui.addTextArea, ui.updateTextArea, tfm.exec.chatMessage, print ui.addTextArea = function(id, str, ...) return addTextArea(id, putColors(str), ...) end ui.updateTextArea = function(id, str, ...) return updateTextArea(id, putColors(str), ...) end tfm.exec.chatMessage = function(str, ...) return chatMessage(putColors(str), ...) end print = function(str) return p(putColors(str)) end end
setColorTag("warn", 0xeb1d51) setColorTag("purp", 0x8A2BE2) setColorTag("grbl",0x84b7d1) setColorTag("brp", 0x6e6eff) setColorTag("lbrp", 0xb3b3ff)

-- Noklusējuma iestatījumi
function startMap() tfm.exec.newGame('<C><P DS="m;200,170" APS="169df582e29.png,0,0,100,100,100,50,40"/><Z><S><S P="0,0,0.3,0.2,0,0,0,0" X="0" L="3000" o="000022" H="3000" c="4" Y="0" T="12" /><S P="0,0,0.3,0.2,0,0,0,0" L="10" o="000022" H="10" X="200" Y="240" T="12" /></S><D /><O /></Z></C>') end
startMap()
tfm.exec.setUIMapName("<ROSE>"..version.."")
ui.addTextArea(0, "<p align='center'><font size='14'><rose>"..title.."</font></p>",nil,5, 25, 790, 22, 0x000022, 0x000022, 0.65, true)
tfm.exec.disableAutoShaman(true)
tfm.exec.disableAfkDeath(true)
tfm.exec.disableAutoScore(true)
tfm.exec.disableAutoNewGame(true)
tfm.exec.disableMortCommand(true)

-- Automātiska ziņojuma parādīšanās
function eventNewPlayer(name)
	userData[name] = {
		lang = tfm.get.room.playerList[name].community
	}

	if hosts[name] or contestants[name] then
		ui.addTextArea(8880, "<bv>"..trans[100].."</bv> <grbl>"..version.."</grbl>\n\n<grbl><font size='14'><v><font face='Wingdings 3'>u</font></v> "..trans[101].."</font></grbl>\n\n<bv>"..trans[102].."\n"..trans[103].."</bv>\n\n<grbl><font size='14'><v><font face='Wingdings 3'>u</font></v> "..trans[104].."</font></grbl>\n\n<bv>"..PLANNEDCONTEST.."</bv>", name, 440, 80, 340, 330, 0x000000, 0x000000, 1, true)
		annonce(miscpref..name.." "..trans[200])
		tfm.exec.setPlayerScore(name,0)
	elseif not contestants[name] or not hosts[name] then
	--	ui.addTextArea(100, trans[80], name, -600, -200, 2400, 1200, 0x000001, 0x000001, 1, true)
	--	ui.addTextArea(101, "<ROSE><font size='40'><p align='center'>"..trans[201].."</p></font>\n<A:ACTIVE><font size='24'><p align='center'>"..trans[202].."</p></font>", name, 0, 20, 800, 384, 0x324650, 0x000000, 0, true)
	--	tfm.exec.killPlayer(name)
	--	tfm.exec.setPlayerScore(name,-32767)
	end
end

-- Sāknēšana
 
for playerName in next, tfm.get.room.playerList do
	if hosts[playerName] or contestants[playerName] then eventNewPlayer(playerName) end
	if hosts[playerName] == true then namecol = "ROSE"
		elseif hosts[playerName] == false then namecol = "V" end

	if SETUP.everyoneVerified=="true" then
    contestants[playerName] = true
	end
end
 
for name,player in pairs(tfm.get.room.playerList) do
	if hosts[name] or contestants[name] then
	eventNewPlayer(name)
elseif not contestants[name] or not hosts[name] then
	ui.addTextArea(100, trans[80], name, -600, -200, 2400, 1200, 0x000022, 0x000000, 1, true)
	ui.addTextArea(101, "<ROSE><font size='40'><p align='center'>"..trans[201].."</p></font>\n<A:ACTIVE><font size='24'><p align='center'>"..trans[202].."</p></font>", name, 0, 20, 800, 384, 0x324650, 0x000000, 0, true)
	tfm.exec.killPlayer(name)
	tfm.exec.setPlayerScore(name,-32767)
end
end

do
    local _, nickname = pcall(nil)
    tfm.get.room.owner = string.match(nickname, "(.-)%.")
end

OWNER_ID = 'Syrius#8114' 


settingState = {respawn="v",clear="v"}
-- Komandas
function eventChatCommand(name,cmd,n,playerName)
if cmd== cmd then annonce("<"..namecol.."><b>[~"..name.."]</b></"..namecol.."> <A:ACTIVE>!"..cmd) end
if cmd:sub(1,1) == "s" and hosts[name] or helpers[name] and cmd:sub(1,1) == "s" then tfm.exec.setShaman(cmd:sub(3)) end
if cmd:sub(1,2) == "s*" and hosts[name] or helpers[name] and cmd:sub(1,2) == "s*" then tfm.exec.setShaman(cmd:sub(4),false) end
if cmd:sub(1,2) == "ce" and hosts[name] or helpers[name] and cmd:sub(1,1) == "ce" then tfm.exec.giveCheese(cmd:sub(4)) end
if cmd:sub(1,3) == "ce*" and hosts[name] or helpers[name] and cmd:sub(1,3) == "ce*" then tfm.exec.removeCheese(cmd:sub(5)) end
if cmd:sub(1,1) == "r" and hosts[name] or helpers[name] and cmd:sub(1,1) == "r" then tfm.exec.respawnPlayer(cmd:sub(3)) end
if cmd:sub(1,2) == "bc" and hosts[name] or helpers[name] and cmd:sub(1,2) == "bc" then ui.updateTextArea(0,"<A:ACTIVE>"..cmd:sub(4),nil) end
if cmd:sub(1,3) == "bc*" and hosts[name] then ui.updateTextArea(0,"<VP>"..string.gsub(string.gsub(cmd:sub(5), "&gt;", ">"), "&lt;", "<"),nil) end
if cmd:sub(1,2) == "np" and hosts[name] then tfm.exec.newGame(cmd:sub(4)) end
if cmd:sub(1,3) == "end" and hosts[name] then startMap() 		ui.addTextArea(8880, "<brp><font size='70'>"..trans[247], nil, 440, 80, 340, 330, 0x000000, 0x000000, 1, true) end
if cmd:sub(1,4) == "kill" and hosts[name] then tfm.exec.killPlayer(cmd:sub(6)) end
if cmd:sub(1,4) == "test" and hosts[name] then test() end
if cmd:sub(1,4) == "meep" and hosts[name] then tfm.exec.giveMeep(cmd:sub(6)) end
if cmd:sub(1,5) == "clear" and hosts[name] or helpers[name] and cmd:sub(1,5)=="clear" then clear() end
if cmd:sub(1,5) == "sname" and hosts[name] then ui.setShamanName(cmd:sub(7)) end
if cmd:sub(1,2) == "uc" and hosts[name] then ui.updateTextArea(32,"<V>["..name.."]<A:ACTIVE> "..string.gsub(string.gsub(cmd:sub(4), "&gt;", ">"), "&lt;", "<"),nil) end 
if cmd:sub(1,3) == "uc*" and hosts[name] then ui.updateTextArea(32,"<ROSE> "..string.gsub(string.gsub("<b>• [~"..name.."]</b> "..cmd:sub(5), "&gt;", ">"), "&lt;", "<"),nil) end
if cmd:sub(1,1) == "i" then ui.addTextArea(8999, "<font size='16'><grbl><a href='event:user.cls'>X</a></font> <purp><b>"..trans[203].."</b></font></font>\n______________\n\n<font size='14'><bv>"..trans[204].."</bv></font>\n<font size='12'><v><li><a href='event:user.nogui'>"..trans[205].."</a>\n", name, 325, 100, 150, 200, 0x000022, 0x00022, 0.65, true) end
if cmd:sub(1,2) == "i*" then ui.addTextArea(8999, "<font size='16'><grbl><a href='event:user.cls'>X</a></font> <purp><b>"..trans[203].."</b></purp></font>\n______________\n\n<font size='14'><bv>"..trans[236].."</bv></font>\n<font size='12'><v><li><a href='event:host.keybind-respawn'><"..settingState.respawn..">"..trans[245].."</a></"..settingState.respawn.."> TAB\n<li><a href='event:host.keybind-clear'><"..settingState.clear..">"..trans[246].."</a></"..settingState.clear.."> DEL", name, 325, 100, 150, 200, 0x000022, 0x000000, 0.65, true) end
-- 'all' komandas
if cmd:sub(1,5) == "s all" and hosts[name] then table.foreach(tfm.get.room.playerList, tfm.exec.setShaman) end
if cmd:sub(1,5) == "r all" and hosts[name] then table.foreach(tfm.get.room.playerList, tfm.exec.respawnPlayer) end  
if cmd:sub(1,6) == "ce all" and hosts[name] then table.foreach(tfm.get.room.playerList, tfm.exec.giveCheese) end
if cmd:sub(1,8) == "tfm all" and hosts[name] then table.foreach(tfm.get.room.playerList, tfm.exec.giveTransformations) end 
if cmd:sub(1,8) == "kill all" and hosts[name] then table.foreach(tfm.get.room.playerList, tfm.exec.killPlayer) end 
if cmd:sub(1,8) == "meep all" and hosts[name] then table.foreach(tfm.get.room.playerList, tfm.exec.giveMeep) end   

-- [[DEBUG]]
debug = {}
-- HostCore izsaucējs
if cmd=="hc" and hosts[name] or helpers[name] and cmd=="hc" then 
		hostcore(name)
		annonce2(infpref..trans[206].." <grbl>"..name.."</grbl></lbrp>     <N2><font size='10'>"..trans[207].."</font><N2>")
end

-- Challenge-specfiskas komandas
if cmd == "next" then nm(name) end
if cmd == "toggle mgoc" and hosts[name] and SETUP.challengemode=="build" then tfm.exec.newGame('<C><P H="850" F="8" L="3000" mgoc="-888" bh=""/><Z><S><S H="50" P="0,0,0.3,0.2,0,0,0,0" L="3200" X="1500" Y="825" T="6" /></S><D /><O /></Z></C>')
elseif cmd=="toggle mgoc" and hosts[name] then error0x2(name)
elseif cmd=="toggle mgoc" then error0x1(name) end
if cmd == "toggle sail" and hosts[name] and SETUP.challengemode=="build" then tfm.exec.newGame(buildship) build.len=6000
elseif cmd=="toggle sail" and hosts[name] then error0x2(name)
elseif cmd=="toggle sail" then error0x1(name) end
if cmd == "toggle f" and hosts[name] and SETUP.challengemode=="build" then buildshipready() end
if cmd == "toggle border" and hosts[name] and SETUP.challengemode=="build" then buildborder() end

-- Challenge komandas
if cmd:sub(1,2) =="c "  then ui.removeTextArea(8880,nil) hostinterfaces(name) end
if cmd == "c survival" and hosts[name] and SETUP.challengemode=="survival" then survutils()
elseif cmd=="c survival" then error0x1(name) end
if cmd == "c vanilla" and SETUP.challengemode == "vanilla" and hosts[name] then vanillautils()
elseif cmd=="c vanilla" then error0x1(name) end
if cmd == "c build" and SETUP.challengemode == "build" and hosts[name] then buildutils() hostinterfaces(name)
elseif cmd:sub(1,2) =="c " and hosts[name] then error0x2(name,cmd) 
elseif cmd=="c build" then error0x1(name) end
-- Augsta līmeņa komandas
    local c = { }
    string.gsub(cmd, "%S+", function(arg)
        c[#c + 1] = arg
    end)
 
    if c[1] == "spawn" then
        tfm.exec.addShamanObject(c[2],c[3],c[4],c[5],c[6],c[7],c[8])
    end
    if c[1] == "r*" and hosts[name] then
        tfm.exec.respawnPlayer(c[2])
        tfm.exec.movePlayer(c[2],c[3],c[4])
    elseif c[1] == "r*" then
        error0x1(name)
    end
    if c[1] == "md" and hosts[name] then
        md()
        tfm.exec.addJoint(c[2],1,1,{type=0,point1=c[3]..","..c[4],point2=c[5]..","..c[6],line=c[7],color=0xFF0000,alpha=0.9,foreground=true})
    elseif c[1] == "md" then
        error0x1(name)
    end
    if c[1] == "md*" and hosts[name] then
        md()
        tfm.exec.addJoint("880"..c[2],1,1,{type=0,point1=c[3]..","..c[4],point2=c[5]..","..c[6],line=c[7],color="0x"..c[8].."00",alpha=c[9],foreground=true})
    elseif c[1] == "md*" then
        error0x1(name)
    end
    if c[1] == "g" and hosts[name] then
        tfm.exec.addPhysicObject(c[2],c[4],c[5],{type=c[3],restitution=c[8],friction=c[9],angle=c[10],width=c[6],height=c[7],dynamic=c[11],mass=c[12],miceCollision=true})
    elseif c[1] == "g" then
        error0x1(name)
    end
    if c[1] == "g*" and hosts[name] then
        tfm.exec.addPhysicObject(c[2],c[4],c[5],{type=c[3],restitution=c[8],friction=c[9],angle=c[10],width=c[6],height=c[7],dynamic=c[11],mass=c[12],miceCollision=false,groundCollision=false})
    elseif c[1] == "g*" then
        error0x1(name)
    end
    if c[1] == "txt" and hosts[name] then
        ui.addTextArea("-"..c[2],"<"..c[8].."><font size='16'>"..c[7],nil,c[3],c[4],c[5],c[6],0x000001,0x000001,0,false)
    elseif c[1] == "txt" then
        error0x1(name)
    end
    if c[1] == "txt*" and hosts[name] then
        ui.updateTextArea(c[2],"<"..c[4]..">"..string.gsub(c[3], "|", " "),nil)
    elseif c[1] == "txt" then
        error0x1(name)
    end
    if c[1] == "col" and hosts[name] then
        tfm.exec.setNameColor(c[2],"0x"..c[3].."00")  
    elseif c[1] == "col" then
        error0x1(name)
    end
    if c[1] == "score" and hosts[name] then
        tfm.exec.setPlayerScore(c[2],c[3],false)  
    elseif c[1] == "score" then
        error0x1(name)
    end
    if c[1] == "add" and hosts[name] then
        tfm.exec.setPlayerScore(c[2],c[3],true)  
    elseif c[1] == "add" then
        error0x1(name)
    end
    if c[1] == "size" and hosts[name] or helpers[name] and c[1] == "size" then
        tfm.exec.changePlayerSize(c[2],c[3])
    elseif c[1] == "size" then
        error0x1(name)
        end
    if c[1] == "smode" and hosts[name] or helpers[name] and c[1] == "smode" then
		tfm.exec.setShaman(c[2])
		tfm.exec.setShamanMode(c[2],c[3])
    elseif c[1] == "cmode" then
        error0x1(name)
    end
    if c[1] == "link" and hosts[name] then
        tfm.exec.linkMice(c[2],c[3])
    elseif c[1] == "link" then
        error0x1(name)
    end
    if c[1] == "link*" and hosts[name] then
        tfm.exec.linkMice(c[2],c[3],false)
    elseif c[1] == "link*" then
        error0x1(name)
    end
    if c[1] == "tfm" and hosts[name] then
        tfm.exec.giveTransformations(c[2])
    elseif c[1] == "tfm" then
        error0x1(name)
    end
    if c[1] == "defcol" and hosts[name] then
			setColorTag(c[2], c[3])
			annonce2(infpref..""..name.." "..trans[208].." <"..c[2]..">"..c[2].."</"..c[2]..">.")
    elseif c[1] == "defcol" then
        error0x1(name)
    end
    if c[1] == "tfm*" and hosts[name] then
        tfm.exec.giveTransformations(c[2],false)
    elseif c[1] == "tfm*" then
        error0x1(name)
    end
    if c[1] == "d" and hosts[name] then
			ui.addTextArea(100, "", c[2], -1500, -1500, 3000, 3000, 0x000022, 0x000022, 0.4, true)
			ui.removeTextArea(0,c[2])
			ui.addTextArea(680, "<p align='center'><font size='14'><warn>"..trans[239].." "..trans[211],c[2],5, 25, 790, 22, 0x000022, 0x000022, 0.65, true)
			ui.updateTextArea(32,"<D>• "..c[2].." "..trans[212],nil)
			print("<D>• "..c[2].." "..trans[212])			
			tfm.exec.killPlayer(c[2])
			tfm.exec.setPlayerScore(c[2],-32768,false)
    elseif c[1] == "d" then
        error0x1(name)
    end
    if c[1] == "role" and hosts[name] then
		    if c[2] == "+" then  
			if c[3] == "host" then hosts[c[4]] = true annonce2(infpref..c[4].." "..trans[213]) end
			if c[3] == "helper" then helpers[c[4]] = true annonce2(infpref..c[4].." "..trans[214]) end end
		    if c[2] == "-" then  
			if c[3] == "host" then hosts[c[4]] = false annonce2(infpref..c[4].." "..trans[215]) end
			if c[3] == "helper" then helpers[c[4]] = false annonce2(infpref..c[4].." "..trans[216]) end end
    elseif c[1] == "role" then
        error0x1(name)
    end
	if c[1] =="c" and c[2] == "pkg" and hosts[name] then
		pkg.data = c[3]
		packageutils(c,name,n)
	end
    if c[1] == "p" and hosts[name] then
        ui.addPopup(c[2], c[3],string.gsub(string.gsub(string.gsub(c[4], "&gt;", ">"), "&lt;", "<"), "|", " "),nil, nil, 100, 250, 400, true)
    elseif c[1] == "p" then
        error0x1(name)
    end
    if c[1] == "play" and hosts[name] then
         tfm.exec.playEmote(c[2],c[3],c[4])
    elseif c[1] == "play" then
        error0x1(name)
    end	
    if c[1] == "msg" and hosts[name] then
        ui.updateTextArea(0,"<CE>"..trans[251].." "..name..":<CS> "..string.gsub(string.gsub(string.gsub(c[3], "&gt;", ">"), "&lt;", "<"), "|", " "),c[2])
    elseif c[1] == "msg" then
        error0x1(name)
    end 
end
-- Slēptās komandas
system.disableChatCommandDisplay(nil)

-- [[Utilijas]]

OWNER_ID2 = 'Syrius#8114' 
 
-- Clear

function clear()
local objects={}
for k,v in pairs(tfm.get.room.objectList) do
table.insert(objects,k)
end
for i,object in ipairs(objects) do
tfm.exec.removeObject(object)
end
end

-- Markdown komanda
function md()
tfm.exec.addPhysicObject(1,400,-600,{type=0,width=10,height=10,foreground=true,friction=0.3,restitution=0,dynamic=false,miceCollision=true,groundCollision=true})
end
-- Kļūdas
 
function error0x1(name)
ui.updateTextArea(32,"<warn><b>• ["..name.."]</b> "..trans[217],nil)
end
function error0x2(name,cmd)
ui.updateTextArea(32,"<warn><b>• ["..name.."]</b> "..trans[218],nil)
end

-- Hostu interfeiss

function hostinterfaces(name)
	if hosts[name] then
		ui.addTextArea(450, "<p align='center'><font size='14'><a href='event:say_vn'><bv><font face='Wingdings'>L</font></bv></a>\n<a href='event:nextmap'><bv><font face='Webdings'>8</font></bv></a>\n<a href='event:reload'><bv><font face='Wingdings 3'>P</font></bv></a>\n<a href='event:printtemp'><bv><font face='Wingdings'>1</font></bv></a>\n<a href='event:r_all'><bv><font face='Webdings'>h</font></bv></a>\n<vi>－</vi>\n<a href='event:conf'><warn><font face='Wingdings'>N</font></font></a>", name, 5, 63, 20, 130, 0x000022, 0x000022, 0.65, true)
		if SETUP.challengemode == "build" then
			ui.addTextArea(451, "<font size='14'><p align='center'><a href='event:toggleborder'><bv><font face='Wingdings 3'>F</font></bv></a>\n<a href='event:togglesailwater'><bv><font face='Wingdings'>h</font></bv></a>\n<vi>－</vi>\n<a href='event:togglemgoc'><grbl><font face='Webdings'>;</font></font></a>\n<a href='event:togglesail'><grbl><font face='Webdings'>J</font></font></a></p></font>", name, 5, 213, 20, 100, 0x000022, 0x000022, 0.65, true)
		end
		annonce2(infpref..trans[235].." (<grbl>"..name.."</grbl><lbrp>)") 
	end
end
 
-- Koordinātu printeris
local SHIFT_KEY = 16
local shifting = {}
 
function eventNewPlayer(n,name)

  system.bindKeyboard(n, SHIFT_KEY, true, true)
  system.bindKeyboard(n, SHIFT_KEY, false, true)
  system.bindKeyboard(n, 18, true, true)
  system.bindKeyboard(n, 33, true, true)
  system.bindKeyboard(n, 34, true, true)
  system.bindKeyboard(n, 73, true, true)
  system.bindMouse(n, true)
end

function eventKeyboard(n, key, down, x, y)
 
if key==34 and hosts[n] then rel(n)
elseif key==33 then nm(n) 
elseif key==SHIFT_KEY then shifting[n] = down
end end 
 
function eventMouse(n, x, y)
 
  if shifting[n] then
    ui.updateTextArea(32,"<BV>• "..n .." "..trans[220].." X:" .. x .. ", Y:" .. y,nil)
    print("<BV>• "..n .." "..trans[220].." X:" .. x .. ", Y:" .. y)
  end
end
 
table.foreach(tfm.get.room.playerList, eventNewPlayer)
 
-- UtilCore
ui.addTextArea(32, "",nil, 9, 377, 784, 27, 0x324650, 0x000000, 0, true)
 
-- HostCore
function hostcore(name)
ui.addTextArea(10, "", name, 5, 25, 790, 30, 0x000022, 0x000022, 0.65, true)
ui.addTextArea(65, miscpref..trans[222], name, 5, 25, 790, 20, 0x324650, 0x000000, 0, true)
ui.addTextArea(0, "<p align='center'><font size='14'><ROSE>"..title.."</font></p>",name,5, -25, 790, 22, 0x000022, 0x000022, 0.65, true)
ui.addTextArea(64, infpref..trans[223].." <V>"..version.."</V> / "..trans[224].." <V>"..OWNER_ID.."</V>", name, 5, 40, 790, 20, 0x324650, 0x000000, 0, true)
end

-- eventPlayerDied

function eventPlayerDied(name)
	if SETUP.challengemode=="survival" then
    local count, winner = 0
    for k, v in next, tfm.get.room.playerList do
        if not v.isDead then
            count = count + 1
            winner = k
        end
    end
    if count == 1 then
        winnerFunction(winner)
    end

print("<BV>• "..name.." "..trans[225])
ui.updateTextArea(0,"<font size='14'><ROSE>"..name.." "..trans[226],nil)
end
	if SETUP.autorespawn == "true" then
    tfm.exec.respawnPlayer(n)
	end 
end

-- eventPlayerLeft

function eventPlayerLeft(name)
	annonce(miscpref..name.." "..trans[250])
end
 
-- Preturķēšanās S1
if OWNER_ID ~= OWNER_ID2 then error("<PT>BRĪDINĀJUMS: Pieķerta urķēšanās gar piederības informāciju. Ja neesi modificējis kodu un šis kods ir no <i>dist</i> rīka, tad kontaktē Syrius#8114.") end

-- [[IZDZĪVOŠANAS CHALLENGE UTILIJAS]]
survtest = [[<C><P H="800" L="1600" /><Z><S /><D><P X="0" P="0,0" C="5d6582" Y="400" T="34" /><P X="800" P="0,0" C="324650" Y="0" T="34" /><P X="0" P="0,0" C="719b9f" Y="0" T="34" /><P X="800" P="0,0" C="ffaf00" Y="400" T="34" /><P X="400" P="0,0" C="faff" Y="200" T="34" /></D><O /></Z></C>]]

if SETUP.challengemode == "survival" then
survrounds = 0 
--###################################$201###$202####$703#####$701
survrot = {7479177,7482494,7485763,7602083,7602098,7605138,7605136}
finalrot = {fap1}
function survutils(name)
ui.updateTextArea(0,"<VP><font size='14'>"..trans[227].."</font>", nil)
survRound()
tfm.exec.setUIShamanName("<VP>"..title)
ui.updateTextArea(32,syscore.." "..trans[228],nil)
end
 
function survRound()

survrounds = survrounds + 1

if survrounds ~= 10 then
srv = survrot[math.random(#survrot)]
tfm.exec.newGame(srv)
elseif survrounds == 10 then
tfm.exec.newGame(survrot[math.random(#survrot)])
end

if survrounds ~= 10 then
ui.updateTextArea(0,"<ROSE>"..survrounds..trans[40].." "..trans[229],nil)
elseif survrounds == 10 then
ui.updateTextArea(0,"<ROSE>"..trans[230],nil)
end
end
function winnerFunction(winner)
ui.updateTextArea(0,"<p align='center'><font size='20'><ROSE>"..winner.." "..trans[231].."</font></p>",nil)
ui.updateTextArea(32,"<D>• "..survrounds..trans[40].." "..trans[232].." "..winner.." "..trans[231],nil)
print('<D>• '..survrounds..trans[40]..' '..trans[233]..' '..winner..' '..trans[231])
tfm.exec.giveCheese(winner)
tfm.exec.playerVictory(winner)
tfm.exec.setPlayerScore(winner,60,true)
end
end
 
-- [[BEZ-NAGLU CHALLENGE UTILIJAS]]
if SETUP.challengemode == "vanilla" then
vanillarot = {0,1,2,3,4,5,6,14,15,16,17,18,19,23,24,25,26,27,31,33,37,38,41,43,44,47,49,51,54,55,56,59,64,68,71,79,83,86,99,100,113,119,127,139,147,153,158,161,163,167,200,202,203,207,209} --nelietot 7,8,58,120
function vanillautils()
nextMap()
end
function nextMap()
tfm.exec.newGame(vanillarot[math.random(#vanillarot)])
end
end
 
-- [[BŪVDARBU CĪŅU UTILIJAS]]
build = {len = 1300,ccount = 0,pos = 1500}
ground = '<S P="0,0,0.3,0.2,0,0,0,0" L="3200" H="50" X="'..build.pos..'" Y="825" T="6" lua="-889" /><S H="150" P="0,0,0.3,0.2,0,0,0,0" L="3200" X="'..build.pos..'" c="4" Y="925" T="5" lua="-998" />'

function buildutils()
getbseq()
tfm.exec.newGame('<C><P bh="" H="1000" F="8" L="'..build.len..'" /><Z><S><S P="0,0,0.3,0.2,0,0,0,0" L="3200" H="50" X="1500" Y="825" T="6" lua="-888" /><S H="150" P="0,0,0.3,0.2,0,0,0,0" L="3200" X="1500" c="4" Y="925" T="5" lua="-999" />'..ground..'</S><D /><O /></Z></C>')
end

function getbseq()
for contestants in next, tfm.get.room.playerList do
	build.ccount = build.ccount + 1
end
build.len = build.len * build.ccount
if build.ccount >= 3 then extend() end
end

function extend()
build.pos = build.pos + build.pos
tfm.exec.newGame('<C><P bh="" H="1000" F="8" L="'..build.len..'" /><Z><S><S P="0,0,0.3,0.2,0,0,0,0" L="3200" H="50" X="1500" Y="825" T="6" lua="-888" /><S H="150" P="0,0,0.3,0.2,0,0,0,0" L="3200" X="1500" c="4" Y="925" T="5" lua="-999" />'..ground..'</S><D /><O /></Z></C>')
end

function buildshipready()
tfm.exec.removePhysicObject(-4800) 
tfm.exec.removePhysicObject(-4801) 
tfm.exec.removePhysicObject(-4802)
end

function buildborder()
tfm.exec.addPhysicObject(-3600,0,0,{type=2,restitution=3,friction=3,width=8,height=15000,groundCollision=true,miceCollision=true})
tfm.exec.addPhysicObject(-3601,build.len,0,{type=2,restitution=3,friction=3,width=8,height=15000,groundCollision=true,miceCollision=true})
end

buildship = '<C><P H="850" mgoc="" F="8" L="6000" bh="" /><Z><S><S P="0,0,0.3,0.2,0,0,0,0" L="3200" H="50" X="1500" Y="825" T="7" /><S P="0,0,0.3,0.2,0,0,0,0" L="3200" H="50" X="4700" Y="825" T="7" /><S P="0,0,,,,0,0,0" L="3000" H="250" X="1400" Y="675" T="9" /><S P="0,0,,,,0,0,0" L="3000" H="250" X="4400" Y="675" T="9" /><S P="0,0,,,,0,0,0" L="3000" H="250" X="7400" Y="675" T="9" /><S P="0,0,0.4,0.2,0,0,0,0" L="3000" H="251" X="1400" lua="-4802" Y="674" T="7" /><S P="0,0,0.4,0.2,0,0,0,0" L="3000" H="251" X="4400" lua="-4801" Y="674" T="7" /><S P="0,0,0.4,0.2,0,0,0,0" L="3000" H="251" X="7400" lua="-4800" Y="674" T="7" /></S><D /><O /></Z></C>'

-- [[MAPJU PAKOTŅU UTILIJAS]]
pkg = {round = -1}
function packageutils(c)
tfm.exec.newGame('#'..pkg.data)
end

 		first = 0

-- eventPlayerWon
function eventPlayerWon(playerName, timeElapsed, timeElapsedSinceRespawn)
	if SETUP.challengemode == "pkg" then
		if first == 0 then
        	first = first + 1
			if first == 1 then
			tfm.exec.setPlayerScore(playerName,60,true)   
			ui.updateTextArea(32,"<D>• "..pkg.round..trans[40].." "..trans[233].." "..playerName.." "..trans[231],nil)
			print("<D>• "..pkg.round..trans[40].." "..trans[233].." "..playerName.." "..trans[231])	
 elseif first < 2 then tfm.exec.setPlayerScore(playerName,10,true) 
		end end 
	end
end
if tfm.get.room.owner ~= OWNER_ID then ui.addTextArea(100, "", nil, -2000, -2000, 4000, 4000, 0x000001, 0x000001, 1, true)
if OWNER_ID ~= OWNER_ID2 then error("<R>BRĪDINĀJUMS: Pieķerta preturķēšanās sistēmas noņemšana. Pieķerta urķēšanās gar piederības informāciju. Ja neesi modificējis kodu un šis kods ir no <i>dist</i> rīka, tad kontaktē Syrius#8114.") end
ui.addTextArea(101, "<R><font size='40'>"..trans[237].."</font>\n<font size='16'>"..trans[238].." <J>"..OWNER_ID.."</J>.</font></R>", nil, 100, 150, 600, 100, 0x324650, 0x000000, 0.1, true) end

--##########$302#####$303#####$304###$307###$308#####$309####$310###$311###$312####$313######$314###$315####$316#####$317####$318##$319####$320######$321####$322####$323###$324####$325###$326#######$327###$328####$329###$330###$331#####$332
threerot = {7612717,6265169,6847550,6370623,6333089,6565399,7612788,6975155,7574375,7612773,7612785,6370622,6334320,7612776,7612782,7574389,7574667,7574973,7574975,7574982,7574984,7574997,7574999,7576032,7575113,7576033,7576035,7576224,7576229}

function newMap()
	tfm.exec.newGame(threerot[math.random(#threerot)]) end

function eventNewGame(name)
	if SETUP.challengemode=="thirty" then
		tfm.exec.setGameTime(30)
	end

    local Ptag = string.match(tfm.get.room.xmlMapInfo.xml, "<P (.-)/>")
    local meta = string.match(Ptag, 'meta ?= ?"(.-)"')
    local mapName

    if meta then
        mapName = string.gsub(meta, ",", "<BL> - $", 1).."</BL>"
end
    ui.setMapName(mapName)
	
	if SETUP.challengemode == "pkg" then
	pkg.round = pkg.round + 1
	ui.updateTextArea(0,"<ROSE><font size='14'>"..pkg.round..trans[40].." "..trans[229].."</font>", nil)
	
	end
	if SETUP.challengemode=="pkg" then
		first=0
	end
end


function test()
tfm.exec.newGame(survtest)
end

function eventTextAreaCallback(textAreaID, playerName, callback,id,other)
	if callback=="spectate" then 
		ui.removeTextArea(100,playerName)
		ui.updateTextArea(101,"<R><font size='40'><p align='center'>"..trans[239].."</p></font>\n<N2><font size='24'><p align='center'>"..trans[211].."</p></font>",playerName)
	end
	if callback=="toggleborder" then 
		buildborder()
	end
	if callback=="togglesailwater" then 
		buildshipready()
	end
	if callback=="init_hostcore" and hosts[playerName] then 
		hostcore(playerName)
		print(syscore.." "..trans[206].." (<V>"..playerName.."</V>)")
		ui.updateTextArea(65,syscore.." "..trans[206].." (<V>"..playerName.."</V>)",nil)
	end
 	if callback=="r_all" then 
		table.foreach(tfm.get.room.playerList, tfm.exec.respawnPlayer)
	end
 	if callback=="clear" then 
		clear()
	end
	if callback=="getInfo" then
		ui.addTextArea(600, "<li>version: <T>"..version.."</T></li><li>OWNER_ID: <T>"..OWNER_ID.."</T></li><li>title: <T>"..title.."</T></li><br><b><font size='16'>SETUP</font></b><li>flymode: <R>false</R></li><li>challengemode: <T>"..SETUP.challengemode.."</T></li><li>autorespawn: <T>"..SETUP.autorespawn.."</T></li><li>everyoneVerified: <T>"..SETUP.everyoneVerified.."</T></li><br><hr><p align='right'><a href='event:hlp'><J>"..trans[240].." </J></a><a href='event:about'><V>"..trans[241].." </V></a><a href='event:infclose'><ROSE>"..trans[242].."</ROSE></a></p>", playerName, 215, 134, 369, 131, 0x000022, 0x000022, 0.65, true)
 end
 	if callback=="infclose" then 
		ui.removeTextArea(600,playerName)
	end
 	if callback=="about" then 
		ui.updateTextArea(600, trans[243]..trans[244], playerName)
	end
 	if callback=="user.nogui" then 
		ui.removeTextArea(0,playerName)	ui.removeTextArea(32,playerName)
	end
 	if callback=="user.cls" then 
		ui.removeTextArea(8999,playerName)
	end
 	if callback=="hlp" then 
		ui.updateTextArea(600, "<warn><b>!!! Šī palīdzība dokumentē visu līdz v.b36 versijai un ir novecojusi !!!</b></font><br><br><J><li><a href='event:hlp1'>A - F</a></li><li><a href='event:hlp2'>G - N</a></li><li><a href='event:hlp3'>O - SM</a></li><li><a href='event:hlp4'>SN - Z</a></li></J>\n\n\n\n\n\n<p align='right'><a href='event:infclose'><ROSE>[aizvērt]</ROSE></a></p>", playerName)
	end
 	if callback=="hlp1" then 
		ui.updateTextArea(600, "<font size='10'>Apzīmējumi: <BL>host</BL>, <PT>helper</PT>, <BV>contestant</BV>, <V>obligāts</V>, <R>ne-obligāts</R></font>\n<N2>____________________________________________________</N2>\n\n<b><PT>!bc</PT><BL>*</BL></b> <R>[teksts]</R>\n<font size='10'>Parāda tekstu augšējā interfeisā. Lietojot <BL>!bc*</BL>, ir pieejami HTML tagi.</font>\n\n<b><BL>!c</BL></b> <V>[režīms]</V> <R>[parametrs]</R>\n<font size='10'>Uzsāk semi-automatizēto konkursu. Parametrs ir papildus informācija modulim, t.i. '!c pkg 7'.</font>\n\n<b><PT>!ce*</PT></b> <V>[lietotājvārds]</V> \n<font size='10'>Iedod sieru spēlētājam. Lietojot <PT>!ce*</PT>, siers tiek atņemts.</font>\n\n<b><BL>!col</BL></b> <V>[lietotājvārds] [krāsa]</V>\n<font size='10'>Iekrāso spēlētāja vārdu. Krāsa ir #xxxx formāta heksadecimālie toņi. Neviena krāsa, kurā nepieciešams zilais, nav pieejama!</font>\n\n<b><PT>!clear</PT></b> \n<font size='10'>Nodzēš visus objektus.</font>\n\n<b><BL>!d</BL></b> <V>[lietotājvārds]</V>\n<font size='10'>Diskvalificē spēlētāju.</font>\n\n\n\n\n\n<p align='right'><a href='event:infclose'><ROSE>[aizvērt]</ROSE></a></p>", playerName)
	end
 	if callback=="hlp2" then 
		ui.updateTextArea(600, "<font size='10'>Apzīmējumi: <BL>host</BL>, <PT>helper</PT>, <BV>contestant</BV>, <V>obligāts</V>, <R>ne-obligāts</R></font>\n<N2>____________________________________________________</N2>\n\n<b><BL>!g*</BL></b> <font size='8'><V>[id] [tips] [x] [y] [platums] [augstums]</V> <R>[atsperība] [berze] [leņķis] [din.] [masa]</R></font>\n<font size='10'>Izveido zemi. Lietojot <BL>!g*</BL>, zemei var iziet cauri.</font>\n\n<b><BL>!kill</BL></b> <V>[lietotājvārds]</V>\n<font size='10'>Nogalina spēlētāju.</font>\n\n<b><BL>!link*</BL></b> <V>[lietotājvārds] [lietotājvārds2]</V>\n<font size='10'>Savieno spēlētājus. Lietojot <BL>!link*</BL>, spēlētāji tiek atvienoti viens no otra.</font>\n\n<b><BL>!md*</BL></b> <V>[id] [x1] [y1] [x2] [y2]</V> <R>[platums]</R>\n<font size='10'>Novelk līniju. Lietojot <BL>!md*</BL>, kļūst pieejami parametri <R>[krāsa] [caursp.]</R>, kurus raksta aiz esošajiem. Krāsa ir #xxxx formāta heksadecimālie toņi. Neviena krāsa, kurā nepieciešams zilais, nav pieejama!</font>\n\n<b><BL>!meep</BL></b> <V>[lietotājvārds]</V>\n<font size='10'>Piešķir spēlētajam meep.</font>\n\n<b><BL>!next</BL></b> \n<font size='10'>Pārslēdz mapi. Nav pieejams 'build' režīmā.</font>\n\n<b><BL>!np</BL></b> <V>[kods]</V>\n<font size='10'>Pārslēdz mapi uz konkrētu vai nejaušu rotācijas mapi.</font>\n\n\n\n\n\n<p align='right'><a href='event:infclose'><ROSE>[aizvērt]</ROSE></a></p>", playerName)
	end
 	if callback=="hlp3" then 
		ui.updateTextArea(600, "<font size='10'>Apzīmējumi: <BL>host</BL>, <PT>helper</PT>, <BV>contestant</BV>, <V>obligāts</V>, <R>ne-obligāts</R></font>\n<N2>____________________________________________________</N2>\n\n<b><BL>!p</BL></b> <V>[id] [tips] [teksts]</V>\n<font size='10'>Izveido aizveramu tekstlodziņu. Tekstā atstarpes jāaizstāj ar |.</font>\n\n<b><BL>!play</BL></b> <V>[lietotājvārds] [id] [parametrs]</V>\n<font size='10'>Liek spēlētājam izdarīt emociju. Parametrs ir papildus informācija modulim, t.i. '!play Syrius#8114 10 lv'.</font>\n\n<b><PT>!r</PT><BL>*</BL></b> <V>[lietotājvārds]</V>\n<font size='10'>Atdzīvina spēlētāju. Lietojot <BL>!r*</BL>, kļūst pieejami parametri <R>[x] [y]</R>, kurus raksta aiz esošajiem.</font>\n\n<b><BL>!role</BL></b> <V>[darbība] [statuss] [lietotājvārds]</V>\n<font size='10'>Nomaina spēlētāja statusu. Darbība ir + vai -. Statuss ir 'host' vai 'helper'.</font>\n\n<b><PT>!s*</PT></b> <V>[lietotājvārds]</V>\n<font size='10'>Padara spēlētāju par šamani. Lietojot <PT>!s*</PT>, šamanis kļūst par peli.</font>\n\n<b><BL>!score</BL></b> <V>[lietotājvārds] [vērtība]</V>\n<font size='10'>Maina spēlētāja punktus t.s. 'scoreboard' interfeisā.</font>\n\n<b><PT>!size</PT></b> <V>[lietotājvārds] [vērtība]</V>\n<font size='10'>Maina spēlētāja lielumu. Vērtība ir skaitlis no 0,1 līdz 5.</font>\n\n<b><PT>!smode</PT></b> <V>[lietotājvārds] [režīms]</V>\n<font size='10'>Maina šamaņa režīmu. 0 = normāls; 1 = grūts; 2 = dievišķais.</font>\n\n\n\n\n\n\n\n<p align='right'><a href='event:infclose'><ROSE>[aizvērt]</ROSE></a></p>", playerName)
	end
 	if callback=="hlp4" then 
		ui.updateTextArea(600, "<font size='10'>Apzīmējumi: <BL>host</BL>, <PT>helper</PT>, <BV>contestant</BV>, <V>obligāts</V>, <R>ne-obligāts</R></font>\n<N2>____________________________________________________</N2>\n\n<b><BL>!sname</BL></b> <V>[teksts]</V>\n<font size='10'>Nomaina šamaņa vārdu augšējā interfeisā uz tekstu.</font>\n\n<b><BV>!spawn</BV></b> <V>[tips] [x] [y]</V> <R>[x-paātr.] [y-paātr.] [caursp.]</R>\n<font size='10'>Izveido objektu.</font>\n\n<b><BL>!test</BL></b> \n<font size='10'>Nav funkcijas.</font>\n\n<b><BL>!tfm*</BL></b> <V>[lietotājvārds]</V>\n<font size='10'>Ļauj spēlētājam transformēties. Lietojot <BL>!tfm*</BL>, transformācijas spēja tiek atņemta.</font>\n\n<b><BL>!toggle</BL></b> <V>[parametrs]</V>\n<font size='10'>'build' režīma palīgkomanda, ar kuru pārveidot mapes. </font>\n\n<b><BL>!txt</BL></b> <V>[id] [x] [y] [platums] [augstums] [teksts] [formāts]</V>\n<font size='10'>Izveido tekstlodziņu. formāts = HTML tags bez V-veida iekavām. </font>\n\n<b><BL>!txt*</BL></b> <V>[id] [teksts] [formāts]</V>\n<font size='10'>Rediģē tekstlodziņu. Lai rediģētu ar !txt veidotus tekstlodziņus, pieliec id skaitlim priekšā -. Tekstā atstarpes aizstāj ar |.</font>\n\n<b><BL>!uc*</BL></b> <V>[teksts]</V>\n<font size='10'>Parāda tekstu apakšējā interfeisā (parasti neredzams). Lietojot <BL>!uc*</BL></font>, tekstā nevar lietot HTML un spēlētāja lietotājvārds ir slēpts.\n\n\n\n\n\n\n\n\n<p align='right'><a href='event:infclose'><ROSE>[aizvērt]</ROSE></a></p>", playerName)
	end
	if callback=="say_vn" then
		print("<D>• "..pkg.round..trans[40].." "..trans[229].." - "..trans[248])
		ui.updateTextArea(32,"<D>• "..pkg.round..trans[40].." "..trans[229].." - "..trans[248],nil)	
	end
	if callback=="kill" then
		error("<ch>Konkurss beidzies. <D>("..playerName..")")
	end
	if callback=="hostmenu" then
		ui.addTextArea(5678, "<p align='center'>\n<rose><a href='event:getInfo'>[infopanelis]</a> <a href='event:hi'>[vadības panelis]</a> <a href='event:clsconf'>[aizvērt]</a></p>\n", playerName, 275, 175, 250, 50, 0x000022, 0x000022, 0.6, true)
	end
	if callback=="hi" then
		hostinterfaces(playerName)
	end
	if callback=="reload" then
		rel(playerName)
	end
	if callback=="clsconf" then
		ui.removeTextArea(5678,name)
	end
	if callback=="nextmap" then
		nm(playerName)
	end 
	if callback=="printtemp" then
		if SETUP.challengemode=="pkg" then print(syscore.." "..trans[84].." - https://atelier801.com/topic?f=774444&t=930558&p=1#m1") print(syscore.." "..trans[85].." - https://atelier801.com/topic?f=774444&t=932134&p=1#m1")
		elseif SETUP.challengemode=="vanilla" then print(syscore.." "..trans[82].." - https://atelier801.com/topic?f=774444&t=930827&p=1#m1") print(syscore.." "..trans[81].." - https://atelier801.com/topic?f=774444&t=931791&p=1#m1")
		elseif SETUP.challengemode=="survival" then print(syscore.." "..trans[83].." - https://atelier801.com/topic?f=774444&t=930530&p=1#m1") 
		elseif SETUP.challengemode=="build" then print(syscore.." "..trans[87].." - https://atelier801.com/topic?f=774444&t=931585&p=1#m1")
		else print(syscore.."Nav pieejams.") end 
	end 
	if callback=="conf" then
		ui.addTextArea(5678, "<p align='center'><font size='16'><b><grbl>Vai esi pārliecināts?</font></b></font>\n\n<rose><a href='event:kill'>[jā]</a> <a href='event:clsconf'>[nē]</a><p>", playerName, 275, 175, 250, 50, 0x000022, 0x000022, 0.6, true)
	end end

-- Nākošā mape

function nm(name)
	if hosts[name] and SETUP.challengemode=="vanilla" then nextMap()
	elseif hosts[name] and SETUP.challengemode=="survival" then survRound()
	elseif hosts[name] and SETUP.challengemode=="thirty" then newMap()
	elseif hosts[name] and SETUP.challengemode=="pkg" then tfm.exec.newGame("#"..pkg.data)
end end

-- Pārlādēt mapi

function rel(name)
tfm.exec.newGame(tfm.get.room.currentMap) annonce2(infpref..name.." "..trans[219]) end
