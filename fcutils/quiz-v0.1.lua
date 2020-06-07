userData = {}
errmsg = {[1] = "<font size='7'>\n</font><p align='center'><font size='20' face='Tahoma'><font color='#ff0000'><b>No questions found:</b> use queue manager to add them</font></font></p>"}
queue = {}

tfm.exec.disableAutoNewGame(true)
tfm.exec.disablePrespawnPreview(true)

tfm.exec.newGame('<C><P /><Z><S /><D /><O /></Z></C>')

function eventNewPlayer(name)
	userData[name] = {
			mainbgid = tfm.exec.addImage("1728fa8fb4b.png","_3",0,0,name)
		}
	tfm.exec.killPlayer(name)
	ui.setMapName("<font color='#ff0000'>TRIVIA QUIZ!</font>\n")
	ui.addTextArea(1, "<font size='7'>\n</font><p align='center'><font size='20' face='Tahoma'><font color='#ff0000'>Q1: </font>With which command you can open the old roomlist?</font></p>", name, 52, 343, 700, 40, 0x324650, 0x000000, 0, true)
	ui.addTextArea(2, "<font size='18' face='Tahoma'>15</font>", name, 176, 272, 25, 25, 0x324650, 0x000000, 0, true)
	ui.addTextArea(3, "<font size='18' face='Tahoma'>15</font>", name, 146, 297, 25, 25, 0x324650, 0x000000, 0, true)
end

table.foreach(tfm.get.room.playerList,eventNewPlayer)

if #queue < 1 then ui.updateTextArea(1,errmsg[1],nil) end
