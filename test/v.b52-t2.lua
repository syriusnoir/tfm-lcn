-- "Vēsture" [[v1 - oriģināls|v2 - survival sakne|v3 - !spawn koordinātu pieejamība|v4 - !bc, !bc*, !utilcore, !utilcore*|v5 - survival pabeigts|v6 - beznaglu sakne|v7 - !r, !r*|v8 - ne-dalībnieku blokāde|v9 - kļūdu reorganizācija|v10 - !md|v11 - !md*|v12 - !cname, !host, !kill|v13 - !txt, !g|v14 - utilcore palaidējs|v15 - !txt*|v16 - !rhost|v17 - !g*|v18 - !col|v19 - !s*|v20 - !cmode, !size|v21 - !ce,!ce*|v22 - !np|v23 - !meep|v24 - !rmtxt|v25 - !score, all: !s, !kill, !r, !meep, !ce|v26 - jauns interfeiss; !tfm, !tfm*, !link, !link*|v27 - all: !tfm; !hlp kodols|v28 - !hlp uzlabojumi; atjaunināts survival|v29 - !nextmap survival režīmā automātiski parāda raunda ciparu|v30 - karte pagarinās build režīmā atbilstoši spēlētaju skaitam, !clear|v.b32 - HostCore (!hc); 30-sek. challenge kodols; everyoneVerified; !d|v.b33 - HTML iekš !bc* un !utilcore; 30-sekunžu mapēs tagad rādās veidotājs]]

SETUP = {challengemode="build",title="lacrosnostra",autorespawn = false,lang="lv",theme="modern"} 

-- [[LCN: LV, EN, DE]]

version = "v.b52 ~T2"

function errstp() fail = true ui.addTextArea(13000, "", nil, -2600, -2800, 6000, 6000, 0x6a7495, 0x000022, 1, false) ui.addTextArea(13001, "<V>[EN]</V> <A:ACTIVE>Invalid configuration! A SETUP variable has an invalid value or isn't existing.</A:ACTIVE>\n<V>[LV]</V> <A:ACTIVE>Nederīga konfigurācija! Kāds no SETUP mainīgajiem satur nederīgu vērtību vai neeksistē.</A:ACTIVE>", nil, 5, 25, 790, 30, 0x324650, 0x324650, 1, true) ui.addTextArea(13002, "<vp><p align='center'>"..version.."</p></vp>", nil, 5, 380, 790, 20, 0x324650, 0x324650, 1, true) end 
if SETUP == nil then SETUP = {challengemode = "@",lang = "lv",title="lacrosnostra"} errstp() end if SETUP.lsimage==nil then SETUP.lsimage = "16f09800dd9.png" end if SETUP.challengemode == nil or type(SETUP.challengemode) == "boolean" then SETUP.challengemode = "@" errstp() end if SETUP.lang == "lv" or SETUP.lang == "en"  or SETUP.lang == "de" then else SETUP.lang = "lv" errstp() end if SETUP.title == nil or type(SETUP.title) == "boolean" then SETUP.title = "lacrosnostra" errstp() end do    local _, nickname = pcall(nil)    tfm.get.room.owner = string.match(nickname, "(.-)%.")end

player={} helpers={} disq={} spectators={}
hosts={['Syrius#8114'] = true,['Yeet#7143'] = true,[tfm.get.room.owner] = true}
contestants={}
userData={} -- Piezīme Syrius (dist 88, 292)
theme = {modern = {hcHeight = 30,windowHeadingColor = "vi",windowBorderColor = 0x000030,windowColor = 0x000022,highlightedWindowColor = 0x000044,contestSelWindowColor = 0x000033,contestSelWindowBorder = 0x000066,contestSelWindowTransparency = 1,windowColor2 = 0x000022,closeBtnColor = "grbl",startScreenColor = 000022,startScreenGround = 12,bcBackground = 0x000022,bcTransparency = 0.65,bcHeight = 22,bcFontSize = 14,bcWidth = 790,bcX = 5,welcomeScreenColor = 0x000022,welcomeScreenTextColor="BV",welcomeScreenDecoColor="V",welcomeScreenHeadingColor="grbl",commonColor1 = "grbl",commonColor2 = "brp",commonColor3 = "lbrp",commonColor4 = "vi",commonColor5 = "rose",panelCommonItemColor="BV",panelWarningItemColor="warn"},classic = {hcHeight = 30,windowHeadingColor = "rose",windowBorderColor = 0x000000,windowColor = 0x324650,windowColor2 = 0x000001,highlightedWindowColor = 0x324650,contestSelWindowColor = 0x324650,contestSelWindowBorder = 0x000001,contestSelWindowTransparency = 0.5,closeBtnColor = "warn",startScreenColor = 000000,startScreenGround = 12,bcBackground = 0x324650,bcTransparency = 0.5,bcHeight = 30,bcFontSize = 20,bcWidth = 600,bcX = 100,welcomeScreenColor = 0x000001,welcomeScreenTextColor="V",welcomeScreenDecoColor="VP",welcomeScreenHeadingColor="J",commonColor1 = "grbl",commonColor2 = "PT",commonColor3 = "T",commonColor4 = "PS",commonColor5 = "S",panelCommonItemColor="V",panelWarningItemColor="warn"}}
title = "#"..SETUP.title:lower().."LCN " .. SETUP.challengemode

