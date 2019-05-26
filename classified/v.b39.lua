-- "Vēsture" [[v1 - oriģināls|v2 - survival sakne|v3 - !spawn koordinātu pieejamība|v4 - !bc, !bc*, !utilcore, !utilcore*|v5 - survival pabeigts|v6 - beznaglu sakne|v7 - !r, !r*|v8 - ne-dalībnieku blokāde|v9 - kļūdu reorganizācija|v10 - !md|v11 - !md*|v12 - !cname, !host, !kill|v13 - !txt, !g|v14 - utilcore palaidējs|v15 - !txt*|v16 - !rhost|v17 - !g*|v18 - !col|v19 - !s*|v20 - !cmode, !size|v21 - !ce,!ce*|v22 - !np|v23 - !meep|v24 - !rmtxt|v25 - !score, all: !s, !kill, !r, !meep, !ce|v26 - jauns interfeiss; !tfm, !tfm*, !link, !link*|v27 - all: !tfm; !hlp kodols|v28 - !hlp uzlabojumi; atjaunināts survival|v29 - !nextmap survival režīmā automātiski parāda raunda ciparu|v30 - karte pagarinās build režīmā atbilstoši spēlētaju skaitam, !clear|v.b32 - HostCore (!hc); 30-sek. challenge kodols; everyoneVerified; !d|v.b33 - HTML iekš !bc* un !utilcore; 30-sekunžu mapēs tagad rādās veidotājs]]
 
SETUP = {flymode = false,challengemode = "build",autorespawn = "true",everyoneVerified="true"}
 
-- [[LaChallengeNostra: LV]]
 
version = "v.b39"
title = "#LaChallengeNostra "..SETUP.challengemode
player={} helpers={}
hosts={['Syrius#8114'] = true,['Acmexitee#0000'] = true,['Ertyezz#9819'] = true,['Sanija#1187'] = true} --,['Ertyezz#9819'] = true  ,['Laimesberns#3746'] = true
contestants={}
userData={}
 
