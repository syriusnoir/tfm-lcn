do local _, nickname = pcall(nil) tfm.get.room.owner = string.match(nickname, "(.-)%.") end
userData = {}
errmsg = {[1] = "<font size='7'>\n</font><p align='center'><font size='20' face='Tahoma'><font color='#ff0000'><b>No questions found:</b> use queue manager to add them</font></font></p>",[2]="<font size='7'>\n</font><p align='center'><font size='20' face='Tahoma'><font color='#ff0000'>Waiting for room host to begin...</font></font></p>"}
queue = {}
etc = {time=1,questions=#queue,responsetime=15}

tfm.exec.disableAutoNewGame(true)
tfm.exec.disableAutoShaman(true)
tfm.exec.disablePrespawnPreview(true)

tfm.exec.newGame('<C><P /><Z><S /><D /><O /></Z></C>')

temp = ""
disp = errmsg[2]
function queueManager(name)
		ui.addTextArea(600, "<font size='20' color='#ff0000'><b><p align='center'>Queue Manager</p></b></a>", name, -250, 5, 240, 390, 0x000001, 0x000000, 1, true)
		for i=1,#queue do
			ui.addTextArea(600+i, "<font size='10'><N>"..i..": 123456789012345678901234</font>", name, -250, 20+(i*12), 210, 16, 0x000001, 0xff0000, 0, true)
			ui.addTextArea(650+i, "<font size='10'><a href='event:edit'>✏</a><font color='#ff0000'><a href='event:del'>❌</a></font></font>", name, -35, 20+(i*12), 30, 16, 0x000001, 0xff0000, 0, true)
		end
		for k,v in next,queue do 
			if v[1]:len()>24 then temp = v[1]:sub(1,21).."..." else temp = v[1] end
			ui.updateTextArea(600+k,"<a href='event:display'>"..v[2]..k..": "..temp.."</a>") 
		end
		ui.addTextArea(686, "<p align='center'><font size='10' color='#ff0000'><a href='event:add'>add</a> | <a href='event:begin'>begin</a> | <a href='event:clear'>clear</a> | <a href='event:end'>end</a></font></p>", name, -250, 380, 240, 16, 0x000001, 0xff0000, 0, true)

end

function eventNewPlayer(name)
	userData[name] = {
			mainbgid = tfm.exec.addImage("1728fa8fb4b.png","_3",0,0,name),
			host = false
		}
	tfm.exec.killPlayer(name)
	ui.setMapName("<font color='#ff0000'>TRIVIA QUIZ!</font>\n")
	ui.addTextArea(1, disp, name, 52, 343, 700, 40, 0x324650, 0x000000, 0, true)
	ui.addTextArea(2, "<font size='18' face='Tahoma'>".. etc.questions.."</font>", name, 176, 272, 25, 25, 0x324650, 0x000000, 0, true)
	ui.addTextArea(3, "<font size='18' face='Tahoma'>".. etc.time/2 .."</font>", name, 146, 297, 25, 25, 0x324650, 0x000000, 0, true)
	if name==tfm.get.room.owner then userData[name].host = true end
	if userData[name].host == true then
		queueManager(name)
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
	if callback=="add" then 
		if #queue<29 then
			ui.addPopup(15, 2, "<font size='20' color='#ff0000'><p align='center'><b>Add</b></p></font>", name, 296, 154, 200, true) 
		else
			ui.addPopup(15, 0, "<font size='20' color='#ff0000'><p align='center'><b>Add</b></p></font>\nYou may not exceed 29 questions at the time.", name, 296, 154, 200, true) 
		end
	end
	if callback=="clear" then for i=1,#queue do queue[i]=nil end queueManager(name) end
	if callback=="edit" then ui.addPopup(id, 2, "<font size='20' color='#ff0000'><p align='center'><b>Edit</b> Q".. id-650 .."</p></font>", name, 296, 154, 200, true)  end
	if callback=="display" then tfm.exec.chatMessage("<font color='#ff0000'>Q".. id-600 ..": </font><N>"..queue[id-600][1],name) end
	if callback=="end" then system.exit() end
end

function eventPopupAnswer(id,name,answer)
	tfm.exec.chatMessage("<VI>"..id.." "..name.." "..answer)
	if id==15 then queue[#queue+1]={answer,"<N>"} queueManager(name) end
	if id>649 and id<700 then queue[id-650][1]=answer queueManager(name) end
end

if #queue < 1 then ui.updateTextArea(1,errmsg[1],nil) end