-- Tulkojumi
local t = {lv={[40]=".",[70]="jā",[71]="ieslēgts",[72]="izslēgts",[73]="nē",[80]="<warn>Nav zināms.</warn>",[81]="Bez-naglu challenge",[82]="Divine challenge",[83]="Izdzīvošanas challenge",[84]="Cilts racing",[85]="Defilante sacensības",[86]="30-sekunžu challenge",[87]="Būvdarbu cīņas",[88]="Izaicinājumu izaicinājums",[100]="LCN versija:",[101]="Esi sveicināts #LCN modulī!",[102]="Šis modulis tiek izmantots atvieglotai konkursu uzturēšanai.",[103]="Ja ienāc konkursa vidū, lūdzu izej no ciltsmājas.",[104]="Tūlīt notiks:",[181]="Lai gan ar naglām būvēt ir elementāri, tomēr cik radošs vari būt bez tām? Parādi savas spējas šeit!",[182]="Tavs uzdevums ir izglābt pēc iespējas vairāk peļu vanilla mapēs. Ir tikai viens āķis - tu esi dievišķajā režīmā.",[183]="Turies pie visa iespējamā un esi pēdējais izdzīvojušais - ja vien nenokritīsi...",[184]="Mēs visi zinām veco, labo racing - vismaz cerams... Nu ko, uzmanību... gatavību... STARTS!",[185]="Kas gan notiktu, ja racing apvienotu ar defilante? Sanāktu šis - konkurss, kurā tu defilante mapēs pirmais mēģini nokļūt alā!",[186]="Tev ir dotas īpaši dizainētas mapes, dažas vieglākas, dažas grūtākas, bet, ja nepaspēsi iziet mapi 30 sekundēs - mirsi.",[187]="Kopīga tematika... kopīgi noteikumi... Lai uzvar labākais!",[188]="Tavs mērķis ikreiz ir citāds - vienreiz tas būs īpašas trases iziešana, citreiz varbūt peļu karš vai pat antīku konkursu spēlēšana!",[200]="ir ienācis ciltsmājā.",[201]="Darbojas #LaChallengeNostra.",[202]="Tu neesi cilts eventa dalībnieks/vadītājs.",[203]="Iestatījumi",[204]="Interfeiss",[205]="[noņemt]",[206]="HostCore ieslēgts:",[207]="(nospied •, lai redzētu moduļa informāciju)",[208]="iestatīja krāsu tagu",[209]="TU ESI DISKVALIFICĒTS.",[210]="Konkursa vadītājs ir tevi diskvalificējis.",[211]="Drīksti pamest ciltsmāju.",[212]="ir diskvalificēts.",[213]="tagad pieder konkursa vadītāja statuss.",[214]="tagad pieder konkursa palīga statuss.",[215]="vairs nepieder konkursa vadītāja statuss.",[216]="vairs nepieder konkursa palīga statuss.",[217]="Nederīga komanda vai arī tev nav pietiekamu tiesību tās lietošanai.",[218]="Nederīgs spēles režīms: nomaini SETUP.challengemode uz atbilstošo režīmu.",[219]="pārlādēja mapi.",[220]="kursora koordinātas ir -",[221]="[SISTĒMA]",[222]="Konkursa vadītāj, esi sveicināts šajā moduļa versijā.",[223]="Versija:",[224]="Identifikators:",[225]="ir zaudējis ;(",[226]="ir zaudējis.",[227]="Izdzīvošanas challenge ir sācies!",[228]="Darbojas t.s. <i>survival challenge.</i>",[229]="raunds",[230]="Fināla raunds",[231]="uzvarēja!",[232]="raunds beidzies:",[233]="raunds -",[234]="Bez-naglu challenge ir sācies!",[235]="Vadības panelis atvērts.",[236]="Īsinājumtaustiņi",[237]="NEDERĪGA AUTORIZĀCIJA.",[238]="Šis kods ir paredzēts",[239]="Tu esi diskvalificēts.",[240]="[palīdzība]",[241]="Par",[242]="[aizvērt]",[243]="Veidoja <lbrp>Syrius#8114</font>.",[244]="<br><br>Paldies <lbrp>Sanija#1187</font>, <lbrp>Ertyezz#9819</font>, <lbrp>Acmexitee#0000</font> un citiem cilts <lbrp>La Cros Nostra</font> dalībniekiem par palīdzību moduļa veidošanas gaitā.",[245]="Atdzīvošanās (visi) -",[246]="Notīrīt -",[247]="Paldies par dalību.",[248]="Visi nomira ;(",[249]="Vai esi pārliecināts?",[250]="izgāja no ciltsmājas.",[251]="Ziņa no",[252]="Tulkojums",[253]="Tu nevari diskvalificēt vadītāju/palīgu.",[254]="Diskvalificēt",[255]="Automātiskā mapju ieslēgšana:",[256]="Ir atstāts ieslēgts SETUP.autorespawn!",[257]="Iestatīt lietotājvārda krāsu",[258]="Iestatīt līnijas krāsu",[259]="Definēt krāsu tagu",[260]="Vadītāju iestatījumi",[261]="[mainīt v.p. pozīciju]",[262]="Statuss:",[263]="Komūna:",[264]="Pārsniegts objektu limits! Objekti:",[265]="[infopanelis]",[266]="[vadības panelis]",[267]="Mainīt utilcore caurspīdīgumu",[268]="[mainīt uc. caursp.]",[269]="Iemesls:",[270]="Kļūda",[271]="Ir transformējies:",[272]="Tu esi padarīts par skatītāju.",[273]="Tu nevari padarīt vadītāju par skatītāju!",[274]="[augsta kontrasta uc.]",[275]="Kādu konkursu vadīsi?",[276]="Konkursa vārds",[277]="Konkursa apraksts" ,[278]="Pielāgots",[279]="Pārsniegts barjeru blīvums! Blīvums:",[280]="(apmācību režīms)",[281]="Iestatīt zemes krāsu",[282]="Kāds ir tavs viedoklis par šo konkursu?",[283]="Šis saturs nav pieejams šajā valodā.",[284]="Vadītāji",[285]="Palīgi",[286]="Kļūdu vēsture",[287]="Komandu vēsture",[288]="Darbību vēsture"}, en={[40]="th",[70]="yes",[71]="on",[72]="off",[73]="no",[80]="<warn>Unknown.</warn>",[81]="No nail challenge",[82]="Divine challenge",[83]="Survival challenge",[84]="Tribe's racing",[85]="Defilante race",[86]="30-second challenge",[87]="Builders' Battle",[88]="The Challenge",[100]="LCN version:",[101]="Welcome to #LCN module!",[102]="This module is used to simplify the hosting of contests.",[103]="If you come here in the middle of the contest, please leave the tribe house.",[104]="Will be hosted soon:",[181]="Yes, building with nails is easy, but how creative can you be without them? Show your skills here!",[182]="Your goal is to save as many mice as possible in vanilla maps. But there's a catch - you're in divine mode!",[183]="Hold on to everything you see and be the last survivor... unless you fall...",[184]="We all know racing - at least hopefully... No time to waste, ready... set... GO!",[185]="What would happen, if racing and defilante was merged? This would get made - a contest where mice in defilante maps race to be the first mouse in the hole!",[186]="You've got specially designed maps, some easier, some harder, but if you will not complete map in 30 seconds - you'll die.",[187]="Everyone has the same theme, the same rules... May the best builder win!",[188]="Your goal is different every time - one time it will be winning in a custom map, other time maybe a mice war or even participation in legacy contests!",[200]="entered the tribe house.",[201]="#LaChallengeNostra is active.",[202]="You aren't a contestant or a host.",[203]="Settings",[204]="Interface",[205]="[remove]",[206]="HostCore enabled:",[207]="(press • to see the info panel)",[208]="has set color tag",[209]="YOU ARE DISQUALIFIED.",[210]="A host has disqualified you.",[211]="You may leave the tribe house.",[212]="has been disqualified.",[213]="is now a host.",[214]="is now a helper.",[215]="is no longer a host.",[216]="is no longer a helper.",[217]="Invalid command or you have insufficient permissions to use it.",[218]="Invalid game mode: change SETUP.challengemode to the corresponding mode.",[219]="reloaded the map.",[220]="'s pointer's coordinates are -",[221]="[SYSTEM]",[222]="Host, welcome to this version of the module.",[223]="Version:",[224]="Identificator:",[225]="died ;(",[226]="died.",[227]="Survival challenge has begun!",[228]="<i>Survival challenge</i> is active.",[229]="round",[230]="Final round",[231]="won!",[232]="round has ended:",[233]="round -",[234]="No nail challenge has begun!",[235]="Control panel has been opened.", [236]="Keybinds", [237]="INVALID AUTHENTICATION.",[238]="This code is intended for",[239]="You are disqualified.",[240]="[help]",[241]="About",[242]="[close]",[243]="Created by <lbrp>Syrius#8114</font>.",[244]="<br><br>Thanks to <lbrp>Sanija#1187</font>, <lbrp>Ertyezz#9819</font>, <lbrp>Acmexitee#0000</font> and other members of the tribe <lbrp>La Cros Nostra</font> for help in the module's development.",[245]="Respawn (all) -",[246]="Clear -",[247]="<font size='50'>Thanks for participation.",[248]="Everyone died ;(",[249]="Are you sure?",[250]="left the tribehouse.",[251]="A message from",[252]="Translation",[253]="You can't disqualify a host or a helper.",[254]="Disqualify",[255]="Map autoplay:",[256]="SETUP.autorespawn is left on!",[257]="Set username color",[258]="Set line color",[259]="Define color tag",[260]="Host settings",[261]="[change c.p. position]",[262]="Role:",[263]="Community:",[264]="Object limit exceeded! Objects:",[265]=" [info]",[266]="[control panel]",[267]="Change utilcore transparency",[268]="[change uc. transp.]",[269]="Reason:",[270]="Error",[271]="Is transformed:",[272]="You are a spectator now.",[273]="You can't make a host a spectator!",[274]="[high contrast uc.]",[275]="What are you going to host?",[276]="Contest name",[277]="Contest description" ,[278]="Custom",[279]="Barrier density exceeded! Density:",[280]="(training mode)",[281]="Set ground color",[282]="What's your feedback about this contest?",[283]="This feature is not available in this language.",[284]="Hosts",[285]="Helpers",[286]="Error log",[287]="Command log",[288]="Action log"}, de={[40]=".",[70]="ja",[71]="auf",[72]="aus",[73]="nein",[80]="<warn>Nicht bekannt.</warn>",[81]="Ohne Nagel Herausforderung",[82]="Göttlicher Modus Herausforderung",[83]="Überlebens Herausforderung",[84]="Stamm racing",[85]="Defilante Herausforderung",[86]="30-Sekunden Herausforderung",[87]="Bauschlachten",[88]="Die Herausforderung",[100]="LCN version:",[101]="Willkommen zum #LCN Modul!",[102]="Dieses Modul dient zur Pflege von Wettbeverben.",[103]="Wenn Sie mitten im Wettbeverb hereinkommen, bitte verlassen Sie das Stammeshaus.",[104]="Gleich passiert:",[181]="Obwohl Bauen mit Nägeln einfach ist, wie kreativ kannst du ohne Nägel sein? Zeig hier was du Kannst!",[182]="Dein Ziel ist es, so viele Mäuse wie möglich in Vanillekarten zu retten. Aber es gibt einen Haken - du bist im göttlichen Modus!",[183]="Halte an allem fest, was du siest, und sei der letzte Überlebende - es sei denn, du fällst ...",[184]="Wir alle kennen den guten, alten Racing - zumindest hoffentlich ... Nun, Aufmerksamkeit ... Bereitschaft ... START!",[185]="Was würde passieren, wenn racing mit defilante kombiniert würde? Dies würde gemacht werden - ein Wettbewerb, bei dem Mäuse in defilante Karten versuchen, die erste in der Höhle zu sein!",[186]="Du hast speziell gestaltete Karten, einige einfacher, andere schwieriger, aber wenn du die Karte nicht in 30 Sekunden fertigstellen - stribst du.",[187]="Jeder hat das gleiche Thema... die gleichen Regeln ... Möge der beste Baumeister gewinnen!",[188]="Dein Ziel ist jedes Mal anders - einmal wird es eine schwierige Karte gewinnen sein, ein anderes Mal vielleicht ein Mäusekrieg oder sogar die Teilnahme an früheren Wettbewerben sein!",[200]="betrat das Stammeshaus.",[201]="#LaChallengeNostra ist aktiv.",[202]="Sie sind kein Teilnehmer oder Anführer des Stammesereignesses.",[203]="Einstellungen",[204]="Schnittstelle",[205]="[entfernen]",[206]="HostCore auf:",[207]="(Drück • um die Moduldetails zu sehen)",[208]="hat den Farbetikett eingestellen",[209]="DU BIST DISQUALIFIZIERT.",[210]="Der Wettbewerbs Anführer hat Sie disqualifiziert.",[211]="Du kannst das Stammeshaus verlassen.",[212]="wurde disqualifiziert.",[213]="hat jetzt den Status eines Wettbewerb Anführers.",[214]="hat jetzt den Status eines Wettbeverbasissten.",[215]="hat nicht mehr den Status eines Wettbewerb Anführers.",[216]="hat nicht mehr den Status eines Wettbeverbasissten.",[217]="Ungültiges commando oder Sie haben nicht genügend Rechte um es auszuführen.",[218]="Ungültiger Spielemodus: Ändern Sie den SETUP.challengemode in den entsprechenden Modus.",[219]="hat die mape neu gestartet.",[220]="'s Cursor Koordinaten sind -",[221]="[SYSTEM]",[222]="Anführer des Wettbewerbs, willkommen zu dieser Version des Moduls.",[223]="Version:",[224]="Identifikator:",[225]="ist gestorben ;(",[226]="ist gestorben.",[227]="Überlebens Herausforderung hat begonnen!",[228]="<i>Überlebens Herausforderung</i> ist aktiv.",[229]="runde",[230]="Letzte runde",[231]="hat gewonnen!",[232]="runde hat geendet:",[233]="runde -",[234]="Die Ohne Nagel Herausforderung hat begonnen!",[235]="Systemsteuerung wurde geöffnet.",[237]="UNGÜLTIGE AUTORISIERUNG.",[238]="Dieser Code ist für",[239]="Du bist disqualifiziert.",[240]="[hilfe]",[241]="Über",[242]="[schließen]",[243]="Erstellt von <lbrp>Syrius#8114</font>.",[244]="<br><br>Danke an <lbrp>Sanija#1187</font>, <lbrp>Ertyezz#9819</font>, <lbrp>Acmexitee#0000</font> und andere Stamm <lbrp>La Cros Nostra</font> Teilnehmer für der Unterstützung beim Aufbau des Moduls.",[245]=" Wiederbelebung (alle) -",[246]="Löschen -",[247]="<font size='50'>Vielen Dank für Ihre Teilnahme.",[248]="Alle sind gestorben ;(",[249]="Bist du dir sicher?",[250]="hat das Stammeshaus verlassen.",[251]="Eine Nachricht von",[252]="Übersetzung",[253]="Sie können einen Anführer oder Assistenten nicht disqualifizieren.",[254]="Disqualifizieren",[255]="Karten Autoplay:",[256]="SETUP.autorespawn ist aufgeblieben!",[257]="Benutzernamfarbe einstellen",[258]="Linienfarbe einstellen",[259]="Farbetikett definieren",[260]="Anführer Einstellungen",[261]="[s.s. Position ändern]",[262]="Status:",[263]="Gemeinshaft:",[264]="Objekt Limit überschritten! Objekte:",[265]="[infopanel]",[266]="[Systemsteuerung]",[267]="Die Ulticore-Transparenz ändern",[268]="[die Uc. Transp. ändern]",[269]="Grund:",[270]="Fehler",[271]="Hat sich verwandelt:",[272]="Du bist jetzt ein Zuschauer.",[273]="Sie können einen Anführer nicht zum Zuschauer Machen!",[274]="[hoher Kontrast uc.]",[275]="Welchen Wettbewerb wirst du anführen?",[276]="Wettbewerb name",[277]="Wettbewerb beschreibung" ,[278]="Angepasst",[279]="Barrierendichte überschritten! Dichte:",[280]="(Trainingsmods)",[281]="Erdfarbe einstellen",[282]="Was ist deine Meinung über diesem Wettbewerb?",[283]="Diese Funktion ist in dieser Sprache nicht verfügbar.",[284]="Anführer",[285]="Assistent",[286]="Fehlergeschichte",[287]="Kommandogeschichte",[288]="Aktiongeschichte"}}
local trans = t[tfm.get.room.community] or t[SETUP.lang]

cmdlog = ""
-- Paziņot
function annonce_log(input)
	if string.len(cmdlog) > 1900 then cmdlog = "" end
	cmdlog = input .. "\n" .. cmdlog
	ui.updateTextArea(54, cmdlog, nil)
end
function annonce(text)
	print(text)
	ui.updateTextArea(65,text,nil)
	annonce_log(text)
end
function annonce2(text)
	print(text)
	ui.updateTextArea(64,text,nil)
	annonce_log(text)
end

-- Dizainu konfigurācija
theme.oldclassic = setmetatable({startScreenGround = 5,bcTransparency = 0.2,bcHeight = 55,bcFontSize = 40,bcWidth = 750,bcX = 25}, {__index=theme.classic})
SETUP.theme = SETUP.theme or "modern"

-- Prefiksi
syscore = "<ROSE><b>"..trans[221].."</b>"
infpref = "<"..theme[SETUP.theme].commonColor2.."><b>[<a href='event:hostmenu'>•</a>]</b><"..theme[SETUP.theme].commonColor3.."> "
miscpref = "<"..theme[SETUP.theme].commonColor4.."><b>[–]</b><"..theme[SETUP.theme].commonColor5.."> "

local colqueue

