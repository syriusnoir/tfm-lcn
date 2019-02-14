-- **************/ SyrEval v.b31 \**************


evalmap = [[]]
--         ^^ iekopē evaluējamo kodu šeit starpā

tfm.exec.newGame(evalmap)
tfm.exec.disableAutoNewGame(true)
tfm.exec.disableAutoShaman(true)

function eventChatCommand(name,cmd,n)
if cmd:sub(1,1) == "a" then print("<N><b>[b]<VP>[color=#30ba76]Pieņemts[/color]</VP>[/b]</b>[color=#92cf91]<T> - būs pieejams "..cmd:sub(3).." versijā.</T>[/color]") end
if cmd:sub(1,1) == "r" then print("<N><b>[b]<font color='#eb1d51'>[color=#eb1d51]Nav pieņemts[/color]</font>[/b]</b><R> - "..cmd:sub(3)) end
if cmd:sub(1,2) == "ar" then print("<N><b>[b]<CE>[color=#e68d43]Pieņemts[/color]</CE>[/b]</b>[color=#f0a78e]<CEP> - būs pieejama kā rezerves mape!<font size='10'>[size=10]"..cmd:sub(4).."[/size]</font></CEP>[/color]") end
end

function eventNewPlayer(name)
tfm.exec.bindKeyboard(name,18,true,true)
end

function eventKeyboard(name, key, down, x, y)
if key==18 then
tfm.exec.newGame(evalmap) end 
-- ^^ kad uzspiež alt, tiek pārlādēta mape
end

for name,player in pairs(tfm.get.room.playerList) do eventNewPlayer(name) end
-- ^^ definē 'name'
