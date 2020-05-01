requests = {}

ui.addTextArea(144, "", nil, 20, 40, 360, 300, 0x000001, 0x000000, 0.8, true)
ui.addTextArea(10, "", nil, 350, 40, 30, 300, 0x000001, 0x000000, 1, true)
ui.addTextArea(2, "<font size='20'><V><p align='center'><b>Requests</b></p></V></font>", nil, 20, 40, 360, 30, 0x000001, 0x000000, 1, true)
ui.addTextArea(1, "<V><p align='center'><a href='event:reqMenu'>make a request</a></p></V>", nil, 685, 380, 100, 100, 0x000001, 0x000000, 0.8, true)

for i=1,23 do ui.addTextArea(10+i, "<font face='Lucida Console'><p align='center'><VP><a href='event:itemAccept"..i.."'>✔</VP><R><a href='event:itemDeny"..i.."'>❌</a></R></p></font>", nil, 350, 66+(i*11), 30, 14, 0x000000, 0x000000, 1, true) end
for i=1,23 do ui.addTextArea(144+i, "<font face='Lucida Console'><BL>123456789012345678901234567890123456789012345</font>", nil, 20, 66+(i*11), 320, 15, 0x000000, 0x000000, 1, true) end



