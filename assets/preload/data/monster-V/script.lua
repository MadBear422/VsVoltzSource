function onCreate()
	makeLuaSprite('cat1', 'monster/pussy', 0, 0)
	makeLuaSprite('cat2', 'monster/practice', 0, 0)
	makeLuaSprite('pussy', 'monster/what', 1080, 200)
	setObjectCamera('cat1', 'camHUD')
	setObjectCamera('cat2', 'camHUD')
	setObjectCamera('pussy', 'camHUD')
	scaleObject('cat1', 2.3, 2)
	scaleObject('cat2', 6.4, 3.7)
	scaleObject('pussy', 2, 2)
	precacheImage('cat1')
	precacheImage('cat2')
	precacheImage('pussy')


end

function onStepHit()
	----
	if curStep == 304 then
		addLuaSprite('cat1', true)
	end
	if curStep == 314 then
		removeLuaSprite('cat1', true)
	end
	----
	if curStep == 830 then
		addLuaSprite('cat2', true)
	end
	if curStep == 840 then
		removeLuaSprite('cat2', true)
	end
	----
	if curStep == 1005 then
		addLuaSprite('pussy', true)
		doTweenX('pussyMoves', 'pussy', -500, 2.57, 'linear')
	end
	if curStep == 1026 then
		removeLuaSprite('pussy', true)
	end
end

function onSongStart()
	if not isStoryMode then
		setProperty('fakeN0.offset.y', 20)
		setProperty('fakeN0.offset.x', 36.5)
		setProperty('fakeN1.offset.y', 38)
		setProperty('fakeN2.offset.y', 42)
	else
		setProperty('fakeN0.offset.y', 20.5)
		setProperty('fakeN0.offset.x', 36.5)
		setProperty('fakeN1.offset.y', 38)
		setProperty('fakeN2.offset.y', 45)
	end
end