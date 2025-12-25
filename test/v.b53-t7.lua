-- "Vēsture" [[v1 - oriģināls|v2 - survival sakne|v3 - !spawn koordinātu pieejamība|v4 - !bc, !bc*, !utilcore, !utilcore*|v5 - survival pabeigts|v6 - beznaglu sakne|v7 - !r, !r*|v8 - ne-dalībnieku blokāde|v9 - kļūdu reorganizācija|v10 - !md|v11 - !md*|v12 - !cname, !host, !kill|v13 - !txt, !g|v14 - utilcore palaidējs|v15 - !txt*|v16 - !rhost|v17 - !g*|v18 - !col|v19 - !s*|v20 - !cmode, !size|v21 - !ce,!ce*|v22 - !np|v23 - !meep|v24 - !rmtxt|v25 - !score, all: !s, !kill, !r, !meep, !ce|v26 - jauns interfeiss; !tfm, !tfm*, !link, !link*|v27 - all: !tfm; !hlp kodols|v28 - !hlp uzlabojumi; atjaunināts survival|v29 - !nextmap survival režīmā automātiski parāda raunda ciparu|v30 - karte pagarinās build režīmā atbilstoši spēlētaju skaitam, !clear|v.b32 - HostCore (!hc); 30-sek. challenge kodols; everyoneVerified; !d|v.b33 - HTML iekš !bc* un !utilcore; 30-sekunžu mapēs tagad rādās veidotājs]]

SETUP = {challengemode="racing",title="lacrosnostra",autorespawn = false,lang="lv"} 

-- [[LCN: LV, EN, DE]]

version = "v.b53 ~T7"

function errstp(err) fail = true ui.addTextArea(13000, "", nil, -2600, -2800, 6000, 6000, 0x6a7495, 0x000022, 1, false) ui.addTextArea(13001, "<V>[EN]</V> <A:ACTIVE>Invalid configuration! A SETUP variable has an invalid value or doesn't exist.</A:ACTIVE>\n<V>[LV]</V> <A:ACTIVE>Nederīga konfigurācija! Kāds no SETUP mainīgajiem satur nederīgu vērtību vai neeksistē.</A:ACTIVE>", nil, 5, 25, 790, 30, 0x324650, 0x324650, 1, true) ui.addTextArea(13002, "<vp><p align='center'>"..version.."</p></vp>", nil, 5, 380, 790, 20, 0x324650, 0x324650, 1, true) ui.addTextArea(13003, "\n\n\n\n\n\n<font face='Lucida Console' size='16'><p align='center'>"..(err or "").."</p></font>", nil, 0, 0, 800, 400, 0x324650, 0x0, 0, true) end 
if SETUP == nil then SETUP = {challengemode = "@",lang = "lv",title="lacrosnostra"} errstp() end if SETUP.lsimage==nil then SETUP.lsimage = "16f09800dd9.png" end if SETUP.challengemode == nil or type(SETUP.challengemode) == "boolean" then SETUP.challengemode = "@" errstp() end if SETUP.lang == "lv" or SETUP.lang == "en" or SETUP.lang == "de" or SETUP.lang == "debug" then else SETUP.lang = "lv" errstp() end if SETUP.title == nil or type(SETUP.title) == "boolean" then SETUP.title = "lacrosnostra" errstp() end do    local _, nickname = pcall(nil)    tfm.get.room.owner = string.match(nickname, "(.-)%.")end

function main()

player={} helpers={} disq={} spectators={}
hosts={['Syrius#8114'] = true,['Yeet#7143'] = true,['Hanakotoba#7318'] = true,[tfm.get.room.owner] = true}
contestants={}
userData={} 
theme = {modern = {hcHeight = 30,windowHeadingColor = "vi",windowBorderColor = 0x000030,windowColor = 0x000022,highlightedWindowColor = 0x000044,contestSelWindowColor = 0x000033,contestSelWindowBorder = 0x000066,contestSelWindowTransparency = 1,windowColor2 = 0x000022,closeBtnColor = "grbl",startScreenColor = 000022,startScreenGround = 12,bcBackground = 0x000022,bcTransparency = 0.65,bcHeight = 22,bcFontSize = 14,bcWidth = 790,bcX = 5,welcomeScreenColor = 0x000022,welcomeScreenTextColor="BV",welcomeScreenDecoColor="V",welcomeScreenHeadingColor="grbl",welcomeScreenHighlightColor="lgrbl",commonColor1 = "grbl",commonColor2 = "brp",commonColor3 = "lbrp",commonColor4 = "vi",commonColor5 = "rose",panelCommonItemColor="BV",panelWarningItemColor="warn"},classic = {hcHeight = 30,windowHeadingColor = "rose",windowBorderColor = 0x000000,windowColor = 0x324650,windowColor2 = 0x000001,highlightedWindowColor = 0x324650,contestSelWindowColor = 0x324650,contestSelWindowBorder = 0x000001,contestSelWindowTransparency = 0.5,closeBtnColor = "warn",startScreenColor = 000000,startScreenGround = 12,bcBackground = 0x324650,bcTransparency = 0.5,bcHeight = 30,bcFontSize = 20,bcWidth = 600,bcX = 100,welcomeScreenColor = 0x000001,welcomeScreenTextColor="V",welcomeScreenDecoColor="VP",welcomeScreenHeadingColor="J",welcomeScreenHighlightColor="pt",commonColor1 = "V",commonColor2 = "PT",commonColor3 = "T",commonColor4 = "PS",commonColor5 = "S",panelCommonItemColor="V",panelWarningItemColor="warn"}}
title = "#"..SETUP.title:lower().."LCN " .. SETUP.challengemode

-- Dizainu konfigurācija
theme.oldclassic = setmetatable({startScreenGround = 5,bcTransparency = 0.2,bcHeight = 55,bcFontSize = 40,bcWidth = 750,bcX = 25}, {__index=theme.classic})
SETUP.theme = SETUP.theme or "modern"

