--[[
2020 04 26 - FFA
Shoot cannons with down key!

Commands
=========================================================================
msg               Send a public chat message as [Funcorp] in orange text
next              Starts the next round
cannons           Enable/disable cannons
mice              Use this with cannons enabled for a little surprise!

Controls
=========================================================================
Mice: shoot cannons with down key (when cannons are enabled)

I've got the best results using this in VILLAGE rooms. Some people would
spend hours just shooting cannons there without any objective.

Make sure to disable cannons before stopping/reloading/changing the script
in village rooms, otherwise you'll end up with a room full of cannons that
you won't be able to get rid of (and you'll have to /closeroom to clear it).

!mice makes everything more chaotic, random and fun. Add a little colors,
sizes, and /linkmice * from time to time and you'll get the most fun out
of it.
]]

admins = {['Syrius#8114']=true}

text = {}
text.en = {
	welcome = "<VP>Welcome to the FunCorp room! Stats don't count here.\n<J>DUCK to shoot! (down key)"
}
text.es = {
	welcome = "<VP>¡Bienvenido a la sala FunCorp! Aquí no cuentan los stats."
}

despawnTime = 1000
fireDelay = 250
offsetX = -17
offsetY = 16

commands = {"msg","next","cannons","mice"}
keys = {0,2,3}
_left = 0
_right = 2

facingLeft = {}
toDespawn = {}
fireTS = {}

cannonsEnabled = true
mouseCannons = false
lang = text[tfm.get.room.community] or text.en

function main()
	for _,c in pairs(commands) do
		system.disableChatCommandDisplay(c)
	end
	for n in pairs(tfm.get.room.playerList) do
		eventNewPlayer(n)
	end
end

function eventNewPlayer(name)
	facingLeft[name] = false
	fireTS[name] = 0
	
	for _,k in pairs(keys) do
		system.bindKeyboard(name, k, true)
	end
	
	tfm.exec.chatMessage(lang.welcome, name)
end

function eventLoop(t, tr)
	for i,o in ipairs(toDespawn) do
		if os.time() > o[2]+despawnTime then
			tfm.exec.removeObject (o[1])
			table.remove (toDespawn, i)
		end
	end
end

function eventKeyboard(name, key, down, px, py)
	if key == _left then
		facingLeft[name] = true
	
	elseif key == _right then
		facingLeft[name] = false
	
	elseif key==3 and cannonsEnabled and os.time() > fireTS[name] + fireDelay then
		fireTS[name] = os.time()
		local dx,a,id
		if facingLeft[name] then
			dx,dy,a = -1,0,-90
		else
			dx,dy,a = 1,0,90
		end
		id = tfm.exec.addShamanObject(17, px+(offsetX*dx), py+offsetY, a)
		table.insert(toDespawn, {id, os.time()})
		if mouseCannons then
			tfm.exec.addImage("153d3352946.png", "#"..id, -37, -19)
			--tfm.exec.addImage("153a43d39b8.png", "#"..id, -14, -13)
		end
	end
end

function eventChatCommand(name, mes)
	if admins[name] then
		if mes:sub(1,3) == "msg" then
			tfm.exec.chatMessage("<font color='#ff8547'>[FunCorp] "..mes:sub(5).."</font>", nil)
		elseif mes == "next" then
			tfm.exec.newGame()
		elseif mes == "cannons" then
			cannonsEnabled = not cannonsEnabled
			local t = cannonsEnabled and "<VP>Cannons enabled" or "<R>Cannons disabled"
			tfm.exec.chatMessage(t, name)
		elseif mes == "mice" then
			mouseCannons = not mouseCannons
			local t = mouseCannons and "<VP>Mouse skin enabled" or "<R>Mouse skin disabled"
			tfm.exec.chatMessage(t, name)
		end
	end
end

main()
