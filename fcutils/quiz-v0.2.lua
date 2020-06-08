do local _, nickname = pcall(nil) tfm.get.room.owner = string.match(nickname, "(.-)%.") end
userData = {}
errmsg = {[1] = "<font size='7'>\n</font><p align='center'><font size='20' face='Tahoma'><font color='#ff0000'><b>No questions found:</b> use queue manager to add them</font></font></p>",[2]="<font size='7'>\n</font><p align='center'><font size='20' face='Tahoma'><font color='#ff0000'>Waiting for room host to begin...</font></font></p>"}
queue = {}
etc = {time=1,questions=0}

tfm.exec.disableAutoNewGame(true)
tfm.exec.disableAutoShaman(true)
tfm.exec.disablePrespawnPreview(true)

tfm.exec.newGame('<C><P /><Z><S /><D /><O /></Z></C>')

function eventNewPlayer(name)
	userData[name] = {
			mainbgid = tfm.exec.addImage("1728fa8fb4b.png","_3",0,0,name),
			host = false
		}
	tfm.exec.killPlayer(name)
	ui.setMapName("<font color='#ff0000'>TRIVIA QUIZ!</font>\n")
	ui.addTextArea(1, "<font size='7'>\n</font><p align='center'><font size='20' face='Tahoma'><font color='#ff0000'>Q1: </font>With which command you can open the old roomlist?</font></p>", name, 52, 343, 700, 40, 0x324650, 0x000000, 0, true)
	ui.addTextArea(2, "<font size='18' face='Tahoma'>".. etc.questions.."</font>", name, 176, 272, 25, 25, 0x324650, 0x000000, 0, true)
	ui.addTextArea(3, "<font size='18' face='Tahoma'>".. etc.time/2 .."</font>", name, 146, 297, 25, 25, 0x324650, 0x000000, 0, true)
	if name==tfm.get.room.owner then userData[name].host = true end
	if userData[name].host == true then
		ui.addTextArea(600, "<font size='20' color='#ff0000'><b><p align='center'>Queue Manager</p></b></a>", name, -250, 5, 240, 390, 0x000001, 0x000000, 1, true)
		for i=1,28 do
			ui.addTextArea(600+i, "<font size='10'><N>"..i..": 123456789012345678901234</font>", name, -250, 20+(i*12), 200, 16, 0x000001, 0xff0000, 0.1, true)
			ui.addTextArea(650+i, "<font size='10'><a href='event:edit'>✏</a><font color='#ff0000'><a href='event:del'>❌</a></font></font>", name, -35, 20+(i*12), 30, 16, 0x000001, 0xff0000, 0.1, true)
		end
	end
end

table.foreach(tfm.get.room.playerList,eventNewPlayer)

function eventLoop(elapsed,rmng)
	if etc.time == 1 then etc.time = 30 end
	etc.time = etc.time - 1
	ui.updateTextArea(3,"<font size='18' face='Tahoma'>".. math.ceil(etc.time/2) .."</font>")
end

function eventTextAreaCallback(id,name,callback)
	tfm.exec.chatMessage("<R>"..id.." "..name.." "..callback)
end

if #queue < 1 then ui.updateTextArea(1,errmsg[1],nil) end
