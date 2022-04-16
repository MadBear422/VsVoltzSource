-- Event notes hooks
function onEvent(name, value1, value2)
	if name == 'startGo' then
		playThree()
		runTimer('threeExp', crochet / 1000, 3)
	end
end

function onTimerCompleted(tag, loops, loopsLeft)
	if loopsLeft == 2 then
		playTwo()
	end
	if loopsLeft == 1 then
		playOne()
	end
	if loopsLeft == 0 then
		playGo()
	end
end


local startX = 300
local startY = 200

function playThree()
    playSound('intro3')
end

function playTwo()
    playSound('intro2', 1)
    makeLuaSprite('ready', 'ready', startX, startY)
	-- setScrollFactor('ready', 0, 0)
	setObjectCamera('ready', 'hud')
    addLuaSprite('ready', true)
    doTweenAlpha('readyTween', 'ready', 0, crochet / 1000, cubeInOut)
end

function playOne()
    playSound('intro1', 1)
    makeLuaSprite('sett', 'set', startX, startY)
	-- setScrollFactor('sett', 0, 0)
	setObjectCamera('sett', 'hud')
    addLuaSprite('sett', true)
    doTweenAlpha('setTween', 'sett', 0, crochet / 1000, cubeInOut)
end

function playGo()
    playSound('introGo', 1)
    makeLuaSprite('goo', 'go', startX, startY - 50)
	-- setScrollFactor('goo', 0, 0)
	setObjectCamera('goo', 'hud')
    addLuaSprite('goo', true)
    doTweenAlpha('goTween', 'goo', 0, crochet / 1000, cubeInOut)
end