-- **************/ SyrEval v.b31.2 \**************

mode = 30 -- pieejamie režīmi: -1 = parastais, 30 = 30 sekunžu

eval1 = [[]] -- spied 1, lai palaistu šo mapi
eval2 = [[]]
eval3 = [[]]
eval4 = [[]]
eval5 = [[]]
eval6 = [[]]
--       ^^ iekopē evaluējamo kodu šeit starpā

tfm.exec.newGame(eval1)
tfm.exec.disableAutoNewGame(true)
tfm.exec.disableAutoShaman(true)


function eventChatCommand(name,cmd,n)
if cmd:sub(1,1) == "a" then print("<N><b>[b]<VP>[color=#30ba76]Pieņemts[/color]</VP>[/b]</b>[color=#92cf91]<T> - būs pieejams "..cmd:sub(3).." versijā.</T>[/color]") end
if cmd:sub(1,1) == "r" then print("<N><b>[b]<font color='#eb1d51'>[color=#eb1d51]Nav pieņemts[/color]</font>[/b]</b><R> - "..cmd:sub(3)) end
if cmd:sub(1,2) == "ar" then print("<N><b>[b]<CE>[color=#e68d43]Pieņemts[/color]</CE>[/b]</b>[color=#f0a78e]<CEP> - būs pieejama kā rezerves mape!<font size='10'>[size=10]"..cmd:sub(4).."[/size]</font></CEP>[/color]") end
end

function eventNewPlayer(name)
tfm.exec.bindKeyboard(name,18,true,true)
tfm.exec.bindKeyboard(name,49,true,true) tfm.exec.bindKeyboard(name,50,true,true) tfm.exec.bindKeyboard(name,51,true,true) tfm.exec.bindKeyboard(name,52,true,true) tfm.exec.bindKeyboard(name,53,true,true) tfm.exec.bindKeyboard(name,54,true,true)
end

function eventKeyboard(name, key, down, x, y)
if key==18 then
tfm.exec.newGame(tfm.get.room.xmlMapInfo.xml) 
-- ^^ kad uzspiež alt, tiek pārlādēta mape

elseif key==49 then
tfm.exec.newGame(eval1)
elseif key==50 then
tfm.exec.newGame(eval2)
elseif key==51 then
tfm.exec.newGame(eval3)
elseif key==52 then
tfm.exec.newGame(eval4)
elseif key==53 then
tfm.exec.newGame(eval5)
elseif key==54 then
tfm.exec.newGame(eval6) end
end


function eventNewGame()
if mode==30 then
tfm.exec.setGameTime(30)
end
end


for name,player in pairs(tfm.get.room.playerList) do eventNewPlayer(name) end
-- ^^ definē 'name'
