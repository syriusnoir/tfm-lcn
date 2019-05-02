-- "Vēsture" [[v1 - oriģināls|v2 - survival sakne|v3 - !spawn koordinātu pieejamība|v4 - !bc, !bc*, !utilcore, !utilcore*|v5 - survival pabeigts|v6 - beznaglu sakne|v7 - !r, !r*|v8 - ne-dalībnieku blokāde|v9 - kļūdu reorganizācija|v10 - !md|v11 - !md*|v12 - !cname, !host, !kill|v13 - !txt, !g|v14 - utilcore palaidējs|v15 - !txt*|v16 - !rhost|v17 - !g*|v18 - !col|v19 - !s*|v20 - !cmode, !size|v21 - !ce,!ce*|v22 - !np|v23 - !meep|v24 - !rmtxt|v25 - !score, all: !s, !kill, !r, !meep, !ce|v26 - jauns interfeiss; !tfm, !tfm*, !link, !link*|v27 - all: !tfm; !hlp kodols|v28 - !hlp uzlabojumi; atjaunināts survival]]
 
SETUP = {flymode = false,challengemode = "build",autorespawn = "true"}
 
-- [[LaChallengeNostra: LV]]
 
version = "v.b28.1"
title = "#LaChallengeNostra "..SETUP.challengemode
player={}
hosts={['Syrius#8114'] = true,['Acmexitee#0000'] = true} --  ,['Ertyezz#9819'] = true,['Laimesberns#3746'] = true
contestants={['Xeon#1182'] = true,['Sanija#1187'] = true,['Zurcinaa#0000'] = true,['Ilutaffie#9665'] = true,['Ertyezz#9819'] = true,['Miks#7922'] = true}
 
-- Noklusējuma iestatījumi
tfm.exec.newGame('<C><P mgoc="1" G="0,0.96" /><Z><S><S P="0,0,0.3,0.2,0,0,0,0" H="586" L="859" X="398" c="4" Y="276" T="5" /><S P="0,0,0,1.2,0,0,0,0" L="798" H="10" X="401" Y="402" T="3" /><S P="0,0,0,1.2,0,0,0,0" L="798" H="10" X="402" Y="9" T="3" /></S><D /><O /></Z></C>')
tfm.exec.setUIMapName("<ROSE>"..version.."")
ui.addTextArea(0,"<ROSE><p align='center'><font size='20'>"..title.."</font></p>", nil, 100, 25, 600, 30, 0x324650, 0x000000, 0.5, true)
ui.addTextArea(2048, "<ROSE><font size='20'>Debug</font><N2>\n\nSpēlētāja X: <A:ACTIVE>$<N2>\nSpēlētāja Y: <A:ACTIVE>[..]<N2>\nHost: <A:ACTIVE>$ <N2>\nRežīms: <A:ACTIVE>vanilla<N2>\nVersija: <A:ACTIVE>v.b27<N2>\nKartes XML: <PS><a href='event:getxml'>[iegūt]</a><N2>\n\n<ROSE><font size='12'><b>Debug (set)</b></font><N2>\n\nAutorespawn: <A:ACTIVE>true<N2>\n\n\n", nil, -220, 0, 188, 200, 0x324650, 0x000000, 0.5, true)
tfm.exec.disableAutoShaman(true)
tfm.exec.disableAfkDeath(true)
tfm.exec.disableAutoScore(true)
tfm.exec.disableAutoNewGame(true)
tfm.exec.disableMortCommand(true)
 
-- Automātiska ziņojuma parādīšanās
 
