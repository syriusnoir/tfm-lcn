do local _, nickname = pcall(nil) tfm.get.room.owner = string.match(nickname, "(.-)%.") end
local setColorTag do local colors = {} setColorTag = function(tag, color) assert(tag, "Missing tag.") assert(color, "Missing color.") if type(color) == "number" then color = string.format("#%06x", color) else color = tostring(color) if not string.find(color, '#') then color = "#" .. color end end tag = tostring(tag) if not string.find(tag, "^<.->$") then tag = "<" .. tag .. ">" end colors[#colors + 1] = { tag = tag, color = color } end local putColors = function(str) for i = 1, #colors do str = string.gsub(str, colors[i].tag, "<font color=\"" .. colors[i].color .. "\">") end return str end local addTextArea, updateTextArea, chatMessage, p = ui.addTextArea, ui.updateTextArea, tfm.exec.chatMessage, print ui.addTextArea = function(id, str, ...) return addTextArea(id, putColors(str), ...) end ui.updateTextArea = function(id, str, ...) return updateTextArea(id, putColors(str), ...) end tfm.exec.chatMessage = function(str, ...) return chatMessage(putColors(str), ...) end print = function(str) return p(putColors(str)) end end
setColorTag("FCC", 0xeaa5a5) setColorTag("CR", 0xeb1d51)
system.disableChatCommandDisplay(nil)

userData = {} requests = {} etc = {common = {C = "Nickname color",M = "Mouse color",N = "Nickname change"},cmd={C = "/colornick",M = "/colormouse",N = "/changenick"},size={[1]=0.1,[2]=0.5,[3]=1,[4]=1.5,[5]=2,[6]=5},sizeCommon={[1]="0.1 (minimum)",[2]="0.5 (small)",[3]="1 (default)",[4]="1.5 (bigger)",[5]="2 (big)",[6]="5 (maximum)"}}
filter = {"flynn","null","rapunzel","juunaz","linkaito","moderacja","zoefke","bembija","adami","charissa","djealvi","fillyusha","haannq","link","mouseori","sav","teo","titivillus","yosska","fiarb","miwakiko","nuhy","philae","alisenokm","elteria","lovca","mishska","ariana_grande","bijububu","cate","fanieh","full","kurt","lucas","lummit","matterhorn","moderacao_br","niccamp","pamots","vlump","guacamolito","jackgt20","jefitou","karbi","lezzly","makis","shironinger","piratearthur","xiezi","lexa","sha","mistle","arcanacra","haribo","lament","meow","migotka","mysiaapl","staszekowaty","allis","jordy","santa","ceicu","matza","mev","tarmac","archaeron","mrslouzifer","alfiecakes","bemmh","charlen","christine","dimbles","gavin","makoto","mcsplash","asmodan","#0010","matekooo","a_801","bog","etyla","ragekitteee","hollya","mlledebby","centr","bortverde","excasr","grastfetry","kiwrimai","miau","ork","sollyun","tini","plubio","ratacp","speedy","ted","visne","amegake","mesmera","milkycoffee","peanut_butter","wooferx","chibi","hotaru","batt_mellamy","calysis","chiara","dracoleaf","inkzooka","katburger","shamousey","elysium","massi","layora","#0015","censere","eliterecon","goondad","katow","lei","mapcrew","mapcrewone","mapcrewtwo","sharpiepoops","apo","reshman","#0020","melibellule","tigrounette","#0001","#0095","amyeeera","aquawings","bapereira","conceptismo","ddniemo","gmctf","lacksas","marichamex","nettoork","old","phliperama","refused","wrfg","colakatze","notearl","acer","amy","charbz","delirium","etoile","hyena","icewolfbob","kim","lapinprince","lostchicken","lou","luchreimse","papero","poomph","sam","sebaisseba","secretive","star_ling","tachiyukan","tat","toasteis","saintgio","verdomice","warfenix","toritomm","honeythief_mew","becerritomm","azzillapp","cassette","cillanne","chamsouris","devilders","eyeground","lunewie","mquk","tortuegreen","velaceraptox","holdmancs","don","furianera","syrius","distances","faz_x","rkubi","syberin","alex","animeska6","belajasova","bionhh","frankenshtein","jerry","meow","pecheee","samandaira","ymniza","bodykudo","noooooooorr","turkitutu","chizuko","grapeup"} 
SETUP = {welcometext="Welcome to the FunCorp room! Stats do not count here. Also, please don't spam the chat and use the request button instead. Thanks!"}

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
		ui.addTextArea(201, "<BL><font face='Lucida Console'><li><a href='event:requestSize'>change size</a></li><li>change nickname</li><li><a href='event:requestColorNick'>color nickname</a></li><li><a href='event:requestColorMouse'>color mouse</a></li><li>transform</li><li><a href='event:requestMeep'>meep</a></li>\n\n<p align='center'><ROSE><a href='event:reqMenu'>[close this window]</a></ROSE></p></font></BL>", targ, 570, 95, 200, 110, 0x000000, 0x000000, 0, true)
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
	if etc.x==nil and etc.y==nil then 
		imageAlign(target,image,executor)
	else mouseImage(target,executor,image,{h=0,x=etc.x,y=etc.y})
	end
	if etc.h==0 then
		tfm.exec.addImage(image, "%"..target, etc.x, etc.y, nil)
		hostMessage("<FCC><b>• [Module]</b> "..formatName(target).." has been given image overlay "..image.." by "..formatName(executor))
	end
end

function formatName(input,mode)
	mode = mode or 0
	if userData[input]==nil then userData[input]={host=false} end
	if mode==0 then
		if string.find(input,"#") then
			input=input:sub(1,input:len()-5).."<font size='10'><G>"..input:sub(input:len()-4).."</G></font>"
		end
	elseif mode==1 then
		if string.find(input,"#") then
			if input:sub(input:len()-4)=="#0001" then
				input="<CR>"..input:sub(1,input:len()-5).."</font><font size='10'><G>"..input:sub(input:len()-4).."</G></font>"
			elseif input:sub(input:len()-4)=="#0010" then
				input="<J>"..input:sub(1,input:len()-5).."</J><font size='10'><G>"..input:sub(input:len()-4).."</G></font>"
			elseif input:sub(input:len()-4)=="#0015" then
				input="<VP>"..input:sub(1,input:len()-5).."</VP><font size='10'><G>"..input:sub(input:len()-4).."</G></font>"
			elseif input:sub(input:len()-4)=="#0020" then
				input="<BV>"..input:sub(1,input:len()-5).."</BV><font size='10'><G>"..input:sub(input:len()-4).."</G></font>"
			elseif userData[input].host then
				input="<FC>"..input:sub(1,input:len()-5).."</FC><font size='10'><G>"..input:sub(input:len()-4).."</G></font>"
			else
				input="<V>"..input:sub(1,input:len()-5).."</V><font size='10'><G>"..input:sub(input:len()-4).."</G></font>"
			end
		end
	end
	return input
end

function eventTextAreaCallback(id,name,callback)
	if callback=="reqMenu" then displayReqMenu(name) end
	if callback=="reqList" and userData[name].host then displayReqList(name) end
	if callback=="requestMeep" then 		
		ui.updateTextArea(201,"<BL><font face='Lucida Console'>You now have the meep ability.\n\n\n\n\n\n\n<p align='center'><ROSE><a href='event:reqMenu'>[close this window]</a></ROSE></p></font></BL>",name)
		tfm.exec.giveMeep(name)
		userData[name].reqmenuwindowstate=1
	end
	if callback=="requestSize" then 		
		ui.updateTextArea(201, "<BL><font face='Lucida Console'>"..sizeMenu.."\n\n<p align='center'><ROSE><a href='event:reqMenu'>[close this window]</a></ROSE></p></font></BL>", name)
		userData[name].reqmenuwindowstate=1
	end
	if callback=="align" then 
		
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
			userData[requests[i][2]].reqmenuwindowstate=1
			ui.removeTextArea(144+#requests,name)
			requests[i] = requests[#requests] 
			requests[#requests] = nil
			if userData[name].requestwindowstate==1 then userData[name].requestwindowstate=0 displayReqList(name) end
			requestPopup()
		end
		if callback=="itemDeny"..i then
			ui.addPopup(i, 2, "<p align='center'><font size='20' color='#009d9d'><b>Reason</b></V></font>\nTo cancel this action, type 'cancel'.</p>", name, 291, 148, 211, true)
		end
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
	if c[1]=="host" and userData[name].host then userData[c[2]].host=true	hostMessage("<FCC><b>• [Module]</b> "..formatName(name).." now has room host rights.") end
	if c[1]=="fc" and userData[name].host then hostMessage("<FCC>Ξ ["..formatName(name).."] "..cmd:sub(4)) end
	if c[1]=="img" and userData[name].host then mouseImage(c[2],name,c[3],{x=c[4],y=c[5]}) end
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
end
--imageAlign("Syrius#8114",0,"Syrius#8114")