-- customcolortag bibliotēka
local setColorTag do local colors = {} setColorTag = function(tag, color) assert(tag, "Missing tag.") assert(color, "Missing color.") if type(color) == "number" then color = string.format("#%06x", color) else color = tostring(color) if not string.find(color, '#') then color = "#" .. color end end tag = tostring(tag) if not string.find(tag, "^<.->$") then tag = "<" .. tag .. ">" end colors[#colors + 1] = { tag = tag, color = color } end local putColors = function(str) for i = 1, #colors do str = string.gsub(str, colors[i].tag, "<font color=\"" .. colors[i].color .. "\">") end return str end local addTextArea, updateTextArea, chatMessage, p = ui.addTextArea, ui.updateTextArea, tfm.exec.chatMessage, print ui.addTextArea = function(id, str, ...) return addTextArea(id, putColors(str), ...) end ui.updateTextArea = function(id, str, ...) return updateTextArea(id, putColors(str), ...) end tfm.exec.chatMessage = function(str, ...) return chatMessage(putColors(str), ...) end print = function(str) return p(putColors(str)) end end
setColorTag("warn", 0xeb1d51) setColorTag("purp", 0x8A2BE2) setColorTag("grbl",0x84b7d1) setColorTag("lgrbl",0x84a7f1) setColorTag("brp", 0x6e6eff) setColorTag("lbrp", 0xb3b3ff) setColorTag("black", 0x000001)

-- Noklusējuma iestatījumi
function startMap() tfm.exec.newGame('<C><P DS="m;200,170" APS="'..SETUP.lsimage..',0,0,0,0,100,50,40" /><Z><S><S P="0,0,0.3,0.2,0,0,0,0" X="0" L="3000" o="'..theme[SETUP.theme].startScreenColor..'" H="3000" c="4" Y="0" T="'..theme[SETUP.theme].startScreenGround..'" /><S P="0,0,0.3,0.2,0,0,0,0" L="40" o="'..theme[SETUP.theme].startScreenColor..'" H="10" X="200" Y="240" T="12" /><S P="0,0,0.3,0.2,90,0,0,0" L="40" o="'..theme[SETUP.theme].startScreenColor..'" H="10" X="215" Y="225" T="12" /><S P="0,0,0.3,0.2,90,0,0,0" L="40" o="000022" H="10" X="2500" Y="225" T="12" /><S P="0,0,0.3,0.2,90,0,0,0" L="40" o="'..theme[SETUP.theme].startScreenColor..'" H="10" X="185" Y="225" T="12" /><S P="0,0,0.3,0.2,0,0,0,0" L="40" o="'..theme[SETUP.theme].startScreenColor..'" H="10" X="200" Y="210" T="12" /></S><D><DS Y="225" X="200" /></D><O /></Z></C>') 
end
startMap()
tfm.exec.setUIMapName("<ROSE>"..version.."")
ui.addTextArea(0, "<p align='center'><font size='"..theme[SETUP.theme].bcFontSize.."'><rose>"..title.."</font></p>",nil,theme[SETUP.theme].bcX, 25, theme[SETUP.theme].bcWidth, theme[SETUP.theme].bcHeight, theme[SETUP.theme].bcBackground, theme[SETUP.theme].windowBorderColor, theme[SETUP.theme].bcTransparency, true)
tfm.exec.disableAutoShaman(true)
tfm.exec.disableAfkDeath(true)
tfm.exec.disableAutoScore(true)
tfm.exec.disableAutoNewGame(true)
tfm.exec.disableMortCommand(true)
math.randomseed(os.time())

-- Apmācību režīms
tclog = "" errlog = ""
function exectrcore(name)
ui.addTextArea(51, "", name, 297, 64, 500, 20, 0x324650, 0x000000, 0, true)
ui.addTextArea(50, "", name, 296, 63, 500, 20, 0x324650, 0x000000, 0, true)
end

function trainingcore(executor,action)
ui.updateTextArea(51, "<p align='right'><black><b>[@"..tostring(executor).."]</b> "..tostring(action).."</black></p>", nil)
ui.updateTextArea(50, "<p align='right'><"..userData[executor].ncol.."><b>[@"..tostring(executor).."]</"..userData[executor].ncol.."></b><A:ACTIVE> "..tostring(action).."</A:ACTIVE></p>", nil)
if string.len(tclog) > 1900 then tclog = "" end
tclog = "<p align='left'><"..userData[executor].ncol.."><b>[@"..tostring(executor).."]</"..userData[executor].ncol.."></b><A:ACTIVE> "..tostring(action).."</A:ACTIVE></p>\n" .. tclog
ui.updateTextArea(52, tclog, nil)
if SETUP.logcallbacks == true then print("<"..userData[executor].ncol.."><b>[@"..tostring(executor).."]</"..userData[executor].ncol.."></font></b><A:ACTIVE> "..tostring(action).."</A:ACTIVE>") end
end

-- UtilCore
function utilcore(name)
	for name,player in pairs(tfm.get.room.playerList) do
		ui.addTextArea(33, "",name, 6, 379, 790, 27, 0x000022, 0x000022, 0, true)
		ui.addTextArea(32, "",name, 5, 378, 790, 27, 0x000022, 0x000022, 0, true)
	end
end

-- Automātiska ziņojuma parādīšanās
function eventNewPlayer(name)
	utilcore(name)
	if SETUP.nocontrast == true then ui.removeTextArea(33,name) end
	contestants[name] = true
	userData[name] = {
		lang = tfm.get.room.playerList[name].community,
		role = "default",
		id = tfm.get.room.playerList[name].id,
		ncol = "n2",
		uctrans = 0,
		tfm = false,
		showactionbuffer = false,
		showerrorbuffer = false,
		showcmdbuffer = false,
		hc = false,
		hc_tabbed = false,
		hipstate = SETUP.panelpos or 1,
		visualScoreboard = false
	}
	annonce(miscpref..name.." "..trans[200])
	if hosts[name] then userData[name].role = "host" userData[name].ncol = "rose" end
	if helpers[name] then userData[name].role = "helper" userData[name].ncol = "o" end
	if hosts[name] or contestants[name] then
		ui.addTextArea(8880, "<"..theme[SETUP.theme].welcomeScreenTextColor..">"..trans[100].."</"..theme[SETUP.theme].welcomeScreenTextColor.."></font> <"..theme[SETUP.theme].welcomeScreenHeadingColor..">"..version.."</"..theme[SETUP.theme].welcomeScreenTextColor.."></font>\n\n<font size='14'><"..theme[SETUP.theme].welcomeScreenDecoColor.."><font face='Wingdings 3'>u</font></"..theme[SETUP.theme].welcomeScreenDecoColor.."><"..theme[SETUP.theme].welcomeScreenHeadingColor.."> "..trans[101].."</"..theme[SETUP.theme].welcomeScreenHeadingColor.."></font></font>\n\n<"..theme[SETUP.theme].welcomeScreenTextColor..">"..trans[102].."\n"..trans[103].."</font>\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n<rose><p align='right'><a href='event:user.nowelcome'>"..trans[242], name, 440, 80, 340, 330, theme[SETUP.theme].welcomeScreenColor, theme[SETUP.theme].windowBorderColor, 1, true)
		ui.addTextArea(8881, "", name, 440, 190, 340, 100, theme[SETUP.theme].welcomeScreenColor, theme[SETUP.theme].windowBorderColor, 1, true)
		if name == tfm.get.room.owner then
			startmenu(name)
		end
		tfm.exec.setPlayerScore(name,0)
	elseif not contestants[name] or not hosts[name] then
	--	ui.addTextArea(100, trans[80], name, -600, -200, 2400, 1200, 0x000001, 0x000001, 1, true)
	--	ui.addTextArea(101, "<ROSE><font size='40'><p align='center'>"..trans[201].."</p></font>\n<A:ACTIVE><font size='24'><p align='center'>"..trans[202].."</p></font>", name, 0, 20, 800, 384, 0x324650, 0x000000, 0, true)
	--	tfm.exec.killPlayer(name)
	--	tfm.exec.setPlayerScore(name,-32767)
	end
		system.bindKeyboard(name, 69, false, true)
	for i=187,192 do
		system.bindKeyboard(name, i, false, true)
	end
	for i=0,192 do
		system.bindKeyboard(name, i, true, true)
	end
	for i=9,17 do
		system.bindKeyboard(name, i, false, true)
	end
  system.bindMouse(name, true)
end
-- Testēšana

-- Starta izvēlne hostiem
local startmenuy = 200
function startmenu(name)
	if SETUP.challengemode == "survival" then
		ui.addTextArea(8888, "<"..theme[SETUP.theme].welcomeScreenHeadingColor.."><font size='14'><v><font face='Webdings'>@</font></v> "..trans[275].."</font></"..theme[SETUP.theme].welcomeScreenHeadingColor.."></font>\n\n<bv><li><a href='event:cn.survival'>"..trans[83].."</a></li><li><a href='event:cn.iziz'>"..trans[88].."</li><li><a href='event:cn.custom'>"..trans[278].."</li>\n</bv>\n\n", name, 440, startmenuy, 340, 100, theme[SETUP.theme].contestSelWindowColor, theme[SETUP.theme].contestSelWindowBorder, theme[SETUP.theme].contestSelWindowTransparency, true)
	end
	if SETUP.challengemode == "vanilla" then
		ui.addTextArea(8888, "<"..theme[SETUP.theme].welcomeScreenHeadingColor.."><font size='14'><v><font face='Webdings'>@</font></v> "..trans[275].."</font></"..theme[SETUP.theme].welcomeScreenHeadingColor.."></font>\n\n<bv><li><a href='event:cn.nonail'>"..trans[81].."</a></li><li><a href='event:cn.divine'>"..trans[82].."</a></li><li><a href='event:cn.iziz'>"..trans[88].."</li><li><a href='event:cn.custom'>"..trans[278].."</li>\n</bv>\n\n", name, 440, startmenuy, 340, 100, theme[SETUP.theme].contestSelWindowColor, theme[SETUP.theme].contestSelWindowBorder, theme[SETUP.theme].contestSelWindowTransparency, true)
	end
	if SETUP.challengemode == "pkg" then
		ui.addTextArea(8888, "<"..theme[SETUP.theme].welcomeScreenHeadingColor.."><font size='14'><v><font face='Webdings'>@</font></v> "..trans[275].."</font></"..theme[SETUP.theme].welcomeScreenHeadingColor.."></font>\n\n<bv><li><a href='event:cn.racing'>"..trans[84].."</a></li><li><a href='event:cn.defilante'>"..trans[85].."</a></li><li><a href='event:cn.iziz'>"..trans[88].."</li><li><a href='event:cn.custom'>"..trans[278].."</li>\n</bv>\n\n", name, 440, startmenuy, 340, 100, theme[SETUP.theme].contestSelWindowColor, theme[SETUP.theme].contestSelWindowBorder, theme[SETUP.theme].contestSelWindowTransparency, true)
	end
	if SETUP.challengemode == "build" then
		ui.addTextArea(8888, "<font size='14'><"..theme[SETUP.theme].welcomeScreenDecoColor.."><font face='Webdings'>@</font></"..theme[SETUP.theme].welcomeScreenDecoColor.."><"..theme[SETUP.theme].welcomeScreenHeadingColor.."> "..trans[275].."</"..theme[SETUP.theme].welcomeScreenHeadingColor.."></font></font>\n\n<"..theme[SETUP.theme].welcomeScreenTextColor.."><li><a href='event:cn.build'>"..trans[87].."</a></li><li><a href='event:cn.iziz'>"..trans[88].."</li><li><a href='event:cn.custom'>"..trans[278].."</li>\n</"..theme[SETUP.theme].welcomeScreenTextColor..">\n\n", name, 440, startmenuy, 340, 100, theme[SETUP.theme].contestSelWindowColor, theme[SETUP.theme].contestSelWindowBorder, theme[SETUP.theme].contestSelWindowTransparency, true)
	end
	if SETUP.challengemode == "thirty" then
		ui.addTextArea(8888, "<"..theme[SETUP.theme].welcomeScreenHeadingColor.."><font size='14'><v><font face='Webdings'>@</font></v> "..trans[275].."</font></"..theme[SETUP.theme].welcomeScreenHeadingColor.."></font>\n\n<bv><li><a href='event:cn.thirty'>"..trans[86].."</a></li><li><a href='event:cn.iziz'>"..trans[88].."</li><li><a href='event:cn.custom'>"..trans[278].."</li>\n</bv>\n\n", name, 440, startmenuy, 340, 100, theme[SETUP.theme].contestSelWindowColor, theme[SETUP.theme].contestSelWindowBorder, theme[SETUP.theme].contestSelWindowTransparency, true)
	end
end


settingState = {respawn="v",clear="v"}

-- Fatāla kļūda
if fail==true then for i=0,9000 do ui.removeTextArea(i,nil) end end
-- Definīciju krātuves

tp = {} 
replaceobj = {}

-- Errlog
function errbuf(output)
if string.len(errlog) > 1900 then errlog = "" end
errlog = output .. "\n" .. errlog
ui.updateTextArea(53, errlog, nil)
end

-- Infopanelis

infodata={setup="",misc=""}
function hostinfo(mode,target)
		trainingcore(target,"hostcore:about;"..tostring(mode))
		infodata.setup=""
		ui.addTextArea(600, "", target, -3695, -1847, 8192, 4096, theme[SETUP.theme].windowColor2, theme[SETUP.theme].windowColor2, 1, true)
		ui.addTextArea(603, "", target, -803, -953, 8192, 1000, theme[SETUP.theme].highlightedWindowColor, theme[SETUP.theme].highlightedWindowColor, 1, true)
	if mode==0 then --par
		ui.addTextArea(602, "<font size='16'><"..theme[SETUP.theme].windowHeadingColor.."><b>"..trans[241].."</b></"..theme[SETUP.theme].windowHeadingColor.."></font>\n___________________________\n\n<BV>Veidoja <CH>Syrius#8114</CH>.\n\nPaldies <CH>Yeet#7143</CH>, <CH>Creativemice#7925</CH>, <CH>Sanija#1187</CH>, <CH>Acmexitee#0000</CH> un citiem cilts <CH>La Cros Nostra</CH> dalībniekiem par palīdzību moduļa veidošanas gaitā.\n\n</BV>", target, 275, 100, 250, 200, 0x000022, 0x000022, 0, true)
		ui.addTextArea(604, "<ROSE><p align='left'><b><grbl><font face='Webdings'>i</font> par</font></b></a> <vi>|</vi> <a href='event:setupinf'><font face='Webdings'>@</font> tehniskā informācija</a></p> ", target, 8, 25, 300, 20, 0x000022, 0x000022, 0, true)
		ui.addTextArea(601, "<ROSE><p align='right'><a href='event:infclose'><font face='Wingdings 3'>|</font> atpakaļ</a></p>", target, 656, 27, 140, 20, 0x000022, 0x000022, 0, true)
	end
	if mode==1 then --tehniskā informācija
		for k,v in next,SETUP do infodata.setup = infodata.setup.."\n<BV>"..tostring(k)..": <D>"..tostring(v) end
		ui.addTextArea(602, "<font size='16'><"..theme[SETUP.theme].windowHeadingColor.."><b>SETUP</b></"..theme[SETUP.theme].windowHeadingColor.."></font>\n___________________________\n</BV>"..infodata.setup, target, 275, 100, 250, 200, 0x000022, 0x000022, 0, true)
		ui.addTextArea(604, "<ROSE><p align='left'><a href='event:getInfo'><font face='Webdings'>i</font> par</a> <vi>|</vi> <b><grbl><font face='Webdings'>@</font> tehniskā informācija</b></font></p> ", target, 8, 25, 300, 20, 0x000022, 0x000022, 0, true)
		ui.addTextArea(601, "<ROSE><p align='right'><a href='event:infclose'><font face='Wingdings 3'>|</font> atpakaļ</a></p>", target, 656, 27, 140, 20, 0x000022, 0x000022, 0, true)
	end
end
-- Profils
function profile(target,executor)
ui.addTextArea(288, "<font size='16'><grbl><a href='event:pr.cls'>X</a></font> <"..theme[SETUP.theme].windowHeadingColor.."><b>"..tostring(target).."</b></"..theme[SETUP.theme].windowHeadingColor.."></font></font>\n___________________________\n\n<BV>"..tostring(trans[263]).."</BV> <CS>"..tostring(userData[target].lang).."</CS>\n<BV>"..tostring(trans[262]).."</BV> <CS>"..tostring(userData[target].role).."</CS>\n<BV>ID:</BV> <CS>"..tostring(userData[target].id).."</CS>\n<BV>"..tostring(trans[271]).."</BV> <CS>"..tostring(userData[target].tfm).."</CS>", executor, 300, 110, 200, 180, 0x000022, 0x000022, 0.6, true) 
end

-- Hostcore log
selmenu = {[-1]="<vi><p align='center'><font size='3'> \n</font><font size='14'>[<a href='event:hc.errorlog'><rose>"..trans[286].."</rose></a> | <a href='event:hc.commandlog'><rose>"..trans[287].."</rose></a> | <a href='event:hc.actionlog'><rose>"..trans[288].."</rose></a>]</font></p></vi>",[0]="<vi><p align='center'><font size='3'> \n</font><font size='14'>[<a href='event:hc.errorlog'><rose>"..trans[286].."</rose></a> | <a href='event:hc.commandlog'><rose>"..trans[287].."</rose></a> | <a href='event:hc.actionlog'><b><grbl>"..trans[288].."</font></b></a>]</font></p></vi>",[1]="<vi><p align='center'><font size='3'> \n</font><font size='14'>[<a href='event:hc.errorlog'><b><grbl>"..trans[286].."</font></b></a> | <a href='event:hc.commandlog'><rose>"..trans[287].."</rose></a> | <a href='event:hc.actionlog'><rose>"..trans[288].."</rose></b></a>]</font></p></vi>",[2]="<vi><p align='center'><font size='3'> \n</font><font size='14'>[<a href='event:hc.errorlog'><rose>"..trans[286].."</rose></a> | <a href='event:hc.commandlog'><b><grbl>"..trans[287].."</font></b></a> | <a href='event:hc.actionlog'><rose>"..trans[288].."</rose></b></a>]</font></p></vi>"}

function showbuffer(mode,name) -- -1=hctabview,0=actionlog,1=errorlog,2=commandlog
	if mode==-1 and hosts[name] then 
		userData[name].hc_tabbed = true
		ui.removeTextArea(65,name) 
		ui.removeTextArea(64,name) 
		ui.updateTextArea(10,selmenu[-1],name) 
	end
	if mode==0 and hosts[name] and userData[name].hc == true then 
		if userData[name].showactionbuffer == false then 
			ui.addTextArea(52, tclog, name, theme[SETUP.theme].bcX, 64, 0, 0, 0x324650, 0x000000, 0, true) 
			ui.removeTextArea(50,name) 
			ui.removeTextArea(51,name) 
			ui.removeTextArea(53,name) 
			ui.removeTextArea(54,name) 
			userData[name].showactionbuffer = true 
			userData[name].showerrorbuffer = false 
			userData[name].showcmdbuffer = false 
			if userData[name].hc_tabbed==true then 
				ui.updateTextArea(10,selmenu[0],name) 
			end
		elseif userData[name].showactionbuffer == true then
			ui.removeTextArea(52,name) 
			if userData[name].hc_tabbed~=true then 
				exectrcore(name) 
			end
			userData[name].showactionbuffer = false 
			if userData[name].hc_tabbed==true then 
				ui.updateTextArea(10,selmenu[-1],name) 
			end
		end
	end
	if mode==1 and hosts[name] and userData[name].hc == true then 
		if userData[name].showerrorbuffer == false then 
			ui.addTextArea(53, errlog, name, theme[SETUP.theme].bcX, 64, 0, 0, 0x324650, 0x000000, 0, true) 
			ui.removeTextArea(52,name) 
			ui.removeTextArea(54,name) 
			userData[name].showcmdbuffer = false 
			userData[name].showactionbuffer = false 
			userData[name].showerrorbuffer = true
			if userData[name].hc_tabbed==true then 
				ui.updateTextArea(10,selmenu[1],name) 
			end
		elseif userData[name].showerrorbuffer == true then 
			ui.removeTextArea(53,name) 
			userData[name].showerrorbuffer = false 
			if userData[name].hc_tabbed==true then 
				ui.updateTextArea(10,selmenu[-1],name) 
			end
		end
	end
	if mode==2 and hosts[name] and userData[name].hc == true then 
		if userData[name].showcmdbuffer == false then 
			ui.addTextArea(54, cmdlog, name, theme[SETUP.theme].bcX, 64, 0, 0, 0x324650, 0x000000, 0, true) 
			ui.removeTextArea(53,name) 
			ui.removeTextArea(52,name) 
			userData[name].showcmdbuffer = true 
			userData[name].showactionbuffer = false 
			userData[name].showerrorbuffer = false 
			if userData[name].hc_tabbed==true then 
				ui.updateTextArea(10,selmenu[2],name) 
			end
		elseif userData[name].showcmdbuffer == true then 
			ui.removeTextArea(54,name) 
			userData[name].showcmdbuffer = false 
			if userData[name].hc_tabbed==true then 
				ui.updateTextArea(10,selmenu[-1],name) 
			end
		end
	end
end

-- Komandas
function eventChatCommand(name,cmd)
if cmd== cmd then annonce("<"..userData[name].ncol.."><b>[~"..name.."]</b></"..userData[name].ncol.."> <A:ACTIVE>!"..cmd) end
if cmd:sub(1,1) == "s" and hosts[name] or helpers[name] and cmd:sub(1,1) == "s" then tfm.exec.setShaman(cmd:sub(3)) end
if cmd:sub(1,2) == "ce" and hosts[name] or helpers[name] and cmd:sub(1,1) == "ce" then tfm.exec.giveCheese(cmd:sub(4)) end
if cmd:sub(1,3) == "ce*" and hosts[name] or helpers[name] and cmd:sub(1,3) == "ce*" then tfm.exec.removeCheese(cmd:sub(5)) end
if cmd:sub(1,1) == "r" and hosts[name] or helpers[name] and cmd:sub(1,1) == "r" then tfm.exec.respawnPlayer(cmd:sub(3)) end
if cmd:sub(1,2) == "bc" and hosts[name] or helpers[name] and cmd:sub(1,2) == "bc" then ui.updateTextArea(0,"<A:ACTIVE>"..cmd:sub(4),nil) end
if cmd:sub(1,3) == "bc*" and hosts[name] then ui.updateTextArea(0,"<VP>"..string.gsub(string.gsub(cmd:sub(5), "&gt;", ">"), "&lt;", "<"),nil) end
if cmd:sub(1,3) == "end" and hosts[name] then startMap() 		ui.addTextArea(8880, "<brp><font size='70'>"..trans[247], nil, 440, 80, 340, 330, 0x000000, 0x000000, 1, true) end
if cmd:sub(1,4) == "end*" and hosts[name] then startMap() 		ui.addTextArea(8880, "<brp><font size='70'>"..trans[247], nil, 440, 80, 340, 330, 0x000000, 0x000000, 1, true) ui.addPopup(404, 2, "<p align='center'>"..trans[282].."</p>", nil, 10, 310, 250, true) end
if cmd:sub(1,4) == "kill" and hosts[name] then tfm.exec.killPlayer(cmd:sub(6)) end
if cmd:sub(1,4) == "test" and hosts[name] then test() end
if cmd:sub(1,5) == "sname" and hosts[name] then ui.setShamanName(string.gsub(string.gsub(cmd:sub(7), "&gt;", ">"), "&lt;", "<")) end
if cmd:sub(1,2) == "uc" and hosts[name] then ui.updateTextArea(33,"<black>["..name.."] "..string.gsub(string.gsub(cmd:sub(4), "&gt;", ">"), "&lt;", "<"),nil) ui.updateTextArea(32,"<V>["..name.."]<A:ACTIVE> "..string.gsub(string.gsub(cmd:sub(4), "&gt;", ">"), "&lt;", "<"),nil) end
if cmd:sub(1,3) == "uc*" and hosts[name] then ui.updateTextArea(33,"<black> "..string.gsub(string.gsub("<b>• ["..name.."]</b> "..cmd:sub(5), "&gt;", ">"), "&lt;", "<"),nil) ui.updateTextArea(32,"<ROSE> "..string.gsub(string.gsub("<b>• ["..name.."]</b> "..cmd:sub(5), "&gt;", ">"), "&lt;", "<"),nil) end
-- 'all' komandas
if cmd:sub(1,5) == "s all" and hosts[name] then table.foreach(tfm.get.room.playerList, tfm.exec.setShaman) end
if cmd:sub(1,5) == "r all" and hosts[name] then table.foreach(tfm.get.room.playerList, tfm.exec.respawnPlayer) end
if cmd:sub(1,6) == "ce all" and hosts[name] then table.foreach(tfm.get.room.playerList, tfm.exec.giveCheese) end
if cmd:sub(1,7) == "ce* all" and hosts[name] then table.foreach(tfm.get.room.playerList, tfm.exec.removeCheese) end
if cmd:sub(1,8) == "kill all" and hosts[name] then table.foreach(tfm.get.room.playerList, tfm.exec.killPlayer) end

-- [[DEBUG]]
debug = {}

validcmds = {contestants={["pr"]=true,["i"]=true,["spawn"]=true},helpers={["bc"]=true,["meep"]=true,["f"]=true,["f*"]=true,["ce"]=true,["ce*"]=true,["clear"]=true,["i"]=true,["hc"]=true,["r"]=true,["r"]=true,["s"]=true,["s*"]=true,["size"]=true,["smode"]=true},hosts={["bc*"]=true,["end"]=true,["end*"]=true,["kill"]=true,["test"]=true,["sname"]=true,["uc"]=true,["uc*"]=true,["next"]=true,["c"]=true,["spawn*"]=true,["r*"]=true,["md"]=true,["md*"]=true,["np"]=true,["np*"]=true,["g"]=true,["g*"]=true,["barrier"]=true,["col"]=true,["sp"]=true,["score"]=true,["add"]=true,["link"]=true,["link*"]=true,["tfm"]=true,["defcol"]=true,["startfrom"]=true,["tfm*"]=true,["d"]=true,["d*"]=true,["cd"]=true,["map"]=true,["defcol"]=true,["tr"]=true,["debug"]=true,["role"]=true,["p"]=true,["play"]=true,["msg"]=true,["txt"]=true,["settp"]=true,["replace"]=true}}

-- Challenge-specfiskas komandas
if cmd == "next" then nm(name) end
if cmd == "toggle sail" and hosts[name] and SETUP.challengemode=="build" then tfm.exec.newGame('<C><P H="850" mgoc="" F="8" L="6000" bh="" /><Z><S><S P="0,0,0.3,0.2,0,0,0,0" L="3200" H="50" X="1500" Y="825" T="7" /><S P="0,0,0.3,0.2,0,0,0,0" L="3200" H="50" X="4700" Y="825" T="7" /><S P="0,0,,,,0,0,0" L="3000" H="250" X="1400" Y="675" T="9" /><S P="0,0,,,,0,0,0" L="3000" H="250" X="4400" Y="675" T="9" /><S P="0,0,,,,0,0,0" L="3000" H="250" X="7400" Y="675" T="9" /><S P="0,0,0.4,0.2,0,0,0,0" L="3000" H="251" X="1400" lua="-4802" Y="674" T="7" /><S P="0,0,0.4,0.2,0,0,0,0" L="3000" H="251" X="4400" lua="-4801" Y="674" T="7" /><S P="0,0,0.4,0.2,0,0,0,0" L="3000" H="251" X="7400" lua="-4800" Y="674" T="7" /></S><D /><O /></Z></C>') inheritwidth=6000
elseif cmd=="toggle sail" and hosts[name] then error0x2(name)
elseif cmd=="toggle sail" then error0x1(name,cmd) end
if cmd == "toggle f" and hosts[name] and SETUP.challengemode=="build" then buildshipready() end
if cmd == "toggle border" and hosts[name] and SETUP.challengemode=="build" then buildborder() end

-- Augsta līmeņa komandas
    local c = { }
    string.gsub(cmd, "%S+", function(arg)
        c[#c + 1] = arg
    end)

if validcmds.helpers[c[1]] then 
	if not helpers[name] then
		if not hosts[name] then error0x1(name,cmd,1) end
	end
end

if validcmds.hosts[c[1]] then 
	if not hosts[name] then error0x1(name,cmd,2) end
end

if contestants[name] then
    if c[1] == "spawn" then
        tfm.exec.addShamanObject(c[2],c[3],c[4],c[5],c[6],c[7],c[8])
    end
    if c[1] == "i" then
			ui.addTextArea(8999, "<font size='16'><"..theme[SETUP.theme].closeBtnColor.."><a href='event:user.cls'>X</a></"..theme[SETUP.theme].closeBtnColor.."></font> <"..theme[SETUP.theme].windowHeadingColor.."><b>"..trans[203].."</b></"..theme[SETUP.theme].windowHeadingColor.."></font></font>\n___________________________\n\n<font size='14'><bv>"..trans[204].."</bv></font>\n<font size='12'><v><li><a href='event:user.nogui'>"..trans[205].."</a></li><li><a href='event:user.highcontrast'>"..trans[274].."</a></li>", name, 300, 100, 200, 200, theme[SETUP.theme].windowColor2, theme[SETUP.theme].windowBorderColor, 0.65, true)
    end
    if c[1] == "pr" and contestants[c[2]] then
			profile(c[2],name)
    end
end
if helpers[name] or hosts[name] then
	if c[1] == "hc" then
		userData[name].hc_tabbed = false
		if c[2] ~="-b" and c[2] ~="-e" and c[2] ~="-c" then hostcore(name) userData[name].hc = true end
		if c[2] ~= "-t" and c[2] ~= "-b" and c[2] ~= "-e" and c[2] ~= "-c" then annonce2(infpref..trans[206].." <grbl>"..name.."</grbl></lbrp>     <N2><font size='10'>"..trans[207].."</font><N2>") end
		if c[2] == "-t" and hosts[name] then annonce2(infpref..trans[206].." <grbl>"..name.."</grbl>  <D><font size='10'>"..trans[280].."</font></D>") exectrcore(name) end
		if c[2] == "-b" then showbuffer(0,name) end
		if c[2] == "-e" then showbuffer(1,name) end
		if c[2] == "-c" then showbuffer(2,name) end
	end
   if c[1] == "s*" then
   	if c[2] == "all" then
      	for name,player in next,tfm.get.room.playerList do
        	tfm.exec.setShaman(name,false)
      	end
   	else
      	tfm.exec.setShaman(c[2],false)
		end
    end
   if c[1] == "meep" then
   	if c[2] == "all" then
      	for name,player in next,tfm.get.room.playerList do
        	tfm.exec.giveMeep(name)
      	end
   	else
      	tfm.exec.giveMeep(c[2])
		end
    end
    if c[1] == "size" then
      if c[2] == "all" then
      for name,player in next,tfm.get.room.playerList do
          tfm.exec.changePlayerSize(name,c[3])
      end
      else tfm.exec.changePlayerSize(c[2],c[3])
      end
    end
    if c[1] == "f" then
      if c[2] == "all" then
      for name,player in next,tfm.get.room.playerList do
          tfm.exec.freezePlayer(name,true)
      end
      else tfm.exec.freezePlayer(c[2],true)
      end
    end
    if c[1] == "f*" then
      if c[2] == "all" then
      for name,player in next,tfm.get.room.playerList do
          tfm.exec.freezePlayer(name,false)
      end
      else tfm.exec.freezePlayer(c[2],false)
      end
    end
    if c[1] == "clear" then
		clear()
    end
    if c[1] == "smode" then
    if c[2] == "all" then
      for name,player in next,tfm.get.room.playerList do
        tfm.exec.setShaman(name)
        tfm.exec.setShamanMode(name,c[3])
      end
    else
      tfm.exec.setShaman(c[2])
      tfm.exec.setShamanMode(c[2],c[3])
    end
	  end
end
if hosts[name] then
	if c[1] == "hc*" then hostcore(name) userData[name].hc = true showbuffer(-1,name) end
    if c[1] == "c" then
			ui.removeTextArea(8880,nil) ui.removeTextArea(8881,nil) ui.removeTextArea(8888,nil) hostinterfaces(name)
			if c[2] == SETUP.challengemode then
				if c[2] == "survival" then
					survutils()
				elseif c[2] == "vanilla" then
					vanillautils()
				elseif c[2] == "pkg" then
					pkg.data = c[3] or 0
					packageutils()
				elseif c[2] == "thirty" then
				elseif c[2] == "build" then
				end
			else error0x2(name)
			end
    end
    if c[1] == "spawn*" then
		if type(tonumber(c[2])) == "number" and type(tonumber(c[3])) == "number" then 
		if tonumber(c[2]) > 8 and tonumber(c[3]) == 57 or tonumber(c[2]) > 8 and tonumber(c[3]) == 61 or tonumber(c[2]) > 8 and tonumber(c[3]) == 68 or tonumber(c[2]) > 8 and tonumber(c[3]) == 69 then
			error0x4(name,c[2],8)
		elseif tonumber(c[2]) > 40 then
			error0x4(name,c[2],40)
		else
			for i = 1, c[2] do
       		tfm.exec.addShamanObject(c[3],c[4],c[5],c[6],c[7],c[8],c[9])
			end
		end
		end
    end
    if c[1] == "r*" then
		if c[2] == "all" then
			for name,player in next,tfm.get.room.playerList do
        		tfm.exec.respawnPlayer(name)
        		tfm.exec.movePlayer(name,c[3],c[4])
			end
		else
        tfm.exec.respawnPlayer(c[2])
        tfm.exec.movePlayer(c[2],c[3],c[4])
		end
    end
    if c[1] == "md" then
        md()
        tfm.exec.addJoint(c[2],1,1,{type=0,point1=c[3]..","..c[4],point2=c[5]..","..c[6],line=c[7],color=0xFF0000,alpha=0.9,foreground=true})
    end
    if c[1] == "md*" then
			md()
		  	if c[8] then c[8] = tonumber(c[8],16) end
        	tfm.exec.addJoint("880"..c[2],1,1,{type=0,point1=c[3]..","..c[4],point2=c[5]..","..c[6],line=c[7],color=c[8],alpha=c[9],foreground=true})
    end
    if c[1] == "np" then
		tfm.exec.newGame(c[2])
    end
    if c[1] == "np*" then
		tfm.exec.newGame(c[2],true)
    end
    if c[1] == "g" and hosts[name] then
		if tonumber(c[3]) == 12 or tonumber(c[3]) == 13 then
		  	g_id = c[2]
		  	g_type = c[3]
		  	g_x = c[4]
		  	g_y = c[5]
		  	g_width = c[6]
		  	g_height = c[7]
		  	g_restitution = c[8]
		  	g_friction = c[9]
		  	g_angle = c[10]
			if c[11] == "true" or tonumber(c[11]) == 1 then g_dyn=true else g_dyn=false end
		  	g_mass = c[12]
        	ui.showColorPicker(303,name,0x000022,trans[281])
		else
        	tfm.exec.addPhysicObject(c[2],c[4],c[5],{type=c[3],restitution=c[8],friction=c[9],angle=c[10],width=c[6],height=c[7],dynamic=c[11],mass=c[12],miceCollision=true})
		end
    end
    if c[1] == "g*" and hosts[name] then
		if tonumber(c[3]) == 12 or tonumber(c[3]) == 13 then
		  	g_id = c[2]
		  	g_type = c[3]
		  	g_x = c[4]
		  	g_y = c[5]
		  	g_width = c[6]
		  	g_height = c[7]
		  	g_restitution = c[8]
		  	g_friction = c[9]
		  	g_angle = c[10]
			if c[11] == "true" or tonumber(c[11]) == 1 then g_dyn=true else g_dyn=false end
		  	g_mass = c[12]
        	ui.showColorPicker(304,name,0x000022,trans[281])
		else
        tfm.exec.addPhysicObject(c[2],c[4],c[5],{type=c[3],restitution=c[8],friction=c[9],angle=c[10],width=c[6],height=c[7],dynamic=c[11],mass=c[12],miceCollision=false,groundCollision=false})
		end
    end
    if c[1] == "barrier" and hosts[name] then
		for i = 1, c[2] - 1 do
        tfm.exec.addPhysicObject(-968 .. i * 1000,math.floor(c[3]/(c[2]) * i),400,{type=9,restitution=0.2,friction=5,angle=0,width=10,height=3000,dynamic=false,mass=0,miceCollision=true})
			print("<o>"..math.floor(c[3]/(c[2]) * i).." <V>".. -968 .. i * 1000)
		end
    end
    if c[1] == "col" and hosts[name] then
        colqueue = c[2]
        ui.showColorPicker(300,name,0x000022,trans[257])
    end
    if c[1] == "sp" and hosts[name] then
		if c[2] == tfm.get.room.owner and name == tfm.get.room.owner then
			spectators[c[2]] = true
			tfm.exec.killPlayer(c[2])
			tfm.exec.setPlayerScore(c[2],-100,false)
			ui.updateTextArea(0,"<CE>"..trans[251].." "..trans[221]..":<CS> "..trans[272],c[2])
		end
		if hosts[c[2]] or helpers[c[2]] then if c[2] ~= tfm.get.room.owner then error0x5(name) end
		else
			spectators[c[2]] = true
			tfm.exec.killPlayer(c[2])
			tfm.exec.setPlayerScore(c[2],-100,false)
			ui.updateTextArea(0,"<CE>"..trans[251].." "..trans[221]..":<CS> "..trans[272],c[2])
		end
    end
    if c[1] == "score" and hosts[name] then
		if c[2] == "all" then
			for name,player in next,tfm.get.room.playerList do
        		tfm.exec.setPlayerScore(name,c[3],false)
			end
		else tfm.exec.setPlayerScore(c[2],c[3],false)
		end
    end
    if c[1] == "add" and hosts[name] then
		if c[2] == "all" then
			for name,player in next,tfm.get.room.playerList do
        		tfm.exec.setPlayerScore(name,c[3],true)
			end
		else tfm.exec.setPlayerScore(c[2],c[3],true)
		end
    end

		txtidoffset = 470000 txtfixedpos = false

    if c[1] == "txt" and hosts[name] then
		if c[7] == "-a" or c[8] == "-a" then txtidoffset = 0 print(txtidoffset) else txtidoffset = 470000 end
		if c[7] == "-f" or c[8] == "-f" then txtfixedpos = true else txtfixedpos = false end
		if type(tonumber(c[2])) == "number" then c[2] = txtidoffset + tonumber(c[2]) else c[2] = 470000 end
		if c[6] then ui.addTextArea(c[2],string.gsub(string.gsub(string.gsub(tostring(c[6]), "&gt;", ">"), "&lt;", "<"), "|", " "),nil,c[3],c[4],0,0,"0x"..c[5],"0x"..c[5],0.65,txtfixedpos) end
    end
    if c[1] == "rmtxt" and hosts[name] then
		if c[3] == "-a" or c[4] == "-a" then txtidoffset = 0 else txtidoffset = 470000 end
		if type(tonumber(c[2])) == "number" then c[2] = txtidoffset + tonumber(c[2]) else c[2] = txtidoffset end
		ui.removeTextArea(c[2],nil)
    end
    if c[1] == "settp" and hosts[name] then
		c[2] = tonumber(c[2]) + 470000 or 470000
		c[3] = tonumber(c[3]) or 0
		c[4] = tonumber(c[4]) or 0
		tp[c[2]] = {x = c[3],y = c[4]}
		print(tp[c[2]].x) print(tp[c[2]].y)
		trainingcore(name,"settings:settp;"..c[2]..";"..c[3]..";"..c[4])
    end
    if c[1] == "link" and hosts[name] then
		if c[3] == "all" then
			for name,player in next,tfm.get.room.playerList do
        		tfm.exec.linkMice(c[2],name)
			end
		else tfm.exec.linkMice(c[2],c[3])
		end
    end
    if c[1] == "link*" and hosts[name] then
		if c[3] == "all" then
			for name,player in next,tfm.get.room.playerList do
        		tfm.exec.linkMice(c[2],name,false)
			end
		else tfm.exec.linkMice(c[2],c[3],false)
		end
    end
    if c[1] == "tfm" and hosts[name] then
		if c[2] == "all" then
			for name,player in next,tfm.get.room.playerList do
				tfm.exec.giveTransformations(name)
				userData[name].tfm = true
			end
		elseif contestants[c[2]] then tfm.exec.giveTransformations(c[2])	userData[c[2]].tfm = true
		end
    end
    if c[1] == "defcol" and hosts[name] then
        	defqueue = c[2]
			ui.showColorPicker(302,name,0x000022,trans[259])
    end
    if c[1] == "startfrom" and hosts[name] then
		c[2] = tonumber(c[2])
		if type(c[2]) == "number" then
			if SETUP.challengemode=="survival" then
				survrounds = c[2]
			elseif SETUP.challengemode=="pkg" then
				pkg.round = c[2]
			end
		end
    end
    if c[1] == "tfm*" and hosts[name] then
		if c[2] == "all" then
			for name,player in next,tfm.get.room.playerList do
        		tfm.exec.giveTransformations(name,false)
				userData[name].tfm = false
			end
		elseif contestants[c[2]] then tfm.exec.giveTransformations(c[2],false) userData[c[2]].tfm = false
		end
    end
    if c[1] == "d" and hosts[name] then
			if hosts[c[2]] or helpers[c[2]] then error0x3(name)
			else d(c[2],0.4,0x000022,5,25,string.gsub(string.gsub(string.gsub(tostring(c[3]), "&gt;", ">"), "&lt;", "<"), "|", " ")) end
    end
    if c[1] == "d*" and hosts[name] then
			if hosts[c[2]] or helpers[c[2]] then error0x3(name)
			else d(c[2],1,0x000001,5,195,string.gsub(string.gsub(string.gsub(tostring(c[3]), "&gt;", ">"), "&lt;", "<"), "|", " ")) end
    end
    if c[1] == "cd" and hosts[name] then
			if hosts[c[2]] or helpers[c[2]] then error0x3(name)
			else d(c[2],c[3],c[4],c[5],c[6],string.gsub(string.gsub(string.gsub(tostring(c[7]), "&gt;", ">"), "&lt;", "<"), "|", " ")) end
    end
    if c[1] == "map" and hosts[name] then
			c[2] = c[2] or 0 --mgoc
			c[3] = c[3] or 3000 --platums
			c[4] = c[4] or 850 --augstums
			c[5] = c[5] or 8 --fons
			c[6] = c[6] or 6 --tips
			if c[7] then c[7] = tonumber(c[7],16) end --krāsa
			inheritmgoc = c[2] inheritwidth = c[3] inheritheight = c[4] inheritbg = c[5] inherittype = c[6] inheritcolor = c[7]
			tfm.exec.newGame('<C><P H="'..c[4]..'" F="'..c[5]..'" L="'..c[3]..'" mgoc="'..c[2]..'" bh=""/><Z><S /><D /><O /></Z></C>')
			for i=0,math.ceil((c[3]/3000)-1) do
				tfm.exec.addPhysicObject(-888 - i,1500 + (i * 3000),c[4] - 25,{type=c[6],width=3000,height=50,restitution=0.2,friction=0.3,color=c[7]})
			end
    end
    if c[1] == "tr" and hosts[name] then
			annonce2(infpref..trans[252].." "..c[2].." - "..tostring(trans[tonumber(c[2])]))
    end
    if c[1] == "debug" and hosts[name] then
		if SETUP.debug==true then
			_G[c[2]](c[3],c[4],c[5],c[6],c[7],c[8],c[9],c[10],c[11],c[12],c[13],c[14],c[15],c[16])
		else error0x1(name,cmd) end
    end
    if c[1] == "role" and hosts[name] then
		    if c[2] == "+" then
				if c[3] == "host" then if contestants[c[4]] then hosts[c[4]] = true annonce2(infpref..c[4].." "..trans[213]) userData[c[4]].role = "host" userData[c[4]].ncol = "rose" end end
				if c[3] == "helper" then if contestants[c[4]] then helpers[c[4]] = true annonce2(infpref..c[4].." "..trans[214]) userData[c[4]].role = "helper" userData[c[4]].ncol = "o" end end end
		    if c[2] == "-" then
				if c[3] == "host" then if contestants[c[4]] then hosts[c[4]] = false annonce2(infpref..c[4].." "..trans[215]) userData[c[4]].role = "default" userData[c[4]].ncol = "n2" end end
				if c[3] == "helper" then if contestants[c[4]] then helpers[c[4]] = false annonce2(infpref..c[4].." "..trans[216]) userData[c[4]].role = "default" userData[c[4]].ncol = "n2" end end end
		end
    if c[1] == "p" and hosts[name] then
        ui.addPopup(c[2], c[3],string.gsub(string.gsub(string.gsub(c[4], "&gt;", ">"), "&lt;", "<"), "|", " "),nil, nil, 100, 250, 400, true)
    end
    if c[1] == "play" and hosts[name] then
		if c[2] == "all" then
			for name,player in next,tfm.get.room.playerList do
         		tfm.exec.playEmote(name,c[3],c[4])
			end
		else tfm.exec.playEmote(c[2],c[3],c[4])
		end
    end
    if c[1] == "msg" and hosts[name] then
        ui.updateTextArea(0,"<CE>"..trans[251].." "..name..":<CS> "..string.gsub(string.gsub(string.gsub(tostring(c[3]), "&gt;", ">"), "&lt;", "<"), "|", " "),c[2])
    end
end
end
-- Slēptās komandas
system.disableChatCommandDisplay(nil)

-- [[Utilijas]]

-- Markdown komanda
function md()
tfm.exec.addPhysicObject(1,400,-600,{type=0,width=10,height=10,foreground=true,friction=0.3,restitution=0,dynamic=false,miceCollision=true,groundCollision=true})
end

-- Dummy
function none()
end

objects={}

-- Clear
function clear()
for k,v in pairs(tfm.get.room.objectList) do
table.insert(objects,k)
end
for i,object in ipairs(objects) do
tfm.exec.removeObject(object)
end
end

-- Kļūdas

function error0x1(name,cmd,id)
errn1 = name errc1 = cmd erri1 = id or 0
ui.updateTextArea(33,"<black><b>• ["..name.."]</b> "..trans[217],nil)
ui.updateTextArea(32,"<warn><b>• <a href='event:error0x1'>["..name.."]</a></b> "..trans[217],nil)
errbuf("<warn><b>• ["..name.."]</b> "..trans[217].." <BL><font size='10'>("..errc1..","..erri1..")</font></BL>")
end
function error0x2(name,cmd)
ui.updateTextArea(33,"<black><b>• ["..name.."]</b> "..trans[218],nil)
ui.updateTextArea(32,"<warn><b>• ["..name.."]</b> "..trans[218],nil)
errbuf("<warn><b>• ["..name.."]</b> "..trans[218])
end
function error0x3(name)
ui.updateTextArea(33,"<black><b>• ["..name.."]</b> "..trans[253],nil)
ui.updateTextArea(32,"<warn><b>• ["..name.."]</b> "..trans[253],nil)
errbuf("<warn><b>• ["..name.."]</b> "..trans[253])
end
function error0x4(name,placed,allowed)
ui.updateTextArea(33,"<black><b>• ["..name.."]</b> "..trans[264].." "..placed.." / "..allowed,nil)
ui.updateTextArea(32,"<warn><b>• ["..name.."]</b> "..trans[264].." "..placed.." / "..allowed,nil)
errbuf("<warn><b>• ["..name.."]</b> "..trans[264].." "..placed.." / "..allowed)
end
function error0x5(name)
ui.updateTextArea(33,"<black><b>• ["..name.."]</b> "..trans[273],nil)
ui.updateTextArea(32,"<warn><b>• ["..name.."]</b> "..trans[273],nil)
errbuf("<warn><b>• ["..name.."]</b> "..trans[273])
end

-- Hostu interfeiss
hidata = {[1] = "<p align='center'><font size='14'><VP><a href='event:hipage'>1</a></VP>\n<vi>－</vi>\n<a href='event:say_vn'><bv><font face='Wingdings'>L</font></bv></a>\n<a href='event:nextmap'><bv><font face='Webdings'>8</font></bv></a>\n<a href='event:reload'><bv><font face='Wingdings 3'>P</font></bv></a>\n<a href='event:printtemp'><bv><font face='Wingdings'>1</font></bv></a>\n<a href='event:r_all'><bv><font face='Webdings'>h</font></bv></a>\n<vi>－</vi>\n<a href='event:conf'><warn><font face='Wingdings'>N</font></font></a>",[2] = "<p align='center'><font size='14'><VP><a href='event:hipage'>2</a></VP>\n<vi>－</vi>\n<a href='event:disq'><bv><font face='Wingdings 3'>7</font></a><a href='event:host.chpos'><font face='Wingdings 3'>B</font></a></bv></p>"}
histate = 1
hipos = {[1] = {x = -23,y = 27},[2] = {x=5,y=55},[3] = {x = 803,y = 27},[4] = {x=775,y=55}}
function hostinterfaces(name)
	if hosts[name] or helpers[name] then
		ui.addTextArea(450, hidata[histate], name, hipos[userData[name].hipstate].x, hipos[userData[name].hipstate].y, 20, 165, theme[SETUP.theme].windowColor, theme[SETUP.theme].windowBorderColor, theme[SETUP.theme].bcTransparency, true)
		if SETUP.challengemode == "build" then
			ui.addTextArea(451, "<font size='14'><p align='center'><a href='event:toggleborder'><"..theme[SETUP.theme].panelCommonItemColor.."><font face='Wingdings 3'>F</font></"..theme[SETUP.theme].panelCommonItemColor.."></a>\n<a href='event:togglesailwater'><"..theme[SETUP.theme].panelCommonItemColor.."><font face='Wingdings'>h</font></"..theme[SETUP.theme].panelCommonItemColor.."></a>", name, hipos[userData[name].hipstate].x, hipos[userData[name].hipstate].y + 185, 20, 38, theme[SETUP.theme].windowColor, theme[SETUP.theme].windowBorderColor, theme[SETUP.theme].bcTransparency, true)
		end
		annonce2(infpref..trans[235].." (<grbl>"..name.."</grbl><lbrp>)")
	end
end

-- Koordinātu printeris
local shifting = {}
local eing = {}
local ctrling = {}
local apoing = {}
local oneing = {}
local doting = {}
local dashing = {}
scorestring = ""

function visualScoreboard(name)
	scorestring = ""
	for k,v in next,tfm.get.room.playerList do scorestring = scorestring.."<BV>"..tostring(k)..": <D>"..tostring(v.score).."\n" end
	if userData[name].visualScoreboard==false then ui.addTextArea(17, scorestring, name, 30, 80, 300, nil, theme[SETUP.theme].windowColor2, theme[SETUP.theme].windowColor2, 0.65, true) userData[name].visualScoreboard=true
	elseif userData[name].visualScoreboard==true then ui.removeTextArea(17,name) userData[name].visualScoreboard=false end
end

function eventKeyboard(n, key, down, x, y)
if key==34 and hosts[n] then rel(n) trainingcore(n,"keyboard:reload")
elseif key==0 and userData[n].tfm == true then if hosts[n] or helpers[n] then tfm.exec.movePlayer(n,0,0,true,-15,0,true) end
elseif key==1 and userData[n].tfm == true then if hosts[n] or helpers[n] then tfm.exec.movePlayer(n,0,0,true,0,-16,true) end
elseif key==2 and userData[n].tfm == true then if hosts[n] or helpers[n] then tfm.exec.movePlayer(n,0,0,true,15,0,true) end
elseif key==3 and userData[n].tfm == true then if hosts[n] or helpers[n] then tfm.exec.movePlayer(n,0,0,true,0,16,true) end
elseif key==17 or key==9 then ctrling[n] = down
elseif key==33 then nm(n) trainingcore(n,"keyboard:nextmap")
elseif key==16 then shifting[n] = down
elseif key==67 then visualScoreboard(n)
elseif key==69 then eing[n] = down
elseif key==187 then oneing[n] = down
elseif key==189 then dashing[n] = down
elseif key==190 then doting[n] = down
elseif key==192 then apoing[n] = down
end end

function eventMouse(n, x, y)
  if shifting[n] then
    trainingcore(n,"superpowers:getcoordinates;"..x..";"..y)
    ui.updateTextArea(33,"<black>• "..n .." "..trans[220].." X:" .. x .. ", Y:" .. y,nil)
    ui.updateTextArea(32,"<BV>• "..n .." "..trans[220].." X:" .. x .. ", Y:" .. y,nil)
    print("<BV>• "..n .." "..trans[220].." X:" .. x .. ", Y:" .. y)
  end
  if apoing[n] and hosts[n] or apoing[n] and helpers[n] then
    trainingcore(n,"superpowers:conjuration;"..x..";"..y)
    tfm.exec.addConjuration(x/10,y/10,9999999)
  end
  if eing[n] and hosts[n] or eing[n] and helpers[n] then
		trainingcore(n,"superpowers:explosion;"..x..";"..y)
		tfm.exec.explosion(x,y,20,50,false)
		tfm.exec.displayParticle(12,x,y,0,0,0,0,nil)
  end
  if ctrling[n] and hosts[n] or ctrling[n] and helpers[n] then
		trainingcore(n,"superpowers:teleport;"..x..";"..y)
		tfm.exec.movePlayer(n,x,y)
		tfm.exec.displayParticle(36,x,y,0,0,0,0,nil)
  end
end

table.foreach(tfm.get.room.playerList, eventNewPlayer)

-- HostCore
function hostcore(name)
ui.addTextArea(10, "", name,theme[SETUP.theme].bcX, 25, theme[SETUP.theme].bcWidth, theme[SETUP.theme].hcHeight, theme[SETUP.theme].bcBackground, theme[SETUP.theme].windowBorderColor, theme[SETUP.theme].bcTransparency, true)
ui.addTextArea(65, miscpref..trans[222], name, theme[SETUP.theme].bcX, 25, theme[SETUP.theme].bcWidth, 20, 0x324650, 0x000000, 0, true)
ui.addTextArea(0, "<p align='center'><font size='"..theme[SETUP.theme].bcFontSize.."'><ROSE>"..title.."</font></p>",name,5, -25, 790, 22, 0x000022, 0x000022, 0.65, true)
ui.addTextArea(64, infpref..trans[223].." <V>"..version.."</V> / "..trans[224].." <V>"..tfm.get.room.owner.."</V>", name, theme[SETUP.theme].bcX, 40, theme[SETUP.theme].bcWidth, 20, 0x324650, 0x000000, 0, true)
end

-- eventPlayerDied

function eventPlayerDied(name)
	if SETUP.challengemode=="survival" then
    local count, winner = 0
    for k, v in next, tfm.get.room.playerList do
        if not v.isDead then
            count = count + 1
            winner = k
        end
 end
    if count == 1 then
        winnerFunction(winner)
    end

	print("<BV>• "..name.." "..trans[225])
		if not disq[name] then
			if not spectators[name] then
				ui.updateTextArea(0,"<font size='"..theme[SETUP.theme].bcFontSize.."'><ROSE>"..name.." "..trans[226],nil)
			end
		end
	end
	if SETUP.autorespawn == true then
    tfm.exec.respawnPlayer(name)
	end
end

-- [[IZDZĪVOŠANAS CHALLENGE UTILIJAS]]
survtest = [[<C><P H="800" L="1600" /><Z><S /><D><P X="0" P="0,0" C="5d6582" Y="400" T="34" /><P X="800" P="0,0" C="324650" Y="0" T="34" /><P X="0" P="0,0" C="719b9f" Y="0" T="34" /><P X="800" P="0,0" C="ffaf00" Y="400" T="34" /><P X="400" P="0,0" C="faff" Y="200" T="34" /></D><O /></Z></C>]]

if SETUP.challengemode == "survival" then
survrounds = 0
--##########################$201###$202####$703#####$701#####$203###$204####$205####$206
survrot = {7482494,7602083,7602098,7605138,7605136,7622015,7637491,7645184,7645263}
function survutils(name)
ui.updateTextArea(0,"<VP><font size='"..theme[SETUP.theme].bcFontSize.."'>"..trans[227].."</font>", nil)
survRound()
end

function survRound()

survrounds = survrounds + 1

if survrounds ~= 10 then
srv = survrot[math.random(#survrot)]
tfm.exec.newGame(srv)
elseif survrounds == 10 then
tfm.exec.newGame(survrot[math.random(#survrot)])
end


ui.updateTextArea(0,"<ROSE>"..survrounds..trans[40].." "..trans[229],nil)
end

function winnerFunction(winner)
	ui.updateTextArea(0,"<p align='center'><font size='"..theme[SETUP.theme].bcFontSize.."'><ROSE>"..winner.." "..trans[231].."</font></p>",nil)
	ui.updateTextArea(33,"<black>• "..survrounds..trans[40].." "..trans[232].." "..winner.." "..trans[231],nil)
	ui.updateTextArea(32,"<D>• "..survrounds..trans[40].." "..trans[232].." "..winner.." "..trans[231],nil)
	print('<D>• '..survrounds..trans[40]..' '..trans[233]..' '..winner..' '..trans[231])
	tfm.exec.giveCheese(winner)
	tfm.exec.playerVictory(winner)
	tfm.exec.setPlayerScore(winner,60,true)
	tfm.exec.setGameTime(3)
end

end

-- [[BEZ-NAGLU CHALLENGE UTILIJAS]]
if SETUP.challengemode == "vanilla" then
vanillarot = {0,1,2,3,4,5,6,14,15,16,17,18,19,23,24,25,26,27,31,33,37,38,41,43,44,47,49,51,54,55,56,59,64,68,71,79,83,86,99,100,113,119,127,139,147,153,158,161,163,167,200,202,203,207,209} --nelietot 7,8,58,120
function vanillautils()
nextMap()
end
function nextMap()
tfm.exec.newGame(vanillarot[math.random(#vanillarot)])
end
end

-- [[BŪVDARBU CĪŅU UTILIJAS]]
function buildshipready()
tfm.exec.removePhysicObject(-4800)
tfm.exec.removePhysicObject(-4801)
tfm.exec.removePhysicObject(-4802)
end

function buildborder()
tfm.exec.addPhysicObject(-3600,0,0,{type=2,restitution=3,friction=3,width=8,height=15000,groundCollision=true,miceCollision=true})
tfm.exec.addPhysicObject(-3601,inheritwidth,0,{type=2,restitution=3,friction=3,width=8,height=15000,groundCollision=true,miceCollision=true})
end

-- [[MAPJU PAKOTŅU UTILIJAS]]
pkg = {round = -1}
function packageutils(c)
tfm.exec.newGame('#'..pkg.data)
end

 		first = 0

-- eventPlayerWon
function eventPlayerWon(playerName, timeElapsed, timeElapsedSinceRespawn)
	if SETUP.challengemode == "pkg" then
		first = first + 1
		if first == 1 then
			tfm.exec.setPlayerScore(playerName,60,true)
			ui.updateTextArea(33,"<black>• "..pkg.round..trans[40].." "..trans[233].." "..playerName.." "..trans[231],nil)
			ui.updateTextArea(32,"<D>• "..pkg.round..trans[40].." "..trans[233].." "..playerName.." "..trans[231],nil)
			print("<D>• "..pkg.round..trans[40].." "..trans[233].." "..playerName.." "..trans[231])
 		elseif first > 1 then tfm.exec.setPlayerScore(playerName,10,true)
	 end
	end
end

--##########$302#####$303#####$304###$307###$308#####$309####$310###$311###$312####$313######$314###$315####$316#####$317####$318##$319####$320######$321####$322####$323###$324####$325#####$326#####$327###$328####$329###$330###$331######$332####$333####$334
threerot = {7612717,6265169,6847550,6370623,6333089,6565399,7612788,6975155,7574375,7612773,7612785,6370622,6334320,7612776,7612782,7574389,7574667,7574973,7574975,7574982,7574984,7574997,7574999,7576032,7575113,7576033,7576035,7576224,7576229,7614125,7620702}

function newMap()
	tfm.exec.newGame(threerot[math.random(#threerot)]) end

	directivecooldown = 3

function eventNewGame()
	if SETUP.challengemode=="thirty" then
		tfm.exec.setGameTime(30)
 		ui.addTextArea(24,"", nil, 745, 25, 70, 40, 0x000022, 0x000022, 0, true)
	end
		local Ptag = string.match(tfm.get.room.xmlMapInfo.xml, "<P (.-)/>") 
		local meta = string.match(Ptag, 'meta ?= ?"(.-)"')
		local mapName
	if meta then
		mapName = string.gsub(meta, ",", "<BL> - $", 1).."</BL>"
		print(meta)
    	ui.setMapName(mapName)
	end
		if Ptag:find('directive="LoadAsXML"') then tfm.exec.newGame(tfm.get.room.xmlMapInfo.xml) end
	if SETUP.challengemode == "pkg" then
	pkg.round = pkg.round + 1
	ui.updateTextArea(0,"<ROSE><font size='"..theme[SETUP.theme].bcFontSize.."'>"..pkg.round..trans[40].." "..trans[229].."</font>", nil)

	end
	if SETUP.challengemode=="pkg" then
		first=0
	end
end

-- functionlist

function functionlist(name)
ui.addTextArea(1080, "<v>\n\n<li>[spectate]</li><li>[toggleborder]</li><li>[togglesailwater]</li><li>[init_hostcore]</li><li>[r_all]</li><li>[clear]</li><li>[getInfo]</li><li>[infclose]</li><li>[about]</li><li>[cn.survival]</li><li>[cn.iziz]</li><li>[cn.build]</li><li>[cn.divine]</li><li>[cn.nonail]</li><li>[cn.thirty]</li><li>[cn.racing]</li><li>[cn.defilante]</li>\n</v>", name, 320, 75, 160, 270, 0x000022, 0x000022, 0.6, true)
ui.addTextArea(1088, "<p align='center'><font size='16'><"..theme[SETUP.theme].windowHeadingColor.."><b>Izpildīt funkciju</b></"..theme[SETUP.theme].windowHeadingColor.."></font></p>", name, 320, 75, 160, 30, 0x324650, 0x000000, 0, true)
ui.addTextArea(1086, "\n______________________\n<font size='10'><rose><a href='event:closefunctionlist'><font face='webdings'>r</font> aizvērt</a></rose></font>          <v><font size='10'> « 1. lapa »</font></v>", name, 320, 302, 160, 50, 0x324650, 0x000000, 0, true)
end

-- eventLoop
function eventLoop(elaps,rmng)
	for name,player in pairs(tfm.get.room.playerList) do
		if disq[name] then tfm.exec.killPlayer(name) tfm.exec.setPlayerScore(name,-32768) end
		if spectators[name] then tfm.exec.killPlayer(name) tfm.exec.setPlayerScore(name,-100) end
	end
	if SETUP.challengemode=="thirty" then
 		ui.updateTextArea(24, "<p align='center'><font size='14'><D>"..math.ceil(rmng/1000), nil)
 		if rmng <= 0 then table.foreach(tfm.get.room.playerList,tfm.exec.killPlayer) end
 		if rmng <= -3 and SETUP.autoplay == true then newMap() end
	end
	if SETUP.challengemode=="survival" then
 		if rmng <= -3 and SETUP.autoplay == true then survRound() end
	end
	if SETUP.challengemode=="pkg" then
 		if rmng <= -3 and SETUP.autoplay == true then packageutils() end
	end
	if SETUP.challengemode=="vanilla" then
 		if rmng <= -3 and SETUP.autoplay == true then nextMap() end
	end
end

function test()
tfm.exec.newGame(survtest)
end

function eventTextAreaCallback(textAreaID, playerName, callback)
	if callback=="spectate" then
		trainingcore(playerName,"panel:spectate_legacy")
		ui.removeTextArea(100,playerName)
		ui.updateTextArea(101,"<R><font size='40'><p align='center'>"..trans[239].."</p></font>\n<N2><font size='24'><p align='center'>"..trans[211].."</p></font>",playerName)
	end
	if callback=="closefunctionlist" then
		trainingcore(playerName,"functionlist:close")
		for i=1080,1088 do
			ui.removeTextArea(i,playerName)
		end
	end
	if callback=="toggleborder" then
		trainingcore(playerName,"panel:toggleborder")
		buildborder()
	end
	if callback=="togglesailwater" then
		trainingcore(playerName,"panel:togglesailwater")
		buildshipready()
	end
	if callback=="init_hostcore" and hosts[playerName] then
		hostcore(playerName)
		print(syscore.." "..trans[206].." (<V>"..playerName.."</V>)")
		ui.updateTextArea(65,syscore.." "..trans[206].." (<V>"..playerName.."</V>)",nil)
		trainingcore(playerName,"panel:hostcore")
	end
 	if callback=="r_all" then
		table.foreach(tfm.get.room.playerList, tfm.exec.respawnPlayer)
		trainingcore(playerName,"panel:respawnall")
	end
 	if callback=="hc.actionlog" then
		showbuffer(0,playerName)
		trainingcore(playerName,"hostcore:toggleactionlog")
	end
 	if callback=="hc.errorlog" then
		showbuffer(1,playerName)
		trainingcore(playerName,"hostcore:toggleerrorlog")
	end
 	if callback=="hc.commandlog" then
		showbuffer(2,playerName)
		trainingcore(playerName,"hostcore:togglecommandlog")
	end
 	if callback=="clear" then
		clear()
		trainingcore(playerName,"panel:clear")
	end
	if callback=="getInfo" then
		hostinfo(0,playerName)
 end
	if callback=="setupinf" then
		hostinfo(1,playerName)
 end
 	if callback=="infclose" then
		for i=600,605 do ui.removeTextArea(i,playerName) end trainingcore(playerName,"hostcore:about_close")
	end
 	if callback=="about" then
		ui.updateTextArea(600, trans[243]..trans[244], playerName)
		trainingcore(playerName,"hostcore:about_legacy")
	end
 	if callback=="cn.survival" then
		ui.updateTextArea(8881,"<grbl><font size='14'><v><font face='Wingdings 3'>u</font></v> "..trans[104].."</font></grbl><lgrbl><font size='14'> "..trans[83].."</font></font>\n\n<bv>"..trans[183].."</bv>",nil)
		ui.removeTextArea(8888,nil)
	end
 	if callback=="cn.iziz" then
		ui.updateTextArea(8881,"<grbl><font size='14'><v><font face='Wingdings 3'>u</font></v> "..trans[104].."</font></grbl><lgrbl><font size='14'> "..trans[88].."</font></font>\n\n<bv>"..trans[188].."</bv>",nil)
		ui.removeTextArea(8888,nil)
	end
 	if callback=="cn.build" then
		ui.updateTextArea(8881,"<grbl><font size='14'><v><font face='Wingdings 3'>u</font></v> "..trans[104].."</font></grbl><lgrbl><font size='14'> "..trans[87].."</font></font>\n\n<bv>"..trans[187].."</bv>",nil)
		ui.removeTextArea(8888,nil)
	end
 	if callback=="cn.divine" then
		ui.updateTextArea(8881,"<grbl><font size='14'><v><font face='Wingdings 3'>u</font></v> "..trans[104].."</font></grbl><lgrbl><font size='14'> "..trans[82].."</font></font>\n\n<bv>"..trans[182].."</bv>",nil)
		ui.removeTextArea(8888,nil)
	end
 	if callback=="cn.nonail" then
		ui.updateTextArea(8881,"<grbl><font size='14'><v><font face='Wingdings 3'>u</font></v> "..trans[104].."</font></grbl><lgrbl><font size='14'> "..trans[81].."</font></font>\n\n<bv>"..trans[181].."</bv>",nil)
		ui.removeTextArea(8888,nil)
	end
 	if callback=="cn.thirty" then
		ui.updateTextArea(8881,"<grbl><font size='14'><v><font face='Wingdings 3'>u</font></v> "..trans[104].."</font></grbl><lgrbl><font size='14'> "..trans[86].."</font></font>\n\n<bv>"..trans[186].."</bv>",nil)
		ui.removeTextArea(8888,nil)
	end
 	if callback=="cn.racing" then
		ui.updateTextArea(8881,"<grbl><font size='14'><v><font face='Wingdings 3'>u</font></v> "..trans[104].."</font></grbl><lgrbl><font size='14'> "..trans[84].."</font></font>\n\n<bv>"..trans[184].."</bv>",nil)
		ui.removeTextArea(8888,nil)
	end
 	if callback=="cn.defilante" then
		ui.updateTextArea(8881,"<grbl><font size='14'><v><font face='Wingdings 3'>u</font></v> "..trans[104].."</font></grbl><lgrbl><font size='14'> "..trans[85].."</font></font>\n\n<bv>"..trans[185].."</bv>",nil)
		ui.removeTextArea(8888,nil)
	end
 	if callback=="cn.custom" then
		ui.addPopup(960,2,"<p align='center'><font size='16' color='#84b7d1'><b>"..trans[276].."</b></font>",playerName,440,startmenuy,340,true)
		ui.removeTextArea(8888,nil)
	end
 	if callback=="user.nogui" then
		ui.removeTextArea(0,playerName)	ui.removeTextArea(32,playerName) ui.removeTextArea(33,playerName) trainingcore(playerName,"settings:nogui")
	end
 	if callback=="user.cls" then
		ui.removeTextArea(8999,playerName)
		trainingcore(playerName,"settings:close")
	end
 	if callback=="servetp" then
		if tp[textAreaID] then
			trainingcore(playerName,"settings:usetp;"..textAreaID)
			tfm.exec.movePlayer(playerName,tp[textAreaID].x,tp[textAreaID].y)
		end
	end
 	if callback=="user.highcontrast" then
		ui.removeTextArea(33,playerName)
		trainingcore(playerName,"settings:nocontrast")
	end
 	if callback=="user.nowelcome" then
		ui.removeTextArea(8880,playerName)	ui.removeTextArea(8881,playerName)
		trainingcore(playerName,"greeting:close")
	end
 	if callback=="user.uctrans" then
		ui.addPopup(480,2,"<p align='center'><font size='16' color='#84b7d1'><b>"..trans[267].."</b></font>",playerName,595,300,200,true)
	end
	if callback=="say_vn" then
		print("<D>• "..pkg.round..trans[40].." "..trans[229].." - "..trans[248])
		ui.updateTextArea(33,"<black>• "..pkg.round..trans[40].." "..trans[229].." - "..trans[248],nil)
		ui.updateTextArea(32,"<D>• "..pkg.round..trans[40].." "..trans[229].." - "..trans[248],nil)
		trainingcore(playerName,"panel:everyonedied")
	end
	if callback=="kill" then
		error("<ch>Konkurss beidzies. <D>("..playerName..")")
	end
	if callback=="hostmenu" then
		trainingcore(playerName,"hostcore:menu")
		ui.addTextArea(5678, "<p align='center'>\n<rose><a href='event:getInfo'>"..trans[265].."</a> <a href='event:hi'>"..trans[266].."</a> <a href='event:clsconf'>"..trans[242].."</a></p>\n", playerName, 275, 175, 250, 50, 0x000022, 0x000022, 0.6, true)
	end
	if callback=="hi" then
		trainingcore(playerName,"panel:open")
		hostinterfaces(playerName)
	end
	if callback=="host.chpos" then
		trainingcore(playerName,"panel:changeposition")
		userData[playerName].hipstate = userData[playerName].hipstate + 1		
		if userData[playerName].hipstate > 4 then userData[playerName].hipstate = 1 end
		hostinterfaces(playerName)
	end
	if callback=="reload" then
		trainingcore(playerName,"panel:reload")
		rel(playerName)
	end
	if callback=="clsconf" then
		trainingcore(playerName,"panel:closemenu")
		ui.removeTextArea(5678,playerName)
	end
	if callback=="nextmap" then
		trainingcore(playerName,"panel:nextmap")
		nm(playerName)
	end
	if callback=="printtemp" then
		trainingcore(playerName,"panel:templatelink")
		if SETUP.challengemode=="pkg" then print(syscore.." "..trans[84].." - https://atelier801.com/topic?f=774444&t=930558&p=1#m1") print(syscore.." "..trans[85].." - https://atelier801.com/topic?f=774444&t=932134&p=1#m1")
		elseif SETUP.challengemode=="vanilla" then print(syscore.." "..trans[82].." - https://atelier801.com/topic?f=774444&t=930827&p=1#m1") print(syscore.." "..trans[81].." - https://atelier801.com/topic?f=774444&t=931791&p=1#m1")
		elseif SETUP.challengemode=="survival" then print(syscore.." "..trans[83].." - https://atelier801.com/topic?f=774444&t=930530&p=1#m1")
		elseif SETUP.challengemode=="build" then print(syscore.." "..trans[87].." - https://atelier801.com/topic?f=774444&t=931585&p=1#m1")
		else print(syscore.."Nav pieejams.") end
	end
	if callback=="conf" then
		trainingcore(playerName,"panel:exitmenu")
		if hosts[playerName] then
			ui.addTextArea(5678, "<p align='center'><font size='16'><b><grbl>"..trans[249].."</font></b></font>\n\n<rose><a href='event:kill'>["..trans[70].."]</a> <a href='event:clsconf'>["..trans[73].."]</a><p>", playerName, 275, 175, 250, 50, 0x000022, 0x000022, 0.6, true)
		else ui.addTextArea(5678, "<p align='center'><font size='16'><b><grbl>"..trans[270].."</font></b></font>\n<N>"..trans[217].."</N>\n\n<rose><a href='event:clsconf'>[ok]</a><p>", playerName, 275, 175, 250, 80, 0x000022, 0x000022, 0.6, true)
		end
end
	if callback=="hipage" then
		if histate == 1 then histate = 2 elseif histate == 2 then histate = 1 end
		ui.updateTextArea(450,hidata[histate],playerName)
		trainingcore(playerName,"panel:switchpage;"..histate)
	end
	if callback=="disq" then
		ui.addPopup(800,2,"<p align='center'><font size='16' color='#84b7d1'><b>"..trans[254].."</b></font>",playerName,595,300,200,true)
	end
 	if callback=="pr.cls" then
		trainingcore(playerName,"profile:close")
		ui.removeTextArea(288,playerName)
	end 
	if callback=="error0x1" then
		trainingcore(playerName,"panel:error0x1;"..errn1)
		ui.addTextArea(5678, "<font size='16'><grbl><a href='event:clsconf'>X</a></font> <"..theme[SETUP.theme].windowHeadingColor.."><b>"..trans[270].." 0x1</b></"..theme[SETUP.theme].windowHeadingColor.."></font></font>\n___________________________\n\n<BV><font size='14'>>> "..errn1.."</font></BV><V>\n\n!"..errc1, playerName, 300, 100, 200, 200, 0x000022, 0x00022, 0.65, true)
		print(erri1)
	end
end

-- Nākošā mape

function nm(name)
	if hosts[name] and SETUP.challengemode=="vanilla" then nextMap()
	elseif hosts[name] and SETUP.challengemode=="survival" then survRound()
	elseif hosts[name] and SETUP.challengemode=="thirty" then newMap()
	elseif hosts[name] and SETUP.challengemode=="pkg" then tfm.exec.newGame("#"..pkg.data)
end end

-- eventPopupAnswer
function eventPopupAnswer(popupID, name, answer)
	if popupID==404 then print("<b><PT>["..name.."]</PT></b> <T>"..answer) end
	if popupID==480 then userData[name].uctrans = tonumber(answer) utilcore(name) trainingcore(name,"settings:utilcoretransparency;"..answer) end
	if popupID==800 and hosts[name] then if contestants[answer] then d(answer,0.4,0x000022,5,25) trainingcore(name,"panel:disqualify;"..answer) end end
	if popupID==960 and hosts[name] then trainingcore(name,"greeting:setcustomname") cname = answer ui.addPopup(961,2,"<p align='center'><font size='16' color='#84b7d1'><b>"..trans[277].."</b></font>",name,440,startmenuy,340,true) end
	if popupID==961 and hosts[name] then trainingcore(name,"greeting:setcustomdescription") cdesc = answer ui.updateTextArea(8881,"<grbl><font size='14'><v><font face='Wingdings 3'>u</font></v> "..trans[104].."</font></grbl><lgrbl><font size='14'> "..cname.."</font></font>\n\n<bv>"..cdesc.."</bv>",nil) end
end

-- Pārlādēt mapi

function rel(name)
tfm.exec.newGame(tfm.get.room.currentMap) annonce2(infpref..name.." "..trans[219]) end

-- Diskvalifikācija
function d(targ,tr,col,msgx,msgy,reason)
	disq[targ] = true
	ui.addTextArea(100, "", targ, -1500, -1500, 3000, 3000, col, col, tr, true)
	ui.removeTextArea(0,targ)
	ui.removeTextArea(32,targ)
	ui.removeTextArea(33,targ)
	if reason then
		ui.addTextArea(681, "<warn><b>"..trans[269].."</b> "..reason,targ, 9, 377, 784, 27, 0x000022, 0x000022, userData[targ].uctrans, true)
	end
	ui.addTextArea(680, "<p align='center'><font size='14'><warn>"..trans[239].." "..trans[211],targ,msgx, msgy, 790, 22, col, col, tr + 0.25, true)
	ui.updateTextArea(33,"<black>• "..targ.." "..trans[212],nil)
	ui.updateTextArea(32,"<D>• "..targ.." "..trans[212],nil)
	print("<D>• "..targ.." "..trans[212])
	tfm.exec.killPlayer(targ)
	tfm.exec.setPlayerScore(targ,-32768,false)
end

-- autorespawn brīdinājums
if SETUP.autorespawn == true then
		ui.updateTextArea(0,"<CE>"..trans[251].." "..trans[221]..":<CS> "..trans[256],OWNER_ID)
end

-- eventColorPicked
function eventColorPicked(id,name,color)
	if id==300 then -- vārda krāsošana
		trainingcore(name,"colorselector:colorname;"..colqueue..";"..color)
		if colqueue == "all" then
			for name,player in next,tfm.get.room.playerList do
				tfm.exec.setNameColor(name,color)
			end
		else tfm.exec.setNameColor(colqueue,color)
		end
	end
	if id==302 then -- tagu definīcija
		trainingcore(name,"colorselector:colortag;"..defqueue..";"..color)
		setColorTag(defqueue, color)
		annonce2(infpref..""..name.." "..trans[208].." <"..defqueue..">"..defqueue.."</font>.")
	end
	if id==303 then -- !g zemju krāsošana
		trainingcore(name,"colorselector:ground;"..g_id..";"..color)
		tfm.exec.addPhysicObject(g_id,g_x,g_y,{type=g_type,restitution=g_restitution,friction=g_friction,angle=g_angle,color=color,width=g_width,height=g_height,dynamic=g_dyn,mass=g_mass,miceCollision=true,groundCollision=true})
	end
	if id==304 then -- !g* zemju krāsošana
		trainingcore(name,"colorselector:transparentground;"..g_id..";"..color)
		tfm.exec.addPhysicObject(g_id,g_x,g_y,{type=g_type,restitution=g_restitution,friction=g_friction,angle=g_angle,color=color,width=g_width,height=g_height,dynamic=g_dyn,mass=g_mass,miceCollision=false,groundCollision=false})
	end
end

-- eventSummoningEnd
function eventSummoningEnd(name,type,x,y,angle,data)
end

-- eventSummoningStart
function eventSummoningStart(name,type,x,y,angle)

	if oneing[name] then
		if hosts[name] or helpers[name] then
			trainingcore(name,"superpowers:instaspawn;"..type..";"..x..";"..y..";"..angle)
			tfm.exec.addShamanObject(type,x,y,angle,0,0,false)
		end
	end
	if dashing[name] then
		if hosts[name] or helpers[name] then
			trainingcore(name,"superpowers:instaspawntransparent;"..type..";"..x..";"..y..";"..angle)
			tfm.exec.addShamanObject(type,x,y,angle,0,0,true)
		end
	end
end

-- eventPlayerLeft

function eventPlayerLeft(name)
	annonce(miscpref..name.." "..trans[250])
	d(name,0.4,0x000022,5,25,"Pameta ciltsmāju")
end

-- Debug
function printVariable(v)
print(_G[v])
end

-- Fatāla kļūda 2
if fail==true then for i=0,9000 do ui.removeTextArea(i,nil) end end
