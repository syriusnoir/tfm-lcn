
-- **************/ SyrEval v.b32 \**************

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

    local c = { }
    string.gsub(cmd, "%S+", function(arg)
        c[#c + 1] = arg
    end)

if c[1] == "a" then print("<N><b>[b]<VP>[color=#30ba76]Pieņemts[/color]</VP>[/b]</b>[color=#92cf91]<T> - būs pieejams "..cmd:sub(3).." versijā.</T>[/color]") end
if c[1] == "r" then print("<N><b>[b]<font color='#eb1d51'>[color=#eb1d51]Nav pieņemts[/color]</font>[/b]</b><R> - "..cmd:sub(3)) end
if c[1] == "al" then print("<N><b>[b]<font color='#eb1d51'>[color=#eb1d51]Pieņemu ar labojumiem[/color]</font>[/b]</b><R> - "..cmd:sub(4)) end
if c[1] == "ar" then print("<N><b>[b]<CE>[color=#e68d43]Pieņemts[/color]</CE>[/b]</b>[color=#f0a78e]<CEP> - būs pieejama kā rezerves mape! <font size='10'>[size=10]"..cmd:sub(4).."[/size]</font></CEP>[/color]") end
if c[1] == "arg" then print("<N><b>[b]<CE>[color=#e68d43]Pieņemts[/color]</CE>[/b]</b>[color=#f0a78e]<CEP> - atstāju rezerves rotācijā, līdz izlaboju dizainu. <font size='10'>[size=10]"..cmd:sub(4).."[/size]</font></CEP>[/color]") end


end

function gui()
ui.addTextArea(32, "<b><R><a href='event:r'>[noraidīt]</a> <a href='event:al'>[pieņemt ar labojumiem]</a></R><CE> <a href='event:ar'>[pieņemt kā rezerves]</a> <a href='event:arg'>[atstāt uz gaidīšanu]</a></CE><VP> <a href='event:a'>[pieņemt]</a>", nil, 9, 377, 784, 27, 0x324650, 0x000000, 0.5, true)
end

function rmgui()
ui.removeTextArea(32,nil) end

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

function eventTextAreaCallback(textAreaID, playerName, callback)
if callback=="a" then ui.addPopup(0, 2, "<p align='center'>Versija</p>", playerName, 581, 289, 100, true) end
if callback=="r" then ui.addPopup(1, 2, "<p align='center'>Komentārs</p>", playerName, 581, 289, 200, true) end
if callback=="al" then ui.addPopup(2, 2, "<p align='center'>Komentārs</p>", playerName, 581, 289, 200, true) end
if callback=="ar" then ui.addPopup(3, 2, "<p align='center'>Komentārs</p>", playerName, 581, 289, 200, true) end 
if callback=="arg" then ui.addPopup(4, 2, "<p align='center'>Komentārs</p>", playerName, 581, 289, 200, true) end 
end

function eventPopupAnswer(popupID, playerName, answer)
if popupID=="0" then print("<N><b>[b]<VP>[color=#30ba76]Pieņemts[/color]</VP>[/b]</b>[color=#92cf91]<T> - būs pieejams "..answer.." versijā.</T>[/color]") end  
if popupID=="1" then print("<N><b>[b]<font color='#eb1d51'>[color=#eb1d51]Nav pieņemts[/color]</font>[/b]</b><R> - "..answer) end
if popupID=="2" then print("<N><b>[b]<font color='#eb1d51'>[color=#eb1d51]Pieņemu ar labojumiem[/color]</font>[/b]</b><R> - "..cmd:sub(4)) end
if popupID=="3" then print("<N><b>[b]<CE>[color=#e68d43]Pieņemts[/color]</CE>[/b]</b>[color=#f0a78e]<CEP> - būs pieejama kā rezerves mape! <font size='10'>[size=10]"..answer.."[/size]</font></CEP>[/color]") end
if popupID=="4" then print("<N><b>[b]<CE>[color=#e68d43]Pieņemts[/color]</CE>[/b]</b>[color=#f0a78e]<CEP> - atstāju rezerves rotācijā, līdz izlaboju dizainu. <font size='10'>[size=10]"..cmd:sub(4).."[/size]</font></CEP>[/color]") end
end

for name,player in pairs(tfm.get.room.playerList) do eventNewPlayer(name) end
-- ^^ definē 'name'

gui()