-- Tulkojumi
local t = {
	lv={[40]=".",[70]="jā",[71]="ieslēgts",[72]="izslēgts",[73]="nē",[74]="izvēlēts",[80]="<warn>Nav zināms.</warn>",[81]="Bez-naglu challenge",[82]="Divine challenge",[83]="Noturības challenge",[84]="Cilts racing",[85]="Defilante sacensības",[86]="30-sekunžu challenge",[87]="Būvdarbu cīņas",[88]="Izaicinājumu izaicinājums",[89]="Vienzemju challenge",[90]="Defilante challenge",[100]="LCN versija:",[101]="Esi sveicināts #LCN modulī!",[102]="Šis modulis tiek izmantots atvieglotai konkursu uzturēšanai.",[103]="Ja ienāc konkursa vidū, lūdzu izej no ciltsmājas.",[104]="Tūlīt notiks:",[140]="Tab",[141]="AltGr",[142]="PgUp",[143]="PgDn",[144]="Del",[145]="Shift",[181]="Lai gan ar naglām būvēt ir elementāri, tomēr cik radošs vari būt bez tām? Parādi savas spējas šeit!",[182]="Tavs uzdevums ir izglābt pēc iespējas vairāk peļu vanilla mapēs. Ir tikai viens āķis - tu esi dievišķajā režīmā.",[183]="Turies pie visa iespējamā un esi pēdējais izdzīvojušais - ja vien nenokritīsi...",[184]="Mēs visi zinām veco, labo racing - vismaz cerams... Nu ko, uzmanību... gatavību... STARTS!",[185]="Kas gan notiktu, ja racing apvienotu ar defilante? Sanāktu šis - konkurss, kurā tu defilante mapēs pirmais mēģini nokļūt alā!",[186]="Tev ir dotas īpaši dizainētas mapes, dažas vieglākas, dažas grūtākas, bet, ja nepaspēsi iziet mapi 30 sekundēs - mirsi.",[187]="Sacenties ar citiem spēlētājiem uzbūvēt visizcilāko izpildījumu dotajai tematikai. Ļauj savam radošumam plūst, un lai uzvar labākais!",[188]="Tavs mērķis ikreiz ir citāds - vienreiz tas būs īpašas trases iziešana, citreiz varbūt peļu karš vai pat antīku konkursu spēlēšana!",[189]="Tavs mērķis ir iegūt pēc iespējas mazāk punktu. Par katru nāvi saņemsi tos, tāpēc uzmanies!",[190]="Gluži kā parastā Defilante istabā, uzvar tas, kurš ir savācis visvairāk punktu.",[200]="ir ienācis ciltsmājā.",[201]="Darbojas #LaChallengeNostra.",[202]="Tu neesi cilts eventa dalībnieks/vadītājs.",[203]="Iestatījumi",[204]="Interfeiss",[205]="[noņemt]",[206]="HostCore ieslēgts:",[207]="(nospied •, lai redzētu moduļa informāciju)",[208]="iestatīja krāsu tagu",[209]="TU ESI DISKVALIFICĒTS.",[210]="Konkursa vadītājs ir tevi diskvalificējis.",[211]="Drīksti pamest ciltsmāju.",[212]="ir diskvalificēts.",[213]="tagad pieder konkursa vadītāja statuss.",[214]="tagad pieder konkursa palīga statuss.",[215]="vairs nepieder konkursa vadītāja statuss.",[216]="vairs nepieder konkursa palīga statuss.",[217]="Nederīga komanda vai arī tev nav pietiekamu tiesību tās lietošanai.",[218]="Nederīgs spēles režīms: nomaini SETUP.challengemode uz atbilstošo režīmu.",[219]="pārlādēja mapi.",[220]="kursora koordinātas ir -",[221]="[SISTĒMA]",[222]="Konkursa vadītāj, esi sveicināts šajā moduļa versijā.",[223]="Versija:",[224]="Identifikators:",[225]="ir zaudējis ;(",[226]="ir zaudējis.",[227]="Izdzīvošanas challenge ir sācies!",[228]="Darbojas t.s. <i>survival challenge.</i>",[229]="raunds",[230]="Fināla raunds",[231]="uzvarēja!",[232]="raunds beidzies:",[233]="raunds -",[234]="Bez-naglu challenge ir sācies!",[235]="Vadības panelis atvērts.",[236]="īsinājumtaustiņi",[237]="NEDERĪGA AUTORIZĀCIJA.",[238]="Šis kods ir paredzēts",[239]="Tu esi diskvalificēts.",[240]="[palīdzība]",[241]="Par",[242]="[aizvērt]",[243]="Veidoja <CH>Syrius#8114</CH>.",[244]="\n\nPaldies <CH>Yeet#7143</CH>, <CH>Creativemice#7925</CH>, <CH>Sanija#1187</CH>, <CH>Acmexitee#0000</CH> un citiem cilts <CH>La Cros Nostra</CH> dalībniekiem par palīdzību moduļa veidošanas gaitā.",[245]="Atdzīvošanās (visi)",[246]="Notīrīt",[247]="Paldies par dalību.",[248]="Visi nomira ;(",[249]="Vai esi pārliecināts?",[250]="izgāja no ciltsmājas.",[251]="Ziņa no",[252]="Tulkojums",[253]="Tu nevari diskvalificēt vadītāju/palīgu.",[254]="Diskvalificēt",[255]="Automātiskā mapju ieslēgšana:",[256]="Ir atstāts ieslēgts SETUP.autorespawn!",[257]="Iestatīt lietotājvārda krāsu",[258]="Iestatīt līnijas krāsu",[259]="Definēt krāsu tagu",[260]="Vadītāju iestatījumi",[261]="[mainīt v.p. pozīciju]",[262]="Statuss:",[263]="Komūna:",[264]="Pārsniegts objektu limits! Objekti:",[265]="[infopanelis]",[266]="[vadības panelis]",[267]="Mainīt utilcore caurspīdīgumu",[268]="[mainīt uc. caursp.]",[269]="Iemesls:",[270]="Kļūda",[271]="Ir transformējies:",[272]="Tu esi padarīts par skatītāju.",[273]="Tu nevari padarīt vadītāju par skatītāju!",[274]="[augsta kontrasta uc.]",[275]="Kādu konkursu vadīsi?",[276]="Konkursa vārds",[277]="Konkursa apraksts" ,[278]="Pielāgots",[279]="Pārsniegts barjeru blīvums! Blīvums:",[280]="(apmācību režīms)",[281]="Iestatīt zemes krāsu",[282]="Kāds ir tavs viedoklis par šo konkursu?",[283]="Šis saturs nav pieejams šajā valodā.",[284]="Vadītāji",[285]="Palīgi",[286]="Kļūdu vēsture",[287]="Komandu vēsture",[288]="Darbību vēsture",[289]="Brīdinājums",[290]="Maksimālais mapes augstums, kurā sānu barjeras darbojas pareizi, ir 2050 pikseļi!",[291]="Šī komanda šīs funkcijas argumentā nav atbalstīta.",[292]="tehniskā informācija",[293]="atpakaļ",[294]="Darbība",[295]="nav pieejama tiešā veidā, tā vietā lieto",[296]="Pašlaik ir atbalstītas tikai <i>superpowers</i> tipa darbības.",[297]="tagad var veikt darbību",[298]="vairs nevar veikt darbību",[299]="Pārlādēt karti",[300]="Nākošā mape",[301]="Pārlādēt kā XML",[302]="Variants",[303]="lietotāja dati",[304]="Drīksti pamest istabu.",[305]="izgāja no istabas.",[306]="ir ienācis istabā.",[307]="Komanda",[308]="izpildīja komandu <"..theme[SETUP.theme].commonColor1..">%s</font> %s reizes",[309]="Iestatīt fona krāsu",[310]="atslēga",[311]="vērtība",[312]="komandu saraksts",[313]="nomainīja fona krāsu uz",[314]="reize",[315]="Bijušais <i>pkg</i> režīms ir sadalīts <i>racing</i> un <i>defilante</i> režīmos!"}, 
	en={[40]="th",[70]="yes",[71]="on",[72]="off",[73]="no",[74]="selected",[80]="<warn>Unknown.</warn>",[81]="No nail challenge",[82]="Divine challenge",[83]="Endurance challenge",[84]="Tribe’s racing",[85]="Defilante race",[86]="30-second challenge",[87]="Builders’ Battle",[88]="The Challenge",[89]="Monoground challenge",[90]="Defilante challenge",[100]="LCN version:",[101]="Welcome to #LCN module!",[102]="This module is used to simplify the hosting of contests.",[103]="If you come here in the middle of the contest, please leave the tribe house.",[104]="About to begin:",[140]="Tab",[141]="AltGr",[142]="PgUp",[143]="PgDn",[144]="Del",[145]="Shift",[181]="Yes, building with nails is easy, but how creative can you be without them? Show your skills here!",[182]="Your goal is to save as many mice as possible in vanilla maps. But there’s a catch - you’re in divine mode!",[183]="Hold on to everything you see and be the last survivor... unless you fall...",[184]="We all know racing - at least hopefully... No time to waste, ready... set... GO!",[185]="What would happen, if racing and defilante was merged? This would get made - a contest where mice in defilante maps race to be the first mouse in the hole!",[186]="You’ve got specially designed maps, some easier, some harder, but if you will not complete map in 30 seconds - you’ll die.",[187]="Compete with the other contestants to build the best interpretation of the given theme. Let your creativity run free, and may the best builder win!",[188]="Your goal is different every time - one time it will be winning in a custom map, other time maybe a mice war or even participation in legacy contests!",[189]="Your goal is to get as less points as possible. You will receive them if you die, so be careful!",[190]="Same as in a typical Defilante room, the one who collects the most points becomes the winner.",[200]="entered the tribe house.",[201]="#LaChallengeNostra is active.",[202]="You aren’t a contestant or a host.",[203]="Settings",[204]="Interface",[205]="[remove]",[206]="HostCore enabled:",[207]="(press • to see the info panel)",[208]="has set color tag",[209]="YOU ARE DISQUALIFIED.",[210]="A host has disqualified you.",[211]="You may leave the tribe house.",[212]="has been disqualified.",[213]="is now a host.",[214]="is now a helper.",[215]="is no longer a host.",[216]="is no longer a helper.",[217]="Invalid command or you have insufficient permissions to use it.",[218]="Invalid game mode: change SETUP.challengemode to the corresponding mode.",[219]="reloaded the map.",[220]="’s pointer’s coordinates are -",[221]="[SYSTEM]",[222]="Host, welcome to this version of the module.",[223]="Version:",[224]="Identificator:",[225]="died ;(",[226]="died.",[227]="Survival challenge has begun!",[228]="<i>Survival challenge</i> is active.",[229]="round",[230]="Final round",[231]="won!",[232]="round has ended:",[233]="round -",[234]="No nail challenge has begun!",[235]="Control panel has been opened.",[236]="keybinds", [237]="INVALID AUTHENTICATION.",[238]="This code is intended for",[239]="You are disqualified.",[240]="[help]",[241]="About",[242]="[close]",[243]="Created by <CH>Syrius#8114</CH>.",[244]="\n\nThanks to <CH>Yeet#7143</CH>, <CH>Creativemice#7925</CH>, <CH>Sanija#1187</CH>, <CH>Acmexitee#0000</CH> and other members of tribe <CH>La Cros Nostra</CH> for help in the development of the module.",[245]="Respawn (all)",[246]="Clear",[247]="<font size=’50’>Thanks for participation.",[248]="Everyone died ;(",[249]="Are you sure?",[250]="left the tribehouse.",[251]="A message from",[252]="Translation",[253]="You can’t disqualify a host or a helper.",[254]="Disqualify",[255]="Map autoplay:",[256]="SETUP.autorespawn is left on!",[257]="Set username color",[258]="Set line color",[259]="Define color tag",[260]="Host settings",[261]="[change c.p. position]",[262]="Role:",[263]="Community:",[264]="Object limit exceeded! Objects:",[265]=" [info]",[266]="[control panel]",[267]="Change utilcore transparency",[268]="[change uc. transp.]",[269]="Reason:",[270]="Error",[271]="Is transformed:",[272]="You are a spectator now.",[273]="You can’t make a host a spectator!",[274]="[high contrast uc.]",[275]="What are you going to host?",[276]="Contest name",[277]="Contest description" ,[278]="Custom",[279]="Barrier density exceeded! Density:",[280]="(training mode)",[281]="Set ground color",[282]="What’s your feedback about this contest?",[283]="This feature is not available in this language.",[284]="Hosts",[285]="Helpers",[286]="Error log",[287]="Command log",[288]="Action log",[289]="Warning",[290]="Side barriers only work correctly if the map’s height doesn’t exceed 2050 pixels!",[291]="This command is not supported in this function’s argument.",[292]="technical information",[293]="back",[294]="Action",[295]="is not available directly, instead use",[296]="Only <i>superpowers</i> type actions are supported for now.",[297]="can now perform action",[298]="can no longer perform action",[299]="Reload map",[300]="Next map",[301]="Reload as XML",[302]="Set",[303]="user data",[304]="You may leave the room.",[305]="left the room.",[306]="entered the room..",[307]="Command",[308]="iterated the command <"..theme[SETUP.theme].commonColor1..">%s</font> %s times",[309]="Set background color",[310]="key",[311]="value",[312]="command list",[313]="changed the background color to",[314]="iteration",[315]="The former <i>pkg</i> mode has been split into <i>racing</i> un <i>defilante</i>!"}, 
	de={[40]=".",[70]="ja",[71]="auf",[72]="aus",[73]="nein",[74]="ausgewählt",[80]="<warn>Nicht bekannt.</warn>",[81]="Ohne Nagel Herausforderung",[82]="Göttlicher Modus Herausforderung",[83]="Überlebens Herausforderung",[84]="Stamm racing",[85]="Defilante Herausforderung",[86]="30-Sekunden Herausforderung",[87]="Bauschlachten",[88]="Die Herausforderung",[89]="Die Monoland Herausforderung",[100]="LCN version:",[101]="Willkommen zum #LCN Modul!",[102]="Dieses Modul dient zur Pflege von Wettbeverben.",[103]="Wenn Sie mitten im Wettbeverb hereinkommen, bitte verlassen Sie das Stammeshaus.",[104]="Gleich passiert:",[140]="Tab",[141]="AltGr",[142]="PgUp",[143]="PgDn",[144]="Del",[145]="Shift",[181]="Obwohl Bauen mit Nägeln einfach ist, wie kreativ kannst du ohne Nägel sein? Zeig hier was du Kannst!",[182]="Dein Ziel ist es, so viele Mäuse wie möglich in Vanillekarten zu retten. Aber es gibt einen Haken - du bist im göttlichen Modus!",[183]="Halte an allem fest, was du siest, und sei der letzte Überlebende - es sei denn, du fällst ...",[184]="Wir alle kennen den guten, alten Racing - zumindest hoffentlich ... Nun, Aufmerksamkeit ... Bereitschaft ... START!",[185]="Was würde passieren, wenn racing mit defilante kombiniert würde? Dies würde gemacht werden - ein Wettbewerb, bei dem Mäuse in defilante Karten versuchen, die erste in der Höhle zu sein!",[186]="Du hast speziell gestaltete Karten, einige einfacher, andere schwieriger, aber wenn du die Karte nicht in 30 Sekunden fertigstellen - stribst du.",[187]="Jeder hat das gleiche Thema... die gleichen Regeln ... Möge der beste Baumeister gewinnen!",[188]="Dein Ziel ist jedes Mal anders - einmal wird es eine schwierige Karte gewinnen sein, ein anderes Mal vielleicht ein Mäusekrieg oder sogar die Teilnahme an früheren Wettbewerben sein!",[189]="Dein Ziel ist es, so wenig Punkte wie möglich zu sammeln. Du wirst sie für jeden Tod bekommen, also pass auf!",[200]="betrat das Stammeshaus.",[201]="#LaChallengeNostra ist aktiv.",[202]="Sie sind kein Teilnehmer oder Anführer des Stammesereignesses.",[203]="Einstellungen",[204]="Schnittstelle",[205]="[entfernen]",[206]="HostCore auf:",[207]="(Drück • um die Moduldetails zu sehen)",[208]="hat den Farbetikett holding.eestellen",[209]="DU BIST DISQUALIFIZIERT.",[210]="Der Wettbewerbs Anführer hat Sie disqualifiziert.",[211]="Du kannst das Stammeshaus verlassen.",[212]="wurde disqualifiziert.",[213]="hat jetzt den Status eines Wettbewerb Anführers.",[214]="hat jetzt den Status eines Wettbeverbasissten.",[215]="hat nicht mehr den Status eines Wettbewerb Anführers.",[216]="hat nicht mehr den Status eines Wettbeverbasissten.",[217]="Ungültiges commando oder Sie haben nicht genügend Rechte um es auszuführen.",[218]="Ungültiger Spielemodus: Ändern Sie den SETUP.challengemode in den entsprechenden Modus.",[219]="hat die mape neu gestartet.",[220]="’s Cursor Koordinaten sind -",[221]="[SYSTEM]",[222]="Anführer des Wettbewerbs, willkommen zu dieser Version des Moduls.",[223]="Version:",[224]="Identifikator:",[225]="ist gestorben ;(",[226]="ist gestorben.",[227]="Überlebens Herausforderung hat begonnen!",[228]="<i>Überlebens Herausforderung</i> ist aktiv.",[229]="runde",[230]="Letzte runde",[231]="hat gewonnen!",[232]="runde hat geendet:",[233]="runde -",[234]="Die Ohne Nagel Herausforderung hat begonnen!",[235]="Systemsteuerung wurde geöffnet.",[236]="Tastaturkürze",[237]="UNGÜLTIGE AUTORISIERUNG.",[238]="Dieser Code ist für",[239]="Du bist disqualifiziert.",[240]="[hilfe]",[241]="Über",[242]="[schließen]",[243]="Erstellt von <CH>Syrius#8114</CH>.",[244]="\n\nDanke an <CH>Yeet#7143</CH>,<CH>Creativemice#7925</CH>, <CH>Sanija#1187</CH>, <CH>Acmexitee#0000</CH> und andere <CH>La Cros Nostra</CH> Stammesmitglieder für Hilfe bei der Modulentwicklung.",[245]="Wiederbelebung (alle)",[246]="Löschen",[247]="<font size=’50’>Vielen Dank für Ihre Teilnahme.",[248]="Alle sind gestorben ;(",[249]="Bist du dir sicher?",[250]="hat das Stammeshaus verlassen.",[251]="Eine Nachricht von",[252]="Übersetzung",[253]="Sie können einen Anführer oder Assistenten nicht disqualifizieren.",[254]="Disqualifizieren",[255]="Karten Autoplay:",[256]="SETUP.autorespawn ist aufgeblieben!",[257]="Benutzernamfarbe einstellen",[258]="Linienfarbe einstellen",[259]="Farbetikett definieren",[260]="Anführer Einstellungen",[261]="[s.s. Position ändern]",[262]="Status:",[263]="Gemeinshaft:",[264]="Objekt Limit überschritten! Objekte:",[265]="[infopanel]",[266]="[Systemsteuerung]",[267]="Die Utilcore-Transparenz ändern",[268]="[die Uc. Transp. ändern]",[269]="Grund:",[270]="Fehler",[271]="Hat sich verwandelt:",[272]="Du bist jetzt ein Zuschauer.",[273]="Sie können einen Anführer nicht zum Zuschauer Machen!",[274]="[hoher Kontrast uc.]",[275]="Welchen Wettbewerb wirst du anführen?",[276]="Wettbewerb name",[277]="Wettbewerb beschreibung" ,[278]="Angepasst",[279]="Barrierendichte überschritten! Dichte:",[280]="(Trainingsmods)",[281]="Erdfarbe einstellen",[282]="Was ist deine Meinung über diesem Wettbewerb?",[283]="Diese Funktion ist in dieser Sprache nicht verfügbar.",[284]="Anführer",[285]="Assistent",[286]="Fehlergeschichte",[287]="Kommandogeschichte",[288]="Aktiongeschichte",[289]="Warnung",[290]="Seitenbarrieren funktionieren nur dann korrekt, wenn die Höhe der Karte 2050 Pixel nicht überschreitet!",[291]="Dieser Befehl wird in diesem Funktionsargument nicht unterstützt.",[292]="technische Information",[293]="zurück",[294]="Die Aktion",[295]="ist nicht verfügbar. Verwenden Sie stattdessen",[296]="Jetzt werden nur <i>superpowers</i> unterstützt.",[297]="kann jetzt Aktionen durchführen",[298]="kann nicht mehr Aktionen durchführen",[299]="Karte neu einladen",[300]="Nächste Karte",[301]="Als XML neu einladen",[302]="Set",[303]="Benutzerdaten",[304]="Sie dürfen den Raum verlassen.",[305]="hat der Raum verlassen.",[306]="betrat der Raum."},
	debug={}
}
for i=0,400 do t.debug[i] = "["..i.."]" end
local trans = t[tfm.get.room.community] or t[SETUP.lang]
for k,v in next,t do setmetatable(t[k],{__index=t.en}) end

cmdlog = ""
-- Paziņot
function logHostcore(input)
	if string.len(cmdlog) > 1900 then cmdlog = "" end
	cmdlog = input .. "\n" .. cmdlog
	ui.updateTextArea(54, cmdlog, nil)
end
function hostcore(text)
	print(text)
	ui.updateTextArea(65,text,nil)
	logHostcore(text)
end
function hcCmdFeedback(text)
	print(text)
	ui.updateTextArea(64,text,nil)
	logHostcore(text)
end

-- Prefiksi
syspref = "<ROSE><b>"..trans[221].."</b>"
infpref = "<"..theme[SETUP.theme].commonColor2.."><b>[<a href='event:hostmenu'>•</a>]</b><"..theme[SETUP.theme].commonColor3.."> "
miscpref = "<"..theme[SETUP.theme].commonColor4.."><b>[–]</b><"..theme[SETUP.theme].commonColor5.."> "

local colqueue