function eventNewPlayer(name)
if hosts[name] or contestants[name] then
ui.addPopup(0, 0, "<p align='center'><font size='16'>"..title.."</font></p>\n<font size='7' color='#ffaf00'>"..version.."</font>\nEsi sveicināts La Cros Nostra ciltsmājā! Šis modulis tiek izmantots atvieglotai konkursu uzturēšanai.\n<b>PIEZĪME:</b> Ja ienāc konkursa vidū, lūdzu uzgaidi lidz nākamajam raundam/konkursam vai izej no ciltsmājas.",name, 191, 121, 410, true)
print("<PS>["..version.."] <S>"..name.." ir ienācis ciltsmājā.")
tfm.exec.setPlayerScore(name,0)
else
ui.addTextArea(100, "debug.100", name, -600, -200, 2400, 1200, 0x000001, 0x000001, 1, true)
ui.addTextArea(101, "<ROSE><font size='40'><p align='center'>Darbojas #LaChallengeNostra.</p></font>\n<A:ACTIVE><font size='24'><p align='center'>Tu neesi cilts eventa dalībnieks/vadītājs.</p></font>", name, 0, 20, 800, 384, 0x324650, 0x000000, 0, true)
tfm.exec.killPlayer(name)
tfm.exec.setPlayerScore(name,-32767)
end
end
 
for name,player in pairs(tfm.get.room.playerList) do
if hosts[name] or contestants[name] then
eventNewPlayer(name)
else
ui.addTextArea(100, "debug.100", name, -600, -200, 2400, 1200, 0x000001, 0x000001, 1, true)
ui.addTextArea(101, "<ROSE><font size='40'><p align='center'>Darbojas #LaChallengeNostra.</p></font>\n<A:ACTIVE><font size='24'><p align='center'>Tu neesi cilts eventa dalībnieks/vadītājs.</p></font>", name, 0, 20, 800, 384, 0x324650, 0x000000, 0, true)
tfm.exec.killPlayer(name)
tfm.exec.setPlayerScore(name,-32767)
end
end
 
-- Komandas
function eventChatCommand(name,cmd,n)
if cmd== cmd then print("<PS>["..version.."] <s>"..name.." ir inicializējis komandu <N2>!"..cmd) end
if cmd:sub(1,1) == "s" and hosts[name] then tfm.exec.setShaman(cmd:sub(3)) end
if cmd:sub(1,2) == "s*" and hosts[name] then tfm.exec.setShaman(cmd:sub(4),false) end
if cmd:sub(1,2) == "ce" and hosts[name] then tfm.exec.giveCheese(cmd:sub(4)) end
if cmd:sub(1,3) == "ce*" and hosts[name] then tfm.exec.removeCheese(cmd:sub(5)) end
if cmd:sub(1,1) == "r" and hosts[name] then tfm.exec.respawnPlayer(cmd:sub(3)) end
if cmd:sub(1,2) == "bc" and hosts[name] then ui.updateTextArea(0,"<p align='center'><font size='20'><A:ACTIVE>"..cmd:sub(4),nil) end
if cmd:sub(1,3) == "bc*" and hosts[name] then ui.updateTextArea(0,"<p align='center'><font size='20'><VP>"..cmd:sub(5),nil) end
if cmd:sub(1,2) == "np" and hosts[name] then tfm.exec.newGame(cmd:sub(4)) end
if cmd:sub(1,3) == "fly" and hosts[name] then SETUP.challengemode=cmd:sub(3) end
if cmd:sub(1,3) == "hlp" then helpcore(name,playerName) end
if cmd:sub(1,4) == "kill" and hosts[name] then tfm.exec.killPlayer(cmd:sub(6)) end
if cmd:sub(1,4) == "test" and hosts[name] then test() end
if cmd:sub(1,4) == "meep" and hosts[name] then tfm.exec.giveMeep(cmd:sub(6)) end
if cmd:sub(1,4) == "host" and hosts[name] then hosts[cmd:sub(6)] = true end
if cmd:sub(1,5) == "rhost" and hosts[name] then hosts[cmd:sub(7)] = false end
if cmd:sub(1,5) == "rmtxt" and hosts[name] then tfm.removeTextArea(cmd:sub(7)) end
if cmd:sub(1,5) == "cname" and hosts[name] then ui.setShamanName(cmd:sub(7)) end
if cmd:sub(1,8) == "utilcore" and hosts[name] then ui.updateTextArea(32,"<V>["..name.."]<A:ACTIVE> "..cmd:sub(10),nil) end
if cmd:sub(1,9) == "utilcore*" and hosts[name] then ui.updateTextArea(32,syscore.." "..cmd:sub(11),nil) end

