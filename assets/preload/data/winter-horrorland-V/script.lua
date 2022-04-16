function onCreate()
	makeLuaSprite('cat1', 'monster/micCat1', 0, 0)
	makeLuaSprite('cat2', 'monster/micCat2', 0, 0)
	makeLuaSprite('name', 'monster/name', 0, 0)
	makeLuaSprite('blac', nil, -100, -100)
	makeGraphic('blac', screenWidth*5, screenHeight*5, '000000')
	scaleObject('cat1', 2, 2)
	scaleObject('cat2', 1.5, 1.5)
	scaleObject('name', 1, 1)
	setObjectCamera('cat1', 'hud')
	setObjectCamera('cat2', 'hud')
	setObjectCamera('name', 'hud')
	precacheImage('cat1')
	precacheImage('cat2')
	precacheImage('blac')
	addLuaSprite('name', true)
	addLuaSprite('blac', true)
	setProperty('blac.alpha', 0)
	setProperty('name.alpha', 0)

end

function onStepHit()
	if curStep == 777 then
		addLuaSprite('cat1', false)
		setProperty('blac.alpha', 1)
		cameraShake('camHUD', 0.04, 0.8)
	end
	if curStep == 784 then
		setProperty('blac.alpha', 0)
		removeLuaSprite('cat1', true)
	end
	if curStep == 792 then
		addLuaSprite('cat2', false)
		setProperty('blac.alpha', 1)
		cameraShake('camHUD', 0.045, 0.8)
	end
	if curStep == 800 then
		setProperty('blac.alpha', 0)
		removeLuaSprite('cat2', true)
	end
	if curStep == 1312 then
		doTweenAlpha('m0', 'name', 0.85, 0.6, 'linear')
	end
	if curStep == 1326 then
		doTweenAlpha('m1', 'name', 0, 0.6, 'linear')
	end
end

function onSongStart()
	if isStoryMode then
		setProperty('fakeN0.offset.y', 21)
		setProperty('fakeN0.offset.x', 36.5)
		setProperty('fakeN1.offset.y', 39)
		setProperty('fakeN2.offset.y', 45)
	end
end