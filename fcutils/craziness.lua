players={}

function eventNewPlayer(name)
	players[#players+1]=name
end

table.foreach(tfm.get.room.playerList,eventNewPlayer)

function eventLoop()
	for i=1,4 do
		tfm.exec.changePlayerSize(players[math.random(#players)],math.random(0.1,5))
	end
end