-- 'all' komandas
if cmd:sub(1,5) == "s all" and hosts[name] then table.foreach(tfm.get.room.playerList, tfm.exec.setShaman) end
if cmd:sub(1,5) == "r all" and hosts[name] then table.foreach(tfm.get.room.playerList, tfm.exec.respawnPlayer) end  
if cmd:sub(1,6) == "ce all" and hosts[name] then table.foreach(tfm.get.room.playerList, tfm.exec.giveCheese) end
if cmd:sub(1,8) == "tfm all" and hosts[name] then table.foreach(tfm.get.room.playerList, tfm.exec.giveTransformations) end 
if cmd:sub(1,8) == "kill all" and hosts[name] then table.foreach(tfm.get.room.playerList, tfm.exec.killPlayer) end 
if cmd:sub(1,8) == "meep all" and hosts[name] then table.foreach(tfm.get.room.playerList, tfm.exec.giveMeep) end   


-- Iestatījumu komandas

if cmd:sub(1,15) == "set autorespawn" and hosts[name] and SETUP.autorespawn=="false" then SETUP.autorespawn="true" print(SETUP.autorespawn) elseif SETUP.autorespawn=="true" and hosts[name] then SETUP.autorespawn="false" end


-- Challenge-specfiskas komandas
if cmd == "nextmap" and hosts[name] and SETUP.challengemode=="vanilla" then nextMap()
elseif cmd=="nextmap" and hosts[name] and SETUP.challengemode=="survival" then survRound()
elseif cmd=="nextmap" then error0x1(name) end
if cmd == "toggle mgoc" and hosts[name] and SETUP.challengemode=="build" then tfm.exec.newGame('<C><P H="850" F="8" L="3000" mgoc="-888" bh=""/><Z><S><S H="50" P="0,0,0.3,0.2,0,0,0,0" L="3200" X="1500" Y="825" T="6" /></S><D /><O /></Z></C>')
elseif cmd=="toggle mgoc" and hosts[name] then error0x2(name)
elseif cmd=="toggle mgoc" then error0x1(name) end
 
-- Challenge komandas
if cmd == "c survival" and SETUP.challengemode == "survival" and hosts[name] then survutils()
elseif cmd=="c survival" then error0x1(name) end
if cmd == "c vanilla" and SETUP.challengemode == "vanilla" and hosts[name] then vanillautils()
elseif cmd=="c vanilla" then error0x1(name) end
if cmd == "c build" and SETUP.challengemode == "build" and hosts[name] then buildutils()
elseif cmd:sub(1,2) =="c " and hosts[name] then error0x2(name,cmd)
elseif cmd=="c build" then error0x1(name) end
if cmd:sub(1,5) =="c pkg" then
pkgdata = cmd:sub(7)
packageutils(cmd,name,n)
end
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
        ui.updateTextArea(c[2],"<"..c[4]..">"..c[3],nil)
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
    if c[1] == "size" and hosts[name] then
        tfm.exec.changePlayerSize(c[2],c[3])
    elseif c[1] == "size" then
        error0x1(name)
        end
    if c[1] == "cmode" and hosts[name] then
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
    if c[1] == "tfm*" and hosts[name] then
        tfm.exec.linkMice(c[2],false)
    elseif c[1] == "tfm*" then
        error0x1(name)
    end
end
-- Slēptās komandas
system.disableChatCommandDisplay(nil)
 
-- [[Utilijas]]
 
-- Markdown komanda
function md()
tfm.exec.addPhysicObject(1,400,-600,{type=0,width=10,height=10,foreground=true,friction=0.3,restitution=0,dynamic=false,miceCollision=true,groundCollision=true})
end
-- Kļūdas
 
function error0x1(name)
ui.updateTextArea(32,syscore.."<A:ACTIVE><b>["..name.."]</b> KĻŪDA 0x1: Nav vadītāja tiesību.",nil)
end
function error0x2(name,cmd)
ui.updateTextArea(32,syscore.."<A:ACTIVE><b>["..name.."]</b> KĻŪDA 0x2: Lūdzu izmaini SETUP.challengemode konfigurāciju uz ''"..cmd:sub(3).."'', lai veiktu šo darbību.",nil)
end
 
