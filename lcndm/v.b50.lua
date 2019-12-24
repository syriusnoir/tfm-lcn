-- **************/ LCNDM v.b50 \**************

do
    local _, nickname = pcall(nil)
    tfm.get.room.owner = string.match(nickname, "(.-)%.")
end

tfm.exec.disableAutoNewGame(true)
tfm.exec.disableAutoShaman(true)
tfm.exec.disableAutoScore(true)
system.disableChatCommandDisplay(nil)
function startMap() state=1 tfm.exec.newGame('<C><P DS="m;200,170" APS="16f09800dd9.png,0,100,100,100,100,200,40"/><Z><S><S N="" P="0,0,0.3,0.2,0,0,0,0" X="0" L="3000" o="000022" H="3000" c="4" Y="0" T="12" /><S P="0,0,0.3,0.2,0,0,0,0" L="40" o="000022" H="10" X="200" Y="240" T="12" /><S P="0,0,0.3,0.2,90,0,0,0" L="40" o="000022" H="10" X="215" Y="225" T="12" /><S P="0,0,0.3,0.2,90,0,0,0" L="40" o="000022" H="10" X="2500" Y="225" T="12" /><S P="0,0,0.3,0.2,90,0,0,0" L="40" o="000022" H="10" X="185" Y="225" T="12" /><S P="0,0,0.3,0.2,0,0,0,0" L="40" o="000022" H="10" X="200" Y="210" T="12" /></S><D><DS Y="225" X="200" /></D><O /></Z></C>') tfm.exec.disableAfkDeath(true) tfm.exec.setGameTime(32768) ui.addTextArea(0, "<p align='center'><font size='10'><a:active>Paldies par dalību!</font></p>",nil,135, 25, 540, 15, 0x000022, 0x000022, 0.65, true) end

players={}
toDespawn={}
disq={} sp={}
maps={521833,401421,541917,541928,541936,541943,527935,559634,559644,888052,878047,885641,770600,770656,772172,891472,589736,589800,589708,900012,901062,754380,901337,901411,907870,910078,1190467,1252043,1124380,1016258,1252299,1255902,1256808,986790,1285380,1271249,1255944,1255983,1085344,1273114,1276664,1279258,1286824,1280135,1280342,1284861,1287556,1057753,1196679,1288489,1292983,1298164,1298521,1293189,1296949,1308378,1311136,1314419,1314982,1318248,1312411,1312589,1312845,1312933,1313969,1338762,1339474,1349878,1297154,644588,1351237,1354040,1354375,1362386,1283234,1370578,1306592,1360889,1362753,1408124,1407949,1407849,1343986,1408028,1441370,1443416,1389255,1427349,1450527,1424739,869836,1459902,1392993,1426457,1542824,1533474,1561467,1563534,1566991,1587241,1416119,1596270,1601580,1525751,1582146,1558167,1420943,1466487,1642575,1648013,1646094,1393097,1643446,1545219,1583484,1613092,1627981,1633374,1633277,1633251,1585138,1624034,1616785,1625916,1667582,1666996,1675013,1675316,1531316,1665413,1681719,1699880,1688696,623770,1727243,1531329,1683915,1689533,1738601,3756146,912118,3326933,3722005,3566478,1456622,1357994,1985670,1884075,1708065,1700322,2124484,3699046,2965313,4057963,4019126,3335202,2050466}

function eventNewPlayer(name)
tfm.exec.setPlayerScore(name,0)
for i,key in ipairs({32,40,83}) do
tfm.exec.bindKeyboard(name,key,true,true)
end
players[name]={
timestamp=os.time(),
offsets={x=-16, y=17}
}
end

function eventKeyboard(name,key,down,x,y)
if (key==32 or key==40 or key==83) and not tfm.get.room.playerList[name].isDead and started then
if players[name].timestamp < os.time()-(spawnlimit or 1000) then
local id=tfm.exec.addShamanObject(objecttype or 17, x+(tfm.get.room.playerList[name].isFacingRight and players[name].offsets.x or -players[name].offsets.x), y+players[name].offsets.y, tfm.get.room.playerList[name].isFacingRight and 90 or 270,0)
players[name].timestamp=os.time()
table.insert(toDespawn,{os.time(),id})
end
end
end

