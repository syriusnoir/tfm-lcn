do local _, nickname = pcall(nil) tfm.get.room.owner = string.match(nickname, "(.-)%.") end
local setColorTag do local colors = {} setColorTag = function(tag, color) assert(tag, "Missing tag.") assert(color, "Missing color.") if type(color) == "number" then color = string.format("#%06x", color) else color = tostring(color) if not string.find(color, '#') then color = "#" .. color end end tag = tostring(tag) if not string.find(tag, "^<.->$") then tag = "<" .. tag .. ">" end colors[#colors + 1] = { tag = tag, color = color } end local putColors = function(str) for i = 1, #colors do str = string.gsub(str, colors[i].tag, "<font color=\"" .. colors[i].color .. "\">") end return str end local addTextArea, updateTextArea, chatMessage, p = ui.addTextArea, ui.updateTextArea, tfm.exec.chatMessage, print ui.addTextArea = function(id, str, ...) return addTextArea(id, putColors(str), ...) end ui.updateTextArea = function(id, str, ...) return updateTextArea(id, putColors(str), ...) end tfm.exec.chatMessage = function(str, ...) return chatMessage(putColors(str), ...) end print = function(str) return p(putColors(str)) end end
setColorTag("FCC", 0xeaa5a5) setColorTag("CR", 0xeb1d51)
system.disableChatCommandDisplay(nil)

userData = {} requests = {} etc = {common = {C = "Nickname color",M = "Mouse color",N = "Nickname change"},cmd={C = "/colornick",M = "/colormouse",N = "/changenick"},size={[1]=0.1,[2]=0.5,[3]=1,[4]=1.5,[5]=2,[6]=5},sizeCommon={[1]="0.1 (minimum)",[2]="0.5 (small)",[3]="1 (default)",[4]="1.5 (bigger)",[5]="2 (big)",[6]="5 (maximum)"},features={[1]=3,[2]=5,[3]=7,[4]=8},ftdisp={[1]="Username change requests",[2]="FFA",[3]="Size change",[4]="Greeting message"},fte={[1]="",[2]="",[3]="",[4]=""}}
filter = {"flynn","null","rapunzel","juunaz","linkaito","moderacja","zoefke","bembija","adami","charissa","djealvi","fillyusha","haannq","link","mouseori","sav","teo","titivillus","yosska","fiarb","miwakiko","nuhy","philae","alisenokm","elteria","lovca","mishska","ariana_grande","bijububu","cate","fanieh","full","kurt","lucas","lummit","matterhorn","moderacao_br","niccamp","pamots","vlump","guacamolito","jackgt20","jefitou","karbi","lezzly","makis","shironinger","piratearthur","xiezi","lexa","sha","mistle","arcanacra","haribo","lament","meow","migotka","mysiaapl","staszekowaty","allis","jordy","santa","ceicu","matza","mev","tarmac","archaeron","mrslouzifer","alfiecakes","bemmh","charlen","christine","dimbles","gavin","makoto","mcsplash","asmodan","#0010","matekooo","a_801","bog","etyla","ragekitteee","hollya","mlledebby","centr","bortverde","excasr","grastfetry","kiwrimai","miau","ork","sollyun","tini","plubio","ratacp","speedy","ted","visne","amegake","mesmera","milkycoffee","peanut_butter","wooferx","chibi","hotaru","batt_mellamy","calysis","chiara","dracoleaf","inkzooka","katburger","shamousey","elysium","massi","layora","#0015","censere","eliterecon","goondad","katow","lei","mapcrew","mapcrewone","mapcrewtwo","sharpiepoops","apo","reshman","#0020","melibellule","tigrounette","#0001","#0095","amyeeera","aquawings","bapereira","conceptismo","ddniemo","gmctf","lacksas","marichamex","nettoork","old","phliperama","refused","wrfg","colakatze","notearl","acer","amy","charbz","delirium","etoile","hyena","icewolfbob","kim","lapinprince","lostchicken","lou","luchreimse","papero","poomph","sam","sebaisseba","secretive","star_ling","tachiyukan","tat","toasteis","saintgio","verdomice","warfenix","toritomm","honeythief_mew","becerritomm","azzillapp","cassette","cillanne","chamsouris","devilders","eyeground","lunewie","mquk","tortuegreen","velaceraptox","holdmancs","don","furianera","syrius","distances","faz_x","rkubi","syberin","alex","animeska6","belajasova","bionhh","frankenshtein","jerry","meow","pecheee","samandaira","ymniza","bodykudo","noooooooorr","turkitutu","chizuko","grapeup"} 
SETUP = {features=168,welcometext="Welcome to the FunCorp room! Stats do not count here. Also, please don't spam the chat and use the request button instead. Thanks!"}

function displayReqList(targ)
	if userData[targ].requestwindowstate==0 then
		ui.addTextArea(144, "", targ, 20, 40, 360, 305, 0x000001, 0x000000, 0.8, true)
		ui.addTextArea(10, "", targ, 350, 40, 30, 305, 0x000001, 0x000000, 1, true)
		ui.addTextArea(2, "<font size='20'><V><p align='center'><b>Requests</b></p></V></font>", targ, 20, 40, 360, 30, 0x000001, 0x000000, 1, true)
		for i=1,#requests do ui.addTextArea(10+i, "<font face='Lucida Console'><p align='center'><VP><a href='event:itemAccept'>✔</VP><R><a href='event:itemDeny'>❌</a></R></p></font>", targ, 350, 66+(i*11), 30, 14, 0x000000, 0x000000, 1, true) if i>23 then break end end
		for i=1,#requests do ui.addTextArea(144+i, "<font face='Lucida Console'><BL>["..requests[i][1].."] "..requests[i][2].." >> "..requests[i][3].."</font>", targ, 20, 66+(i*11), 320, 15, 0x000000, 0x000000, 1, true) if i>23 then break end end
		userData[targ].requestwindowstate=1
	elseif userData[targ].requestwindowstate==1 then
		for i=0,24 do
			ui.removeTextArea(10+i,targ) ui.removeTextArea(144+i,targ)
		end
		ui.removeTextArea(2,targ)
		userData[targ].requestwindowstate=0
	elseif userData[targ].requestwindowstate==2 then
		ui.addTextArea(10144, "", targ, 20, 40, 360, 305, 0x000001, 0x000000, 0.8, true)
		ui.addTextArea(10010, "", targ, 350, 40, 30, 305, 0x000001, 0x000000, 1, true)
		ui.addTextArea(10002, "<font size='20'><V><p align='center'><b>Features</b></p></V></font>", targ, 20, 40, 360, 30, 0x000001, 0x000000, 1, true)
		for k,v in next,etc.features do if SETUP.features%v==0 then etc.fte[k] = "<VP><a href='event:chstate'>on</VP>" else etc.fte[k] = "<CR><a href='event:chstate'>off</font>" end end
		for i=1,#etc.ftdisp do ui.addTextArea(10010+i, "<font face='Lucida Console'><p align='center'>"..etc.fte[i].."</p></font>", targ, 350, 66+(i*11), 30, 14, 0x000000, 0x000000, 1, true) if i>23 then break end end
		for i=1,#etc.ftdisp do ui.addTextArea(10144+i, "<font face='Lucida Console'><BL>"..etc.ftdisp[i].."</font>", targ, 20, 66+(i*11), 320, 15, 0x000000, 0x000000, 1, true) if i>23 then break end end
		ui.addTextArea(10144+#etc.ftdisp+1, "<font face='Lucida Console'><V><b>Configuation ID:</b></V> <BL>"..SETUP.features.."</BL> <ROSE><a href='event:loadcfg'>[load]</a></ROSE></font>", targ, 20, 66+((#etc.ftdisp+2)*11), 320, 15, 0x000000, 0x000000, 1, true)
		ui.addTextArea(10144+#etc.ftdisp+2, "<font face='Lucida Console'><p align='center'><ROSE><a href='event:clsf'>[close this window]</a></ROSE></p></font>", targ, 20, 330, 320, 15, 0x000000, 0x000000, 1, true)
		userData[targ].requestwindowstate=1
	end
end

function displayReqMenu(targ)
	if userData[targ].reqmenuwindowstate==0 then
		ui.addTextArea(1, "", targ, 570, 55, 200, 150, 0x000001, 0x000000, 0.8, true)
		ui.addTextArea(200, "<font size='20'><V><p align='center'><b>Make a request</b></p></V></font>", targ, 570, 55, 200, 30, 0x000001, 0x000000, 1, true)
		ui.addTextArea(201, "<BL><font face='Lucida Console'><li><a href='event:requestSize'>change size</a></li><li>change nickname</li><li><a href='event:requestColorNick'>color nickname</a></li><li><a href='event:requestColorMouse'>color mouse</a></li><li><a href='event:tfm'>transform</a></li><li><a href='event:requestMeep'>meep</a></li>\n\n<p align='center'><ROSE><a href='event:reqMenu'>[close this window]</a></ROSE></p></font></BL>", targ, 570, 95, 200, 110, 0x000000, 0x000000, 0, true)
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
	requestPopup()
end

function hostMessage(message)
	for name,player in next,tfm.get.room.playerList do if userData[name].host==true then tfm.exec.chatMessage(message,name) end end
end

function requestPopup()
	for name,player in next,tfm.get.room.playerList do 
		if userData[name].host==true then 
			if #requests>0 then
				if userData[name].warningsign==false then userData[name].warningsignid = tfm.exec.addImage("171da32855e.png", ":2", 765, 33, name) userData[name].warningsign=true end
				ui.addTextArea(2000, "<font color='#eb1d51'><p align='center'>"..#requests.."</p></font>", name, 766, 52, 24, 20, 0x324650, 0x000000, 0, true)
				ui.addTextArea(2001, "<a href='event:reqList'><font size='24'>\n</font></a>", name, 765, 33, 26, 30, 0x000000, 0x000000, 0, true)
			else
				tfm.exec.removeImage(userData[name].warningsignid)
				userData[name].warningsign=false
				ui.removeTextArea(2000,name)
				ui.removeTextArea(2001,name)
			end
		end 
	end
end

function eventNewPlayer(name)
	for i, v in ipairs({66,67,86}) do
		system.bindKeyboard(name,v,false)
		system.bindKeyboard(name,v,true)
	end
	system.bindKeyboard(name,192,false)
	tfm.exec.chatMessage("<FC><b>• [FunCorp] </b>"..SETUP.welcometext,name)
	if userData[name]==nil then
		userData[name] = {
			blacklisted=false,
			blacklistreason="",
			blacklistduration=0,
			requestwindowstate=0,
			activitywindowstate=0,
			reqmenuwindowstate=0,
			warningsign=false,
			warningsignid=0,
			host=false,
			activity={},
			meep=false,
			tfm=false,
			holding={[66]=false,[67]=false,[86]=false},
			image={left="",right="",leftid=0,rightid=0,dummyid=0,alignx=0,aligny=0}
		}
	if userData[name].host==true then userData[name].ncol="FC" end
	end
ui.addTextArea(1, "<V><p align='center'><a href='event:reqMenu'>make a request</a></p></V>", name, 685, 380, 100, 100, 0x000001, 0x000000, 0.8, true)
end

table.foreach(tfm.get.room.playerList, eventNewPlayer)
userData[tfm.get.room.owner].host = true

function imageAlign(target,image,executor,etc)
	ui.addTextArea(8001, "", executor, 200, 115, 400, 200, 0x000001, 0x000000, 0.8, true)
	ui.addTextArea(8000, "<font size='20'><V><p align='center'><b>Align</b></p></V></font>", executor, 200, 100, 400, 30, 0x000001, 0x000000, 1, true)
	ui.addTextArea(8002, "<ROSE><p align='center'><a href='event:align'>←</a></p>", executor, 200, 220, 20, 20, 0x324650, 0x000000, 0, true)
	ui.addTextArea(8003, "<ROSE><p align='center'><a href='event:align'>→</a></p>", executor, 580, 220, 20, 20, 0x324650, 0x000000, 0, true)
	ui.addTextArea(8004, "<ROSE><p align='center'><a href='event:align'>↓</a></p>", executor, 390, 295, 20, 20, 0x324650, 0x000000, 0, true)
	ui.addTextArea(8005, "<ROSE><p align='center'><a href='event:align'>↑</a></p>", executor, 390, 140, 20, 20, 0x324650, 0x000000, 0, true)
	ui.addTextArea(8006, "<p align='center'><font size='16'><ROSE><a href='event:closeAlign'>❌</a></ROSE></font></p>", executor, 570, 103, 30, 30, 0x324650, 0x000000, 0, true)
	ui.addTextArea(8007, "<font face='Lucida Console'><BL>X: 0, Y: 0</font>", executor, 200, 140, 150, 20, 0x000000, 0x000000, 0, true)
	userData[executor].dummyid = tfm.exec.addImage("1507b125cf9.png","&3",375,195,executor)
end

function eventKeyboard(name,key,down,x,y)
	if userData[name].host and key==192 then displayReqList(name) end
	for i,v in ipairs({66,67,86}) do 
		if key==v then userData[name].holding[key]=down end	
	end
end

sizeMenu = ""
for i=1,#etc.size do sizeMenu = sizeMenu.."<li><a href='event:requestSize"..i.."'>"..etc.sizeCommon[i].."</a></li>" end
 
function mouseImage(target,executor,image,etc)
--	if etc.x==nil and etc.y==nil then 
--		imageAlign(target,image,executor)
--	if etc.h==0 then
	tfm.exec.addImage(image, "%"..target, etc.x, etc.y, nil)
	hostMessage("<FCC><b>• [Module]</b> "..formatName(target).." has been given image overlay "..image.." by "..formatName(executor))
--	end
end

function help(name)
ui.addTextArea(60000, "", name, -3000, -3000, 6000, 6000, 0x000001, 0x000000, 0.9, true)
ui.addTextArea(60001, "<b><font size='20'><V><a href='event:rmhelp'>«</a> Help</V></font></b>\n\n<textformat tabstops='0,200,400,600'><J><font size='14'><b>Commands</b></font>\n\n<J>!f</J><BL> : opens the feature options window</BL>\n<J>!fc</J> <V>[text]</V><G></G><BL> : displays a message to every host</BL>\n<J>!help</J><BL> : opens this window</BL>\n<J>!host</J> <V>[playerName]</V><G></G><BL> : grants host permissions to a player</BL>\n<J>!img</J> <V>[playerName] [image]</V><G> [x offset] [y offset]</G><BL> : replaces mouse sprite with the specified image</BL>\n<J>!rel</J> <V>[playerNames|*]</V><G></G><BL> : kills and then respawns the player</BL>\n<J>!w</J> <V>[text]</V><G></G><BL> : changes the greeting message</BL>\n\n\n\n</textformat>", name, 50, 30, 700, 360, 0x324650, 0x000000, 0, true)
end

function formatName(input,mode)
	mode = mode or 0
	if userData[input]==nil then userData[input]={host=false} end
	if mode==0 then
		if string.find(input,"#") then
			input=input:sub(1,input:len()-5).."<font size='-3'><G>"..input:sub(input:len()-4).."</G></font>"
		end
	elseif mode==1 then
		if string.find(input,"#") then
			if input:sub(input:len()-4)=="#0001" then
				input="<CR>"..input:sub(1,input:len()-5).."</font><font size='-3'><G>"..input:sub(input:len()-4).."</G></font>"
			elseif input:sub(input:len()-4)=="#0010" then
				input="<J>"..input:sub(1,input:len()-5).."</J><font size='-3'><G>"..input:sub(input:len()-4).."</G></font>"
			elseif input:sub(input:len()-4)=="#0015" then
				input="<VP>"..input:sub(1,input:len()-5).."</VP><font size='-3'><G>"..input:sub(input:len()-4).."</G></font>"
			elseif input:sub(input:len()-4)=="#0020" then
				input="<BV>"..input:sub(1,input:len()-5).."</BV><font size='-3'><G>"..input:sub(input:len()-4).."</G></font>"
			elseif userData[input].host then
				input="<FC>"..input:sub(1,input:len()-5).."</FC><font size='-3'><G>"..input:sub(input:len()-4).."</G></font>"
			else
				input="<V>"..input:sub(1,input:len()-5).."</V><font size='-3'><G>"..input:sub(input:len()-4).."</G></font>"
			end
		end
	end
	return input
end

function eventTextAreaCallback(id,name,callback)
	if callback=="reqMenu" then displayReqMenu(name) end
	if callback=="reqList" and userData[name].host then displayReqList(name) end
	if callback=="requestMeep" then
		if userData[name].meep==false then 		
			ui.updateTextArea(201,"<BL><font face='Lucida Console'>You now have the meep ability.\n\n\n\n\n\n\n<p align='center'><ROSE><a href='event:reqMenu'>[close this window]</a></ROSE></p></font></BL>",name)
			tfm.exec.giveMeep(name)
			userData[name].meep=true
		else
			ui.updateTextArea(201,"<BL><font face='Lucida Console'>You no longer have the meep ability.\n\n\n\n\n\n\n<p align='center'><ROSE><a href='event:reqMenu'>[close this window]</a></ROSE></p></font></BL>",name)
			tfm.exec.giveMeep(name,false)
			userData[name].meep=false
		end
		userData[name].reqmenuwindowstate=1
	end
	if callback=="tfm" then
		if userData[name].tfm==false then 		
			ui.updateTextArea(201,"<BL><font face='Lucida Console'>You now have the transformation ability.\n\n\n\n\n\n\n<p align='center'><ROSE><a href='event:reqMenu'>[close this window]</a></ROSE></p></font></BL>",name)
			tfm.exec.giveTransformations(name)
			userData[name].tfm=true
		else
			ui.updateTextArea(201,"<BL><font face='Lucida Console'>You no longer have the transformation ability.\n\n\n\n\n\n\n<p align='center'><ROSE><a href='event:reqMenu'>[close this window]</a></ROSE></p></font></BL>",name)
			tfm.exec.giveTransformations(name,false)
			userData[name].tfm=false
		end
		userData[name].reqmenuwindowstate=1
	end
	if callback=="requestSize" then 		
		ui.updateTextArea(201, "<BL><font face='Lucida Console'>"..sizeMenu.."\n\n<p align='center'><ROSE><a href='event:reqMenu'>[close this window]</a></ROSE></p></font></BL>", name)
		userData[name].reqmenuwindowstate=1
	end
	if callback=="align" then 
		
	end	
	if callback=="rmhelp" then 
		for k,v in ipairs({60000,60001}) do ui.removeTextArea(v) end
	end	
	if callback=="chstate" then 
--		10010-id
	end	
	if callback=="clsf" then 
		for i=10000,10200 do ui.removeTextArea(i,name) end
	end	
	if callback=="loadcfg" then 
		ui.addPopup(800, 2, "<p align='center'><font size='20' color='#009d9d'><b>Load</b></V></font>\nEnter the configuation ID of a preset to load it.</p>", name, 291, 148, 350, true)
	end		
	if callback=="requestColorMouse" then 	
		ui.showColorPicker(300,name,0x000000,"Color "..name.."'s mouse") 
	end
	if callback=="requestColorNick" then 	
		ui.showColorPicker(301,name,0x000000,"Color "..name.."'s nickname") 
	end
	if callback=="itemAccept" then
		ui.addTextArea(1, "", requests[id-10][2], 470, 55, 300, 150, 0x000001, 0x000000, 0.8, true)
		ui.addTextArea(200, "<font size='20'><V><p align='center'><b>Information</b></p></V></font>", requests[id-10][2], 470, 55, 300, 30, 0x000001, 0x000000, 1, true)
		ui.addTextArea(201, "<BL><font face='Lucida Console'><V><b>Request:</b></V> "..etc.common[requests[id-10][1]].." "..requests[id-10][3].."\nThis request has been fulfilled.\n\n\n\n\n\n\n<p align='center'><ROSE><a href='event:reqMenu'>[close this window]</a></ROSE></p></font></BL>", requests[id-10][2], 470, 95, 300, 110, 0x000000, 0x000000, 0, true)	
		tfm.exec.chatMessage("<J>"..etc.cmd[requests[id-10][1]].." "..requests[id-10][2].." "..requests[id-10][3],name)
		userData[requests[id-10][2]].reqmenuwindowstate=1
		for k,v in next,userData do 
			if userData[k].requestwindowstate==1 then
					ui.removeTextArea(10+#requests,k)
					ui.removeTextArea(144+#requests,k)
			end
		end
		requests[id-10] = requests[#requests] 
		requests[#requests] = nil
			if userData[name].requestwindowstate==1 then userData[name].requestwindowstate=0 displayReqList(name) 
				requestPopup()
			end
	end
	if callback=="itemDeny" then
		ui.addPopup(id-10, 2, "<p align='center'><font size='20' color='#009d9d'><b>Reason</b></V></font>\nTo cancel this action, type 'cancel'.</p>", name, 291, 148, 211, true)
	end
	for i=1,#etc.size do
		if callback=="requestSize"..i then
			tfm.exec.changePlayerSize(name,etc.size[i])
			ui.updateTextArea(201,"<BL><font face='Lucida Console'>Your size has been changed to "..etc.size[i]..".\n\n\n\n\n\n\n<p align='center'><ROSE><a href='event:reqMenu'>[close this window]</a></ROSE></p></font></BL>",name)
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

	if c[1]=="w" and userData[name].host then SETUP.welcometext=cmd:sub(3) 	hostMessage("<FCC><b>• [Module]</b> Welcome text has been changed to: "..SETUP.welcometext) end
	if c[1]=="host" and userData[name].host then 
		if userData[c[2]] then
			userData[c[2]].host=true	
			hostMessage("<FCC><b>• [Module]</b> "..formatName(c[2]).." now has room host rights.")
		end
	end
	if c[1]=="help" and userData[name].host then help(name) end
	if c[1]=="fc" and userData[name].host then hostMessage("<FCC>Ξ ["..formatName(name).."] "..cmd:sub(4)) end
	if c[1]=="img" and userData[name].host then mouseImage(c[2],name,c[3],{x=c[4],y=c[5]}) end
	if c[1]=="f" and userData[name].host then userData[name].requestwindowstate=2 displayReqList(name) end
	if c[1]=="rel" and userData[name].host then 
		if c[2]=="*" then
			table.foreach(userData,tfm.exec.killPlayer)
			table.foreach(userData,tfm.exec.respawnPlayer)
		else
			for i=2,#c do
				tfm.exec.killPlayer(c[i])
				tfm.exec.respawnPlayer(c[i])
			end
		end
	end
end

function eventPopupAnswer(id,name,answer)
	for i=1,24 do
		if id==i then 	
				if answer~="cancel" then		
					ui.addTextArea(1, "", requests[i][2], 470, 55, 300, 150, 0x000001, 0x000000, 0.8, true)
					ui.addTextArea(200, "<font size='20'><V><p align='center'><b>Information</b></p></V></font>", requests[i][2], 470, 55, 300, 30, 0x000001, 0x000000, 1, true)
					ui.addTextArea(201, "<BL><font face='Lucida Console'><V><b>Request:</b></V> "..etc.common[requests[i][1]].." "..requests[i][3].."\nThis request has been rejected.\n\n<V><b>Reason:</b></V> "..answer.."\n\n\n\n\n<p align='center'><ROSE><a href='event:reqMenu'>[close this window]</a></ROSE></p></font></BL>", requests[i][2], 470, 95, 300, 110, 0x000000, 0x000000, 0, true)	
					userData[requests[i][2]].reqmenuwindowstate=1
					ui.removeTextArea(144+#requests,name)
					requests[i] = requests[#requests] 
					requests[#requests] = nil
					if userData[name].requestwindowstate==1 then userData[name].requestwindowstate=0 displayReqList(name) end
					requestPopup()
				end
		end
	end
	if id==800 then
		if tonumber(answer)~=nil then SETUP.features=tonumber(answer) userData[name].requestwindowstate=2 displayReqList(name) end
	end
end

function eventNewGame()
	for k,v in next,userData do 
		if userData[k].meep==true then tfm.exec.giveMeep(k) end
	end
end
--imageAlign("Syrius#8114",0,"Syrius#8114")