-- Koordinātu printeris
local SHIFT_KEY = 16
 
local shifting = {}
 
function eventNewPlayer(n)
 
  shifting[n] = false
 
  system.bindKeyboard(n, SHIFT_KEY, true, true)
  system.bindKeyboard(n, SHIFT_KEY, false, true)
  system.bindMouse(n, true)
end
 
function eventKeyboard(n, key, down, x, y)
 
  shifting[n] = down -- ieslēgts, ja tiek turēts SHIFT
end
 
function eventMouse(n, x, y)
 
  if shifting[n] then
    ui.updateTextArea(32,"<PT> [util-"..version.."] <N2>"..n .." kursora koordinātas ir - X:" .. x .. ", Y:" .. y,nil)
    print("<PT>[util-"..version.."] <N2>"..n .." kursora koordinātas ir - X:" .. x .. ", Y:" .. y)
  end
end
 
table.foreach(tfm.get.room.playerList, eventNewPlayer)
 
-- Prefiksi
syscore = "<ROSE><b>[SISTĒMA]</b>"
 
 
-- UtilCore
ui.addTextArea(32, "<PS><b>["..version.."]</b> <a href='event:c_surv'><s>Sākt survival challenge </a><PS>| <a href='event:c_vanilla'><s>Sākt bez-naglu challenge </a><PS>| <a href='event:c_build'><s>Sākt būvdarbu cīņas </a><PS>| <a href='event:null'><s>Palaist moduli tukšgaitā </a>",nil, 9, 377, 784, 27, 0x324650, 0x000000, 0, true)
 
-- HostCore
function hostcore(name,contestants)
if hosts[name] then
ui.addTextArea(65, "<PS><b>["..version.."]</b> test",hosts, 9, 363, 784, 27, 0x324650, 0x000000, 0, true)
else
ui.removeTextArea(65,contestants)
end
end
 
hostcore()
 
-- [[IZDZĪVOŠANAS CHALLENGE UTILIJAS]]

