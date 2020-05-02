do local _, nickname = pcall(nil) tfm.get.room.owner = string.match(nickname, "(.-)%.") end
local setColorTag do local colors = {} setColorTag = function(tag, color) assert(tag, "Missing tag.") assert(color, "Missing color.") if type(color) == "number" then color = string.format("#%06x", color) else color = tostring(color) if not string.find(color, '#') then color = "#" .. color end end tag = tostring(tag) if not string.find(tag, "^<.->$") then tag = "<" .. tag .. ">" end colors[#colors + 1] = { tag = tag, color = color } end local putColors = function(str) for i = 1, #colors do str = string.gsub(str, colors[i].tag, "<font color=\"" .. colors[i].color .. "\">") end return str end local addTextArea, updateTextArea, chatMessage, p = ui.addTextArea, ui.updateTextArea, tfm.exec.chatMessage, print ui.addTextArea = function(id, str, ...) return addTextArea(id, putColors(str), ...) end ui.updateTextArea = function(id, str, ...) return updateTextArea(id, putColors(str), ...) end tfm.exec.chatMessage = function(str, ...) return chatMessage(putColors(str), ...) end print = function(str) return p(putColors(str)) end end
setColorTag("FCC", 0xeaa5a5)
system.disableChatCommandDisplay(nil)

userData = {} requests = {} etc = {common = {C = "Nickname color",M = "Mouse color",N = "Nickname change"},cmd={C = "/colornick",M = "/colormouse",N = "/changenick"}}
filter = {} SETUP = {welcometext="Welcome to the FunCorp room! Stats do not count here. Also, please don't spam the chat and use the request button instead. Thanks!"}

function displayReqList(targ)
	if userData[targ].requestwindowstate==0 then
		ui.addTextArea(144, "", targ, 20, 40, 360, 305, 0x000001, 0x000000, 0.8, true)
		ui.addTextArea(10, "", targ, 350, 40, 30, 305, 0x000001, 0x000000, 1, true)
		ui.addTextArea(2, "<font size='20'><V><p align='center'><b>Requests</b></p></V></font>", targ, 20, 40, 360, 30, 0x000001, 0x000000, 1, true)
		for i=1,#requests do ui.addTextArea(10+i, "<font face='Lucida Console'><p align='center'><VP><a href='event:itemAccept"..i.."'>✔</VP><R><a href='event:itemDeny"..i.."'>❌</a></R></p></font>", targ, 350, 66+(i*11), 30, 14, 0x000000, 0x000000, 1, true) if i>23 then break end end
		for i=1,#requests do ui.addTextArea(144+i, "<font face='Lucida Console'><BL>["..requests[i][1].."] "..requests[i][2].." >> "..requests[i][3].."</font>", targ, 20, 66+(i*11), 320, 15, 0x000000, 0x000000, 1, true) if i>23 then break end end
		userData[targ].requestwindowstate=1
	elseif userData[targ].requestwindowstate==1 then
		for i=0,24 do
			ui.removeTextArea(10+i,targ) ui.removeTextArea(144+i,targ)
		end
		ui.removeTextArea(2,targ)
		userData[targ].requestwindowstate=0
	end
end

function displayReqMenu(targ)
	if userData[targ].reqmenuwindowstate==0 then
		ui.addTextArea(1, "", targ, 570, 55, 200, 150, 0x000001, 0x000000, 0.8, true)
		ui.addTextArea(200, "<font size='20'><V><p align='center'><b>Make a request</b></p></V></font>", targ, 570, 55, 200, 30, 0x000001, 0x000000, 1, true)
		ui.addTextArea(201, "<BL><font face='Lucida Console'><li>change size</li><li>change nickname</li><li><a href='event:requestColorNick'>color nickname</a></li><li><a href='event:requestColorMouse'>color mouse</a></li><li>transform</li><li><a href='event:requestMeep'>meep</a></li>\n\n<p align='center'><ROSE><a href='event:reqMenu'>[close this window]</a></ROSE></p></font></BL>", targ, 570, 95, 200, 110, 0x000000, 0x000000, 0, true)
		userData[targ].reqmenuwindowstate=1
	elseif userData[targ].reqmenuwindowstate==1 then
		ui.addTextArea(1, "<V><p align='center'><a href='event:reqMenu'>make a request</a></p></V>", targ, 685, 380, 100, 100, 0x000001, 0x000000, 0.8, true)
		ui.removeTextArea(200,targ) ui.removeTextArea(201,targ)
		userData[targ].reqmenuwindowstate=0
	end
end

function request(type,targ,request)
	requests[#requests+1]={type,targ,request}
	for name,player in next,tfm.get.room.playerList do if userData[name].requestwindowstate==1 then userData[name].requestwindowstate=0 displayReqList(name) end end
end

function eventNewPlayer(name)
	tfm.exec.chatMessage("<FC><b>• [FunCorp] </b>"..SETUP.welcometext,name)
	system.bindKeyboard(name,66,false)
	system.bindKeyboard(name,66,true)
	system.bindKeyboard(name,192,false)
	userData[name] = {
		blacklisted=false,
		blacklistreason="",
		blacklistduration=0,
		requestwindowstate=0,
		reqmenuwindowstate=0,
		host=false
	}
ui.addTextArea(1, "<V><p align='center'><a href='event:reqMenu'>make a request</a></p></V>", name, 685, 380, 100, 100, 0x000001, 0x000000, 0.8, true)
end

table.foreach(tfm.get.room.playerList, eventNewPlayer)
userData[tfm.get.room.owner].host = true

function eventKeyboard(name,key,down,x,y)
	if userData[name].host and key==192 then displayReqList(name) end
end

function eventTextAreaCallback(id,name,callback)
	if callback=="reqMenu" then displayReqMenu(name) end
	if callback=="requestMeep" then 		
		ui.updateTextArea(201,"<BL><font face='Lucida Console'>You now have the meep ability.\n\n\n\n\n\n\n<p align='center'><ROSE><a href='event:reqMenu'>[close this window]</a></ROSE></p></font></BL>",name)
		tfm.exec.giveMeep(name)
		userData[name].reqmenuwindowstate=1
	end
	if callback=="requestSize" then 		
		ui.updateTextArea(201,"<BL><font face='Lucida Console'>You now have the meep ability.\n\n\n\n\n\n\n<p align='center'><ROSE><a href='event:reqMenu'>[close this window]</a></ROSE></p></font></BL>",name)
		tfm.exec.giveMeep(name)
		userData[name].reqmenuwindowstate=1
	end
	if callback=="requestColorMouse" then 	
		ui.showColorPicker(300,name,0x000000,"Color "..name.."'s mouse") 
	end
	if callback=="requestColorNick" then 	
		ui.showColorPicker(301,name,0x000000,"Color "..name.."'s nickname") 
	end
	for i=1,24 do
		if callback=="itemAccept"..i then
			ui.addTextArea(1, "", requests[i][2], 470, 55, 300, 150, 0x000001, 0x000000, 0.8, true)
			ui.addTextArea(200, "<font size='20'><V><p align='center'><b>Information</b></p></V></font>", requests[i][2], 470, 55, 300, 30, 0x000001, 0x000000, 1, true)
			ui.addTextArea(201, "<BL><font face='Lucida Console'><V><b>Request:</b></V> "..etc.common[requests[i][1]].." "..requests[i][3].."\nThis request has been fulfilled.\n\n\n\n\n\n\n<p align='center'><ROSE><a href='event:reqMenu'>[close this window]</a></ROSE></p></font></BL>", requests[i][2], 470, 95, 300, 110, 0x000000, 0x000000, 0, true)	
			tfm.exec.chatMessage("<J>"..etc.cmd[requests[i][1]].." "..requests[i][2].." "..requests[i][3],name)
			userData[name].reqmenuwindowstate=1
			ui.removeTextArea(144+#requests,name)
			requests[i] = requests[#requests] 
			requests[#requests] = nil
			if userData[name].requestwindowstate==1 then userData[name].requestwindowstate=0 displayReqList(name) end
		end
	end
end

function eventColorPicked(id,name,color)
	if id==300 then 
		if color~=-1 then request("M",name,"<font color='#"..string.format("%06x",color).."'>#"..string.format("%06x",color).."</font>") ui.updateTextArea(201,"<BL><font face='Lucida Console'>Your request has been taken into consideration.\n\n\n\n\n\n\n<p align='center'><ROSE><a href='event:reqMenu'>[close this window]</a></ROSE></p></font></BL>",targ) end
	end
	if id==301 then 
		if color~=-1 then request("C",name,"<font color='#"..string.format("%06x",color).."'>#"..string.format("%06x",color).."</font>") ui.updateTextArea(201,"<BL><font face='Lucida Console'>Your request has been taken into consideration.\n\n\n\n\n\n\n<p align='center'><ROSE><a href='event:reqMenu'>[close this window]</a></ROSE></p></font></BL>",targ) end
	end
end

function eventChatCommand(name,cmd)
	local c = { }
	string.gsub(cmd, "%S+", function(arg)
	c[#c + 1] = arg
	end)

	if c[1]=="w" and userData[name].host then SETUP.welcometext=cmd:sub(3) 	tfm.exec.chatMessage("<FCC><b>• [Module]</b> Welcome text has been changed to: "..SETUP.welcometext,name) end
end





