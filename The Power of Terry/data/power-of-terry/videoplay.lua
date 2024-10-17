local offset = 0
local s1 = 0
local s2 = 0
local vde = "No Video"
local mdc = 'Enabled'
local f = false
local okm = true
local modchart = true
local playvideo = false
local al = false
allowCountdown = false

function luatxt(tag,txt,w,x,y,cam,ts,tc,sc,f) -- set certain values to '.' for default or no value
    makeLuaText(tag,txt,w,x,y)
    setObjectCamera(tag,cam)
    setTextSize(tag, ts)
    if tc == '.' then
        tc = 'FFFFFF'
    end
    setTextColor(tag, tc)
    if sc ~= '.' then
        screenCenter(tag, sc)
    end
    if f == '.' then
        f = false
    end
    addLuaText(tag,f)
end

function luasprite(tag,path,x,y,cam,xs,ys,sfx,sfy,sc,f) -- set certain values to '.' for default or no value
    makeLuaSprite(tag,path,x,y)
    setObjectCamera(tag,cam)
    scaleObject(tag, xs, ys)
    setScrollFactor(tag, sfx, sfy)
    if sc ~= '.' then
        screenCenter(tag, sc)
    end
    if f == '.' then
        f = false
    end
    addLuaSprite(tag,f)
end

function onCreate()
    luasprite('hide','me/popup/dim',0,0,'other',1,1,0,0,'.',true)
    setGraphicSize("hide", screenWidth, screenHeight)

    luatxt('ret',("Video Quality: "..vde..'p'), screenWidth, 0.0, 0.0,'other',screenWidth/35,'.','xy','.')
    luatxt('ret1',"Press 1-4 to choose Quality", screenWidth, 0.0, screenHeight/1.75,'other',screenWidth/40,'.','x','.')
    luatxt('ret2',"Press Spacebar to Start", screenWidth, 0.0, screenHeight/2.5,'other',screenWidth/40,'.','x','.')
    luatxt('why',"Laggy? Press N for no video", screenWidth, 0.0, screenHeight/5,'other',screenWidth/40,'00FFFF','x','.')
    luatxt('coolguy',"Song Suggested by StupidBlanalba08", screenWidth, 0.0, screenHeight-screenHeight/1.1,'other',screenWidth/40,'00FF00','x','.')

    --buttons
    
    luasprite('button','me/buttons/button',0,screenHeight/4,'other',0.5,0.5,0,0,'.',true)
    luasprite('button1','me/buttons/button',screenWidth-screenWidth/1.1,screenHeight/4,'other',0.5,0.5,0,0,'.',true)
    luasprite('button2','me/buttons/button',0,screenHeight/2.5,'other',0.5,0.5,0,0,'.',true)
    luasprite('button3','me/buttons/button',screenWidth-screenWidth/1.1,screenHeight/2.5,'other',0.5,0.5,0,0,'.',true)
    luasprite('buttonn','me/buttons/button',screenWidth/5,screenHeight/2.3,'other',0.5,0.5,0,0,'.',true)
    luasprite('buttonm','me/buttons/button',screenWidth/8,screenHeight/1.35,'other',0.5,0.5,0,0,'.',true)
    luasprite('buttonc','me/buttons/button',screenWidth/1.085,screenHeight/1.1625,'other',0.5,0.5,0,0,'.',true)

    luatxt('b1','1',0,screenWidth-screenWidth/1.0225,screenHeight/3.65,'other',screenWidth/20,'.','.',true)
    luatxt('b2','2',0,screenWidth-screenWidth/1.1275,screenHeight/3.65,'other',screenWidth/20,'.','.',true)
    luatxt('b3','3',0,screenWidth-screenWidth/1.0225,screenHeight/2.35,'other',screenWidth/20,'.','.',true)
    luatxt('b4','4',0,screenWidth-screenWidth/1.1275,screenHeight/2.35,'other',screenWidth/20,'.','.',true)
    luatxt('bn','N',0,screenWidth-screenWidth/1.286,screenHeight/2.175,'other',screenWidth/20,'.','.',true)

    luatxt('bc','Done', 0,screenWidth/1.075,screenHeight/1.105,'other',screenWidth/39,'.','.',true)
    luatxt('bm','Mod',0,screenWidth-screenWidth/1.1625,screenHeight/1.275,'other',screenWidth/40,'.','.',true)
    luatxt('mc',('ModChart: '..mdc),screenWidth,0.0,screenHeight/1.25,'other',60,'FF0000','x',true)
    luatxt("mct","<Press T or F to choose>",screenWidth,0.0,screenHeight/1.35,'other',40,'00FF00','x',true)
    
    addLuaScript("modcharts/terry")
end

function mouseOverlaps(tag, camera)
    x = getMouseX(camera or 'camHUD')
    y = getMouseY(camera or 'camHUD')
    return (x > getProperty(tag..'.x') and y > getProperty(tag..'.y') and x < (getProperty(tag..'.x') + getProperty(tag..'.width')) and y < (getProperty(tag..'.y') + getProperty(tag..'.height')))
end

function onStartCountdown()
	if not allowCountdown then
		return Function_Stop
	elseif allowCountdown then
		return Function_Continue
	end
end