map1 = [[<C><P L="1600" H="800" /><Z><S><S H="185" P="1,0,0,1.2,0,0,0,0" L="34" X="205" Y="293" T="2" /><S H="185" P="1,0,0,1.2,0,0,0,0" L="34" X="305" Y="293" T="2" /><S H="185" P="1,0,0,1.2,0,0,0,0" L="34" X="405" Y="293" T="2" /><S H="10" P="1,0,0.3,0.2,0,0,0,0" L="32" o="324650" X="713" Y="95" T="13" /><S H="10" P="0,0,0.3,0.2,0,0,0,0" L="47" X="111" Y="123" T="9" /><S H="10" P="1,0,0,0.2,45,0,0,0" L="47" X="84" Y="107" T="1" /><S H="18" P="1,0,0.3,0.2,0,0,0,0" L="125" X="686" Y="256" T="0" /></S><D /><O /><L><JR M1="2" M2="3" /><JD M1="3" M2="6" /><JPL M1="0" P3="800,402" M2="1" P4="399,0" /><JP M1="2" M2="5" /><JPL M1="5" P3="0,250" M2="6" P4="797,249" /></L></Z></C>]]
map2 = [[<C><P L="1600" H="800" /><Z><S><S H="10" P="1,0,0.3,0.2,0,0,0,0" L="50" o="5d6582" X="300" c="4" Y="258" T="13" /><S H="10" P="1,0,0.3,0.2,0,0,0,0" L="50" o="324650" X="500" Y="258" T="13" /><S H="10" P="1,0,20,0.2,0,0,0,0" L="17" X="135" Y="372" T="4" /><S H="210" P="1,0,0.3,0.2,0,0,0,0" L="20" X="730" Y="152" T="0" /><S H="10" P="1,0,0,0.2,25,0,0,0" L="256" X="179" Y="89" T="1" /><S H="20" P="1,0,0,1.2,0,0,0,0" L="200" X="400" Y="400" T="2" /></S><D /><O /><L><JR M1="0" M2="2" /><JR M1="1" M2="3" /><JPL P3="802,229" M1="4" P4="393,3" M2="5" /><JP M1="0" M2="1" /><JD M1="4" M2="3" /><JP M1="5" M2="3" /><JR M1="2" M2="4" /><JP M1="0" M2="3" /><JPL P3="1,598" M1="2" P4="797,-1" M2="5" /><JP M1="0" M2="5" /><JR M1="2" M2="5" /></L></Z></C>]]
map3 = [[<C><P L="1600" H="800" /><Z><S><S H="30" P="1,0,0,1.2,0,0,0,0" L="200" X="165" Y="130" T="2" /><S H="30" P="1,0,0,1.2,0,0,0,0" L="200" X="265" Y="230" T="2" /><S H="30" P="1,0,0,1.2,0,0,0,0" L="200" X="365" Y="330" T="2" /><S H="10" P="1,0,0.3,0.2,0,0,0,0" L="53" o="324650" X="722" Y="241" T="13" /><S H="87" P="0,0,0.3,0.2,0,0,0,0" L="10" X="608" Y="51" T="9" /><S H="30" P="1,0,20,0.2,0,0,0,0" L="30" X="0" Y="0" T="4" /></S><D><P X="400" P="0,0" C="faff" Y="200" T="34" /></D><O /><L><JR M2="3" M1="2" /><JP M2="3" M1="5" /><JD M2="0" M1="4" /><JPL M2="0" P4="799,-3" P3="402,597" M1="2" /><JR M2="4" M1="2" /><JR M2="1" M1="5" /><JD M2="4" M1="1" /></L></Z></C>]]
fap1 = [[<C><P L="1600" H="800" /><Z><S><S H="10" P="0,0,0.3,0.2,0,0,0,0" L="52" X="39" Y="47" T="9" /><S H="10" P="0,0,0.3,0.2,0,0,0,0" L="52" X="91" Y="52" T="9" /><S H="30" P="1,0,0,20,0,0,0,0" L="30" X="666" Y="150" T="3" /><S H="20" P="1,0,0.3,0.2,0,0,0,0" L="120" X="330" Y="300" T="0" /><S H="20" P="1,0,0.3,0.2,0,0,0,0" L="120" X="450" Y="320" T="0" /><S H="216" P="1,0,0,1.2,15,0,0,0" L="17" X="228" Y="144" T="2" /><S H="13" P="1,0,0,0.2,0,0,0,0" L="144" X="666" Y="185" T="1" /></S><D /><O /><L><JD M2="3" M1="0" /><JP M2="6" M1="2" /><JPL M1="5" M2="6" P4="382,2" P3="799,220" /><JR M2="6" M1="4" /><JR M2="1" M1="2" /><JPL M1="3" M2="6" P4="799,-2" P3="798,595" /><JD M2="5" M1="2" /></L></Z></C>]] 
if SETUP.challengemode == "survival" then
 
survrot = {7479177,7482494,7485763,map1,map2,map3}
finalrot = {fap1}
function survutils(name)
ui.updateTextArea(0,"<VP><p align='center'><font size='20'>Izdzīvošanas challenge ir sācies!</font></p>", nil)
survRound()
tfm.exec.setUIMapName("<i>Survival challenge</i>")
tfm.exec.setUIShamanName("<VP>La Cros Nostra")
ui.updateTextArea(32,"<ROSE><b>[SISTĒMA]</b> Darbojas t.s. <i>survival challenge.</i>",nil)
end
 