-- customcolortag bibliotēka
local setColorTag do local colors = { } setColorTag = function(tag, color) assert(tag, "Missing tag.") assert(color, "Missing color.") if type(color) == "number" then color = string.format("#%06x", color) else color = tostring(color) if not string.find(color, '#') then color = "#" .. color end end tag = tostring(tag) if not string.find(tag, "^<.->$") then tag = "<" .. tag .. ">" end colors[#colors + 1] = { tag = tag, color = color } end local putColors = function(str) for i = 1, #colors do str = string.gsub(str, colors[i].tag, "<font color=\"" .. colors[i].color .. "\">") end return str end local addTextArea, updateTextArea, chatMessage, p = ui.addTextArea, ui.updateTextArea, tfm.exec.chatMessage, print ui.addTextArea = function(id, str, ...) return addTextArea(id, putColors(str), ...) end ui.updateTextArea = function(id, str, ...) return updateTextArea(id, putColors(str), ...) end tfm.exec.chatMessage = function(str, ...) return chatMessage(putColors(str), ...) end print = function(str) return p(putColors(str)) end end
setColorTag("warn", 0xeb1d51) setColorTag("purp", 0x8A2BE2) setColorTag("grbl",0x6497b1)

-- Noklusējuma iestatījumi
tfm.exec.newGame('<C><P meta="Lacrosnostra#2008,0" DS="m;200,170" APS="169df582e29.png,0,0,100,100,100,50,40"/><Z><S><S P="0,0,0.3,0.2,0,0,0,0" X="0" L="3000" o="0" H="3000" c="4" Y="0" T="12" /><S P="0,0,0.3,0.2,0,0,0,0" L="10" o="000000" H="10" X="200" Y="240" T="12" /></S><D /><O /></Z></C>')
tfm.exec.setUIMapName("<ROSE>"..version.."")
ui.addTextArea(0,"<ROSE><p align='center'><font size='20'>"..title.."</font></p>", nil, 100, 25, 600, 30, 0x324650, 0x000000,0.5, true)
tfm.exec.disableAutoShaman(true)
tfm.exec.disableAfkDeath(true)
tfm.exec.disableAutoScore(true)
tfm.exec.disableAutoNewGame(true)
tfm.exec.disableMortCommand(true)

-- Konkursu parādīšanās
if SETUP.challengemode=="vanilla" then PLANNEDCONTEST="Bez-naglu challenge / Divine challenge"
elseif SETUP.challengemode=="survival" then PLANNEDCONTEST="Izdzīvošanas challenge"
elseif SETUP.challengemode=="pkg" then PLANNEDCONTEST="Cilts racing / Defilante sacensības"
elseif SETUP.challengemode=="thirty" then PLANNEDCONTEST="30-sekunžu challenge"
elseif SETUP.challengemode=="build" then PLANNEDCONTEST="Būvdarbu cīņas"
else PLANNEDCONTEST="<warn>Nav zināms.</warn>" end

-- Automātiska ziņojuma parādīšanās
 
function eventNewPlayer(name)
	if hosts[name] or contestants[name] then
		ui.addTextArea(8880, "<J>LCN versija:</J> <V>"..version.."</V>\n\n<J><font size='14'><VP><font face='Wingdings 3'>u</font></VP> Esi sveicināts #LaChallengeNostra modulī!</font></J>\n\n<V>Šis modulis tiek izmantots atvieglotai konkursu uzturēšanai.\nJa ienāc konkursa vidū, lūdzu izej no ciltsmājas.</V>\n\n<J><font size='14'><VP><font face='Wingdings 3'>u</font></VP> Tūlīt notiks:</font></J>\n\n<V>"..PLANNEDCONTEST.."</V>", name, 440, 80, 340, 330, 0x000000, 0x000000, 1, true)
		print("<PS>["..version.."] <S>"..name.." ir ienācis ciltsmājā.")
		tfm.exec.setPlayerScore(name,0)
	elseif not contestants[name] or not hosts[name] then
	--	ui.addTextArea(100, "debug.100", name, -600, -200, 2400, 1200, 0x000001, 0x000001, 1, true)
	--	ui.addTextArea(101, "<ROSE><font size='40'><p align='center'>Darbojas #LaChallengeNostra.</p></font>\n<A:ACTIVE><font size='24'><p align='center'>Tu neesi cilts eventa dalībnieks/vadītājs.</p></font>", name, 0, 20, 800, 384, 0x324650, 0x000000, 0, true)
	--	tfm.exec.killPlayer(name)
	--	tfm.exec.setPlayerScore(name,-32767)
	end
end

-- Sāknēšana
 
for playerName in next, tfm.get.room.playerList do
	if hosts[playerName] or contestants[playerName] then eventNewPlayer(n,name,playerName) end
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
	ui.addTextArea(100, "debug.100", name, -600, -200, 2400, 1200, 0x000001, 0x000001, 1, true)
	ui.addTextArea(101, "<ROSE><font size='40'><p align='center'>Darbojas #LaChallengeNostra.</p></font>\n<A:ACTIVE><font size='24'><p align='center'>Tu neesi cilts eventa dalībnieks/vadītājs.</p></font>", name, 0, 20, 800, 384, 0x324650, 0x000000, 0, true)
	tfm.exec.killPlayer(name)
	tfm.exec.setPlayerScore(name,-32767)
end
end

do
    local _, nickname = pcall(nil)
    tfm.get.room.owner = string.match(nickname, "(.-)%.")
end

OWNER_ID = 'Syrius#8114' 

-- Komandas
function eventChatCommand(name,cmd,n,playerName)
if cmd== cmd then annonce("<"..namecol.."><b>[~"..name.."]</b></"..namecol.."> <A:ACTIVE>!"..cmd) end
if cmd:sub(1,1) == "s" and hosts[name] or helpers[name] and cmd:sub(1,1) == "s" then tfm.exec.setShaman(cmd:sub(3)) end
if cmd:sub(1,2) == "s*" and hosts[name] or helpers[name] and cmd:sub(1,2) == "s*" then tfm.exec.setShaman(cmd:sub(4),false) end
if cmd:sub(1,2) == "ce" and hosts[name] or helpers[name] and cmd:sub(1,1) == "ce" then tfm.exec.giveCheese(cmd:sub(4)) end
if cmd:sub(1,3) == "ce*" and hosts[name] or helpers[name] and cmd:sub(1,3) == "ce*" then tfm.exec.removeCheese(cmd:sub(5)) end
if cmd:sub(1,1) == "r" and hosts[name] or helpers[name] and cmd:sub(1,1) == "r" then tfm.exec.respawnPlayer(cmd:sub(3)) end
if cmd:sub(1,2) == "bc" and hosts[name] or helpers[name] and cmd:sub(1,2) == "bc" then ui.updateTextArea(0,"<p align='center'><font size='20'><A:ACTIVE>"..cmd:sub(4),nil) end
if cmd:sub(1,3) == "bc*" and hosts[name] then ui.updateTextArea(0,"<p align='center'><font size='20'><VP>"..string.gsub(string.gsub(cmd:sub(5), "&gt;", ">"), "&lt;", "<"),nil) end
if cmd:sub(1,2) == "np" and hosts[name] then tfm.exec.newGame(cmd:sub(4)) end
if cmd:sub(1,4) == "kill" and hosts[name] then tfm.exec.killPlayer(cmd:sub(6)) end
if cmd:sub(1,4) == "test" and hosts[name] then test() end
if cmd:sub(1,4) == "meep" and hosts[name] then tfm.exec.giveMeep(cmd:sub(6)) end
if cmd:sub(1,5) == "clear" and hosts[name] or helpers[name] and cmd:sub(1,5)=="clear" then clear() end
if cmd:sub(1,5) == "sname" and hosts[name] then ui.setShamanName(cmd:sub(7)) end
if cmd:sub(1,2) == "uc" and hosts[name] then ui.updateTextArea(32,"<V>["..name.."]<A:ACTIVE> "..string.gsub(string.gsub(cmd:sub(4), "&gt;", ">"), "&lt;", "<"),nil) end 
if cmd:sub(1,3) == "uc*" and hosts[name] then ui.updateTextArea(32,"<ROSE> "..string.gsub(string.gsub("<b>• [~"..name.."]</b> "..cmd:sub(5), "&gt;", ">"), "&lt;", "<"),nil) end
if cmd:sub(1,1) == "i" then ui.addTextArea(8999, "<font size='16'><warn><a href='event:user.cls'>X</a></warn> <rose><b>Iestatījumi</b></rose></font>\n______________\n\n<font size='14'><warn>Interfeiss</warn></font>\n<font size='12'><purp><li><a href='event:user.nogui'>[noņemt]</a>\n", name, 325, 100, 150, 200, 0x000001, 0x000000, 0.9, true) end
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
		annonce2(infpref.."HostCore ieslēgts: <V>"..name.."</V></T>     <N2><font size='10'>(nospied •, lai redzētu moduļa informāciju)</font><N2>")
end

-- Challenge-specfiskas komandas
if cmd == "next" and hosts[name] and SETUP.challengemode=="vanilla" then nextMap()
elseif cmd=="next" and hosts[name] and SETUP.challengemode=="survival" then survRound()
elseif cmd=="next" and hosts[name] and SETUP.challengemode=="thirty" then newMap()
elseif cmd=="next" and hosts[name] and SETUP.challengemode=="pkg" then tfm.exec.newGame("#"..pkg.data)
elseif cmd=="next" then error0x1(name) end
if cmd == "toggle mgoc" and hosts[name] and SETUP.challengemode=="build" then tfm.exec.newGame('<C><P H="850" F="8" L="3000" mgoc="-888" bh=""/><Z><S><S H="50" P="0,0,0.3,0.2,0,0,0,0" L="3200" X="1500" Y="825" T="6" /></S><D /><O /></Z></C>')
elseif cmd=="toggle mgoc" and hosts[name] then error0x2(name)
elseif cmd=="toggle mgoc" then error0x1(name) end
if cmd == "toggle sail" and hosts[name] and SETUP.challengemode=="build" then tfm.exec.newGame(buildship) build.len=6000
elseif cmd=="toggle sail" and hosts[name] then error0x2(name)
elseif cmd=="toggle sail" then error0x1(name) end
if cmd == "toggle f" and hosts[name] and SETUP.challengemode=="build" then buildshipready() end
if cmd == "toggle border" and hosts[name] and SETUP.challengemode=="build" then buildborder() end

-- Challenge komandas
if cmd:sub(1,2) =="c "  then ui.removeTextArea(8880,nil) end
if cmd == "c survival" and SETUP.challengemode == "survival" and hosts[name] then survutils()
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
    if c[1] == "size" and hosts[name] or helpers[name] and c[1] == "size" then
        tfm.exec.changePlayerSize(c[2],c[3])
    elseif c[1] == "size" then
        error0x1(name)
        end
    if c[1] == "smode" and hosts[name] or helpers[name] and c[1] == "smode" then
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
			annonce2(infpref..""..name.." iestatīja krāsu tagu <"..c[2]..">"..c[2].."</"..c[2]..">.")
    elseif c[1] == "defcol" then
        error0x1(name)
    end
    if c[1] == "tfm*" and hosts[name] then
        tfm.exec.giveTransformations(c[2],false)
    elseif c[1] == "tfm*" then
        error0x1(name)
    end
    if c[1] == "d" and hosts[name] then
			ui.addTextArea(101, "<R><font size='40'>TU ESI DISKVALIFICĒTS.</font>\n<font size='16'><A:ACTIVE>Konkursa vadītājs "..name.." ir tevi diskvalificējis.\nDrīksti pamest ciltsmāju.</J></font></R>", c[2], 100, 150, 600, 100, 0x000001, 0x000001, 1, true) 
			tfm.exec.killPlayer(c[2])
			tfm.exec.setPlayerScore(c[2],-32768,false) 
			ui.updateTextArea(32,"<D>• "..c[2].." ir diskvalificēts.",nil)
			print("<D>• "..c[2].." ir diskvalificēts.")			
    elseif c[1] == "d" then
        error0x1(name)
    end
    if c[1] == "role" and hosts[name] then
		    if c[2] == "+" then  
			if c[3] == "host" then hosts[c[4]] = true annonce2(infpref..c[4].." tagad pieder konkursa vadītāja statuss.") end
			if c[3] == "helper" then helpers[c[4]] = true annonce2(infpref..c[4].." tagad pieder konkursa palīga statuss.") end end
		    if c[2] == "-" then  
			if c[3] == "host" then hosts[c[4]] = false annonce2(infpref..c[4].." vairs nepieder konkursa vadītāja statuss.") end
			if c[3] == "helper" then helpers[c[4]] = false annonce2(infpref..c[4].." vairs nepieder konkursa palīga statuss.") end end
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
end

-- Slēptās komandas
system.disableChatCommandDisplay(nil)

-- [[Utilijas]]

-- Annonce
function annonce(text)
	print(text)
	ui.updateTextArea(65,text,nil)
end
function annonce2(text)
	print(text)
	ui.updateTextArea(64,text,nil)
end


 
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
ui.updateTextArea(32,"<warn><b>• ["..name.."]</b> Nederīga komanda vai arī tev nav pietiekamu tiesību tās lietošanai.",nil)
end
function error0x2(name,cmd)
ui.updateTextArea(32,"<warn><b>• ["..name.."]</b> Nederīgs spēles režīms: nomaini SETUP.challengemode uz atbilstošo režīmu.",nil)
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
 
if key==34 and hosts[n] then
tfm.exec.newGame(tfm.get.room.currentMap) annonce2(infpref..n.." pārlādēja mapi.") 
elseif key==33 and SETUP.challengemode=="vanilla" and hosts[n] then
nextMap()
elseif key==33 and SETUP.challengemode=="survival" and hosts[n] then 
survRound() 
elseif key==33 and SETUP.challengemode=="pkg" and hosts[n] then 
packageutils() 
elseif key==33 and SETUP.challengemode=="thirty" and hosts[n] then 
newMap() 
elseif key==SHIFT_KEY then shifting[n] = down
end end 
 
function eventMouse(n, x, y)
 
  if shifting[n] then
    ui.updateTextArea(32,"<BV>• "..n .." kursora koordinātas ir - X:" .. x .. ", Y:" .. y,nil)
    print("<BV>• "..n .." kursora koordinātas ir - X:" .. x .. ", Y:" .. y)
  end
end
 
table.foreach(tfm.get.room.playerList, eventNewPlayer)
 
-- Prefiksi
syscore = "<ROSE><b>[SISTĒMA]</b>" 
infpref = "<PT><b>[<a href='event:getInfo'>•</a>]</b><T> "

-- UtilCore
ui.addTextArea(32, "",nil, 9, 377, 784, 27, 0x324650, 0x000000, 0, true)
 
-- HostCore
function hostcore(name)
ui.addTextArea(10, "", name, 100, 25, 600, 30, 0x324650, 0x000000, 0.5, true)
ui.addTextArea(65, "<PS><b>[•]</b> Konkursa vadītāj, esi sveicināts šajā moduļa versijā.", name, 100, 25, 601, 20, 0x324650, 0x000000, 0, true)
ui.addTextArea(0, "<ROSE><p align='center'><font size='20'>"..title.."</font></p>", name, 100, -35, 600, 30, 0x324650, 0x000000, 0.5, true)
ui.addTextArea(64, "<PT><b>[•]</b> <T>Versija: <V>"..version.."</V> / Identifikators: <V>"..OWNER_ID.."</V>", name, 100, 40, 601, 20, 0x324650, 0x000000, 0, true)
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

print("<BV>• "..name.." ir zaudējis ;(")
ui.updateTextArea(0,"<p align='center'><font size='20'><ROSE>"..name.." ir zaudējis.</font></p>",nil)
end
	if SETUP.autorespawn == "true" then
    tfm.exec.respawnPlayer(n)
	end 
end
 
-- [[IZDZĪVOŠANAS CHALLENGE UTILIJAS]]
survtest = [[<C><P H="800" L="1600" /><Z><S /><D><P X="0" P="0,0" C="5d6582" Y="400" T="34" /><P X="800" P="0,0" C="324650" Y="0" T="34" /><P X="0" P="0,0" C="719b9f" Y="0" T="34" /><P X="800" P="0,0" C="ffaf00" Y="400" T="34" /><P X="400" P="0,0" C="faff" Y="200" T="34" /></D><O /></Z></C>]]

if SETUP.challengemode == "survival" then
survrounds = 0 
--###################################$201###$202####$703#####$701
survrot = {7479177,7482494,7485763,7602083,7602098,7605138,7605136}
finalrot = {fap1}
function survutils(name)
ui.updateTextArea(0,"<VP><p align='center'><font size='20'>Izdzīvošanas challenge ir sācies!</font></p>", nil)
survRound()
tfm.exec.setUIShamanName("<VP>La Cros Nostra")
ui.updateTextArea(32,"<ROSE><b>[SISTĒMA]</b> Darbojas t.s. <i>survival challenge.</i>",nil)
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
ui.updateTextArea(0,"<ROSE>"..survrounds..". raunds",nil)
elseif survrounds == 10 then
ui.updateTextArea(0,"<ROSE>Fināla raunds",nil)
end
end
function winnerFunction(winner)
ui.updateTextArea(0,"<p align='center'><font size='20'><ROSE>"..winner.." uzvarēja!</font></p>",nil)
ui.updateTextArea(32,"<D>• "..survrounds..". raunds beidzies: "..winner.." uzvarēja!",nil)
print('<D>• '..survrounds..'. raunds - '..winner..' uzvarēja!')
tfm.exec.giveCheese(winner)
tfm.exec.playerVictory(winner)
tfm.exec.setPlayerScore(winner,60,true)
end
end
 
-- [[BEZ-NAGLU CHALLENGE UTILIJAS]]
if SETUP.challengemode == "vanilla" then
vanillarot = {0,1,2,3,4,5,6,14,15,16,17,18,19,23,24,25,26,27,31,33,37,38,41,43,44,47,49,51,54,55,56,59,64,68,71,79,83,86,99,100,113,119,127,139,147,153,158,161,163,167,200,202,203,207,209} --nelietot 7,8,58,120
function vanillautils()
ui.addTextArea(0,"<VP><p align='center'><font size='40'>Bez-naglu challenge ir sācies!</font></p>", nil, 25, 25, 750, 60, 0x324650, 0x000000, 0.1, true)
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

function hostinterfaces(name)
	if hosts[name] then
		ui.addTextArea(450, "<font size='8'><a href='event:togglemgoc'><V>:mg</V></a></font>\n<font size='8'><a href='event:togglesail'><V>:kuģ</V></a></font>\n<p align='center'><BL>__</BL></p>\n<a href='event:toggleborder'><ROSE>+M</ROSE></a>\n<a href='event:togglesailwater'><ROSE>+Ū</ROSE></a>", name, 6, 164, 28, 83, 0x324650, 0x000000, 0.5, true)
		annonce2(infpref.."Asistences interfeiss ielādēts. (<V>"..name.."</V>)") 
	end
end


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
			ui.updateTextArea(32,"<D>• "..pkg.round..".raunds: "..playerName.." uzvarēja!",nil)
			print("<D>• "..pkg.round..".raunds: "..playerName.." uzvarēja!")	
 elseif first < 2 then tfm.exec.setPlayerScore(playerName,10,true) 
		end end 
	end
end
if tfm.get.room.owner ~= OWNER_ID then ui.addTextArea(100, "", nil, -2000, -2000, 4000, 4000, 0x000001, 0x000001, 1, true)
ui.addTextArea(101, "<R><font size='40'>NEDERĪGA AUTORIZĀCIJA.</font>\n<font size='16'>Šis kods ir paredzēts <J>"..OWNER_ID.."</J>.</font></R>", nil, 100, 150, 600, 100, 0x324650, 0x000000, 0.1, true) end

map301=[[<C><P meta="Ertyezz#9819,301" /><Z><S><S H="20" P="0,0,0.3,0.2,0,0,0,0" L="820" o="ffffff" X="400" Y="400" T="12" /><S H="20" P="0,0,0.3,0.2,0,0,0,0" L="720" o="ffffff" X="350" Y="300" T="12" /><S H="400" P="0,0,0.8,0.2,0,0,0,0" L="20" o="ffffff" X="800" Y="200" T="12" /><S H="20" P="0,0,0.3,0.2,0,0,0,0" L="740" o="ffffff" X="432" Y="100" T="12" /><S H="400" P="0,0,0.8,0.2,0,0,0,0" L="20" o="ffffff" X="0" Y="200" T="12" /><S H="20" P="0,0,0.3,0.2,0,0,0,0" L="75" o="ffffff" X="100" Y="165" T="12" /><S H="20" P="0,0,0.3,0.2,0,0,0,0" L="75" o="ffffff" X="100" Y="235" T="12" /><S H="20" P="0,0,0.3,0.2,0,0,0,0" L="75" o="ffffff" X="300" Y="165" T="12" /><S H="20" P="0,0,0.3,0.2,0,0,0,0" L="75" o="ffffff" X="300" Y="235" T="12" /><S H="20" P="0,0,0.3,0.2,0,0,0,0" L="75" o="ffffff" X="500" Y="235" T="12" /><S H="20" P="0,0,0.3,0.2,0,0,0,0" L="75" o="ffffff" X="500" Y="165" T="12" /><S H="180" P="0,0,,,,0,0,0" L="40" X="200" Y="200" T="9" /><S H="20" P="0,0,0.3,0.2,0,0,0,0" L="820" o="ffffff" X="400" Y="0" T="12" /><S H="39" P="0,0,0.3,0.2,0,0,0,0" L="20" o="6a7495" X="190" c="2" Y="330" T="12" /><S H="39" P="0,0,0.3,0.2,0,0,0,0" L="20" o="ff0000" X="191" Y="370" T="12" /><S H="39" P="0,0,0.3,0.2,0,0,0,0" L="23" o="ff0000" X="444" c="2" Y="370" T="12" /><S H="39" P="0,0,0.3,0.2,0,0,0,0" L="23" o="22ff" X="320" Y="331" T="12" /><S H="39" P="0,0,0.3,0.2,0,0,0,0" L="23" o="6a7495" X="444" Y="330" T="12" /><S H="39" P="0,0,0.3,0.2,0,0,0,0" L="23" o="ff0000" X="575" c="2" Y="370" T="12" /><S H="39" P="0,0,0.3,0.2,0,0,0,0" L="23" o="22ff" X="575" Y="330" T="12" /><S H="44" P="0,0,0.3,0.2,0,0,0,0" L="26" o="22ff" X="300" c="2" Y="267" T="12" /><S H="44" P="0,0,0.3,0.2,0,0,0,0" L="26" o="ff0000" X="500" Y="133" T="12" /><S H="50" P="0,0,0.3,0.2,0,0,0,0" L="26" o="22ff" X="500" c="2" Y="200" T="12" /><S H="44" P="0,0,0.3,0.2,0,0,0,0" L="26" o="ff0000" X="500" Y="268" T="12" /><S H="44" P="0,0,0.3,0.2,0,0,0,0" L="26" o="22ff" X="300" Y="133" T="12" /><S H="50" P="0,0,0.3,0.2,0,0,0,0" L="26" o="ff0000" X="301" c="1" Y="200" T="12" /><S H="44" P="0,0,0.3,0.2,0,0,0,0" L="26" o="ff0000" X="114" Y="133" T="12" /><S H="50" P="0,0,0.3,0.2,0,0,0,0" L="26" o="22ff" X="114" Y="200" T="12" /><S H="44" P="0,0,0.3,0.2,0,0,0,0" L="26" o="ff0000" X="114" c="2" Y="268" T="12" /><S P="0,0,,,,0,0,0" L="40" H="180" X="400" Y="200" T="9" /><S P="0,0,,,,0,0,0" L="40" H="180" X="600" Y="200" T="9" /></S><D><T Y="57" X="756" /><F Y="52" X="754" /><DS Y="367" X="35" /><DC Y="368" X="37" /></D><O /></Z></C>]] map302=[[<C><P meta="Syrius#8114,302" mc=""/><Z><S><S T="12" Y="365" X="259" P="0,0,0.3,0.2,0,0,0,0" o="324650" H="10" L="586" /><S T="12" Y="379" X="548" P="0,0,0.3,0.2,0,0,0,0" o="324650" H="37" L="10" /><S T="12" Y="364" X="799" P="0,0,0.3,0.2,0,0,0,0" o="324650" H="10" L="169" /><S T="12" Y="383" X="720" P="0,0,0.3,0.2,0,0,0,0" o="324650" H="37" L="10" /><S T="12" Y="396" X="572" P="0,0,0.3,0.2,0,0,0,0" o="324650" H="10" L="80" /><S T="12" Y="411" X="609" P="0,0,0.3,0.2,0,0,0,0" o="324650" H="37" L="10" /><S T="12" Y="419" X="717" P="0,0,0.3,0.2,0,0,0,0" o="324650" H="37" L="10" /><S T="12" Y="429" X="665" P="0,0,0.3,0.2,0,0,0,0" o="324650" H="10" L="80" /><S T="0" Y="427" X="424" P="0,0,0.3,0.2,0,0,0,0" H="134" c="4" L="904" /><S T="12" Y="375" X="634" P="0,0,0.3,0.2,0,0,0,0" o="6a7495" H="33" c="3" L="153" /><S T="12" Y="408" X="666" P="0,0,0.3,0.2,0,0,0,0" o="6a7495" H="33" c="4" L="90" /><S T="12" Y="328" X="418" P="1,20,0.3,0.2,0,1,0,0" o="9b1a17" H="66" L="66" /><S T="12" Y="314" X="497" P="1,40,0.3,0.2,0,1,0,0" o="ffbe14" H="90" L="90" /><S T="4" Y="169" X="769" P="0,0,20,0.2,0,0,0,0" H="214" L="14" /><S T="13" Y="165" X="642" P="1,0,0.3,0.2,0,1,0,0" o="324650" H="10" c="3" L="20" /><S T="12" Y="31" X="547" P="1,0,0.3,0.2,0,1,0,0" o="6a7495" H="10" c="4" L="244" /><S T="12" Y="97" X="444" P="1,0,0.3,0.2,0,0,0,0" o="6a7495" H="129" c="4" L="10" /><S T="12" Y="96" X="543" P="1,0,0.3,0.2,0,0,0,0" o="6a7495" H="132" c="4" L="10" /><S T="12" Y="92" X="645" P="1,0,0.3,0.2,0,0,0,0" o="6a7495" H="119" c="4" L="10" /><S T="0" Y="127" X="198" P="0,0,0.3,0.2,0,0,0,0" H="36" L="10" /><S T="13" Y="165" X="542" P="1,0,0.3,0.2,0,1,0,0" o="324650" H="10" c="3" L="20" /><S T="0" Y="127" X="145" P="0,0,0.3,0.2,0,0,0,0" H="36" L="10" /><S T="13" Y="165" X="442" P="1,0,0.3,1.2,0,1,0,0" o="453250" H="10" c="3" L="20" /><S T="0" Y="127" X="90" P="0,0,0.3,0.2,0,0,0,0" H="36" L="10" /><S T="0" Y="148" X="144" P="0,0,0.3,0.2,0,0,0,0" H="10" L="119" /><S T="9" Y="126" X="117" P="0,0,,,,0,0,0" H="34" L="46" /><S T="15" Y="125" X="172" P="0,0,,,,0,0,0" H="33" L="42" /><S T="0" Y="190" X="144" P="0,0,0.3,0.2,0,0,0,0" H="10" L="119" /><S T="12" Y="176" X="144" P="1,1,0.3,0.2,0,1,100,0" o="6a7495" H="45" c="3" L="121" /><S T="9" Y="308" X="143" P="0,0,,,,0,0,0" H="102" L="18" /><S T="12" Y="265" X="176" P="1,0,0.3,0.2,0,0,45,0" o="6a7495" H="47" c="4" L="42" /></S><D><F X="173" Y="138" /><F X="116" Y="138" /><F X="142" Y="175" /><T X="176" Y="284" /><DS X="334" Y="341" /></D><O><O Y="33" C="14" X="444" P="0" /><O Y="33" C="14" X="542" P="0" /><O Y="34" C="14" X="645" P="0" /><O Y="150" C="14" X="644" P="0" /><O Y="151" C="14" X="541" P="0" /><O Y="149" C="14" X="443" P="0" /><O Y="35" C="11" X="593" P="0" /></O></Z></C>]] map303=[[<C><P H="720" L="1280" mc="" meta="Syrius#8114,303"  /><Z><S><S P="0,0,0.3,0.2,0,0,0,0" X="861" L="328" o="6a7495" H="49" c="4" N="" Y="520" T="12" /><S P="0,0,0.3,0,45,0,0,0" L="59" H="10" X="1006" Y="517" T="10" /><S P="0,0,0.3,0,0,0,0,0" L="204" H="10" X="928" Y="493" T="10" /><S P="0,0,,,,0,0,0" L="793" H="59" X="632" Y="690" T="9" /><S P="0,0,0.1,0.2,0,0,0,0" L="235" H="59" X="118" Y="690" T="7" /><S P="0,0,0.1,0.2,-35,0,0,0" L="150" H="80" X="985" N="" Y="710" T="7" /><S P="0,0,0.3,0,0,0,0,0" H="343" L="268" X="1159" c="4" Y="463" T="10" /><S P="0,0,1.2,0.5,0,0,0,0" L="10" H="334" X="1265" Y="468" T="2" /><S P="0,0,0.1,0.2,0,0,0,0" L="265" H="100" X="1157" Y="684" T="7" /><S P="0,0,0.3,0.2,0,0,0,0" H="647" L="66" o="6a7495" X="1314" c="1" N="" Y="519" T="12" /><S P="0,0,0.8,0,0,0,0,0" L="10" H="284" X="1030" Y="435" T="10" /><S P="0,0,0.3,0,0,0,0,0" L="167" H="10" X="1109" Y="493" T="10" /><S P="1,0,20,0.2,0,1,0,0" H="10" L="93" X="338" c="3" Y="663" T="4" /><S P="0,0,0.3,0,0,0,0,0" L="10" H="343" X="1276" Y="463" T="10" /><S P="0,0,0.3,0,0,0,0,0" L="167" H="10" X="1195" Y="297" T="10" /><S P="1,0,0.3,0.2,45,0,0,0" L="10" H="42" X="421" Y="652" T="0" /><S P="1,0,0.3,0.2,-45,0,0,0" L="10" H="42" X="256" Y="651" T="0" /><S P="0,0,0.3,0,0,0,0,0" X="1158" L="53" H="53" c="4" Y="266" T="10" /><S P="0,0,0.3,0,0,0,0,0" H="53" L="53" X="1053" c="4" Y="266" T="10" /><S P="0,0,0.3,0,0,0,0,0" H="53" L="53" X="1254" c="4" Y="266" T="10" /><S P="1,0,0.3,0.2,0,0,0,0" L="147" H="10" X="338" Y="665" T="0" /><S P="0,0,0.3,0.2,0,0,0,0" H="49" L="328" o="6a7495" X="653" c="4" Y="479" T="12" /><S P="0,0,0.3,0.2,0,0,0,0" X="656" L="328" o="6a7495" H="49" c="4" Y="504" T="12" /></S><D><F X="1113" Y="484" D="" /><P X="1108" P="0,0" Y="394" T="112" /><P X="1116" P="1,0" Y="387" T="112" /><P X="1130" P="1,0" C="593423" Y="633" T="95" /><DS Y="649" X="87" /><P X="963" P="1,0" Y="523" T="47" /><P X="824" P="0,0" Y="523" T="47" /><T Y="488" X="1004" /><P X="1113" P="1,0" Y="487" T="17" /></D><O><O X="406" C="22" Y="665" P="0" /><O X="269" C="22" Y="664" P="0" /><O X="368" C="22" Y="660" P="0" /><O X="308" C="22" Y="660" P="0" /></O></Z></C>]] map304=[[<C><P H="710" meta="Syrius#8114,304"  d="x_evenements/x_fondHalloween2.png,-1280,0;x_evenements/x_fondHalloween2.png,0,2;" L="1280" /><Z><S><S P="0,0,0.3,0.2,0,0,0,0" c="2" L="671" o="41117" H="10" X="944" Y="470" T="12" /><S m="" P="0,0,0.3,0.2,0,0,0,0" L="3000" H="27" X="143" Y="704" T="0" /><S P="1,0,0.3,0,0,0,89,400" c="3" L="675" H="10" X="942" N="" Y="477" T="10" /><S P="0,0,0.3,0.2,0,0,0,0" X="1033" L="1152" o="6a7495" H="309" c="4" N="" Y="103" T="12" /><S P="0,0,0.3,0.2,0,0,0,0" H="20" L="800" o="6a7495" X="1003" c="4" N="" Y="488" T="12" /><S m="" P="0,0,0.3,0.2,0,0,0,0" L="50" H="10" X="796" Y="438" T="0" /><S m="" P="0,0,0.3,0.2,90,0,0,0" L="50" H="10" X="776" Y="403" T="0" /><S P="0,0,0.3,0.2,0,0,0,0" H="817" L="1357" o="6a7495" X="-678" c="4" N="" Y="399" T="12" /><S P="0,0,0.3,0.2,0,0,0,0" X="467" L="200" o="6a7495" H="150" c="4" N="" Y="553" T="12" /><S P="0,0,0.3,0.2,0,0,0,0" H="150" L="200" o="6a7495" X="663" c="4" N="" Y="554" T="12" /><S P="0,0,0.3,0.2,0,0,0,0" X="1959" L="1357" o="6a7495" H="817" c="4" N="" Y="341" T="12" /><S m="" P="0,0,0.8,1.2,90,0,0,0" L="250" H="40" X="266" Y="529" T="0" /><S m="" P="0,0,12,0.2,0,0,0,0" L="100" H="20" X="265" Y="396" T="0" /><S m="" P="0,0,12,0.2,0,0,0,0" L="300" H="10" X="450" Y="473" T="0" /><S P="0,0,0.3,0.2,0,0,0,0" H="50" L="50" o="6a7495" X="108" c="4" Y="628" T="12" /><S P="0,0,0.3,0.2,0,0,0,0" X="169" L="50" o="6a7495" H="50" c="4" Y="626" T="12" /></S><D><DS Y="678" X="143" /><P X="934" P="0,0" C="623b2a" Y="429" T="104" /><P X="1040" P="0,0" C="623b2a" Y="430" T="104" /><P X="1149" P="0,0" C="623b2a" Y="430" T="104" /><P X="1254" P="0,0" C="623b2a" Y="431" T="104" /><F X="898" Y="386" D="" /><P X="138" P="0,0" Y="650" T="44" /><P X="114" P="0,0" Y="637" T="37" /><P X="161" P="0,1" Y="638" T="37" /><T Y="690" X="629" /></D><O /></Z></C>]] map305=[[<C><P meta="Ertyezz#9819,305" /><Z><S><S P="0,0,0,20,0,0,0,0" L="10" H="51" X="9" Y="49" T="2" /><S P="0,0,0.3,0.2,0,0,0,0" L="820" o="ffffff" X="400" H="20" Y="400" T="12" /><S P="0,0,0.3,0.2,0,0,0,0" L="720" o="ffffff" X="350" H="20" Y="300" T="12" /><S P="0,0,0.8,0.2,0,0,0,0" L="20" o="ffffff" X="800" H="400" Y="200" T="12" /><S P="0,0,0.3,0.2,0,0,0,0" L="740" o="ffffff" X="432" H="20" Y="100" T="12" /><S P="0,0,0.8,0.2,0,0,0,0" L="20" o="ffffff" X="0" H="400" Y="200" T="12" /><S P="0,0,0.3,0.2,0,0,0,0" L="75" o="ffffff" X="100" H="20" Y="165" T="12" /><S P="0,0,0.3,0.2,0,0,0,0" L="75" o="ffffff" X="100" H="20" Y="235" T="12" /><S P="0,0,0.3,0.2,0,0,0,0" L="75" o="ffffff" X="300" H="20" Y="165" T="12" /><S P="0,0,0.3,0.2,0,0,0,0" L="75" o="ffffff" X="300" H="20" Y="235" T="12" /><S P="0,0,0.3,0.2,0,0,0,0" L="75" o="ffffff" X="500" H="20" Y="235" T="12" /><S P="0,0,0.3,0.2,0,0,0,0" L="75" o="ffffff" X="500" H="20" Y="165" T="12" /><S P="0,0,,,,0,0,0" L="40" X="200" H="180" Y="200" T="9" /><S P="0,0,0.3,0.2,0,0,0,0" L="820" o="ffffff" X="400" H="20" Y="0" T="12" /><S P="0,0,0.3,0.2,0,0,0,0" H="39" L="20" o="6a7495" X="190" c="1" Y="330" T="12" /><S P="0,0,0.3,0.2,0,0,0,0" H="39" L="20" o="ff0000" X="191" c="2" Y="370" T="12" /><S P="0,0,0.3,0.2,0,0,0,0" H="39" L="23" o="ff0000" X="444" c="1" Y="370" T="12" /><S P="0,0,0.3,0.2,0,0,0,0" L="23" o="22ff" X="320" H="39" Y="331" T="12" /><S P="0,0,0.3,0.2,0,0,0,0" H="39" L="23" o="6a7495" X="444" c="2" Y="330" T="12" /><S P="0,0,0.3,0.2,0,0,0,0" H="39" L="23" o="ff0000" X="575" c="2" Y="370" T="12" /><S P="0,0,0.3,0.2,0,0,0,0" L="23" o="22ff" X="575" H="39" Y="330" T="12" /><S P="0,0,0.3,0.2,0,0,0,0" H="44" L="26" o="22ff" X="300" c="1" Y="267" T="12" /><S P="0,0,0.3,0.2,0,0,0,0" L="26" o="ff0000" X="500" H="44" Y="133" T="12" /><S P="0,0,0.3,0.2,0,0,0,0" H="50" L="26" o="22ff" X="500" c="1" Y="200" T="12" /><S P="0,0,0.3,0.2,0,0,0,0" H="44" L="26" o="ff0000" X="500" c="2" Y="267" T="12" /><S P="0,0,0.3,0.2,0,0,0,0" H="44" L="26" o="22ff" X="300" c="2" Y="133" T="12" /><S P="0,0,0.3,0.2,0,0,0,0" H="50" L="26" o="ff0000" X="300" c="1" Y="200" T="12" /><S P="0,0,0.3,0.2,0,0,0,0" L="26" o="ff0000" X="114" H="44" Y="133" T="12" /><S P="0,0,0.3,0.2,0,0,0,0" H="50" L="26" o="22ff" X="114" c="2" Y="200" T="12" /><S P="0,0,0.3,0.2,0,0,0,0" H="44" L="26" o="ff0000" X="114" c="2" Y="268" T="12" /><S P="0,0,,,,0,0,0" L="40" X="400" H="180" Y="200" T="9" /><S P="0,0,,,,0,0,0" L="40" X="600" H="180" Y="200" T="9" /></S><D><T Y="57" X="756" /><F Y="52" X="754" /><DS Y="367" X="35" /><DC Y="368" X="37" /></D><O /></Z></C>]]
map306=[[<C><P meta="Ertyezz#9819,306" /><Z><S><S X="400" P="0,0,0.3,0.2,0,0,0,0" L="820" o="ffffff" H="20" Y="400" T="12" /><S H="50" P="0,0,0,20,0,0,0,0" L="15" X="7" Y="46" T="2" /><S X="350" P="0,0,0.3,0.2,0,0,0,0" L="720" o="ffffff" H="20" Y="300" T="12" /><S X="800" P="0,0,0.8,0.2,0,0,0,0" L="20" o="ffffff" H="400" Y="200" T="12" /><S X="432" P="0,0,0.3,0.2,0,0,0,0" L="740" o="ffffff" H="20" Y="100" T="12" /><S X="0" P="0,0,0.8,0.2,0,0,0,0" L="20" o="ffffff" H="400" Y="200" T="12" /><S X="100" P="0,0,0.3,0.2,0,0,0,0" L="75" o="ffffff" H="20" Y="165" T="12" /><S X="100" P="0,0,0.3,0.2,0,0,0,0" L="75" o="ffffff" H="20" Y="235" T="12" /><S X="300" P="0,0,0.3,0.2,0,0,0,0" L="75" o="ffffff" H="20" Y="165" T="12" /><S X="300" P="0,0,0.3,0.2,0,0,0,0" L="75" o="ffffff" H="20" Y="235" T="12" /><S X="500" P="0,0,0.3,0.2,0,0,0,0" L="75" o="ffffff" H="20" Y="235" T="12" /><S X="500" P="0,0,0.3,0.2,0,0,0,0" L="75" o="ffffff" H="20" Y="165" T="12" /><S X="200" P="0,0,,,,0,0,0" L="40" H="180" Y="200" T="9" /><S X="400" P="0,0,0.3,0.2,0,0,0,0" L="820" o="ffffff" H="20" Y="0" T="12" /><S X="190" P="0,0,0.3,0.2,0,0,0,0" L="20" o="6a7495" H="39" c="1" Y="330" T="12" /><S X="191" P="0,0,0.3,0.2,0,0,0,0" L="20" o="ff0000" H="39" c="2" Y="370" T="12" /><S X="444" P="0,0,0.3,0.2,0,0,0,0" L="23" o="ff0000" H="39" c="1" Y="370" T="12" /><S X="320" P="0,0,0.3,0.2,0,0,0,0" L="23" o="22ff" H="39" Y="331" T="12" /><S X="444" P="0,0,0.3,0.2,0,0,0,0" L="23" o="6a7495" H="39" c="2" Y="330" T="12" /><S X="575" P="0,0,0.3,0.2,0,0,0,0" L="23" o="ff0000" H="39" c="2" Y="370" T="12" /><S X="575" P="0,0,0.3,0.2,0,0,0,0" L="23" o="22ff" H="39" Y="330" T="12" /><S X="300" P="0,0,0.3,0.2,0,0,0,0" L="26" o="22ff" H="44" c="2" Y="267" T="12" /><S X="501" P="0,0,0.3,0.2,0,0,0,0" L="26" o="ff0000" H="44" c="2" Y="133" T="12" /><S X="500" P="0,0,0.3,0.2,0,0,0,0" L="26" o="22ff" H="50" c="1" Y="200" T="12" /><S X="501" P="0,0,0.3,0.2,0,0,0,0" L="26" o="ff0000" H="44" c="1" Y="267" T="12" /><S X="300" P="0,0,0.3,0.2,0,0,0,0" L="26" o="22ff" H="44" c="1" Y="133" T="12" /><S X="300" P="0,0,0.3,0.2,0,0,0,0" L="26" o="ff0000" H="50" c="1" Y="200" T="12" /><S X="114" P="0,0,0.3,0.2,0,0,0,0" L="26" o="ff0000" H="44" Y="133" T="12" /><S X="114" P="0,0,0.3,0.2,0,0,0,0" L="26" o="22ff" H="50" c="2" Y="200" T="12" /><S X="114" P="0,0,0.3,0.2,0,0,0,0" L="26" o="ff0000" H="44" c="2" Y="268" T="12" /><S X="400" P="0,0,,,,0,0,0" L="40" H="180" Y="200" T="9" /><S X="600" P="0,0,,,,0,0,0" L="40" H="180" Y="200" T="9" /></S><D><T Y="57" X="756" /><F Y="52" X="754" /><DS Y="367" X="35" /><DC Y="368" X="37" /></D><O /></Z></C>]] map307=[[<C><P meta="Syrius#8114,307" G="-10,10" /><Z><S><S P="0,0,0,0.2,0,0,0,0" T="1" Y="182" H="10" X="72" L="150" /><S P="0,0,0,0.2,0,0,0,0" T="1" Y="279" H="10" X="100" L="200" /><S P="0,0,0,0.2,45,0,0,0" T="1" Y="360" H="60" X="260" L="60" /><S P="0,0,0,1.2,0,0,0,0" T="2" Y="200" H="400" X="10" L="15" /><S P="0,0,0,0.2,0,0,0,0" T="1" Y="390" H="20" X="400" L="800" /><S P="0,0,0,0.2,45,0,0,0" T="1" Y="275" H="60" X="200" L="60" /><S P="0,0,0,0.2,45,0,0,0" T="1" Y="182" H="60" X="145" L="60" /><S H="667" P="0,0,0.3,0.2,0,0,0,0" T="12" Y="295" c="4" X="-20" o="6a7495" L="44" /></S><D><F Y="376" X="47" /><DS Y="362" X="283" /><T Y="176" X="49" /></D><O /></Z></C>]] map308=[[<C><P aie="" meta="Sanija#1187; Syrius#8114,308" /><Z><S><S P="0,0,0,20,0,0,0,0" T="3" Y="375" H="41" X="572" L="453" /><S P="0,0,0.3,0.2,0,0,0,0" T="0" Y="400" H="60" X="400" L="800" /><S P="0,0,0.5,0.2,0,0,0,0" T="0" Y="350" H="40" X="360" L="30" /><S P="0,0,0.5,0.2,0,0,0,0" T="0" Y="330" H="80" X="430" L="30" /><S P="0,0,0.5,0.2,0,0,0,0" T="0" Y="310" H="120" X="500" L="30" /><S P="0,0,0.5,0.2,0,0,0,0" T="0" Y="290" H="160" X="570" L="30" /><S P="0,0,0.5,0.2,0,0,0,0" T="0" Y="269" H="200" X="640" L="30" /><S P="0,0,0.5,0.2,0,0,0,0" T="0" Y="250" H="240" X="710" L="30" /><S P="0,0,0.5,0.2,0,0,0,0" T="0" Y="230" H="280" X="780" L="30" /><S P="0,0,0.3,0.2,0,0,0,0" T="0" Y="181" H="10" X="65" L="128" /><S P="0,0,0.3,0.2,0,0,0,0" T="0" Y="181" H="10" X="260" L="128" /><S P="0,0,0.3,0.2,0,0,0,0" T="0" Y="181" H="10" X="430" L="40" /><S P="0,0,0.3,0.2,0,0,0,0" T="0" Y="100" H="10" X="570" L="40" /><S P="0,0,0.3,0.2,0,0,0,0" T="0" Y="50" H="10" X="710" L="40" /></S><D><T Y="176" X="92" /><T Y="176" X="92" /><F Y="40" X="710" /><DS Y="352" X="109" /></D><O /></Z></C>]] map309=[[<C><P meta="Sanija#1187; Syrius#8114,309" mgoc="-1" /><Z><S><S P="0,0,0.3,0.2,0,0,0,0" T="0" Y="350" H="10" X="54" L="109" /><S P="0,0,0.3,0.2,0,0,0,0" T="0" Y="150" H="10" X="750" L="100" /></S><D><T Y="344" X="55" /><F Y="140" X="750" /></D><O><O Y="320" C="6" X="150" P="0" /><O Y="300" C="6" X="250" P="0" /><O Y="280" C="6" X="350" P="0" /><O Y="260" C="6" X="450" P="0" /><O Y="240" C="6" X="550" P="0" /><O Y="220" C="6" X="650" P="0" /></O></Z></C>]] map310=[[<C><P meta="Sanija#1187,310" /><Z><S><S P="0,0,0.3,0.2,0,0,0,0" T="0" Y="381" H="81" X="414" L="826" /><S P="0,0,20,0.2,20,0,0,0" T="4" Y="262" H="10" X="60" L="69" /><S P="0,0,20,0.2,-20,0,0,0" T="4" Y="279" H="10" X="59" L="69" /><S P="0,0,0.1,0.2,20,0,0,0" T="7" Y="252" H="10" X="60" L="60" /><S P="0,0,0,1.2,0,0,0,0" T="2" Y="257" H="74" X="274" L="246" /><S P="0,0,0.1,0.2,-20,0,0,0" T="7" Y="287" H="10" X="60" L="60" /><S P="0,0,20,0.2,0,0,0,0" T="4" Y="270" H="24" X="112" L="48" /><S P="0,0,0,1.2,0,0,0,0" T="2" Y="254" H="50" X="140" L="16" /><S P="0,0,0,1.2,30,0,0,0" T="2" Y="283" H="35" X="172" L="67" /><S P="0,0,0,1.2,0,0,0,0" T="2" Y="301" H="29" X="292" L="202" /><S P="0,0,0,1.2,0,0,0,0" T="2" Y="209" H="29" X="294" L="202" /><S P="0,0,0,1.2,-30,0,0,0" T="2" Y="226" H="35" X="172" L="67" /><S P="0,0,0,0.2,0,0,0,0" T="1" Y="259" H="10" X="461" L="10" /><S P="0,0,0,0.2,0,0,0,0" T="1" Y="258" H="99" X="401" L="20" /><S P="0,0,0,0.2,0,0,0,0" T="1" Y="257" H="69" X="420" L="18" /><S P="0,0,0,0.2,0,0,0,0" T="1" Y="259" H="44" X="435" L="13" /><S P="0,0,0,0.2,0,0,0,0" T="1" Y="260" H="19" X="448" L="10" /><S P="0,0,0.3,0.2,-30,0,0,0" T="0" Y="172" H="59" X="293" L="10" /><S P="0,0,0,0.2,-40,0,0,0" T="1" Y="288" N="" H="10" X="426" L="89" /><S P="0,0,0.3,0.2,30,0,0,0" T="0" Y="172" H="59" X="267" L="10" /><S P="0,0,20,0.2,0,0,0,0" T="4" Y="161" H="69" X="390" L="10" /><S P="0,0,0,0.2,40,0,0,0" T="1" Y="229" N="" H="10" X="426" L="89" /><S P="0,0,0,10.9,0,0,0,0" T="2" Y="221" H="10" X="422" L="10" /><S P="0,0,0,10.9,0,0,0,0" T="2" Y="245" H="10" X="454" L="10" /><S P="0,0,0.3,0.2,0,0,0,0" X="433" T="13" Y="248" N="" H="10" o="-1" L="10" /></S><D><F Y="140" X="275" /><F Y="140" X="275" /><T Y="341" X="674" /></D><O><O Y="330" C="7" X="589" P="0" /></O></Z></C>]]
map311=[[<C><P mgoc="-1" meta="Syrius#8114,311"  /><Z><S><S P="0,0,0.3,0.2,0,0,0,0" L="40" H="70" X="40" Y="365" T="0" /><S P="0,0,0.3,0.2,0,0,0,0" L="40" H="100" X="100" Y="350" T="0" /><S P="0,0,0.3,0.2,0,0,0,0" L="40" H="130" X="160" Y="335" T="0" /><S P="0,0,0.3,0.2,0,0,0,0" L="40" H="130" X="640" Y="335" T="0" /><S P="0,0,0.3,0.2,0,0,0,0" L="40" H="100" X="700" Y="350" T="0" /><S P="0,0,0.3,0.2,0,0,0,0" L="40" H="70" X="760" Y="365" T="0" /></S><D><T Y="330" X="760" /><F Y="325" X="40" /></D><O><O X="250" C="7" Y="270" P="0" /><O X="550" C="7" Y="270" P="0" /></O></Z></C>]] map313=[[<C><P meta="Syrius#8114,313"  DS="m;250,380,550,380" /><Z><S><S P="0,0,20,0.2,0,0,0,0" L="30" H="130" X="400" v="15001" Y="175" T="4" /><S P="0,0,0,1.2,0,0,0,0" L="20" H="400" X="400" v="14999" Y="200" T="2" /><S P="0,0,0.3,0.2,0,0,0,0" L="800" H="18" X="400" Y="392" T="0" /><S P="0,0,,,,0,0,0" L="800" H="10" X="400" v="15000" Y="150" T="9" /></S><D><F Y="140" X="777" /><F Y="140" X="22" /><T Y="100" X="350" /><T Y="100" X="450" /><T Y="200" X="400" /></D><O><O X="342" C="7" Y="373" P="0" /><O X="461" C="7" Y="373" P="0" /></O></Z></C>]] map314=[[<C><P meta="Syrius#8114,314" mgoc="250" /><Z><S /><D><P X="115" P="0,0" Y="399" T="17" /><P X="218" P="0,0" Y="364" T="17" /><P X="322" P="0,0" Y="328" T="17" /><P X="425" P="0,0" Y="292" T="17" /><P X="529" P="0,0" Y="256" T="17" /><P X="633" P="0,0" Y="220" T="17" /><P X="737" P="0,0" Y="184" T="17" /><P X="634" P="0,0" Y="148" T="17" /><P X="531" P="0,0" Y="111" T="17" /><P X="428" P="0,0" Y="75" T="17" /><P X="325" P="0,0" Y="46" T="17" /><F Y="68" X="482" /><F Y="105" X="585" /><T Y="328" X="322" /><T Y="219" X="637" /><DS Y="349" X="118" /></D><O><O X="583" C="10" Y="205" P="0" /><O X="585" C="10" Y="97" P="0" /></O></Z></C>]]
map315=[[<C><P meta="Sanija#1187,315"/><Z><S><S H="360" P="0,0,0.3,0.2,0,0,0,0" L="800" X="400" Y="560" T="0" /><S H="10" P="0,0,0.3,0.2,0,0,0,0" L="70" X="480" Y="365" T="0" /><S H="10" P="0,0,0.3,0.2,0,0,0,0" L="130" X="730" Y="130" T="0" /><S H="12" P="0,0,0.3,0.2,0,0,0,0" L="798" X="399" Y="6" T="0" /><S H="30" P="0,0,0.3,0.2,0,0,0,0" L="800" X="400" Y="20" T="0" /><S P="0,0,0.3,0.2,90,0,0,0" L="130" H="10" X="795" Y="70" T="0" /><S P="0,0,0.3,0.2,0,0,0,0" L="70" H="10" X="580" Y="330" T="0" /><S P="0,0,0.3,0.2,0,0,0,0" L="70" H="10" X="680" Y="290" T="0" /><S P="0,0,0.3,0.2,0,0,0,0" L="70" H="10" X="580" Y="250" T="0" /><S P="0,0,0.3,0.2,0,0,0,0" L="70" H="10" X="680" Y="210" T="0" /><S P="0,0,0.3,0.2,0,0,0,0" L="70" H="10" X="580" Y="170" T="0" /><S P="0,0,0.3,0.2,0,0,0,0" L="70" H="10" X="160" Y="365" T="0" /><S P="0,0,0.3,0.2,0,0,0,0" L="70" H="10" X="60" Y="330" T="0" /><S P="0,0,0.3,0.2,0,0,0,0" L="70" H="10" X="160" Y="290" T="0" /><S P="0,0,0.3,0.2,0,0,0,0" L="70" H="10" X="60" Y="250" T="0" /><S P="0,0,0.3,0.2,0,0,0,0" L="70" H="10" X="160" Y="210" T="0" /></S><D><T Y="205" X="160" /><F Y="117" X="730" /><DS Y="369" X="306" /></D><O /></Z></C>]] map317=[[<C><P H="720" meta="Ertyezz#9819,317"/><Z><S><S X="56" L="111" Y="711" H="20" P="0,0,0.3,0.2,0,0,0,0" T="0" /><S X="15" L="10" Y="671" H="71" P="0,0,0,5,-20,0,0,0" T="2" /><S X="744" L="111" Y="654" H="20" P="0,0,0.3,0.2,0,0,0,0" T="0" /><S X="785" L="10" Y="612" H="71" P="0,0,0,5,20,0,0,0" T="2" /><S X="0" o="6a7495" L="10" Y="358" H="729" P="0,0,0,0.2,0,0,0,0" T="12" /><S X="806" o="6a7495" L="10" Y="354" H="729" P="0,0,0,0.2,0,0,0,0" T="12" /><S X="363" o="6a7495" L="10" Y="-5" H="729" P="0,0,0.3,0.2,90,0,0,0" T="12" /><S X="448" o="6a7495" L="10" Y="-3" H="729" P="0,0,0.3,0.2,90,0,0,0" T="12" /><S X="744" L="111" Y="444" H="20" P="0,0,0.3,0.2,0,0,0,0" T="0" /><S X="58" L="111" Y="537" H="20" P="0,0,0.3,0.2,0,0,0,0" T="0" /><S X="56" L="111" Y="357" H="20" P="0,0,0.3,0.2,0,0,0,0" T="0" /><S X="745" L="111" Y="286" H="20" P="0,0,0.3,0.2,0,0,0,0" T="0" /><S X="59" L="111" Y="205" H="20" P="0,0,0.3,0.2,0,0,0,0" T="0" /><S X="637" L="111" Y="108" H="20" P="0,0,0.3,0.2,0,0,0,0" T="0" /><S X="747" L="111" Y="108" H="20" P="0,0,0.3,0.2,0,0,0,0" T="0" /><S X="17" L="10" Y="161" H="71" P="0,0,0,5,-20,0,0,0" T="2" /><S X="16" L="10" Y="313" H="71" P="0,0,0,5,-20,0,0,0" T="2" /><S X="17" L="10" Y="492" H="71" P="0,0,0,5,-20,0,0,0" T="2" /><S X="785" L="10" Y="242" H="71" P="0,0,0,5,20,0,0,0" T="2" /><S X="786" L="10" Y="399" H="71" P="0,0,0,5,20,0,0,0" T="2" /></S><D><DS X="97" Y="689" /><DC X="98" Y="687" /><T X="778" Y="97" /><F X="775" Y="92" /></D><O /></Z></C>]] map318=[[<C><P meta="Sanija#1187,318"/><Z><S><S X="401" L="800" Y="407" H="44" P="0,0,20,0.2,0,0,0,0" T="4" /><S X="388" L="632" Y="90" H="10" P="0,0,20,0.2,0,0,0,0" T="4" /><S X="797" L="10" Y="205" H="362" P="0,0,0,0.2,0,0,0,0" T="1" /><S X="442" L="722" Y="386" H="10" P="0,0,0,0.2,0,0,0,0" T="1" /><S X="401" L="803" Y="27" H="10" P="0,0,20,0.2,0,0,0,0" T="4" /><S X="772" L="75" Y="361" H="10" P="0,0,0,0.2,-50,0,0,0" T="1" /><S X="109" L="10" Y="341" H="80" P="0,0,0,8.6,0,0,0,0" T="2" /><S X="5" L="10" Y="204" H="360" P="0,0,0.3,0.2,0,0,0,0" T="0" /><S X="99" L="10" Y="236" H="289" P="0,0,0,0.2,0,0,0,0" T="1" /><S X="703" L="10" Y="201" H="228" P="0,0,0,0.2,0,0,0,0" T="1" /><S X="765" L="67" Y="44" H="10" P="0,0,0,0.2,20,0,0,0" T="1" /><S X="26" L="35" Y="368" H="37" P="0,0,20,0.2,0,0,0,0" T="4" /><S X="26" L="31" Y="292" H="36" P="0,0,20,0.2,0,0,0,0" T="4" /><S X="26" L="30" Y="217" H="35" P="0,0,20,0.2,0,0,0,0" T="4" /><S X="25" L="28" Y="147" H="40" P="0,0,20,0.2,0,0,0,0" T="4" /></S><D><T X="649" Y="74" /><F X="150" Y="356" /><DS X="58" Y="369" /></D><O /></Z></C>]]

--													           $312			 	    $316	           	  $319	$320  $321    $322     $323    $324  $325      $326    $327  $328    $329      $330   $331     $332
threerot = {map301,map302,map303,map304,map305,map306,map307,map308,map309,map310,map311,7574375,map313,map314,map315,6334320,map317,map318,7574389,7574667,7574973,7574975,7574982,7574984,7574997,7574999,7576032,7575113,7576033,7576035,7576224,7576229}

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
	ui.updateTextArea(0,"<ROSE><p align='center'><font size='20'>"..pkg.round..". raunds</font></p>", nil)
	
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
		ui.updateTextArea(101,"<R><font size='40'><p align='center'>Tu esi diskvalificēts.</p></font>\n<N2><font size='24'><p align='center'>Drīksti pamest ciltsmāju.</p></font>",playerName)
	end
	if callback=="toggleborder" then 
		buildborder()
	end
	if callback=="togglesailwater" then 
		buildshipready()
	end
	if callback=="init_hostcore" and hosts[playerName] then 
		hostcore(playerName)
		print(syscore.." HostCore ieslēgts. (<V>"..playerName.."</V>)")
		ui.updateTextArea(65,syscore.." HostCore ieslēgts. (<V>"..playerName.."</V>)",nil)
	end
 	if callback=="r_all" then 
		table.foreach(tfm.get.room.playerList, tfm.exec.respawnPlayer)
	end
 	if callback=="clear" then 
		clear()
	end
	if callback=="getInfo" then
		ui.addTextArea(600, "<li>version: <T>"..version.."</T></li><li>OWNER_ID: <T>"..OWNER_ID.."</T></li><li>title: <T>"..title.."</T></li><br><b><font size='16'>SETUP</font></b><li>flymode: <R>false</R></li><li>challengemode: <T>"..SETUP.challengemode.."</T></li><li>autorespawn: <T>"..SETUP.autorespawn.."</T></li><li>everyoneVerified: <T>"..SETUP.everyoneVerified.."</T></li><br><hr><p align='right'><a href='event:hlp'><J>[palīdzība] </J></a><a href='event:about'><V>[par] </V></a><a href='event:infclose'><ROSE>[aizvērt]</ROSE></a></p>", playerName, 215, 134, 369, 131, 0x324650, 0x000000, 0.9, true)
 end
 	if callback=="infclose" then 
		ui.removeTextArea(600,playerName)
	end
 	if callback=="about" then 
		ui.addTextArea(600, "Veidoja <VP>Syrius#8114</VP>.<br><br>Paldies <VP>Sanija#1187</VP>, <VP>Ertyezz#9819</VP>, <VP>Acmexitee#0000</VP> un citiem cilts <VP>La Cros Nostra</VP> dalībniekiem par palīdzību moduļa veidošanas gaitā.<br><br><br><br><br><p align='right'><a href='event:infclose'><ROSE>[aizvērt]</ROSE></a></p>", playerName, 215, 134, 369, 131, 0x324650, 0x000000, 0.9, true)
	end
 	if callback=="user.nogui" then 
		ui.removeTextArea(0,playerName)	ui.removeTextArea(32,playerName)
	end
 	if callback=="user.cls" then 
		ui.removeTextArea(8999,playerName)
	end
 	if callback=="hlp" then 
		ui.addTextArea(600, "<J><li><a href='event:hlp1'>A - F</a></li><li><a href='event:hlp2'>G - N</a></li><li><a href='event:hlp3'>O - SM</a></li><li><a href='event:hlp4'>SN - Z</a></li></J>\n\n\n\n\n\n<p align='right'><a href='event:infclose'><ROSE>[aizvērt]</ROSE></a></p>", playerName, 215, 134, 369, 131, 0x324650, 0x000000, 0.9, true)
	end
 	if callback=="hlp1" then 
		ui.addTextArea(600, "<font size='10'>Apzīmējumi: <BL>host</BL>, <PT>helper</PT>, <BV>contestant</BV>, <V>obligāts</V>, <R>ne-obligāts</R></font>\n<N2>____________________________________________________</N2>\n\n<b><PT>!bc</PT><BL>*</BL></b> <R>[teksts]</R>\n<font size='10'>Parāda tekstu augšējā interfeisā. Lietojot <BL>!bc*</BL>, ir pieejami HTML tagi.</font>\n\n<b><BL>!c</BL></b> <V>[režīms]</V> <R>[parametrs]</R>\n<font size='10'>Uzsāk semi-automatizēto konkursu. Parametrs ir papildus informācija modulim, t.i. '!c pkg 7'.</font>\n\n<b><PT>!ce*</PT></b> <V>[lietotājvārds]</V> \n<font size='10'>Iedod sieru spēlētājam. Lietojot <PT>!ce*</PT>, siers tiek atņemts.</font>\n\n<b><BL>!col</BL></b> <V>[lietotājvārds] [krāsa]</V>\n<font size='10'>Iekrāso spēlētāja vārdu. Krāsa ir #xxxx formāta heksadecimālie toņi. Neviena krāsa, kurā nepieciešams zilais, nav pieejama!</font>\n\n<b><PT>!clear</PT></b> \n<font size='10'>Nodzēš visus objektus.</font>\n\n<b><BL>!d</BL></b> <V>[lietotājvārds]</V>\n<font size='10'>Diskvalificē spēlētāju.</font>\n\n\n\n\n\n<p align='right'><a href='event:infclose'><ROSE>[aizvērt]</ROSE></a></p>", playerName, 215, 134, 369, 131, 0x324650, 0x000000, 0.9, true)
	end
 	if callback=="hlp2" then 
		ui.addTextArea(600, "<font size='10'>Apzīmējumi: <BL>host</BL>, <PT>helper</PT>, <BV>contestant</BV>, <V>obligāts</V>, <R>ne-obligāts</R></font>\n<N2>____________________________________________________</N2>\n\n<b><BL>!g*</BL></b> <font size='8'><V>[id] [tips] [x] [y] [platums] [augstums]</V> <R>[atsperība] [berze] [leņķis] [din.] [masa]</R></font>\n<font size='10'>Izveido zemi. Lietojot <BL>!g*</BL>, zemei var iziet cauri.</font>\n\n<b><BL>!kill</BL></b> <V>[lietotājvārds]</V>\n<font size='10'>Nogalina spēlētāju.</font>\n\n<b><BL>!link*</BL></b> <V>[lietotājvārds] [lietotājvārds2]</V>\n<font size='10'>Savieno spēlētājus. Lietojot <BL>!link*</BL>, spēlētāji tiek atvienoti viens no otra.</font>\n\n<b><BL>!md*</BL></b> <V>[id] [x1] [y1] [x2] [y2]</V> <R>[platums]</R>\n<font size='10'>Novelk līniju. Lietojot <BL>!md*</BL>, kļūst pieejami parametri <R>[krāsa] [caursp.]</R>, kurus raksta aiz esošajiem. Krāsa ir #xxxx formāta heksadecimālie toņi. Neviena krāsa, kurā nepieciešams zilais, nav pieejama!</font>\n\n<b><BL>!meep</BL></b> <V>[lietotājvārds]</V>\n<font size='10'>Piešķir spēlētajam meep.</font>\n\n<b><BL>!next</BL></b> \n<font size='10'>Pārslēdz mapi. Nav pieejams 'build' režīmā.</font>\n\n<b><BL>!np</BL></b> <V>[kods]</V>\n<font size='10'>Pārslēdz mapi uz konkrētu vai nejaušu rotācijas mapi.</font>\n\n\n\n\n\n<p align='right'><a href='event:infclose'><ROSE>[aizvērt]</ROSE></a></p>", playerName, 215, 134, 369, 131, 0x324650, 0x000000, 0.9, true)
	end
 	if callback=="hlp3" then 
		ui.addTextArea(600, "<font size='10'>Apzīmējumi: <BL>host</BL>, <PT>helper</PT>, <BV>contestant</BV>, <V>obligāts</V>, <R>ne-obligāts</R></font>\n<N2>____________________________________________________</N2>\n\n<b><BL>!p</BL></b> <V>[id] [tips] [teksts]</V>\n<font size='10'>Izveido aizveramu tekstlodziņu. Tekstā atstarpes jāaizstāj ar |.</font>\n\n<b><BL>!play</BL></b> <V>[lietotājvārds] [id] [parametrs]</V>\n<font size='10'>Liek spēlētājam izdarīt emociju. Parametrs ir papildus informācija modulim, t.i. '!play Syrius#8114 10 lv'.</font>\n\n<b><PT>!r</PT><BL>*</BL></b> <V>[lietotājvārds]</V>\n<font size='10'>Atdzīvina spēlētāju. Lietojot <BL>!r*</BL>, kļūst pieejami parametri <R>[x] [y]</R>, kurus raksta aiz esošajiem.</font>\n\n<b><BL>!role</BL></b> <V>[darbība] [statuss] [lietotājvārds]</V>\n<font size='10'>Nomaina spēlētāja statusu. Darbība ir + vai -. Statuss ir 'host' vai 'helper'.</font>\n\n<b><PT>!s*</PT></b> <V>[lietotājvārds]</V>\n<font size='10'>Padara spēlētāju par šamani. Lietojot <PT>!s*</PT>, šamanis kļūst par peli.</font>\n\n<b><BL>!score</BL></b> <V>[lietotājvārds] [vērtība]</V>\n<font size='10'>Maina spēlētāja punktus t.s. 'scoreboard' interfeisā.</font>\n\n<b><PT>!size</PT></b> <V>[lietotājvārds] [vērtība]</V>\n<font size='10'>Maina spēlētāja lielumu. Vērtība ir skaitlis no 0,1 līdz 5.</font>\n\n<b><PT>!smode</PT></b> <V>[lietotājvārds] [režīms]</V>\n<font size='10'>Maina šamaņa režīmu. 0 = normāls; 1 = grūts; 2 = dievišķais.</font>\n\n\n\n\n\n\n\n<p align='right'><a href='event:infclose'><ROSE>[aizvērt]</ROSE></a></p>", playerName, 215, 134, 369, 131, 0x324650, 0x000000, 0.9, true)
	end
 	if callback=="hlp4" then 
		ui.addTextArea(600, "<font size='10'>Apzīmējumi: <BL>host</BL>, <PT>helper</PT>, <BV>contestant</BV>, <V>obligāts</V>, <R>ne-obligāts</R></font>\n<N2>____________________________________________________</N2>\n\n<b><BL>!sname</BL></b> <V>[teksts]</V>\n<font size='10'>Nomaina šamaņa vārdu augšējā interfeisā uz tekstu.</font>\n\n<b><BV>!spawn</BV></b> <V>[tips] [x] [y]</V> <R>[x-paātr.] [y-paātr.] [caursp.]</R>\n<font size='10'>Izveido objektu.</font>\n\n<b><BL>!test</BL></b> \n<font size='10'>Nav funkcijas.</font>\n\n<b><BL>!tfm*</BL></b> <V>[lietotājvārds]</V>\n<font size='10'>Ļauj spēlētājam transformēties. Lietojot <BL>!tfm*</BL>, transformācijas spēja tiek atņemta.</font>\n\n<b><BL>!toggle</BL></b> <V>[parametrs]</V>\n<font size='10'>'build' režīma palīgkomanda, ar kuru pārveidot mapes. </font>\n\n<b><BL>!txt</BL></b> <V>[id] [x] [y] [platums] [augstums] [teksts] [formāts]</V>\n<font size='10'>Izveido tekstlodziņu. formāts = HTML tags bez V-veida iekavām. </font>\n\n<b><BL>!txt*</BL></b> <V>[id] [teksts] [formāts]</V>\n<font size='10'>Rediģē tekstlodziņu. Lai rediģētu ar !txt veidotus tekstlodziņus, pieliec id skaitlim priekšā -. Tekstā atstarpes aizstāj ar |.</font>\n\n<b><BL>!uc*</BL></b> <V>[teksts]</V>\n<font size='10'>Parāda tekstu apakšējā interfeisā (parasti neredzams). Lietojot <BL>!uc*</BL></font>, tekstā nevar lietot HTML un spēlētāja lietotājvārds ir slēpts.\n\n\n\n\n\n\n\n\n<p align='right'><a href='event:infclose'><ROSE>[aizvērt]</ROSE></a></p>", playerName, 215, 134, 369, 131, 0x324650, 0x000000, 0.9, true)
	end
end