function eventChatCommand(name,command)
print("<b><PS>["..name.."]</PS></b><S> !"..command)
    local c = { }
    string.gsub(command, "%S+", function(arg)
        c[#c + 1] = arg
    end)
if name == tfm.get.room.owner and c[1]=="end" then startMap() end
if name == tfm.get.room.owner and c[1]=="d" then d(c[2],1,0x000001,5,195) end
if name == tfm.get.room.owner and c[1]=="type" then objecttype = c[2] end
if name == tfm.get.room.owner and c[1]=="sp" then sp[c[2]] = true tfm.exec.killPlayer(c[2]) tfm.exec.setPlayerScore(c[2],-100,false) ui.addTextArea(0, "<p align='center'><font size='10'><a:active>Tu esi padarīts par skatītāju.</font></p>",c[2],135, 25, 540, 15, 0x000022, 0x000022, 0.65, true) end
if name == tfm.get.room.owner and c[1]=="limit" then spawnlimit = tonumber(c[2]) end
end

round = 0
state = 0
function eventNewGame()
round = round+1
if state == 0 then
ui.addTextArea(0, "<p align='center'><font size='10'><rose>"..round..". raunds</font></p>",nil,135, 25, 540, 15, 0x000022, 0x000022, 0.65, true)
	for t,player in next,tfm.get.room.playerList do
		if t == tfm.get.room.owner then ui.addTextArea(2, "<p align='left'><font size='13' face='Wingdings' color='#000000'>N <font face='Webdings'>s</font></p>",t,686, 24, 150, 18, 0x000022, 0x000022, 0, true) ui.addTextArea(1, "<p align='left'><font size='13' face='Wingdings'><R><a href='event:killModule'>N</a></R><V> <font face='Webdings'><a href='event:tie'>s</a></font></font></p>",t,685, 23, 150, 18, 0x000022, 0x000022, 0, true) end
	end
end
started=false
end

function eventTextAreaCallback(id, name, callback)
if callback=="killModule" then error("<R> ["..name.."] MODULIS PĀRTRAUKTS.") end
if callback=="tie" then 	print("<D>• "..round..". raunds: Neizšķirts!") end
end

function eventLoop(time,rmng)
	for t,player in next,tfm.get.room.playerList do
		if disq[t] then tfm.exec.killPlayer(t) tfm.exec.setPlayerScore(t,-32768) ui.removeTextArea(0,t) end
		if sp[t] then tfm.exec.killPlayer(t) tfm.exec.setPlayerScore(t,-100) end
	end
if time >= 3000 and not started then
started=true
end
if rmng<=0 then
tfm.exec.newGame(maps[math.random(#maps)])
end
for i,cannon in ipairs(toDespawn) do
if cannon[1] <= os.time()-3000 then
tfm.exec.removeObject(cannon[2])
table.remove(toDespawn,i)
end
end
end

function eventPlayerDied(name)
local i=0
local n
for pname,player in pairs(tfm.get.room.playerList) do
if not player.isDead then
i=i+1
n=pname
end
end
if i==0 then
tfm.exec.newGame(maps[math.random(#maps)])
elseif i==1 then
tfm.exec.giveCheese(n)
tfm.exec.playerVictory(n)
tfm.exec.setGameTime(5)
end
end

for name,player in pairs(tfm.get.room.playerList) do
eventNewPlayer(name)
end

function eventPlayerWon(name, elapsed, respawnelapsed)
	print("<D>• "..round..". raunds: "..name.." uzvarēja!")
	tfm.exec.setPlayerScore(name,60,true)
	winner=round
end

function d(targ,tr,col,msgx,msgy)
	disq[targ] = true
	ui.addTextArea(100, "", targ, -1500, -1500, 3000, 3000, col, col, tr, true)
	ui.removeTextArea(0,targ)
	ui.addTextArea(680, "<p align='center'><font size='10' color='#eb1d51'>Tu esi diskvalificēts. Drīksti pamest ciltsmāju.",targ,msgx, msgy, 790, 22, col, col, tr + 0.25, true)
	print("<D>• "..targ.." ir diskvalificēts.")
	tfm.exec.killPlayer(targ)
	tfm.exec.setPlayerScore(targ,-32768,false)
end
tfm.exec.newGame(maps[math.random(#maps)])