function buttonStuff()
    if mouseOverlaps('buttonc', 'camOther') and mouseClicked("left") then
        okc = true
    end
    if mouseOverlaps('button', 'camOther') and mouseClicked("left") then
        okn = false
        ok4 = false
        ok3 = false
        ok2 = false
        ok1 = true
    elseif mouseOverlaps('button1', 'camOther') and mouseClicked("left") then
        okn = false
        ok4 = false
        ok3 = false
        ok2 = true
        ok1 = false
    elseif mouseOverlaps('button2', 'camOther') and mouseClicked("left") then
        okn = false
        ok4 = false
        ok3 = true
        ok2 = false
        ok1 = false
    elseif mouseOverlaps('button3', 'camOther') and mouseClicked("left") then
        okn = false
        ok4 = true
        ok3 = false
        ok2 = false
        ok1 = false
    elseif mouseOverlaps('buttonn', 'camOther') and mouseClicked("left") then
        okn = true
        ok4 = false
        ok3 = false
        ok2 = false
        ok1 = false
    end
    if mouseOverlaps('buttonm', 'camOther') and mouseClicked("left") and okm == false then
        okm = true
    elseif mouseOverlaps('buttonm', 'camOther') and mouseClicked("left") and okm == true then
        okm = false
    end

    if not allowCountdown then
        if keyboardJustPressed('T') or okm then
            modchart = true
            okm = true
            mdc = 'Enabled'
            setTextString("mc", ("ModChart: "..mdc))
            setTextColor("mc", "FF0000")
        end
        if keyboardJustPressed("F") or not okm then
            modchart = false
            okm = false
            mdc = 'Disabled'
            setTextString("mc", ("ModChart: "..mdc))
            setTextColor("mc", "00FFFF")
        end
        if keyboardJustPressed('ONE') or ok1 then
            vde = 360
            vden = 'a'
            f = true
            s1 = 2.222
            s2 = 2.2205
            p1 = 355.5
            p2 = -174.3
            okn = false
            ok4 = false
            ok3 = false
            ok2 = false
            ok1 = true
        end
        if keyboardJustPressed('TWO') or ok2 then
            vde = 480
            vden = 'b'
            f = true
            s1 = 1.677
            s2 = 1.666
            p1 = 253.5
            p2 = -234.2
            okn = false
            ok4 = false
            ok3 = false
            ok2 = true
            ok1 = false
        end
        if keyboardJustPressed('THREE') or ok3 then
            vde = 720
            vden = 'c'
            f = true
            s1 = 1.111
            s2 = 1.11025
            p1 = 35.5
            p2 = -354.25
            okn = false
            ok4 = false
            ok3 = true
            ok2 = false
            ok1 = false
        end
        if keyboardJustPressed('FOUR') or ok4 then
            vde = 1080
            vden = 'd'
            f = true
            s1 = 0.742
            s2 = 0.741
            p1 = -284.7
            p2 = -534.3
            okn = false
            ok4 = true
            ok3 = false
            ok2 = false
            ok1 = false
        end
        if not (keyboardJustPressed('N') or okn) and f then
            setTextString("ret", "Video Resolution: "..vde..'p')
            playvideo = true
        else
            setTextString("ret", "No Video")
            vde = 'No Video'
            playvideo = false
            f = false
            okn = true
            ok4 = false
            ok3 = false
            ok2 = false
            ok1 = false
        end
    end
    if keyboardJustPressed('SPACE') or okc then
        for _, value in pairs({'ret','ret1','ret2','why','coolguy','b1','b2','b3','b4','bn','bc','mc','mct','bm'}) do
            removeLuaText(value)
        end
        for _, value in pairs({'hide','button','button1','button2','button3','buttonn','buttonc','buttonm'}) do
            removeLuaSprite(value)
        end
        for _, value in pairs({'healthBar.alpha','healthBarBG.alpha','iconP1.alpha','iconP2.alpha','scoreTxt.alpha'}) do
            setProperty(value,0)
        end
        setProperty('timeBar.visible', false)
        setProperty('timeBarBG.visible', false)
        setProperty('timeTxt.visible', false)
        callScript("modcharts/terry", "modccc",{modchart})
        allowCountdown = true
        startCountdown()
        for i = 0,3 do
            setPropertyFromGroup('playerStrums',i,'alpha',0);
            setPropertyFromGroup('opponentStrums',i,'alpha',0);
        end
        if not playvideo then
            vde = 'No Video'
            playvideo = false
            f = false
        end
    end
end

function onUpdate()
    if not allowCountdown then
        buttonStuff()
    end
end

function onSongStart()
    offset = getPropertyFromClass('ClientPrefs','noteOffset')
    debugPrint('Current Offset: ','(',offset,')')
    if playvideo then
        setProperty('showRating', false);
        setProperty('showComboNum', false);
        runTimer('vid',(offset)/1000)
    end
    setProperty('camZoomingMult', 0)
    if botPlay then
        setTextString('botplayTxt', 'You could have tried you know')
        setTextSize("botplayTxt", 15)
        setProperty('botplayTxt.x', 0)
        setProperty('botplayTxt.y', screenHeight/1.025)
        setTextWidth("botplayTxt", screenWidth)
        setTextAlignment("botplayTxt", 'right')
        setObjectCamera("botplayTxt",'other')
    end
end

function onTimerCompleted(tag)
    if tag == 'vid' and playvideo then
        callScript('scripts/videoSprite', 'makeVideoSprite', {vden, vden, p1, p2, 'camGame', s1, s2})
    end
end