function survRound()
tfm.exec.newGame(survrot[math.random(#survrot)])
end
function winnerFunction(winner)
ui.updateTextArea(0,"<p align='center'><font size='20'><ROSE>"..winner.." uzvarēja!</font></p>",nil)
ui.updateTextArea(32,syscore.." Raunds beidzies: "..winner.." uzvarēja!",nil)
tfm.exec.giveCheese(winner)
tfm.exec.playerVictory(winner)
tfm.exec.setPlayerScore(winner,60,true)
print("<PT>[util-"..version.."] <N2>"..winner.." uzvarēja!")
end
 
 
function eventPlayerDied(name)
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
	if SETUP.autorespawn == "true" then
    tfm.exec.respawnPlayer(n)
	end
 
print("<PT>[util-"..version.."] <N2>"..name.." ir zaudējis ;(")
ui.updateTextArea(0,"<p align='center'><font size='20'><ROSE>"..name.." ir zaudējis.</font></p>",nil)
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
function buildutils()
ui.addTextArea(0,"<VP><p align='center'><font size='20'></font></p>", nil, 25, 25, 750, 60, 0x324650, 0x000000, 0.1, true)
tfm.exec.newGame('<C><P bh="" H="1000" F="8" L="3000" /><Z><S><S P="0,0,0.3,0.2,0,0,0,0" L="3200" H="50" X="1500" Y="825" T="6" lua="-888" /><S H="150" P="0,0,0.3,0.2,0,0,0,0" L="3200" X="1500" c="4" Y="925" T="5" lua="-999" /></S><D /><O /></Z></C>')
end
-- [[MAPJU PAKOTŅU UTILIJAS]]
function packageutils(c)
tfm.exec.newGame('#'..pkgdata)
end

function test()
tfm.exec.newGame('<C><P /><Z><S><S P="0,0,20,0.2,0,0,0,0" L="1381" H="143" X="442" Y="413" T="4" /></S><D /><O><O X="409" C="39" Y="245" P="0,0" /><O X="411" C="11" Y="228" P="0" /><O X="480" C="5" Y="298" P="0" /><O X="407" C="39" Y="189" P="0" /><O X="405" C="39" Y="139" P="0" /><O X="402" C="39" Y="85" P="0" /><O X="450" C="39" Y="138" P="0" /><O X="365" C="39" Y="138" P="0" /><O X="366" C="39" Y="193" P="0" /><O X="452" C="39" Y="188" P="0" /><O X="318" C="39" Y="193" P="0" /><O X="496" C="39" Y="185" P="0" /><O X="309" C="39" Y="241" P="0" /><O X="362" C="39" Y="242" P="0" /><O X="455" C="39" Y="243" P="0" /><O X="504" C="39" Y="245" P="0" /><O X="544" C="39" Y="247" P="0" /><O X="253" C="39" Y="244" P="0" /></O></Z></C>')
end

-- [[DEBUG]]

debug = {}


-- [[HELP]]

function helpcore(playerName,name)
ui.addTextArea(3500, "", name, 85, 70, 640, 280, 0x324650, 0x000000, 0.5, true)
ui.addTextArea(3501, "<ROSE><p align='center'><font size='20'>#lachallengenostra</font></p>", name, 200, 72, 400, 30, 0x324650, 0x000000, 0, true)
ui.addTextArea(3502, "<a href='event:hlp.close'><S>X</a>", name, 709, 72, 12, 19, 0x324650, 0x000000, 0, true)
ui.addTextArea(3503, "<S>[<a href='event:hlpid_1'><CE>?</a><S>|<a href='event:hlpid_x1'><VP>P<S>]</a>\n<S>[<a href='event:hlpid_2'><CE>?</a><S>|<a href='event:hlpid_x2'><VP>P<S>]</a>\n<S>[<a href='event:hlpid_3'><CE>?</a><S>|<a href='event:hlpid_x3'><VP>P<S>]</a>\n<S>[<a href='event:hlpid_4'><CE>?</a><S>|<a href='event:hlpid_x4'><VP>P<S>]</a>\n<S>[<a href='event:hlpid_5'><CE>?</a><S>|<a href='event:hlpid_x5'><VP>P<S>]</a>\n<S>[<a href='event:hlpid_6'><CE>?</a><S>|<a href='event:hlpid_x6'><VP>P<S>]</a>\n<S>[<a href='event:hlpid_7'><CE>?</a><S>|<a href='event:hlpid_x7'><VP>P<S>]</a>\n<S>[<a href='event:hlpid_8'><CE>?</a><S>|<a href='event:hlpid_x8'><VP>P<S>]</a>\n<S>[<a href='event:hlpid_9'><CE>?</a><S>|<a href='event:hlpid_x9'><VP>P<S>]</a>\n<S>[<a href='event:hlpid_10'><CE>?</a><S>|<a href='event:hlpid_x10'><VP>P<S>]</a>\n<S>[<a href='event:hlpid_11'><CE>?</a><S>|<a href='event:hlpid_x11'><VP>P<S>]</a>\n<S>[<a href='event:hlpid_12'><CE>?</a><S>|<a href='event:hlpid_x12'><VP>P<S>]</a>\n<S>[<a href='event:hlpid_13'><CE>?</a><S>|<a href='event:hlpid_x13'><VP>P<S>]</a>\n<S>[<a href='event:hlpid_14'><CE>?</a><S>|<a href='event:hlpid_x14'><VP>P<S>]</a>", name, 95, 105, 35, 175, 0x324650, 0x000000, 0, true)
ui.addTextArea(3504, "", name, 100, 286, 610, 55, 0x324650, 0x000000, 1, true)
ui.addTextArea(3505, "<S>[<a href='event:hlpid_15'><CE>?</a><S>|<a href='event:hlpid_x15'><VP>P<S>]</a>\n<S>[<a href='event:hlpid_16'><CE>?</a><S>|<a href='event:hlpid_x16'><VP>P<S>]</a>\n<S>[<a href='event:hlpid_17'><CE>?</a><S>|<a href='event:hlpid_x17'><VP>P<S>]</a>\n<S>[<a href='event:hlpid_18'><CE>?</a><S>|<a href='event:hlpid_x18'><VP>P<S>]</a>\n<S>[<a href='event:hlpid_19'><CE>?</a><S>|<a href='event:hlpid_x19'><VP>P<S>]</a>\n<S>[<a href='event:hlpid_20'><CE>?</a><S>|<a href='event:hlpid_x20'><VP>P<S>]</a>\n<S>[<a href='event:hlpid_21'><CE>?</a><S>|<a href='event:hlpid_x21'><VP>P<S>]</a>\n<S>[<a href='event:hlpid_22'><CE>?</a><S>|<a href='event:hlpid_x22'><VP>P<S>]</a>\n<S>[<a href='event:hlpid_23'><CE>?</a><S>|<a href='event:hlpid_x23'><VP>P<S>]</a>\n<S>[<a href='event:hlpid_24'><CE>?</a><S>|<a href='event:hlpid_x24'><VP>P<S>]</a>\n<S>[<a href='event:hlpid_25'><CE>?</a><S>|<a href='event:hlpid_x25'><VP>P<S>]</a>\n<S>[<a href='event:hlpid_26'><CE>?</a><S>|<a href='event:hlpid_x26'><VP>P<S>]</a>\n<S>[<a href='event:hlpid_27'><CE>?</a><S>|<a href='event:hlpid_x27'><VP>P<S>]</a>\n<S>[<a href='event:hlpid_28'><CE>?</a><S>|<a href='event:hlpid_x28'><VP>P<S>]</a>\n", name, 185, 105, 35, 175, 0x324650, 0x000000, 0, true)
ui.addTextArea(3593, "!c\n!g\n!s\n!r\n!bc\n!ce\n!np\n!md\n!col\n!tfm\n!txt\n!link\n!host\n!meep\n", name, 131, 105, 49, 176, 0x324650, 0x0, 0, true)
ui.addTextArea(3595, "!size\n!cmode\n!cname\n!rhost\n!score\n!spawn\n!toggle\n!nextmap\n!utilcore\n\n\n", name, 222, 105, 59, 176, 0x324650, 0x0, 0, true)
end

-- hlp.var = hlp.var_c.mode,hlp.var_g.[type,height,width,res,angle,friection,dyn,weight],hlp.var_x,hlp.var_id,hlp.var_y
function eventTextAreaCallback(textAreaID, playerName, callback)
	if callback=="hlp.close" then 
		ui.removeTextArea(3500,playerName)
		ui.removeTextArea(3501,playerName)
		ui.removeTextArea(3502,playerName)
		ui.removeTextArea(3503,playerName)
		ui.removeTextArea(3504,playerName)
		ui.removeTextArea(3505,playerName)
		ui.removeTextArea(3593,playerName)
		ui.removeTextArea(3595,playerName)	
	end
	if callback=="hlpid_1" then 
		ui.updateTextArea(3504,"<ROSE><font size='13'><b>!c</b></font><BL><a href='event:hlp.var_c.mode'> [režīms]<N>\n<b>Darbība:</b> Iedarbina cilts eventu.\n<b>Piekļuve:</b> <R>Host</R>\n", playerName)
	end
	if callback=="hlpid_2" then 
		ui.updateTextArea(3504, "<ROSE><font size='13'><b>!g</b></font><G>*<BL> <a href='event:hlp.var_id'>[id]</a> <a href='event:hlp.var_g.type'>[tips]</a> <a href='event:hlp.var_x'>[x]</a> <a href='event:hlp.var_y'>[y]</a> <a href='event:hlp.var_g.width'>[platums]</a> <a href='event:hlp.var_g.height'>[augstums]</a> <G><a href='event:hlp.var_g.res'>[atsperība]</a> <a href='event:hlp.var_g.friction'>[berze]</a> <a href='event:hlp.var_g.angle'>[rotācija]</a><a href='event:hlp.var_g.dyn'> [dinamiskums]</a> <a href='event:hlp.var_g.weight'>[masa]</a><N>\n<b>Darbība:</b> Uzliek zemi. <A:ACTIVE> <font size='9'>Ja pieliek *, tad zemei var iziet cauri.</font> <N>\n<b>Piekļuve:</b> <R>Host</R>\n", playerName)
	end
	if callback=="hlpid_3" then 
		ui.updateTextArea(3504, "<ROSE><font size='13'><b>!s</b></font><G>*<BL> <a href='event:hlp.var_name'>[lietotājvārds]</a> <N>\n<b>Darbība:</b> Padara spēlētāju par šamani. <A:ACTIVE> <font size='9'>Ja pieliek *, tad šamanis kļūst par parasto peli.</font> <N>\n<b>Piekļuve:</b> <R>Host</R>\n",playerName)
	end
	if callback=="hlpid_4" then 
		ui.updateTextArea(3504, "<ROSE><font size='13'><b>!r</b></font><G>*<BL> <a href='event:hlp.var_name'>[lietotājvārds]</a><R> <a href='event:hlp.var_x'>[x]</a> <a href='event:hlp.var_y'>[y]</a><N>\n<b>Darbība:</b> Atdzīvina spēlētāju. <A:ACTIVE> <font size='9'>Ja pieliek *, tad kļūst pieejamas konkrētas atdzīvināšanas/teleportācijas koordinātes.</font> <N>\n<b>Piekļuve:</b> <R>Host</R>",playerName)
	end		
	if callback=="hlpid_5" then 
		ui.updateTextArea(3504, "<ROSE><font size='13'><b>!bc</b></font><G>*<BL> <a href='event:hlp.var_txt'>[teksts]</a><N>\n<b>Darbība:</b> Parāda dzeltenu tekstu augšējā moduļa interfeisā. <A:ACTIVE> <font size='9'>Ja pieliek *, tad teksts kļūst zaļš.</font> <N>\n<b>Piekļuve:</b> <R>Host</R>",playerName)
	end		
 	if callback=="hlpid_6" then 
		ui.updateTextArea(3504, "<ROSE><font size='13'><b>!ce</b></font><G>*<BL> <a href='event:hlp.var_name'>[lietotājvārds]</a><N>\n<b>Darbība:</b> Piešķir sieru. <A:ACTIVE> <font size='9'>Ja pieliek *, tad siers tiek atņemts.</font> <N>\n<b>Piekļuve:</b> <R>Host</R>",playerName)
	end
 	if callback=="hlpid_7" then 
		ui.updateTextArea(3504, "<ROSE><font size='13'><b>!np</b></font><BL> <a href='event:hlp.var_npcode'>[kods]</a><N>\n<b>Darbība:</b> Pārslēdz mapi. <A:ACTIVE> <font size='0'>Ja pieliek *, tad siers tiek atņemts.</font> <N>\n<b>Piekļuve:</b> <R>Host</R>",playerName)
	end
end
