mui = {
	windows = {
		[120] = {
			[80] = "172e17cffd9.png"
		},
		[160] = {
			[270] = "172e17f3b3e.png"
		},
		[240] = {
			[320] = ""
		},
		[256] = {
			[144] = ""
		},
		[360] = {
			[240] = "",
			[300] = ""	
		},
		[400] = {
			[200] = "",
			[270] = "",	
			[300] = ""	
		},
		[480] = {
			[270] = ""
		},
		[576] = {
			[240] = "",
			[270] = "",	
			[320] = ""	
		},
		[640] = {
			[300] = "",
			[340] = ""	
		},
		[768] = {
			[350] = ""
		}
	}
}

function ui.emboss(id,text,data,...)
	data.col,data.bcol,data.alpha = data.col,data.bcol,data.alpha or 0x000000,0x000000,0
	ui.addTextArea(id+60000,"<font color='#000000'>"..string.gsub(text, "%%s", ""),data.target,data.x,data.y,data.w,data.h,data.col,data.bcol,data.alpha,data.pos)
	ui.addTextArea(id,string.format(text,...),data.target,data.x-1,data.y-1,data.w,data.h,data.col,data.bcol,data.alpha,data.pos)	
end

function eventNewGame()
	local Ptag = string.match(tfm.get.room.xmlMapInfo.xml, "<P (.-)/>") 
	ui.emboss(200,"%s"..Ptag,{x=5,y=380,pos=true},"<BL>")
end