-- customcolortag bibliotēka
local setColorTag do local colors = {} setColorTag = function(tag, color) assert(tag, "Missing tag.") assert(color, "Missing color.") if type(color) == "number" then color = string.format("#%06x", color) else color = tostring(color) if not string.find(color, '#') then color = "#" .. color end end tag = tostring(tag) if not string.find(tag, "^<.->$") then tag = "<" .. tag .. ">" end colors[#colors + 1] = { tag = tag, color = color } end local putColors = function(str) for i = 1, #colors do str = string.gsub(str, colors[i].tag, "<font color=\"" .. colors[i].color .. "\">") end return str end local addTextArea, updateTextArea, chatMessage, p = ui.addTextArea, ui.updateTextArea, tfm.exec.chatMessage, print ui.addTextArea = function(id, str, ...) return addTextArea(id, putColors(str), ...) end ui.updateTextArea = function(id, str, ...) return updateTextArea(id, putColors(str), ...) end tfm.exec.chatMessage = function(str, ...) return chatMessage(putColors(str), ...) end print = function(str) return p(putColors(str)) end end
setColorTag("warn", 0xeb1d51) setColorTag("purp", 0x8A2BE2) setColorTag("grbl",0x84b7d1) setColorTag("lgrbl",0x84a7f1) setColorTag("brp", 0x6e6eff) setColorTag("lbrp", 0xb3b3ff) setColorTag("black", 0x000001) setColorTag("wy", 0xffaf00)

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
math.randomseed(os.time()%576)

-- Apmācību režīms
tclog = "" errlog = ""
function initTrainingCore(name)
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

-- Testēšanas log
debdata={log="",open={},userdata={}}
function deb(name,mode,arg1,arg2)
	if string.len(debdata.log) > 1765 then deb(nil,"store") end
	arg1 = arg1 or "<warn><b>[ERR]</b> inv arg1</font>"
	arg2 = arg2 or "<warn><b>[ERR]</b> inv arg2</font>"
	if SETUP.debug==true then 
		if debdata.open[name] == true then ui.addTextArea(200, "<PT><font face='Lucida Console,Monaco'>#LCN "..version.."\nDebug mode", name, 5, 25, nil, nil, 0x000001, 0x000001, 0.05, true) else end
		if mode=="remove" then debdata.open[name] = false ui.removeTextArea(200,name) end
		if mode=="debdata" then debdata.log = debdata.log.."\n"..arg1 end
		if mode=="debdisplay" then ui.updateTextArea(200,"<PT><font face='Lucida Console,Monaco'>#LCN "..version.."\nDebug mode</PT>\n"..debdata.log,name) end
		if mode=="force" then debdata.open[name] = true ui.addTextArea(200, "<PT><font face='Lucida Console,Monaco'>#LCN "..version.."\nDebug mode", name, 5, 25, nil, nil, 0x000001, 0x000001, 0.05, true) end
		if mode=="store" then notepad[#notepad+1] = debdata.log deb(nil,"clear") deb(nil,"debdata","<V><b>[deb]</b></V> <BL>debdata.log &gt;&gt; $notepad"..#notepad) deb(nil,"debdisplay")
		end
		if mode=="clear" then debdata.log = "" end
	end
end

function debprint(text,targ)
	deb(targ,"debdata",text)
end

-- UtilCore
function initUtilcore(name)
	for name,player in pairs(tfm.get.room.playerList) do
		ui.addTextArea(33, "",name, 6, 379, 790, 27, 0x000022, 0x000022, 0, true)
		ui.addTextArea(32, "",name, 5, 378, 790, 27, 0x000022, 0x000022, 0, true)
	end
end

-- Automātiska ziņojuma parādīšanās
function eventNewPlayer(name)
	debdata.open[name] = true
	debdata.userdata[name] = ""
	deb(name)
	initUtilcore(name)
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
		hipstate = SETUP.panelpos or 4,
		histate = 1,
		visualScoreboard = false,
		keyset = 1,
		allowedSuperpowers = {launch=false,conjuration=false,instaspawn=false,teleport=false,explosion=false,getcoordinates=true}
	}
	hostcore(miscpref..name.." "..trans[200])
	if hosts[name] then userData[name].role = "host" userData[name].ncol = "rose" end
	if helpers[name] then userData[name].role = "helper" userData[name].ncol = "o" end
	if hosts[name] or contestants[name] then
		ui.addTextArea(8880, "<"..theme[SETUP.theme].welcomeScreenTextColor..">"..trans[100].."</"..theme[SETUP.theme].welcomeScreenTextColor.."></font> <"..theme[SETUP.theme].welcomeScreenHeadingColor..">"..version.."</"..theme[SETUP.theme].welcomeScreenTextColor.."></font>\n\n<font size='14'><"..theme[SETUP.theme].welcomeScreenDecoColor.."><font face='Wingdings 3'>u</font></"..theme[SETUP.theme].welcomeScreenDecoColor.."><"..theme[SETUP.theme].welcomeScreenHeadingColor.."> "..trans[101].."</"..theme[SETUP.theme].welcomeScreenHeadingColor.."></font></font>\n\n<"..theme[SETUP.theme].welcomeScreenTextColor..">"..trans[102].."\n"..trans[103].."</font>\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n<rose><p align='right'><a href='event:user.nowelcome'>"..trans[242], name, 440, 80, 340, 330, theme[SETUP.theme].welcomeScreenColor, theme[SETUP.theme].welcomeScreenColor, 1, true)
		ui.addTextArea(8881, "", name, 440, 190, 340, 100, theme[SETUP.theme].welcomeScreenColor, theme[SETUP.theme].welcomeScreenColor, 1, true)
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
		system.bindKeyboard(name, 76, false, true)
		system.bindKeyboard(name, 120, false, true)
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
	eventRole(name)
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
	if SETUP.challengemode == "racing" then
		ui.addTextArea(8888, "<"..theme[SETUP.theme].welcomeScreenHeadingColor.."><font size='14'><v><font face='Webdings'>@</font></v> "..trans[275].."</font></"..theme[SETUP.theme].welcomeScreenHeadingColor.."></font>\n\n<bv><li><a href='event:cn.racing'>"..trans[84].."</a></li><li><a href='event:cn.defilante'>"..trans[85].."</a></li><li><a href='event:cn.iziz'>"..trans[88].."</li><li><a href='event:cn.custom'>"..trans[278].."</li>\n</bv>\n\n", name, 440, startmenuy, 340, 100, theme[SETUP.theme].contestSelWindowColor, theme[SETUP.theme].contestSelWindowBorder, theme[SETUP.theme].contestSelWindowTransparency, true)
	end
	if SETUP.challengemode == "defilante" then
		ui.addTextArea(8888, "<"..theme[SETUP.theme].welcomeScreenHeadingColor.."><font size='14'><v><font face='Webdings'>@</font></v> "..trans[275].."</font></"..theme[SETUP.theme].welcomeScreenHeadingColor.."></font>\n\n<bv><li><a href='event:cn.defilantebonus'>"..trans[90].."</a></li><li><a href='event:cn.iziz'>"..trans[88].."</li><li><a href='event:cn.custom'>"..trans[278].."</li>\n</bv>\n\n", name, 440, startmenuy, 340, 100, theme[SETUP.theme].contestSelWindowColor, theme[SETUP.theme].contestSelWindowBorder, theme[SETUP.theme].contestSelWindowTransparency, true)
	end
	if SETUP.challengemode == "build" then
		ui.addTextArea(8888, "<font size='14'><"..theme[SETUP.theme].welcomeScreenDecoColor.."><font face='Webdings'>@</font></"..theme[SETUP.theme].welcomeScreenDecoColor.."><"..theme[SETUP.theme].welcomeScreenHeadingColor.."> "..trans[275].."</"..theme[SETUP.theme].welcomeScreenHeadingColor.."></font></font>\n\n<"..theme[SETUP.theme].welcomeScreenTextColor.."><li><a href='event:cn.build'>"..trans[87].."</a></li><li><a href='event:cn.iziz'>"..trans[88].."</li><li><a href='event:cn.custom'>"..trans[278].."</li>\n</"..theme[SETUP.theme].welcomeScreenTextColor..">\n\n", name, 440, startmenuy, 340, 100, theme[SETUP.theme].contestSelWindowColor, theme[SETUP.theme].contestSelWindowBorder, theme[SETUP.theme].contestSelWindowTransparency, true)
	end
	if SETUP.challengemode == "thirty" then
		ui.addTextArea(8888, "<"..theme[SETUP.theme].welcomeScreenHeadingColor.."><font size='14'><v><font face='Webdings'>@</font></v> "..trans[275].."</font></"..theme[SETUP.theme].welcomeScreenHeadingColor.."></font>\n\n<bv><li><a href='event:cn.thirty'>"..trans[86].."</a></li><li><a href='event:cn.iziz'>"..trans[88].."</li><li><a href='event:cn.custom'>"..trans[278].."</li>\n</bv>\n\n", name, 440, startmenuy, 340, 100, theme[SETUP.theme].contestSelWindowColor, theme[SETUP.theme].contestSelWindowBorder, theme[SETUP.theme].contestSelWindowTransparency, true)
	end
	if SETUP.challengemode == "mono" then
		ui.addTextArea(8888, "<font size='14'><"..theme[SETUP.theme].welcomeScreenDecoColor.."><font face='Webdings'>@</font></"..theme[SETUP.theme].welcomeScreenDecoColor.."><"..theme[SETUP.theme].welcomeScreenHeadingColor.."> "..trans[275].."</"..theme[SETUP.theme].welcomeScreenHeadingColor.."></font></font>\n\n<"..theme[SETUP.theme].welcomeScreenTextColor.."><li><a href='event:cn.mono'>"..trans[89].."</a></li><li><a href='event:cn.iziz'>"..trans[88].."</li><li><a href='event:cn.custom'>"..trans[278].."</li>\n</"..theme[SETUP.theme].welcomeScreenTextColor..">\n\n", name, 440, startmenuy, 340, 100, theme[SETUP.theme].contestSelWindowColor, theme[SETUP.theme].contestSelWindowBorder, theme[SETUP.theme].contestSelWindowTransparency, true)
	end
end

iterArgs={}
foreachArgs = ""

-- Fatāla kļūda
if fail==true then for i=0,9000 do ui.removeTextArea(i,nil) end end

-- Definīciju krātuves
tp = {} 
notepad = {}
objtable = {}


-- Errlog
function errbuf(output)
if string.len(errlog) > 1900 then errlog = "" end
errlog = output .. "\n" .. errlog
ui.updateTextArea(53, errlog, nil)
end

-- eventRole
function eventRole(name)
	if SETUP.disablesuperpowers then
	else 
		if hosts[name] or helpers[name] then
			userData[name].allowedSuperpowers.launch=true
			userData[name].allowedSuperpowers.explosion=true
			userData[name].allowedSuperpowers.instaspawn=true
			userData[name].allowedSuperpowers.conjuration=true
			userData[name].allowedSuperpowers.teleport=true
			userData[name].allowedSuperpowers.getcoordinates=true
		else
			userData[name].allowedSuperpowers.launch=false
			userData[name].allowedSuperpowers.explosion=false
			userData[name].allowedSuperpowers.instaspawn=false
			userData[name].allowedSuperpowers.conjuration=false
			userData[name].allowedSuperpowers.teleport=false
			userData[name].allowedSuperpowers.getcoordinates=true
		end
	end
	if hosts[name] then
		userData[name].role = "host" userData[name].ncol = "rose"
		helpers[name] = false
	elseif helpers[name] then
		userData[name].role = "helper" userData[name].ncol = "o" 
	else 
		userData[name].role = "default" userData[name].ncol = "n2"
	end
	deb(nil,"debdata","<V><b>[eventRole]</b></V> <BL>"..tostring(name))
	deb(nil,"debdisplay")
end

-- Izvēlne vadītājiem
function hostmenu(targ)
		ui.addTextArea(5678, "<p align='center'>\n<rose><a href='event:getInfo'>"..trans[265].."</a> <a href='event:keybinds'>["..trans[236].."]</a> <a href='event:help'>"..trans[240].."</a> <a href='event:hi'>"..trans[266].."</a> <a href='event:clsconf'>"..trans[242].."</a></p> ", targ, 200, 175, 400, 50, 0x000022, 0x000022, 0.6, true)
		trainingcore(targ,"hostcore:menu")
end
-- Infopanelis
infodata={setup="",misc="",kb={[1]="<font size='16'><"..theme[SETUP.theme].windowHeadingColor.."><b>"..trans[302].." 1 <font size='12'>("..trans[74]..")</font></b></"..theme[SETUP.theme].windowHeadingColor.."></font>\n</BV>\n<BV>["..trans[142].."]</BV> <CH>"..trans[300].."</CH>\n<BV>["..trans[143].."]</BV> <CH>"..trans[299].."</CH>\n\n<font size='16'><"..theme[SETUP.theme].windowHeadingColor.."><b><a href='event:kbuser2'>"..trans[302].." 2</a></b></"..theme[SETUP.theme].windowHeadingColor.."></font>\n\n<BV>["..trans[142].."]</BV> <CH>"..trans[300].."</CH>\n<BV>["..trans[143].."]</BV> <CH>"..trans[245].."</CH>\n<BV>["..trans[141].."]</BV> <CH>"..trans[299].."</CH>",[2]="<font size='16'><"..theme[SETUP.theme].windowHeadingColor.."><b><a href='event:kbuser1'>"..trans[302].." 1</a></b></"..theme[SETUP.theme].windowHeadingColor.."></font>\n</BV>\n<BV>["..trans[142].."]</BV> <CH>"..trans[300].."</CH>\n<BV>["..trans[143].."]</BV> <CH>"..trans[299].."</CH>\n\n<font size='16'><"..theme[SETUP.theme].windowHeadingColor.."><b>"..trans[302].." 2 <font size='12'>("..trans[74]..")</font></b></"..theme[SETUP.theme].windowHeadingColor.."></font>\n\n<BV>["..trans[142].."]</BV> <CH>"..trans[300].."</CH>\n<BV>["..trans[143].."]</BV> <CH>"..trans[245].."</CH>\n<BV>["..trans[141].."]</BV> <CH>"..trans[299].."</CH>"}}
function hostinfo(mode,target)
		ui.removeTextArea(5678,target)
		trainingcore(target,"hostcore:about;"..tostring(mode))
		infodata.setup=""
		if userData[target].hc==false then trans1=0.5 trans2=0 else trans1=1 trans2=1 end		
		ui.addTextArea(600, "", target, -3695, -1847, 8192, 4096, theme[SETUP.theme].windowColor2, theme[SETUP.theme].windowColor2, trans1, true)
		ui.addTextArea(603, "", target, -803, -953, 8192, 1000, theme[SETUP.theme].highlightedWindowColor, theme[SETUP.theme].highlightedWindowColor, trans2, true)
	if mode==0 then --par
		ui.addTextArea(602, "<font size='16'><"..theme[SETUP.theme].windowHeadingColor.."><b>"..trans[241].."</b></"..theme[SETUP.theme].windowHeadingColor.."></font>\n___________________________\n\n<BV>"..trans[243]..trans[244].."\n\n</BV>", target, 275, 100, 250, 200, 0x000022, 0x000022, 0, true)
		ui.addTextArea(604, "<ROSE><p align='left'><b><grbl><font face='Webdings'>i</font> "..trans[241]:lower().."</font></b></a> <vi>|</vi> <a href='event:setupinf'><font face='Webdings'>@</font> "..trans[292].."</a></p> ", target, 8, 25, 300, 20, 0x000022, 0x000022, 0, true)
		ui.addTextArea(601, "<ROSE><p align='right'><a href='event:infclose'><font face='Wingdings 3'>|</font> "..trans[293].."</a></p>", target, 656, 27, 140, 20, 0x000022, 0x000022, 0, true)
	end
	if mode==1 then --tehniskā informācija
		for k,v in next,SETUP do infodata.setup = infodata.setup.."\n<BV>"..tostring(k)..": <D>"..tostring(v) end
		ui.addTextArea(602, "<font size='16'><"..theme[SETUP.theme].windowHeadingColor.."><b>SETUP</b></"..theme[SETUP.theme].windowHeadingColor.."></font>\n___________________________\n</BV>"..infodata.setup, target, 275, 100, 250, 200, 0x000022, 0x000022, 0, true)
		ui.addTextArea(604, "<ROSE><p align='left'><a href='event:getInfo'><font face='Webdings'>i</font> "..trans[241]:lower().."</a> <vi>|</vi> <b><grbl><font face='Webdings'>@</font> "..trans[292].."</b></font></p> ", target, 8, 25, 300, 20, 0x000022, 0x000022, 0, true)
		ui.addTextArea(601, "<ROSE><p align='right'><a href='event:infclose'><font face='Wingdings 3'>|</font> "..trans[293].."</a></p>", target, 656, 27, 140, 20, 0x000022, 0x000022, 0, true)
	end
	if mode==2 then --īsinājumtaustiņi
		ui.addTextArea(602, infodata.kb[userData[target].keyset], target, 200, 100, 400, 200, 0x000022, 0x000022, 0, true)
		ui.addTextArea(604, "<ROSE><p align='left'><b><grbl><font face='Wingdings'>7</font> "..trans[236].."</b></font></p> ", target, 8, 26, 300, 20, 0x000022, 0x000022, 0, true)
		ui.addTextArea(601, "<ROSE><p align='right'><a href='event:infclose'><font face='Wingdings 3'>|</font> "..trans[293].."</a></p>", target, 656, 27, 140, 20, 0x000022, 0x000022, 0, true)
	end
	if mode==3 then --lietotāja dati
		ui.addTextArea(602, debdata.userdata[target], target, 200, 100, 400, 300, 0x000022, 0x000022, 0, true)
		ui.addTextArea(604, "<b><grbl><font face='Wingdings'>5</font> "..trans[303].."</b></font></p> ", target, 8, 28, 300, 20, 0x000022, 0x000022, 0, true)
		ui.addTextArea(601, "<ROSE><p align='right'><a href='event:infclose'><font face='Wingdings 3'>|</font> "..trans[293].."</a></p>", target, 656, 27, 140, 20, 0x000022, 0x000022, 0, true)
	end
	if mode==4 then --komandu saraksts
		commandList = {contestants={},helpers={},hosts={}}
		for k,v in next,validcmds.contestants do
			commandList.contestants[#commandList.contestants+1]="!"..k
		end
		for k,v in next,validcmds.helpers do
			commandList.helpers[#commandList.helpers+1]="!"..k
		end
		for k,v in next,validcmds.hosts do
			commandList.hosts[#commandList.hosts+1]="!"..k
		end
		for k,v in next,commandList do
			table.sort(commandList[k])
		end
		ui.addTextArea(602, "<font size='9'><V>"..table.concat(commandList.contestants," <BL>|</BL> ").."</V>\n\n<FC>"..table.concat(commandList.helpers," <BL>|</BL> ").."</FC>\n\n<ROSE>"..table.concat(commandList.hosts," <BL>|</BL> ").."</ROSE></font>", target, 50, 100, 700, 200, 0x000022, 0x000022, 0, true)
		ui.addTextArea(604, "<ROSE><p align='left'><b><grbl><font face='Wingdings'>&</font> "..trans[312].."</b></font></p> ", target, 8, 26, 300, 20, 0x000022, 0x000022, 0, true)
		ui.addTextArea(601, "<ROSE><p align='right'><a href='event:infclose'><font face='Wingdings 3'>|</font> "..trans[293].."</a></p>", target, 656, 27, 140, 20, 0x000022, 0x000022, 0, true)
		commandList = {}
	end
	if mode==5 then --notepad list
		local notepadList = ""
		for i=1,#notepad do notepadList = notepadList .. "\n" .. "<D>"..i.."</D>" .. " <BL>" .. string.gsub(string.gsub(string.gsub(notepad[i]:sub(1,20), "<(.-)>", " "), "<br>", " "), "\n", " ") .. "...</BL>" end
		ui.addTextArea(602, notepadList, target, 200, 100, 400, 300, 0x000022, 0x000022, 0, true)
		ui.addTextArea(604, "<b><grbl><font face='Wingdings 2'>1</font> notepad</b></font></p> ", target, 8, 28, 300, 20, 0x000022, 0x000022, 0, true)
		ui.addTextArea(601, "<ROSE><p align='right'><a href='event:infclose'><font face='Wingdings 3'>|</font> "..trans[293].."</a></p>", target, 656, 27, 140, 20, 0x000022, 0x000022, 0, true)
		notepadList = ""
	end
end

-- Logu interfeisi
function fieldui(mode,targ,header,miscdata)
	miscdata={field1 = miscdata.field1 or "",field2 = miscdata.field2 or "",field3 = miscdata.field3 or "",actions = miscdata.actions or "",score = miscdata.score or ""}
	mode = mode or "single"
	header = header or ""
	if mode=="single" then
		ui.addTextArea(350, "", targ, 100, 85, 600, 250, theme[SETUP.theme].windowColor, theme[SETUP.theme].windowBorderColor, 0.6, true)
		ui.addTextArea(351, "<font size='30'>"..header, targ, 100, 85, 600, 40, 0x324650, 0x000000, 0, true)
		ui.addTextArea(352, miscdata.field1, targ, 100, 125, 600, 150, 0x324650, 0x000000, 0, true)
		ui.addTextArea(353, "<p align='right'><font size='14'>"..miscdata.score, targ, 625, 85, 75, 20, theme[SETUP.theme].windowColor, 0x000000, 0, true)
		ui.addTextArea(354, "<p align='right'>"..miscdata.actions, targ,  650, 30, 140, 20, 0x324650, 0x000000, 0, true)
	end
	if mode=="notepad" then
		ui.addTextArea(350, "", targ, -1500, -1500, 3000, 3000, theme[SETUP.theme].windowColor, theme[SETUP.theme].windowBorderColor, 0.6, true)
		ui.addTextArea(352, "<font size='9'>"..miscdata.field1, targ, 20, 60, 760, 330, 0x324650, 0x000000, 0, true)
		ui.addTextArea(353, "<p align='right'><font size='14'>"..miscdata.score, targ, 720, 370, 75, 20, theme[SETUP.theme].windowColor, 0x000000, 0, true)
		ui.addTextArea(354, "<p align='center'>"..miscdata.actions, targ, 330, 25, 140, 20, 0x324650, 0x000000, 0, true)
	end
	if mode=="tricolumn" then
		ui.addTextArea(350, "", targ, 100, 85, 600, 250, 0x000022, 0x000022, 0.6, true)
		ui.addTextArea(351, "<font size='30'><p align='center'>"..header, targ, 100, 90, 600, 40, 0x324650, 0x000000, 0, true)
		ui.addTextArea(352, miscdata.field1, targ, 110, 140, 180, 150, 0x000022, 0x000000, 0.5, true)
		ui.addTextArea(353, "<p align='right'><font size='14'>"..miscdata.score, targ, 625, 85, 75, 20, 0x000022, 0x000000, 0, true)
		ui.addTextArea(354, "<p align='right'>"..miscdata.actions, targ, 560, 315, 140, 20, 0x324650, 0x000000, 0, true)
		ui.addTextArea(355, miscdata.field2, targ, 310, 140, 180, 150, 0x000022, 0x000000, 0.5, true)
		ui.addTextArea(356, miscdata.field3, targ, 510, 140, 180, 150, 0x000022, 0x000000, 0.5, true)
	end
end

-- Profils
function profile(target,executor)
ui.addTextArea(288, "<font size='16'><grbl><a href='event:pr.cls'>X</a></font> <"..theme[SETUP.theme].windowHeadingColor.."><b>"..tostring(target).."</b></"..theme[SETUP.theme].windowHeadingColor.."></font></font>\n___________________________\n\n<BV>"..tostring(trans[263]).."</BV> <CS>"..tostring(userData[target].lang).."</CS>\n<BV>"..tostring(trans[262]).."</BV> <CS>"..tostring(userData[target].role).."</CS>\n<BV>ID:</BV> <CS>"..tostring(userData[target].id).."</CS>\n<BV>"..tostring(trans[271]).."</BV> <CS>"..tostring(userData[target].tfm).."</CS>\n<BV>"..tostring(trans[302])..":</BV> <CS>"..tostring(userData[target].keyset).."</CS>", executor, 300, 110, 200, 180, 0x000022, 0x000022, 0.6, true) 
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
				initTrainingCore(name) 
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

fielddata={header,field1,field2,field3,actions,score,repmode="ovr"}
colqueue = {}
-- Komandas
function eventChatCommand(name,cmd)
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
if cmd:sub(1,2) == "uc" and hosts[name] then if SETUP.elevatedmode==true then tfm.exec.chatMessage("<FC>"..string.gsub(string.gsub("<V>["..name.."]<A:ACTIVE> "..cmd:sub(4), "&gt;", ">"), "&lt;", "<"),nil) else ui.updateTextArea(33,"<black>["..name.."] "..string.gsub(string.gsub(cmd:sub(4), "&gt;", ">"), "&lt;", "<"),nil) ui.updateTextArea(32,"<V>["..name.."]<A:ACTIVE> "..string.gsub(string.gsub(cmd:sub(4), "&gt;", ">"), "&lt;", "<"),nil) end end
if cmd:sub(1,3) == "uc*" and hosts[name] then if SETUP.elevatedmode==true then tfm.exec.chatMessage("<FC>"..string.gsub(string.gsub("<b>• ["..name.."]</b> "..cmd:sub(5), "&gt;", ">"), "&lt;", "<"),nil) else ui.updateTextArea(33,"<black> "..string.gsub(string.gsub("<b>• ["..name.."]</b> "..cmd:sub(5), "&gt;", ">"), "&lt;", "<"),nil) ui.updateTextArea(32,"<FC> "..string.gsub(string.gsub("<b>• ["..name.."]</b> "..cmd:sub(5), "&gt;", ">"), "&lt;", "<"),nil) end end
-- 'all' komandas
if cmd:sub(1,5) == "s all" and hosts[name] then table.foreach(tfm.get.room.playerList, tfm.exec.setShaman) end
if cmd:sub(1,5) == "r all" and hosts[name] then table.foreach(tfm.get.room.playerList, tfm.exec.respawnPlayer) end
if cmd:sub(1,6) == "ce all" and hosts[name] then table.foreach(tfm.get.room.playerList, tfm.exec.giveCheese) end
if cmd:sub(1,7) == "ce* all" and hosts[name] then table.foreach(tfm.get.room.playerList, tfm.exec.removeCheese) end
if cmd:sub(1,8) == "kill all" and hosts[name] then table.foreach(tfm.get.room.playerList, tfm.exec.killPlayer) end

-- [[DEBUG]]
debug = {}

validcmds = {
	contestants={["pr"]=true,["i"]=true,["spawn"]=true},
	helpers={["col"]=true,["bc"]=true,["bg"]=true,["meep"]=true,["f"]=true,["f*"]=true,["n"]=true,["n*"]=true,["aie"]=true,["aie*"]=true,["ce"]=true,["ce*"]=true,["clear"]=true,["menu"]=true,["i"]=true,["hc"]=true,["notepad"]=true,["r"]=true,["r"]=true,["s"]=true,["s*"]=true,["size"]=true,["smode"]=true,["change"]=true,["gscale"]=true,["wscale"]=true},
	hosts={["bc*"]=true,["end"]=true,["end*"]=true,["kill"]=true,["test"]=true,["toggle"]=true,["sname"]=true,["uc"]=true,["uc*"]=true,["hc*"]=true,["next"]=true,["c"]=true,["t"]=true,["spawn*"]=true,["r*"]=true,["draw"]=true,["draw*"]=true,["np"]=true,["np*"]=true,["g"]=true,["g*"]=true,["barrier"]=true,["sp"]=true,["score"]=true,["add"]=true,["link"]=true,["link*"]=true,["tfm"]=true,["defcol"]=true,["startfrom"]=true,["tfm*"]=true,["d"]=true,["d*"]=true,["cd"]=true,["userdata"]=true,["map"]=true,["defcol"]=true,["tr"]=true,["debug"]=true,["role"]=true,["p"]=true,["f1"]=true,["f2"]=true,["f3"]=true,["fa"]=true,["fs"]=true,["fieldui"]=true,["fh"]=true,["play"]=true,["msg"]=true,["txt"]=true,["settp"]=true,["action"]=true,["mp"]=true,["set"]=true,["setfreq"]=true,["gset"]=true,["wset"]=true,["for"]=true,["foreach"]=true}
}

-- Challenge-specfiskas komandas
if cmd == "next" then nm(name) end
if cmd == "toggle sail" and hosts[name] and SETUP.challengemode=="build" then tfm.exec.newGame('<C><P H="850" mgoc="" F="8" L="6000" bh="" /><Z><S><S P="0,0,0.3,0.2,0,0,0,0" L="3200" H="50" X="1500" Y="825" T="7" /><S P="0,0,0.3,0.2,0,0,0,0" L="3200" H="50" X="4700" Y="825" T="7" /><S P="0,0,,,,0,0,0" L="3000" H="250" X="1400" Y="675" T="9" /><S P="0,0,,,,0,0,0" L="3000" H="250" X="4400" Y="675" T="9" /><S P="0,0,,,,0,0,0" L="3000" H="250" X="7400" Y="675" T="9" /><S P="0,0,0.4,0.2,0,0,0,0" L="3000" H="251" X="1400" lua="-4802" Y="674" T="7" /><S P="0,0,0.4,0.2,0,0,0,0" L="3000" H="251" X="4400" lua="-4801" Y="674" T="7" /><S P="0,0,0.4,0.2,0,0,0,0" L="3000" H="251" X="7400" lua="-4800" Y="674" T="7" /></S><D /><O /></Z></C>') inheritwidth=6000
elseif cmd=="toggle sail" and hosts[name] then error0x2(name)
elseif cmd=="toggle sail" then error0x1(name,cmd) end
if cmd == "toggle f" and hosts[name] and SETUP.challengemode=="build" then buildshipready() end
if cmd == "toggle border" and hosts[name] and SETUP.challengemode=="build" then buildborder(name) end

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
		if c[2] ~="-b" and c[2] ~="-e" and c[2] ~="-c" then initHostcore(name) userData[name].hc = true end
		if c[2] ~= "-t" and c[2] ~= "-b" and c[2] ~= "-e" and c[2] ~= "-c" then hcCmdFeedback(infpref..trans[206].." <"..theme[SETUP.theme].commonColor1..">"..name.."</"..theme[SETUP.theme].commonColor1.."></font></lbrp>     <N2><font size='10'>"..trans[207].."</font><N2>") end
		if c[2] == "-t" and hosts[name] then hcCmdFeedback(infpref..trans[206].." <grbl>"..name.."</grbl>  <D><font size='10'>"..trans[280].."</font></D>") initTrainingCore(name) end
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
	if c[1] == "col" then
		colqueue = {}
		for i=2,#c do
        colqueue[#colqueue+1] = c[i]
		end
		ui.showColorPicker(300,name,0x000022,trans[257])
	end
	if c[1] == "bg" then
		ui.showColorPicker(305,name,0x6a7495,trans[309])
	end
   if c[1] == "change" then
   	if c[2] == "all" then
      	for name,player in next,tfm.get.room.playerList do
        	tfm.exec.setPlayerLook(name,c[3])
      	end
   	else
      	tfm.exec.setPlayerLook(c[2],c[3])
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
    if c[1] == "n" then
      if c[2] == "all" then
      for name,player in next,tfm.get.room.playerList do
          tfm.exec.setPlayerNightMode(true,name)
      end
      else tfm.exec.setPlayerNightMode(true,c[2])
      end
    end
    if c[1] == "n*" then
      if c[2] == "all" then
      for name,player in next,tfm.get.room.playerList do
          tfm.exec.setPlayerNightMode(false,name)
      end
      else tfm.exec.setPlayerNightMode(false,c[2])
      end
    end
    if c[1] == "aie" then
      if c[2] == "all" then
			tfm.exec.setAieMode(true,c[3],nil)
      else tfm.exec.setAieMode(true,c[3],c[2])
      end
    end
    if c[1] == "aie*" then
      if c[2] == "all" then
      for name,player in next,tfm.get.room.playerList do
			tfm.exec.setAieMode(false,c[3],nil)
      end
      else tfm.exec.setAieMode(false,c[3],c[2])
      end
    end
    if c[1] == "gscale" then
      if c[2] == "all" then
      for name,player in next,tfm.get.room.playerList do
          tfm.exec.setPlayerGravityScale(name,c[3])
      end
      else tfm.exec.setPlayerGravityScale(c[2],c[3])
      end
    end
    if c[1] == "wscale" then
      if c[2] == "all" then
      for name,player in next,tfm.get.room.playerList do
          tfm.exec.setPlayerGravityScale(name,nil,c[3])
      end
      else tfm.exec.setPlayerGravityScale(c[2],nil,c[3])
      end
    end
    if c[1] == "clear" then
		clear(c[2])
    end
	if c[1] == "notepad" then
		if notepad[tonumber(c[2])] then fieldui("notepad",name,"",{field1=notepad[tonumber(c[2])],score=c[2],actions="<ROSE><a href='event:rmfieldui'>"..trans[242].."</a></ROSE>"}) 
		elseif c[2]==nil then hostinfo(5,name) 
		end
	end
    if c[1] == "menu" then
		hostmenu(name)
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
	if c[1] == "hc*" then initHostcore(name) userData[name].hc = true showbuffer(-1,name) end
    if c[1] == "c" then
			ui.removeTextArea(8880,nil) ui.removeTextArea(8881,nil) ui.removeTextArea(8888,nil) ui.removeTextArea(8889,nil) hostinterfaces(name)
			if c[2] == SETUP.challengemode then
				if c[2] == "survival" then
					survutils()
				elseif c[2] == "vanilla" then
					vanillautils()
				elseif c[2] == "racing" then
					pkg.data = c[3] or 17
					packageutils()
				elseif c[2] == "defilante" then
					pkg.data = c[3] or 18
					packageutils()
				elseif c[2] == "thirty" then
				elseif c[2] == "mono" then
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
    if c[1] == "draw" then
        md()
        tfm.exec.addJoint(c[2],1,1,{type=0,point1=c[3]..","..c[4],point2=c[5]..","..c[6],line=c[7],color=0xFF0000,alpha=0.9,foreground=true})
    end
    if c[1] == "draw*" then
			md()
		  	if c[8] then c[8] = tonumber(c[8],16) end
        	tfm.exec.addJoint("880"..c[2],1,1,{type=0,point1=c[3]..","..c[4],point2=c[5]..","..c[6],line=c[7],color=c[8],alpha=c[9],foreground=true})
    end
    if c[1] == "f1" then
		if fielddata.repmode=="ovr" then
			fielddata.field1 = string.gsub(string.gsub(cmd:sub(4), "&gt;", ">"), "&lt;", "<")
		elseif fielddata.repmode=="concat" then
			fielddata.field1 = fielddata.field1.." "..string.gsub(string.gsub(cmd:sub(4), "&gt;", ">"), "&lt;", "<")
		end
    end
    if c[1] == "f2" then
		if fielddata.repmode=="ovr" then
			fielddata.field2 = string.gsub(string.gsub(cmd:sub(4), "&gt;", ">"), "&lt;", "<")
		elseif fielddata.repmode=="concat" then
			fielddata.field2 = fielddata.field2.." "..string.gsub(string.gsub(cmd:sub(4), "&gt;", ">"), "&lt;", "<")
		end
    end
    if c[1] == "f3" then
		if fielddata.repmode=="ovr" then
			fielddata.field3 = string.gsub(string.gsub(cmd:sub(4), "&gt;", ">"), "&lt;", "<")
		elseif fielddata.repmode=="concat" then
			fielddata.field3 = fielddata.field3.." "..string.gsub(string.gsub(cmd:sub(4), "&gt;", ">"), "&lt;", "<")
		end   end
    if c[1] == "fh" then
		if fielddata.repmode=="ovr" then
			fielddata.header = string.gsub(string.gsub(cmd:sub(4), "&gt;", ">"), "&lt;", "<")
		elseif fielddata.repmode=="concat" then
			fielddata.header = fielddata.header.." "..string.gsub(string.gsub(cmd:sub(4), "&gt;", ">"), "&lt;", "<")
		end
    end
    if c[1] == "fs" then
		if fielddata.repmode=="ovr" then
			fielddata.score = string.gsub(string.gsub(cmd:sub(4), "&gt;", ">"), "&lt;", "<")
		elseif fielddata.repmode=="concat" then
			fielddata.score = fielddata.score.." "..string.gsub(string.gsub(cmd:sub(4), "&gt;", ">"), "&lt;", "<")
		end    end
	if c[1] == "fa" then
		if fielddata.repmode=="ovr" then
			fielddata.actions = string.gsub(string.gsub(cmd:sub(4), "&gt;", ">"), "&lt;", "<")
		elseif fielddata.repmode=="concat" then
			fielddata.actions = fielddata.actions.." "..string.gsub(string.gsub(cmd:sub(4), "&gt;", ">"), "&lt;", "<")
		end    
	end
    if c[1] == "fieldui" then
		if c[2] == "remove" then for i=350,356 do ui.removeTextArea(i,c[3]) end
		elseif c[2] == "repmode" then if fielddata.repmode=="ovr" then fielddata.repmode="concat" elseif fielddata.repmode=="concat" then fielddata.repmode="ovr" end
		else fieldui(c[2],c[3],fielddata.header,{actions=fielddata.actions,score=fielddata.score,field1=fielddata.field1,field2=fielddata.field2,field3=fielddata.field3}) end
    end
    if c[1] == "np" then
		tfm.exec.newGame(c[2])
    end
    if c[1] == "np*" then
		tfm.exec.newGame(c[2],true)
    end
    if c[1] == "gset" then
		tfm.exec.setWorldGravity(nil,c[2])
    end
    if c[1] == "wset" then
		tfm.exec.setWorldGravity(c[2],nil)
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
		if type(tonumber(c[2]))=="number" then c[2]=tonumber(c[2]) else c[2]=0 end
		if type(tonumber(c[3]))=="number" then c[3]=tonumber(c[3]) else c[3]=0 end
		for i = 1, c[2] - 1 do
			tfm.exec.addPhysicObject(-968 .. i * 1000,math.floor(c[3]/(c[2]) * i),400,{type=9,restitution=0.2,friction=5,angle=0,width=10,height=3000,dynamic=false,mass=0,miceCollision=true})
			debprint("<o>"..math.floor(c[3]/(c[2]) * i).." <V>".. -968 .. i * 1000)
			if c[3] / c[2] < 1.5 then error0x8(name,(c[3]/c[2])^-1,1.5^-1) break end
			if c[2] > 400 then break end
		end
    end
	if c[1] == "userdata" and hosts[name] then
		if c[2]=="set" then
			if not (c[3] or c[4] or c[5]) then
			else
				if c[5]=="true" then 
					c[5]=true 
				elseif c[5]=="false" then 
					c[5]=false 
				elseif tonumber(c[5]) then 
					c[5]=tonumber(c[5]) 
				end
				userData[c[3]][c[4]]=c[5]
			end
		else
			c[2] = c[2] or name
			if not contestants[c[2]] then 
			else
				debdata.userdata[name] = ""
				for k,v in next,userData[c[2]] do debdata.userdata[name] = debdata.userdata[name].."<BV>"..tostring(k)..": <D>"..tostring(v).."\n" end
				hostinfo(3,name)
			end	
		end
	end
    if c[1] == "sp" and hosts[name] then
		for i=2,#c do
			spectators[c[i]] = true
			tfm.exec.killPlayer(c[i])
			tfm.exec.setPlayerScore(c[i],-100,false)
			ui.updateTextArea(0,"<CE>"..trans[251].." "..trans[221]..":<CS> "..trans[272],c[i])
		end
		deb(nil,"debdata","<V><b>[eventRole]</b></V> <BL>"..tostring(name))
		deb(nil,"debdisplay")
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
		if c[7] == "-a" or c[8] == "-a" then txtidoffset = 0 debprint(txtidoffset) else txtidoffset = 470000 end
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
		debprint(tp[c[2]].x) debprint(tp[c[2]].y)
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
    if c[1] == "action" and hosts[name] then 
			if c[2]:sub(1,12)=="superpowers:" then 
				if userData[c[3]].allowedSuperpowers[c[2]:sub(13)]==false then userData[c[3]].allowedSuperpowers[c[2]:sub(13)]=true hcCmdFeedback(infpref..c[3].." "..trans[297].." "..c[2]..".") else userData[c[3]].allowedSuperpowers[c[2]:sub(13)]=false hcCmdFeedback(infpref..c[3].." "..trans[298].." "..c[2]..".") end
			else error0x6(name)
			end
    end
    if c[1] == "startfrom" and hosts[name] then
		c[2] = tonumber(c[2])
		if type(c[2]) == "number" then
			if SETUP.challengemode=="survival" then
				survrounds = c[2]
			elseif SETUP.challengemode=="racing" then
				pkg.round = c[2]
			elseif SETUP.challengemode=="defilante" then
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
			local allObjectsUnlocked = false
			for i=1,#c do
				if c[i]=="-a" then debprint("<VI>"..i) allObjectsUnlocked = true c[i]=nil end
			end
			c[2] = c[2] or 0 --mgoc
			c[3] = c[3] or 3000 --platums
			c[4] = c[4] or 850 --augstums
			c[5] = c[5] or 8 --fons
			c[6] = c[6] or 6 --tips
			if c[7] then c[7] = tonumber(c[7],16) end --krāsa
			if allObjectsUnlocked then
				debprint("<VI>allObjectsUnlocked")
				if #objtable==0 then
					debprint("<VI>objtable")
					objtable = {0,}
					for i=0,2900 do 
						objtable[#objtable+1]=i 
					end
				end
				inheritobjects = 'shaman_tools="'..table.concat(objtable,",")..'"'; debprint("<VI>inheritobjects")
			else 
				inheritobjects = ""; debprint("<R>inheritobjects")
			end
			inheritmgoc = c[2] inheritwidth = c[3] inheritheight = c[4] inheritbg = c[5] inherittype = c[6] inheritcolor = c[7]
			tfm.exec.newGame('<C><P '..inheritobjects..' H="'..c[4]..'" F="'..c[5]..'" L="'..c[3]..'" mgoc="'..c[2]..'" bh=""/><Z><S /><D /><O /></Z></C>')
			for i=0,math.ceil((c[3]/3000)-1) do
				tfm.exec.addPhysicObject(-888 - i,1500 + (i * 3000),c[4] - 25,{type=c[6],width=3000,height=50,restitution=0.2,friction=0.3,color=c[7]})
			end
    end
	if c[1] == "mp" and hosts[name] then
		c[2] = c[2] or 0 --mgoc
		c[3] = c[3] or "space" --preset
		if c[3] == "space" then tfm.exec.newGame('<C><P meta="Syrius#8114,901" L="1800" H="1012" G="0,4" mgoc="'..c[2]..'" bh=""/><Z><S><S X="900" Y="506" T="5" L="10" H="10" P="0,0,0.3,0.2,0,0,0,0" c="4" i="-895,-501,16caa1a14c3.png"/></S><D/><O/><L/></Z></C>') inheritmgoc = c[2] inheritwidth = 1800 inheritheight = 1012 inheritbg = -1 inherittype = 14 inheritcolor = 0 end 
		if c[3] == "spacelarge" then tfm.exec.newGame('<C><P meta="Syrius#8114,902" L="3840" H="1400" G="0,4" mgoc="'..c[2]..'" bh=""/><Z><S><S X="1925" Y="705" T="14" L="10" H="10" P="0,0,0.3,0.2,0,0,0,0" c="4" i="-1920,-700,171083c3cd2.jpg"/></S><D/><O/><L/></Z></C>') inheritmgoc = c[2] inheritwidth = 3840 inheritheight = 1400 inheritbg = -1 inherittype = 14 inheritcolor = 0 end 
		if c[3] == "bluemoon" then tfm.exec.newGame('<C><P meta="Syrius#8114,903" L="3840" H="1200" mgoc="'..c[2]..'" bh=""/><Z><S><S X="1925" Y="605" T="3" L="10" H="10" P="0,0,0,20,0,0,0,0" c="4" i="-1920,-600,17131549f22.jpg"/></S><D/><O/><L/></Z></C>') md() tfm.exec.addJoint(-19865,1,1,{type=0,point1="1,1175",point2="3840,1175",line=50,color=0x204080,alpha=0.5,foreground=true}) inheritmgoc = c[2] inheritwidth = 3840 inheritheight = 1200 inheritbg = -1 inherittype = 7 inheritcolor = 0 end 
		if c[3] == "winter" then tfm.exec.newGame('<C><P meta="Syrius#8114,904" L="3720" H="750" mgoc="'..c[2]..'" bh=""/><Z><S><S X="1870" Y="380" T="3" L="10" H="10" P="0,0,0,20,0,0,0,0" c="4" i="-1865,-375,171317b7194.png"/></S><D/><O/><L/></Z></C>') inheritmgoc = c[2] inheritwidth = 3720 inheritheight = 760 inheritbg = -1 inherittype = 14 inheritcolor = 0 end 
		for i=0,math.ceil((inheritwidth/3000)-1) do
			tfm.exec.addPhysicObject(-888 - i,1500 + (i * 3000),inheritheight - 25,{type=inherittype,width=3000,height=50,restitution=0.2,friction=0.3,color=inheritcolor})
		end
	end
	if c[1] == "tr" and hosts[name] then
		hcCmdFeedback(infpref..trans[252].." "..c[2].." - "..tostring(trans[tonumber(c[2])]))
	end
	if c[1] == "for" and hosts[name] then
		ui.addPopup(398,2,"<p align='center'><font size='16' color='#84b7d1'><b>"..trans[307].."</b></font>\n<font size='10'>%i = "..trans[314].."</font>",name,440,startmenuy,340,true)
		iterArgs = {c[2],c[3],c[4],name}
	end
	if c[1] == "foreach" and hosts[name] then
		if _G[c[2]]~=nil then
			ui.addPopup(399,2,"<p align='center'><font size='16' color='#84b7d1'><b>"..trans[307].."</b></font>\n<font size='10'>%k = "..trans[310]..", %v = "..trans[311].."</font>",name,440,startmenuy,340,true)
			foreachArgs = c[2]
		end
	end
	if c[1] == "debug" and hosts[name] then
		if SETUP.debug==true then
			_G[c[2]](c[3],c[4],c[5],c[6],c[7],c[8],c[9],c[10],c[11],c[12],c[13],c[14],c[15],c[16])
		else error0x1(name,cmd) end
	end
    if c[1] == "role" and hosts[name] then
		    if c[2] == "+" then
				if c[3] == "host" then if contestants[c[4]] then hosts[c[4]] = true eventRole(c[4]) hcCmdFeedback(infpref..c[4].." "..trans[213])  end end
				if c[3] == "helper" then if contestants[c[4]] then helpers[c[4]] = true eventRole(c[4]) hcCmdFeedback(infpref..c[4].." "..trans[214])  end end
			end
		    if c[2] == "-" then
				if c[3] == "host" then if contestants[c[4]] then hosts[c[4]] = false eventRole(c[4]) hcCmdFeedback(infpref..c[4].." "..trans[215])  end end
				if c[3] == "helper" then if contestants[c[4]] then helpers[c[4]] = false eventRole(c[4]) hcCmdFeedback(infpref..c[4].." "..trans[216])  end end
			end
		end
    if c[1] == "p" and hosts[name] then
        ui.addPopup(c[2], c[3],string.gsub(string.gsub(string.gsub(c[4], "&gt;", ">"), "&lt;", "<"), "|", " "),nil, nil, 100, 250, 400, true)
    end
    if c[1] == "set" and hosts[name] then
			if c[3]=="true" then c[3]=true elseif c[3]=="false" then c[3]=false end
			SETUP[c[2]]=c[3]		
			hcCmdFeedback(infpref..c[2].." = "..tostring(c[3]))
    end
	if c[1] == "setfreq" then
		if SETUP.challengemode=="mono" then
			monofreq[1]=tonumber(c[2]) or 10
			monofreq[2]=tonumber(c[3]) or 3
			deb(nil,"debdata","<J><b>[monofreq]</b> monorot_hard="..monofreq[1].." monorot="..monofreq[2].."</J>")
		end
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
    if c[1] == "t" and hosts[name] then
		tfm.exec.setGameTime(c[2])
    end

end
deb(nil,"debdisplay")
end
-- Slēptās komandas
system.disableChatCommandDisplay(nil)

-- [[Utilijas]]

-- Rangs
function range(a,b)
	local r = {}
	for i=a,b do 
		r[#r+1]=i
	end
	return r
end

-- Markdown komanda
function md()
tfm.exec.addPhysicObject(1,400,-600,{type=0,width=10,height=10,foreground=true,friction=0.3,restitution=0,dynamic=false,miceCollision=true,groundCollision=true})
end

-- Dummy
function none()
end

objects={}

-- Clear
function clear(type)
	for k,v in pairs(tfm.get.room.objectList) do
		if tonumber(type)~=nil then 
			if k.type==type then
				table.insert(objects,k)
			end
		else
			table.insert(objects,k)
		end
	end
	for i,object in ipairs(objects) do
		tfm.exec.removeObject(object)
	end
end

-- Kļūdas

function error0x1(name,cmd,id)
	errn1 = name errc1 = cmd erri1 = id or 0
	for k,v in next,hosts do
		ui.updateTextArea(33,"<black><b>• [$"..name.."]</b> "..trans[217],k)
		ui.updateTextArea(32,"<warn><b>• <a href='event:error0x1'>[$"..name.."]</a></b> "..trans[217],k)
	end
	ui.updateTextArea(33,"<black><b>• [$"..name.."]</b> "..trans[217],name)
	ui.updateTextArea(32,"<warn><b>• <a href='event:error0x1'>[$"..name.."]</a></b> "..trans[217],name)
	errbuf("<warn><b>• [$"..name.."]</b> "..trans[217].." <BL><font size='10'>("..errc1..","..erri1..")</font></BL>")
	deb(nil,"debdata","<warn><b>[ERR]</b> 0x1 "..tostring(name).." «"..tostring(cmd).."» "..tostring(id))
	deb(nil,"debdisplay")
end
function error0x2(name,cmd)
	for k,v in next,hosts do
		ui.updateTextArea(33,"<black><b>• [$"..name.."]</b> "..trans[218],k)
		ui.updateTextArea(32,"<warn><b>• [$"..name.."]</b> "..trans[218],k)
	end
	ui.updateTextArea(33,"<black><b>• [$"..name.."]</b> "..trans[218],name)
	ui.updateTextArea(32,"<warn><b>• [$"..name.."]</b> "..trans[218],name)
	errbuf("<warn><b>• [$"..name.."]</b> "..trans[218])
	deb(nil,"debdata","<warn><b>[ERR]</b> 0x2 "..tostring(name).." «"..tostring(cmd).."»")
	deb(nil,"debdisplay")
end
function error0x3(name)
	for k,v in next,hosts do
		ui.updateTextArea(33,"<black><b>• [$"..name.."]</b> "..trans[253],k)
		ui.updateTextArea(32,"<warn><b>• [$"..name.."]</b> "..trans[253],k)
	end
	ui.updateTextArea(33,"<black><b>• [$"..name.."]</b> "..trans[253],name)
	ui.updateTextArea(32,"<warn><b>• [$"..name.."]</b> "..trans[253],name)
	errbuf("<warn><b>• [$"..name.."]</b> "..trans[253])
	deb(nil,"debdata","<warn><b>[ERR]</b> 0x3 "..tostring(name))
	deb(nil,"debdisplay")
end
function error0x4(name,placed,allowed)
	for k,v in next,hosts do
		ui.updateTextArea(33,"<black><b>• [$"..name.."]</b> "..trans[264].." "..placed.." / "..allowed,k)
		ui.updateTextArea(32,"<warn><b>• [$"..name.."]</b> "..trans[264].." "..placed.." / "..allowed,k)
	end
	ui.updateTextArea(33,"<black><b>• [$"..name.."]</b> "..trans[264].." "..placed.." / "..allowed,name)
	ui.updateTextArea(32,"<warn><b>• [$"..name.."]</b> "..trans[264].." "..placed.." / "..allowed,name)
	errbuf("<warn><b>• [$"..name.."]</b> "..trans[264].." "..placed.." / "..allowed)
	deb(nil,"debdata","<warn><b>[ERR]</b> 0x4 "..tostring(name).." "..tostring(placed).." "..tostring(allowed))
	deb(nil,"debdisplay")
end
function error0x5(name)
	for k,v in next,hosts do
		ui.updateTextArea(33,"<black><b>• [$"..name.."]</b> "..trans[273],k)
		ui.updateTextArea(32,"<warn><b>• [$"..name.."]</b> "..trans[273],k)
	end
	ui.updateTextArea(33,"<black><b>• [$"..name.."]</b> "..trans[273],name)
	ui.updateTextArea(32,"<warn><b>• [$"..name.."]</b> "..trans[273],name)
	errbuf("<warn><b>• [$"..name.."]</b> "..trans[273])
	deb(nil,"debdata","<warn><b>[ERR]</b> 0x5 "..tostring(name))
	deb(nil,"debdisplay")
end
function error0x6(name)
	for k,v in next,hosts do
		ui.updateTextArea(33,"<black><b>• [$"..name.."]</b> "..trans[296],k)
		ui.updateTextArea(32,"<warn><b>• [$"..name.."]</b> "..trans[296],k)
	end
	ui.updateTextArea(33,"<black><b>• [$"..name.."]</b> "..trans[296],name)
	ui.updateTextArea(32,"<warn><b>• [$"..name.."]</b> "..trans[296],name)
	errbuf("<warn><b>• [$"..name.."]</b> "..trans[296])
	deb(nil,"debdata","<warn><b>[ERR]</b> 0x6 "..tostring(name))
	deb(nil,"debdisplay")
end
function error0x7(name)
	for k,v in next,hosts do
		ui.updateTextArea(33,"<black><b>• [$"..name.."]</b> "..trans[289]..": "..trans[290],k)
		ui.updateTextArea(32,"<wy><b>• [$"..name.."]</b> "..trans[289]..": "..trans[290],k)
	end
	ui.updateTextArea(33,"<black><b>• [$"..name.."]</b> "..trans[289]..": "..trans[290],name)
	ui.updateTextArea(32,"<wy><b>• [$"..name.."]</b> "..trans[289]..": "..trans[290],name)
	errbuf("<wy><b>• [$"..name.."]</b> "..trans[289]..": "..trans[290])
	deb(nil,"debdata","<warn><b>[ERR]</b> 0x7 "..tostring(name))
	deb(nil,"debdisplay")
end
function error0x8(name,placed,allowed)
	for k,v in next,hosts do
		ui.updateTextArea(33,"<black><b>• [$"..name.."]</b> "..trans[279].." "..placed.." / "..allowed,k)
		ui.updateTextArea(32,"<warn><b>• [$"..name.."]</b> "..trans[279].." "..placed.." / "..allowed,k)
	end
	ui.updateTextArea(33,"<black><b>• [$"..name.."]</b> "..trans[279].." "..placed.." / "..allowed,name)
	ui.updateTextArea(32,"<warn><b>• [$"..name.."]</b> "..trans[279].." "..placed.." / "..allowed,name)
	errbuf("<warn><b>• [$"..name.."]</b> "..trans[279].." "..placed.." / "..allowed)
	deb(nil,"debdata","<warn><b>[ERR]</b> 0x8 "..tostring(name).." "..tostring(placed).." "..tostring(allowed))	
	deb(nil,"debdisplay")
end

-- Hostu interfeiss
hidata = {[1] = "<p align='center'><font size='14'><VP><a href='event:hipage'>1</a></VP>\n<vi>－</vi>\n<a href='event:say_vn'><bv><font face='Wingdings'>L</font></bv></a>\n<a href='event:nextmap'><bv><font face='Webdings'>8</font></bv></a>\n<a href='event:reload'><bv><font face='Wingdings 3'>P</font></bv></a>\n<a href='event:r_all'><bv><font face='Webdings'>h</font></bv></a>\n<bv><a href='event:host.chpos'><font face='Wingdings 3'>B</font></a></bv>\n<vi>－</vi>\n<a href='event:conf'><warn><font face='Wingdings'>N</font></font></a>",[2] = "<p align='center'><font size='14'><VP><a href='event:hipage'>2</a></VP>\n<vi>－</vi>\n<a href='event:ptag'><grbl><font face='Webdings'>i</font></a><//font>\n<a href='event:ptag_edit'><grbl><font face='Webdings'>@</font></a></font>\n<a href='event:disq'><bv><font face='Wingdings 3'>7</font></a></bv></p>"}
hipos = {[1] = {x = -23,y = 27},[2] = {x=5,y=55},[3] = {x = 803,y = 27},[4] = {x=775,y=55}}
function hostinterfaces(name)
	if hosts[name] or helpers[name] then
		ui.addTextArea(450, hidata[userData[name].histate], name, hipos[userData[name].hipstate].x, hipos[userData[name].hipstate].y, 20, 165, theme[SETUP.theme].windowColor, theme[SETUP.theme].windowBorderColor, theme[SETUP.theme].bcTransparency, true)
		if SETUP.challengemode == "build" then
			ui.addTextArea(451, "<font size='14'><p align='center'><a href='event:toggleborder'><"..theme[SETUP.theme].panelCommonItemColor.."><font face='Wingdings 3'>F</font></"..theme[SETUP.theme].panelCommonItemColor.."></a>\n<a href='event:togglesailwater'><"..theme[SETUP.theme].panelCommonItemColor.."><font face='Wingdings'>h</font></"..theme[SETUP.theme].panelCommonItemColor.."></a>", name, hipos[userData[name].hipstate].x, hipos[userData[name].hipstate].y + 185, 20, 38, theme[SETUP.theme].windowColor, theme[SETUP.theme].windowBorderColor, theme[SETUP.theme].bcTransparency, true)
		end
		hcCmdFeedback(infpref..trans[235].." (<grbl>"..name.."</grbl><lbrp>)")
	end
end

-- Koordinātu printeris

local holding = {
	shift = {},
	e = {},
	l = {},
	ctrl = {},
	backtick = {},
	equ = {},
	dot = {},
	hyphen = {},
	deb = {}
}

scorestring = ""

function visualScoreboard(name)
	scorestring = ""
	for k,v in next,tfm.get.room.playerList do scorestring = scorestring.."<BV>"..tostring(k)..": <D>"..tostring(v.score).."\n" end
	if userData[name].visualScoreboard==false then ui.addTextArea(17, scorestring, name, 30, 80, 300, nil, theme[SETUP.theme].windowColor2, theme[SETUP.theme].windowColor2, 0.65, true) userData[name].visualScoreboard=true
	elseif userData[name].visualScoreboard==true then ui.removeTextArea(17,name) userData[name].visualScoreboard=false end
end

function eventKeyboard(n, key, down, x, y)
if key==34 and hosts[n] then 
	if userData[n].keyset==1 then 
		rel(n) trainingcore(n,"keyboard:reload")
	elseif userData[n].keyset==2 then 
		table.foreach(tfm.get.room.playerList, tfm.exec.respawnPlayer) trainingcore(n,"keyboard:respawnall")
	end
elseif key==0 and userData[n].tfm == true then if hosts[n] or helpers[n] then tfm.exec.movePlayer(n,0,0,true,-15,0,true) end
elseif key==1 and userData[n].tfm == true then if hosts[n] or helpers[n] then tfm.exec.movePlayer(n,0,0,true,0,-16,true) end
elseif key==2 and userData[n].tfm == true then if hosts[n] or helpers[n] then tfm.exec.movePlayer(n,0,0,true,15,0,true) end
elseif key==3 and userData[n].tfm == true then if hosts[n] or helpers[n] then tfm.exec.movePlayer(n,0,0,true,0,16,true) end
elseif key==17 or key==9 then holding.ctrl[n] = down
elseif key==33 then 
	if userData[n].keyset==1 or userData[n].keyset==2 then 
		nm(n) trainingcore(n,"keyboard:nextmap") 
	end
elseif key==16 then holding.shift[n] = down
elseif key==18 and hosts[n] then 
	if userData[n].keyset==2 then 
		rel(n) trainingcore(n,"keyboard:reload")
	end
elseif key==67 then visualScoreboard(n)
elseif key==69 then holding.e[n] = down
elseif key==76 then holding.l[n] = down
elseif key==120 then holding.deb[n] = down
elseif key==187 then holding.equ[n] = down
elseif key==189 then holding.hyphen[n] = down
elseif key==190 then holding.dot[n] = down
elseif key==192 then holding.backtick[n] = down
end 
  if holding.deb[n] and SETUP.debug==true then
		if holding.e[n] then if debdata.open[n] == true then deb(n,"remove") else deb(n,"force") end end
		if holding.shift[n] then deb(nil,"clear") deb(nil,"debdisplay") end
		if holding.ctrl[n] then deb(nil,"store") end
  end
end

function eventMouse(n, x, y)
  if holding.shift[n] and userData[n].allowedSuperpowers.getcoordinates==true then
    trainingcore(n,"superpowers:getcoordinates;"..x..";"..y)
    ui.updateTextArea(33,"<black>• "..n .." "..trans[220].." X:" .. x .. ", Y:" .. y,nil)
    ui.updateTextArea(32,"<BV>• "..n .." "..trans[220].." X:" .. x .. ", Y:" .. y,nil)
    print("<BV>• "..n .." "..trans[220].." X:" .. x .. ", Y:" .. y)
  end
  if holding.backtick[n] and userData[n].allowedSuperpowers.conjuration==true then
    trainingcore(n,"superpowers:conjuration;"..x..";"..y)
    tfm.exec.addConjuration(x/10,y/10,9999999)
  end
  if holding.e[n] and userData[n].allowedSuperpowers.explosion==true then
		trainingcore(n,"superpowers:explosion;"..x..";"..y)
		tfm.exec.explosion(x,y,20,50,false)
		tfm.exec.displayParticle(12,x,y,0,0,0,0,nil)
  end
	if holding.ctrl[n] and userData[n].allowedSuperpowers.teleport==true then
		trainingcore(n,"superpowers:teleport;"..x..";"..y)
		tfm.exec.movePlayer(n,x,y)
		tfm.exec.displayParticle(36,x,y,0,0,0,0,nil)
	end
	if holding.l[n] and userData[n].allowedSuperpowers.launch==true then
		trainingcore(n,"superpowers:launch;"..x..";"..y..";"..x-tfm.get.room.playerList[n].x..";"..y-tfm.get.room.playerList[n].y)
		tfm.exec.movePlayer(n,0,0,true,(x-tfm.get.room.playerList[n].x),(y-tfm.get.room.playerList[n].y))
		tfm.exec.displayParticle(26,x,y,(x-tfm.get.room.playerList[n].x),(y-tfm.get.room.playerList[n].y))
	end
end

table.foreach(tfm.get.room.playerList, eventNewPlayer)
ui.addTextArea(8889, "", name, 500, 350, 300, 100, theme[SETUP.theme].welcomeScreenColor, theme[SETUP.theme].welcomeScreenColor, 1, true)

-- HostCore
function initHostcore(name)
ui.addTextArea(10, "", name,theme[SETUP.theme].bcX, 25, theme[SETUP.theme].bcWidth, theme[SETUP.theme].hcHeight, theme[SETUP.theme].bcBackground, theme[SETUP.theme].windowBorderColor, theme[SETUP.theme].bcTransparency, true)
ui.addTextArea(65, miscpref..trans[222], name, theme[SETUP.theme].bcX, 25, theme[SETUP.theme].bcWidth, 20, 0x324650, 0x000000, 0, true)
ui.addTextArea(0, "<p align='center'><font size='"..theme[SETUP.theme].bcFontSize.."'><ROSE>"..title.."</font></p>",name,theme[SETUP.theme].bcX, -tonumber(theme[SETUP.theme].bcHeight), theme[SETUP.theme].bcWidth, theme[SETUP.theme].bcHeight, theme[SETUP.theme].bcBackground, theme[SETUP.theme].windowBorderColor, theme[SETUP.theme].bcTransparency, true)
ui.addTextArea(64, infpref..trans[223].." <V>"..version.."</V> / "..trans[224].." <V>"..tfm.get.room.owner.."</V>", name, theme[SETUP.theme].bcX, 40, theme[SETUP.theme].bcWidth, 20, 0x324650, 0x000000, 0, true)
end

-- eventPlayerDied

function eventPlayerDied(name)
	if SETUP.challengemode=="mono" then
		tfm.exec.setPlayerScore(name,5,true)
		if disq[name] or spectators[name] then else tfm.exec.respawnPlayer(name) end 
	end
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
--###################$201###$202####$703#####$701#####$203###$204####$205####$206###$207####$208#####$209
survrot = {7482494,7602083,7602098,7605138,7605136,7622015,7637491,7645184,7645263,7694355,7694357,7694359}
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

function buildborder(name)
if tonumber(inheritheight) > 2050 then error0x7(name) end
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
function eventPlayerWon(name, timeElapsed, timeElapsedSinceRespawn)
	if SETUP.challengemode == "mono" then
		tfm.exec.respawnPlayer(name)
		if monorounds%monofreq[1]==0 then
			tfm.exec.setPlayerScore(name,-50,true)
		else
			tfm.exec.setPlayerScore(name,-10,true)
		end
	end
	if SETUP.challengemode == "racing" then
		first = first + 1
		if first == 1 then
			tfm.exec.setPlayerScore(name,60,true)
			ui.updateTextArea(33,"<black>• "..pkg.round..trans[40].." "..trans[233].." "..name.." "..trans[231],nil)
			ui.updateTextArea(32,"<D>• "..pkg.round..trans[40].." "..trans[233].." "..name.." "..trans[231],nil)
			print("<D>• "..pkg.round..trans[40].." "..trans[233].." "..name.." "..trans[231])
 		elseif first > 1 then tfm.exec.setPlayerScore(name,10,true)
	 end
	end
end

function eventPlayerBonusGrabbed(name, bonusId)
	if SETUP.challengemode == "defilante" then
		tfm.exec.setPlayerScore(name,1,true)	
	end
end
-- [[30 SEKUNŽU CHALLENGE UTILIJAS]]
--##########$302#####$303#####$304###$307###$308#####$309####$310###$311###$312####$313######$314###$315####$316#####$317####$318##$319####$320######$321####$322####$323###$324####$325#####$326#####$327###$328####$329###$330###$331######$332####$333####$334#####$335####$336####$337####$338
threerot = {7612717,6265169,6847550,6370623,6333089,6565399,7612788,6975155,7574375,7612773,7612785,6370622,6334320,7612776,7612782,7574389,7574667,7574973,7574975,7574982,7574984,7574997,7574999,7576032,7575113,7576033,7576035,7576224,7576229,7614125,7620702,7695859,7695860,7695873,7695875}

function newMap()
	tfm.exec.newGame(threerot[math.random(#threerot)]) 
end

-- [[VIENZEMJU CHALLENGE UTILIJAS]]

--################$801#####$803####$804###$806####$810#####812####$814####$815####$818####$821####$822####$824####$825####$826####$833####$835####$837####$838####$839####$840####$843####$846####$849####$851####$871####$872
monorot_easy = {7653375,7653377,7653379,7653488,7653493,7653503,7653505,7653518,7653532,7653562,7653563,7653567,7653569,7653570,7653637,7653674,7653676,7653677,7653697,7653698,7653825,7653835,7653839,7654114,7752415,7752416}
--##########$802#####$805###$807####$808#####$809####$811####$813####$817####$819####$820####$823####$828####$829####$830####$831####$834####$836####$842####$848####$850####$852####$854####$855####$856####$857####$858####$859####$860####$861####$863####$868###$870####$873
monorot = {7653376,7653487,7653489,7653490,7653491,7653494,7653504,7653520,7653533,7653561,7653565,7653630,7653631,7653633,7653635,7653638,7653675,7653824,7653837,7654113,7654115,7698172,7698174,7698177,7698178,7698179,7698180,7698182,7698183,7698424,7700193,7752414,7752417}
--################$816###$827######$832####$841####$844####$845####$847####$853###$862####$864#####$865###$866####$867#####$869
monorot_hard = {7653519,7653571,7653636,7653699,7653826,7653834,7653836,7698164,7698422,7698426,7698836,7698964,7700191,7700196}

monorounds=0
monofreq={10,3} -- grūto mapju biežums & parasto mapju biežums
if SETUP.challengemode == "mono" then tfm.exec.disableAutoTimeLeft(true) end
function nextMonoMap()
	monorounds=monorounds+1
	if monorounds%monofreq[1]==0 then 
		tfm.exec.newGame(monorot_hard[math.random(#monorot_hard)]) 
		deb(nil,"debdata","<V><b>[nextMonoMap]</b></V> <O>"..tostring(monorounds).." "..tostring(monorounds%monofreq[1]).." monorot_hard")			
	elseif monorounds%monofreq[2]==0 then 	
		tfm.exec.newGame(monorot[math.random(#monorot)]) 
		deb(nil,"debdata","<V><b>[nextMonoMap]</b></V> <O>"..tostring(monorounds).." "..tostring(monorounds%monofreq[2]).." monorot")			
	else
		tfm.exec.newGame(monorot_easy[math.random(#monorot_easy)])
		deb(nil,"debdata","<V><b>[nextMonoMap]</b></V> <O>"..tostring(monorounds).." monorot_easy") 
	end
		deb(nil,"debdisplay") 
end

function eventNewGame()
	if SETUP.challengemode=="thirty" then
		tfm.exec.setGameTime(30)
 		ui.addTextArea(24,"", nil, 745, 25, 70, 40, 0x000022, 0x000022, 0, true)
	end
	if SETUP.challengemode=="mono" then
      for name,player in next,tfm.get.room.playerList do
          tfm.exec.freezePlayer(name,false)
      end
		if monorounds%monofreq[1]==0 then tfm.exec.setGameTime(120) elseif monorounds%monofreq[2]==0 then tfm.exec.setGameTime(60) else tfm.exec.setGameTime(30) end
 		ui.addTextArea(24,"", nil, 745, 25, 70, 40, 0x000022, 0x000022, 0, true)
	end
		local Ptag = string.match(tfm.get.room.xmlMapInfo.xml, "<P (.-)/>") or ""
		local meta = string.match(Ptag, 'meta ?= ?"(.-)"')
		local mapName
	if meta then
		mapName = string.gsub(meta, ",", "<BL> - $", 1).."</BL>"
		deb(nil,"debdata","<J><b>[meta]</b> "..meta.."</J>")
		deb(nil,"debdisplay")
    	ui.setMapName(mapName)
	end
		if Ptag:find('directive="LoadAsXML"') then tfm.exec.newGame(tfm.get.room.xmlMapInfo.xml) end
	if SETUP.challengemode == "racing" then
		pkg.round = pkg.round + 1
		ui.updateTextArea(0,"<ROSE><font size='"..theme[SETUP.theme].bcFontSize.."'>"..pkg.round..trans[40].." "..trans[229].."</font>", nil)
		first=0
	end
	if SETUP.challengemode == "defilante" then
		pkg.round = pkg.round + 1
		ui.updateTextArea(0,"<ROSE><font size='"..theme[SETUP.theme].bcFontSize.."'>"..pkg.round..trans[40].." "..trans[229].."</font>", nil)
		tfm.exec.setGameTime(120)
 		ui.addTextArea(24,"", nil, 745, 25, 70, 40, 0x000022, 0x000022, 0, true)
	end

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
	if SETUP.challengemode=="mono" then
 		ui.updateTextArea(24, "<p align='center'><font size='14'><D>"..math.ceil(rmng/1000), nil)
 		if rmng <= 0 then table.foreach(tfm.get.room.playerList,tfm.exec.freezePlayer) end
 		if rmng <= -3 and SETUP.autoplay == true then nextMonoMap() end
	end
	if SETUP.challengemode=="defilante" then
 		ui.updateTextArea(24, "<p align='center'><font size='14'><D>"..math.ceil(rmng/1000), nil)
 		if rmng <= 0 then table.foreach(tfm.get.room.playerList,tfm.exec.killPlayer) end
 		if rmng <= -3 and SETUP.autoplay == true then packageutils() end
	end
	if SETUP.challengemode=="survival" then
 		if rmng <= -3 and SETUP.autoplay == true then survRound() end
	end
	if SETUP.challengemode=="racing" then
 		if rmng <= -3 and SETUP.autoplay == true then packageutils() end
	end
	if SETUP.challengemode=="vanilla" then
 		if rmng <= -3 and SETUP.autoplay == true then nextMap() end
	end
end

function test()
tfm.exec.newGame(survtest)
end

function eventTextAreaCallback(textAreaID, name, callback)
	if callback=="spectate" then
		trainingcore(name,"panel:spectate_legacy")
		ui.removeTextArea(100,name)
		ui.updateTextArea(101,"<R><font size='40'><p align='center'>"..trans[239].."</p></font>\n<N2><font size='24'><p align='center'>"..trans[211].."</p></font>",name)
	end
	if callback=="toggleborder" then
		trainingcore(name,"panel:toggleborder")
		buildborder(name)
	end
	if callback=="togglesailwater" then
		trainingcore(name,"panel:togglesailwater")
		buildshipready()
	end
	if callback=="init_hostcore" and hosts[name] then
		initHostcore(name)
		print(syspref.." "..trans[206].." (<V>"..name.."</V>)")
		ui.updateTextArea(65,syspref.." "..trans[206].." (<V>"..name.."</V>)",nil)
		trainingcore(name,"panel:hostcore")
	end
 	if callback=="r_all" then
		table.foreach(tfm.get.room.playerList, tfm.exec.respawnPlayer)
		trainingcore(name,"panel:respawnall")
	end
 	if callback=="ptag" then
		local Ptag = string.match(tfm.get.room.xmlMapInfo.xml, "<P (.-)/>") or ""
		if holding.ctrl[name] then
			notepad[#notepad+1] = "<font face='Lucida Console,Menlo' color='#b3b3ff' size='10'>&lt;P<br>"..Ptag.."<br>/&gt;</font>"
			trainingcore(name,"panel:ptag;$notepad"..#notepad)
		elseif holding.shift[name] or #Ptag>120 then
			fieldui("notepad",name,"",{field1="<font face='Lucida Console,Menlo' size='10' color='#b3b3ff'>&lt;P<br>"..Ptag.."<br>/&gt;</font>",actions="<ROSE><a href='event:rmfieldui'>"..trans[242].."</a></ROSE>"})
			trainingcore(name,"panel:ptag*")
		else
			ui.addPopup(501, 0, "<font face='Lucida Console,Menlo' color='#b3b3ff'>&lt;P<br>"..Ptag.."<br>/&gt;</font>", name, 250, 200, 300, true)
			trainingcore(name,"panel:ptag")
		end
	end
	if callback=="ptag_edit" then
		local Ptag = string.match(tfm.get.room.xmlMapInfo.xml, "<P (.-)/>") or ""
		ui.addPopup(501, 2, "<font face='Lucida Console,Menlo' color='#b3b3ff'><font color='#6C77C1'>&lt;P</font><br>"..Ptag.."<br><font color='#6C77C1'>/&gt;</font></font>", name, 250, 200, 300, true)
	end
	if callback=="help" then
		hostinfo(4,name)
	end
 	if callback=="hc.actionlog" then
		showbuffer(0,name)
		trainingcore(name,"hostcore:toggleactionlog")
	end
 	if callback=="hc.errorlog" then
		showbuffer(1,name)
		trainingcore(name,"hostcore:toggleerrorlog")
	end
 	if callback=="hc.commandlog" then
		showbuffer(2,name)
		trainingcore(name,"hostcore:togglecommandlog")
	end
 	if callback=="clear" then
		clear()
		trainingcore(name,"panel:clear")
	end
	if callback=="getInfo" then
		hostinfo(0,name)
 end
	if callback=="setupinf" then
		hostinfo(1,name)
 end
	if callback=="keybinds" then
		hostinfo(2,name)
 end
	if callback=="kbuser1" then
		userData[name].keyset=1
		trainingcore(name,"hostcore:keyset;"..userData[name].keyset)
		hostinfo(2,name)
 end
	if callback=="kbuser2" then
		userData[name].keyset=2
		trainingcore(name,"hostcore:keyset;"..userData[name].keyset)
		hostinfo(2,name)
 end
 	if callback=="infclose" then
		for i=600,605 do ui.removeTextArea(i,name) end trainingcore(name,"hostcore:about_close")
	end
 	if callback=="about" then
		ui.updateTextArea(600, trans[243]..trans[244], name)
		trainingcore(name,"hostcore:about_legacy")
	end
 	if callback=="cn.survival" then
		ui.updateTextArea(8881,"<"..theme[SETUP.theme].welcomeScreenHeadingColor.."><font size='14'><"..theme[SETUP.theme].welcomeScreenDecoColor.."><font face='Wingdings 3'>u</font></"..theme[SETUP.theme].welcomeScreenDecoColor.."> "..trans[104].."</font></"..theme[SETUP.theme].welcomeScreenHeadingColor.."> <"..theme[SETUP.theme].welcomeScreenHighlightColor.."><font size='14'>"..trans[83].."</"..theme[SETUP.theme].welcomeScreenHighlightColor.."></font>\n\n<"..theme[SETUP.theme].welcomeScreenTextColor..">"..trans[183].."</"..theme[SETUP.theme].welcomeScreenTextColor..">",nil)
		ui.removeTextArea(8888,nil)
	end
 	if callback=="cn.iziz" then
		ui.updateTextArea(8881,"<"..theme[SETUP.theme].welcomeScreenHeadingColor.."><font size='14'><"..theme[SETUP.theme].welcomeScreenDecoColor.."><font face='Wingdings 3'>u</font></"..theme[SETUP.theme].welcomeScreenDecoColor.."> "..trans[104].."</font></"..theme[SETUP.theme].welcomeScreenHeadingColor.."> <"..theme[SETUP.theme].welcomeScreenHighlightColor.."><font size='14'>"..trans[88].."</"..theme[SETUP.theme].welcomeScreenHighlightColor.."></font>\n\n<"..theme[SETUP.theme].welcomeScreenTextColor..">"..trans[188].."</"..theme[SETUP.theme].welcomeScreenTextColor..">",nil)
		ui.removeTextArea(8888,nil)
	end
 	if callback=="cn.build" then
		ui.updateTextArea(8881,"<"..theme[SETUP.theme].welcomeScreenHeadingColor.."><font size='14'><"..theme[SETUP.theme].welcomeScreenDecoColor.."><font face='Wingdings 3'>u</font></"..theme[SETUP.theme].welcomeScreenDecoColor.."> "..trans[104].."</font></"..theme[SETUP.theme].welcomeScreenHeadingColor.."> <"..theme[SETUP.theme].welcomeScreenHighlightColor.."><font size='14'>"..trans[87].."</"..theme[SETUP.theme].welcomeScreenHighlightColor.."></font>\n\n<"..theme[SETUP.theme].welcomeScreenTextColor..">"..trans[187].."</"..theme[SETUP.theme].welcomeScreenTextColor..">",nil)
		ui.removeTextArea(8888,nil)
	end
 	if callback=="cn.divine" then
		ui.updateTextArea(8881,"<"..theme[SETUP.theme].welcomeScreenHeadingColor.."><font size='14'><"..theme[SETUP.theme].welcomeScreenDecoColor.."><font face='Wingdings 3'>u</font></"..theme[SETUP.theme].welcomeScreenDecoColor.."> "..trans[104].."</font></"..theme[SETUP.theme].welcomeScreenHeadingColor.."> <"..theme[SETUP.theme].welcomeScreenHighlightColor.."><font size='14'>"..trans[82].."</"..theme[SETUP.theme].welcomeScreenHighlightColor.."></font>\n\n<"..theme[SETUP.theme].welcomeScreenTextColor..">"..trans[182].."</"..theme[SETUP.theme].welcomeScreenTextColor..">",nil)
		ui.removeTextArea(8888,nil)
	end
 	if callback=="cn.nonail" then
		ui.updateTextArea(8881,"<"..theme[SETUP.theme].welcomeScreenHeadingColor.."><font size='14'><"..theme[SETUP.theme].welcomeScreenDecoColor.."><font face='Wingdings 3'>u</font></"..theme[SETUP.theme].welcomeScreenDecoColor.."> "..trans[104].."</font></"..theme[SETUP.theme].welcomeScreenHeadingColor.."> <"..theme[SETUP.theme].welcomeScreenHighlightColor.."><font size='14'>"..trans[81].."</"..theme[SETUP.theme].welcomeScreenHighlightColor.."></font>\n\n<"..theme[SETUP.theme].welcomeScreenTextColor..">"..trans[181].."</"..theme[SETUP.theme].welcomeScreenTextColor..">",nil)
		ui.removeTextArea(8888,nil)
	end
 	if callback=="cn.thirty" then
		ui.updateTextArea(8881,"<"..theme[SETUP.theme].welcomeScreenHeadingColor.."><font size='14'><"..theme[SETUP.theme].welcomeScreenDecoColor.."><font face='Wingdings 3'>u</font></"..theme[SETUP.theme].welcomeScreenDecoColor.."> "..trans[104].."</font></"..theme[SETUP.theme].welcomeScreenHeadingColor.."> <"..theme[SETUP.theme].welcomeScreenHighlightColor.."><font size='14'>"..trans[86].."</"..theme[SETUP.theme].welcomeScreenHighlightColor.."></font>\n\n<"..theme[SETUP.theme].welcomeScreenTextColor..">"..trans[186].."</"..theme[SETUP.theme].welcomeScreenTextColor..">",nil)
		ui.removeTextArea(8888,nil)
	end
 	if callback=="cn.racing" then
		ui.updateTextArea(8881,"<"..theme[SETUP.theme].welcomeScreenHeadingColor.."><font size='14'><"..theme[SETUP.theme].welcomeScreenDecoColor.."><font face='Wingdings 3'>u</font></"..theme[SETUP.theme].welcomeScreenDecoColor.."> "..trans[104].."</font></"..theme[SETUP.theme].welcomeScreenHeadingColor.."> <"..theme[SETUP.theme].welcomeScreenHighlightColor.."><font size='14'>"..trans[84].."</"..theme[SETUP.theme].welcomeScreenHighlightColor.."></font>\n\n<"..theme[SETUP.theme].welcomeScreenTextColor..">"..trans[184].."</"..theme[SETUP.theme].welcomeScreenTextColor..">",nil)
		ui.removeTextArea(8888,nil)
	end
 	if callback=="cn.defilante" then
		ui.updateTextArea(8881,"<"..theme[SETUP.theme].welcomeScreenHeadingColor.."><font size='14'><"..theme[SETUP.theme].welcomeScreenDecoColor.."><font face='Wingdings 3'>u</font></"..theme[SETUP.theme].welcomeScreenDecoColor.."> "..trans[104].."</font></"..theme[SETUP.theme].welcomeScreenHeadingColor.."> <"..theme[SETUP.theme].welcomeScreenHighlightColor.."><font size='14'>"..trans[85].."</"..theme[SETUP.theme].welcomeScreenHighlightColor.."></font>\n\n<"..theme[SETUP.theme].welcomeScreenTextColor..">"..trans[185].."</"..theme[SETUP.theme].welcomeScreenTextColor..">",nil)
		ui.removeTextArea(8888,nil)
	end
 	if callback=="cn.mono" then
		ui.updateTextArea(8881,"<"..theme[SETUP.theme].welcomeScreenHeadingColor.."><font size='14'><"..theme[SETUP.theme].welcomeScreenDecoColor.."><font face='Wingdings 3'>u</font></"..theme[SETUP.theme].welcomeScreenDecoColor.."> "..trans[104].."</font></"..theme[SETUP.theme].welcomeScreenHeadingColor.."> <"..theme[SETUP.theme].welcomeScreenHighlightColor.."><font size='14'>"..trans[89].."</"..theme[SETUP.theme].welcomeScreenHighlightColor.."></font>\n\n<"..theme[SETUP.theme].welcomeScreenTextColor..">"..trans[189].."</"..theme[SETUP.theme].welcomeScreenTextColor..">",nil)
		ui.removeTextArea(8888,nil)
	end
	if callback=="cn.defilantebonus" then
		ui.updateTextArea(8881,"<"..theme[SETUP.theme].welcomeScreenHeadingColor.."><font size='14'><"..theme[SETUP.theme].welcomeScreenDecoColor.."><font face='Wingdings 3'>u</font></"..theme[SETUP.theme].welcomeScreenDecoColor.."> "..trans[104].."</font></"..theme[SETUP.theme].welcomeScreenHeadingColor.."> <"..theme[SETUP.theme].welcomeScreenHighlightColor.."><font size='14'>"..trans[90].."</"..theme[SETUP.theme].welcomeScreenHighlightColor.."></font>\n\n<"..theme[SETUP.theme].welcomeScreenTextColor..">"..trans[190].."</"..theme[SETUP.theme].welcomeScreenTextColor..">",nil)
		ui.removeTextArea(8888,nil)
	end
 	if callback=="cn.custom" then
		ui.addPopup(960,2,"<p align='center'><font size='16' color='#84b7d1'><b>"..trans[276].."</b></font>",name,440,startmenuy,340,true)
		ui.removeTextArea(8888,nil)
	end
 	if callback=="user.nogui" then
		ui.removeTextArea(0,name)	ui.removeTextArea(32,name) ui.removeTextArea(33,name) trainingcore(name,"settings:nogui")
	end
 	if callback=="user.cls" then
		ui.removeTextArea(8999,name)
		trainingcore(name,"settings:close")
	end
 	if callback=="servetp" then
		if tp[textAreaID] then
			trainingcore(name,"settings:usetp;"..textAreaID)
			tfm.exec.movePlayer(name,tp[textAreaID].x,tp[textAreaID].y)
		end
	end
 	if callback=="user.highcontrast" then
		ui.removeTextArea(33,name)
		trainingcore(name,"settings:nocontrast")
	end
 	if callback=="user.nowelcome" then
		ui.removeTextArea(8880,name)	ui.removeTextArea(8881,name)
		trainingcore(name,"greeting:close")
	end
 	if callback=="user.uctrans" then
		ui.addPopup(480,2,"<p align='center'><font size='16' color='#84b7d1'><b>"..trans[267].."</b></font>",name,595,300,200,true)
	end
	if callback=="say_vn" then
		print("<D>• "..pkg.round..trans[40].." "..trans[229].." - "..trans[248])
		ui.updateTextArea(33,"<black>• "..pkg.round..trans[40].." "..trans[229].." - "..trans[248],nil)
		ui.updateTextArea(32,"<D>• "..pkg.round..trans[40].." "..trans[229].." - "..trans[248],nil)
		trainingcore(name,"panel:everyonedied")
	end
	if callback=="kill" then
		error("<ch>Konkurss beidzies. <D>("..name..")")
	end
	if callback=="hostmenu" then
		hostmenu(name)
	end
	if callback=="hi" then
		trainingcore(name,"panel:open")
		hostinterfaces(name)
	end
	if callback=="host.chpos" then
		trainingcore(name,"panel:changeposition")
		userData[name].hipstate = userData[name].hipstate + 1		
		if userData[name].hipstate > 4 then userData[name].hipstate = 1 end
		hostinterfaces(name)
	end
	if callback=="reload" then
		trainingcore(name,"panel:reload")
		rel(name)
	end
	if callback=="clsconf" then
		trainingcore(name,"panel:closemenu")
		ui.removeTextArea(5678,name)
	end
	if callback=="nextmap" then
		trainingcore(name,"panel:nextmap")
		nm(name)
	end
	if callback=="printtemp" then
		trainingcore(name,"panel:templatelink")
		if SETUP.challengemode=="racing" then print(syspref.." "..trans[84].." - https://atelier801.com/topic?f=774444&t=930558&p=1#m1") print(syspref.." "..trans[85].." - https://atelier801.com/topic?f=774444&t=932134&p=1#m1")
		elseif SETUP.challengemode=="vanilla" then print(syspref.." "..trans[82].." - https://atelier801.com/topic?f=774444&t=930827&p=1#m1") print(syspref.." "..trans[81].." - https://atelier801.com/topic?f=774444&t=931791&p=1#m1")
		elseif SETUP.challengemode=="survival" then print(syspref.." "..trans[83].." - https://atelier801.com/topic?f=774444&t=930530&p=1#m1")
		elseif SETUP.challengemode=="build" then print(syspref.." "..trans[87].." - https://atelier801.com/topic?f=774444&t=931585&p=1#m1")
		else print(syspref.."Nav pieejams.") end
	end
	if callback=="conf" then
		trainingcore(name,"panel:exitmenu")
		if hosts[name] then
			ui.addTextArea(5678, "<p align='center'><font size='16'><b><grbl>"..trans[249].."</font></b></font>\n\n<rose><a href='event:kill'>["..trans[70].."]</a> <a href='event:clsconf'>["..trans[73].."]</a><p>", name, 275, 175, 250, 50, 0x000022, 0x000022, 0.6, true)
		else ui.addTextArea(5678, "<p align='center'><font size='16'><b><grbl>"..trans[270].."</font></b></font>\n<N>"..trans[217].."</N>\n\n<rose><a href='event:clsconf'>[ok]</a><p>", name, 275, 175, 250, 80, 0x000022, 0x000022, 0.6, true)
		end
end
	if callback=="hipage" then
		if userData[name].histate == 1 then userData[name].histate = 2 elseif userData[name].histate == 2 then userData[name].histate = 1 end
		ui.updateTextArea(450,hidata[userData[name].histate],name)
		trainingcore(name,"panel:switchpage;"..userData[name].histate)
	end
	if callback=="disq" then
		ui.addPopup(800,2,"<p align='center'><font size='16' color='#84b7d1'><b>"..trans[254].."</b></font>",name,595,300,200,true)
	end
 	if callback=="pr.cls" then
		trainingcore(name,"profile:close")
		ui.removeTextArea(288,name)
	end 
 	if callback=="rmfieldui" then
		trainingcore(name,"fieldui:close")
		for i=350,356 do ui.removeTextArea(i,name) end
	end 
	if callback=="error0x1" then
		trainingcore(name,"panel:error0x1;"..errn1)
		ui.addTextArea(5678, "<font size='16'><grbl><a href='event:clsconf'>X</a></font> <"..theme[SETUP.theme].windowHeadingColor.."><b>"..trans[270].." 0x1</b></"..theme[SETUP.theme].windowHeadingColor.."></font></font>\n___________________________\n\n<BV><font size='14'>>> "..errn1.."</font></BV><V>\n\n!"..errc1, name, 300, 100, 200, 200, 0x000022, 0x00022, 0.65, true)
		print(erri1)
	end
	deb(nil,"debdata","<V><b>[eventTextAreaCallback]</b></V> <BL>"..tostring(textAreaID).." "..tostring(name).." "..tostring(callback))
	deb(nil,"debdisplay")
end

-- Nākošā mape

function nm(name)
	if hosts[name] and SETUP.challengemode=="vanilla" then nextMap()
	elseif hosts[name] and SETUP.challengemode=="survival" then survRound()
	elseif hosts[name] and SETUP.challengemode=="thirty" then newMap()
	elseif hosts[name] and SETUP.challengemode=="mono" then nextMonoMap()
	elseif hosts[name] and SETUP.challengemode=="racing" then tfm.exec.newGame("#"..pkg.data)
	elseif hosts[name] and SETUP.challengemode=="defilante" then tfm.exec.newGame("#"..pkg.data)
end end

-- eventPopupAnswer
function eventPopupAnswer(popupID, name, answer)
	if popupID==398 and hosts[name] then if answer~="" then iter(iterArgs,{popupID,name,answer}) end end
	if popupID==399 and hosts[name] then 
		if answer~="" then 
			for k,v in next,_G[foreachArgs] do
				eventChatCommand(name,string.gsub(string.gsub(answer,"%%k",k),"%%v",v))
			end
		end 
	end
	if popupID==404 then if answer=="" and not SETUP.allowemptyfeedback==true then ui.addPopup(404, 2, "<p align='center'>"..trans[282].."</p>", name, 10, 310, 250, true) else print("<b><PT>["..name.."]</PT></b> <T>"..answer) end end
	if popupID==480 then userData[name].uctrans = tonumber(answer) initUtilcore(name) trainingcore(name,"settings:utilcoretransparency;"..answer) end
	if popupID==501 and hosts[name] then 
		local xml = tfm.get.room.xmlMapInfo.xml
		print(string.gsub(string.gsub(xml, ">", "&gt;"), "<", "&lt;"))
		xml = string.gsub(xml,"<P "..string.match(xml, "<P (.-)/>"),"<P "..answer)
		print(string.gsub(string.gsub(xml, ">", "&gt;"), "<", "&lt;"))
		print(string.gsub(string.gsub("<P "..string.match(xml, "<P (.-)/>"), ">", "&gt;"), "<", "&lt;"))
		print(string.gsub(string.gsub("<P "..answer, ">", "&gt;"), "<", "&lt;"))
		tfm.exec.newGame(xml)
		notepad[#notepad+1] = "<font face='Lucida Console,Menlo' color='#b3b3ff' size='10'>&lt;P<br>"..answer.."<br>/&gt;</font>"
		hcCmdFeedback(infpref..name.." "..trans[219])
		trainingcore(name,"panel:reload;$notepad"..#notepad)
	end
	if popupID==800 and hosts[name] then if contestants[answer] then d(answer,0.4,0x000022,5,25) trainingcore(name,"panel:disqualify;"..answer) end end
	if popupID==960 and hosts[name] then trainingcore(name,"greeting:setcustomname") cname = answer ui.addPopup(961,2,"<p align='center'><font size='16' color='#84b7d1'><b>"..trans[277].."</b></font>",name,440,startmenuy,340,true) end
	if popupID==961 and hosts[name] then trainingcore(name,"greeting:setcustomdescription") cdesc = answer 		ui.updateTextArea(8881,"<"..theme[SETUP.theme].welcomeScreenHeadingColor.."><font size='14'><"..theme[SETUP.theme].welcomeScreenDecoColor.."><font face='Wingdings 3'>u</font></"..theme[SETUP.theme].welcomeScreenDecoColor.."> "..trans[104].."</font></"..theme[SETUP.theme].welcomeScreenHeadingColor.."> <"..theme[SETUP.theme].welcomeScreenHighlightColor.."><font size='14'>"..cname.."</"..theme[SETUP.theme].welcomeScreenHighlightColor.."></font>\n\n<"..theme[SETUP.theme].welcomeScreenTextColor..">"..cdesc.."</"..theme[SETUP.theme].welcomeScreenTextColor..">",nil) end
end

function iter(evtCC,evtPA)
		counter = 0
	for i=evtCC[1],evtCC[2],evtCC[3] do
		eventChatCommand(evtCC[4],string.gsub(evtPA[3],"%%i",i))
		counter=counter+1
	end
	hcCmdFeedback(infpref..evtCC[4].." "..string.format(trans[308],evtPA[3],counter))
end

-- Pārlādēt mapi

function rel(name)
tfm.exec.newGame(tfm.get.room.currentMap) hcCmdFeedback(infpref..name.." "..trans[219]) end

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

-- SETUP brīdinājumi
if SETUP.autorespawn == true then
		ui.updateTextArea(0,"<CE>"..trans[251].." "..trans[221]..":<CS> "..trans[256],OWNER_ID)
end
if SETUP.challengemode == "pkg" then
		ui.updateTextArea(0,"<CE>"..trans[251].." "..trans[221]..":<CS> "..trans[315],OWNER_ID)
end

-- eventColorPicked
function eventColorPicked(id,name,color)
	readable = string.format("%06x",color)
	if color==-1 then return false end
	if id==300 then -- vārda krāsošana
		queuedisplay = "" queuenotepad = ""
		for i=1,#colqueue do 
			queuenotepad = queuenotepad.."<br>"..colqueue[i]
		end
		if #colqueue==1 then queuedisplay = colqueue[1] else notepad[#notepad+1] = queuenotepad queuedisplay="$notepad"..#notepad end
		trainingcore(name,"colorselector:colorname;"..queuedisplay..";"..readable)
		for k,v in next,colqueue do
			if v == "all" then
				for name,player in next,tfm.get.room.playerList do
					tfm.exec.setNameColor(name,color)
				end
			else tfm.exec.setNameColor(v,color)
			end
		end
	end
	if id==302 then -- tagu definīcija
		trainingcore(name,"colorselector:colortag;"..defqueue..";"..readable)
		setColorTag(defqueue, color)
		hcCmdFeedback(infpref..""..name.." "..trans[208].." <"..defqueue..">"..defqueue.."</font>.")
	end
	if id==303 then -- !g zemju krāsošana
		trainingcore(name,"colorselector:ground;"..g_id..";"..readable)
		tfm.exec.addPhysicObject(g_id,g_x,g_y,{type=g_type,restitution=g_restitution,friction=g_friction,angle=g_angle,color=color,width=g_width,height=g_height,dynamic=g_dyn,mass=g_mass,miceCollision=true,groundCollision=true})
	end
	if id==304 then -- !g* zemju krāsošana
		trainingcore(name,"colorselector:transparentground;"..g_id..";"..readable)
		tfm.exec.addPhysicObject(g_id,g_x,g_y,{type=g_type,restitution=g_restitution,friction=g_friction,angle=g_angle,color=color,width=g_width,height=g_height,dynamic=g_dyn,mass=g_mass,miceCollision=false,groundCollision=false})
	end
	if id==305 then -- spēles fona krāsošana
		trainingcore(name,"colorselector:background;"..readable)
		ui.setBackgroundColor("#"..readable)
		hcCmdFeedback(infpref..name.." "..trans[313].." <font face='Lucida Console'><font color='#"..readable.."'>■</font>"..readable.."</font>.")
	end
end

-- eventSummoningEnd
function eventSummoningEnd(name,type,x,y,angle,data)
end

-- eventSummoningStart
function eventSummoningStart(name,type,x,y,angle)
	if holding.equ[name] then
		if userData[name].allowedSuperpowers.instaspawn==true then
			trainingcore(name,"superpowers:instaspawn;"..type..";"..x..";"..y..";"..angle)
			tfm.exec.addShamanObject(type,x,y,angle,0,0,false)
		end
	end
	if holding.hyphen[name] then
		if userData[name].allowedSuperpowers.instaspawn==true then
			trainingcore(name,"superpowers:instaspawntransparent;"..type..";"..x..";"..y..";"..angle)
			tfm.exec.addShamanObject(type,x,y,angle,0,0,true)
		end
	end
end

-- eventPlayerLeft

function eventPlayerLeft(name)
	hostcore(miscpref..name.." "..trans[250])
	d(name,0.4,0x000022,5,25,"Pameta ciltsmāju")
end

-- Debug
function printVariable(v)
print(_G[v])
end

-- Fatāla kļūda 2
if fail==true then for i=0,9000 do ui.removeTextArea(i,nil) end end
end

status, err = xpcall(main,errstp)
