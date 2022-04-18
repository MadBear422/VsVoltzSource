function onCreate()
	makeLuaSprite('sky', 'gym/dusk/background', -888, -661)
	scaleObject('sky', 1.4, 1.4)
	addLuaSprite('sky', false)

	makeLuaSprite('skyT', 'gym/background', -888, -661)
	scaleObject('skyT', 1.4, 1.4)
	addLuaSprite('skyT', false)
	
	makeLuaSprite('standTop', 'gym/dusk/standTop', -888, -661)
	scaleObject('standTop', 1.4, 1.4)
	addLuaSprite('standTop', false)

	makeLuaSprite('standTopLeftT', 'gym/topStandLeft', -888, -661)
	scaleObject('standTopLeftT', 1.4, 1.4)
	addLuaSprite('standTopLeftT', false)

	makeLuaSprite('standTopRightT', 'gym/topStandRight', -888, -661)
	scaleObject('standTopRightT', 1.4, 1.4)
	addLuaSprite('standTopRightT', false)

	makeAnimatedLuaSprite('crowdTopLeft', 'gym/dusk/Crowd Dusk', -970, -66)
	addAnimationByIndices('crowdTopLeft', 'bop', 'mid crowd 1 instance ', '10000,10001,10002,10003,10004,10005,10006,10007,10008,10009,10010,10011,10012,10013')
	scaleObject('crowdTopLeft', 0.87, 0.87)
	addLuaSprite('crowdTopLeft', false)

	makeAnimatedLuaSprite('crowdTopRight', 'gym/dusk/Crowd Dusk', 1300, 30)
	addAnimationByIndices('crowdTopRight', 'bop', 'mid crowd 2 instance ', '10000,10001,10002,10003,10004,10005,10006,10007,10008,10009,10010,10011,10012,10013')
	scaleObject('crowdTopRight', 0.87, 0.87)
	addLuaSprite('crowdTopRight', false)

	makeAnimatedLuaSprite('crowdTopLeftT', 'gym/Crowd Day', -890, -26)
	addAnimationByIndices('crowdTopLeftT', 'bop', 'crowd 1 instance ', '10000,10001,10002,10003,10004,10005,10006,10007,10008,10009,10010,10011,10012,10013')
	scaleObject('crowdTopLeftT', 0.87, 0.87)
	addLuaSprite('crowdTopLeftT', false)

	makeAnimatedLuaSprite('crowdTopRightT', 'gym/Crowd Day', 1350, 80)
	addAnimationByIndices('crowdTopRightT', 'bop', 'crowd 2 instance ', '10000,10001,10002,10003,10004,10005,10006,10007,10008,10009,10010,10011,10012,10013')
	scaleObject('crowdTopRightT', 0.87, 0.87)
	addLuaSprite('crowdTopRightT', false)

	makeLuaSprite('standBottom', 'gym/dusk/standBottom', -888, -661)
	scaleObject('standBottom', 1.4, 1.4)
	addLuaSprite('standBottom', false)

	makeLuaSprite('standBottomLeftT', 'gym/bottomStandLeft', -888, -661)
	scaleObject('standBottomLeftT', 1.4, 1.4)
	addLuaSprite('standBottomLeftT', false)

	makeLuaSprite('standBottomRightT', 'gym/bottomStandRight', -888, -661)
	scaleObject('standBottomRightT', 1.4, 1.4)
	addLuaSprite('standBottomRightT', false)

	--makeAnimatedLuaSprite('gary', 'gym/screens/fizz/garylean', -0, -361)
	--scaleObject('gary', 1.85, 2)
	--addAnimationByPrefix('gary', 'moop', 'lean', 24, true)
	--addLuaSprite('gary', false)

	makeAnimatedLuaSprite('gary', 'gym/screens/garylean', -0, -361)
	scaleObject('gary', 1.85, 2)
	addAnimationByPrefix('gary', 'moop', 'lean', 24, true)
	addLuaSprite('gary', false)

	makeLuaSprite('screen', 'gym/dusk/screen', -888, -661)
	scaleObject('screen', 1.4, 1.4)
	addLuaSprite('screen', false)

	makeLuaSprite('screenT', 'gym/screen', -1048, -701)
	scaleObject('screenT', 1.5, 1.5)
	addLuaSprite('screenT', false)

	makeAnimatedLuaSprite('crowdBottomLeft', 'gym/dusk/Crowd Dusk', -900, 180)
	addAnimationByIndices('crowdBottomLeft', 'bop', 'mid crowd 3 instance ', '10000,10001,10002,10003,10004,10005,10006,10007,10008,10009,10010,10011,10012,10013')
	scaleObject('crowdBottomLeft', 0.85, 0.85)
	addLuaSprite('crowdBottomLeft', false)

	makeAnimatedLuaSprite('crowdBottomRight', 'gym/dusk/Crowd Dusk', 1300, 315)
	addAnimationByIndices('crowdBottomRight', 'bop', 'crowd 4 instance', '10000,10001,10002,10003,10004,10005,10006,10007,10008,10009,10010,10011,10012,10013')
	scaleObject('crowdBottomRight', 0.87, 0.87)
	addLuaSprite('crowdBottomRight', false)

	makeAnimatedLuaSprite('crowdTopLeftHandT', 'gym/Crowd Day Hand', -890, -26)
	addAnimationByIndices('crowdTopLeftHand', 'bop2', 'crowd 1 instance ', '10000,10001,10002,10003,10004,10005,10006,10007,10008,10009,10010,10011,10012,10013')
	scaleObject('crowdTopLeftHand', 0.87, 0.87)
	addLuaSprite('crowdTopLeftHand', false)

	makeAnimatedLuaSprite('crowdBottomLeftT', 'gym/Crowd Day', -870, 260)
	addAnimationByIndices('crowdBottomLeftT', 'bop', 'crowd 3 instance ', '10000,10001,10002,10003,10004,10005,10006,10007,10008,10009,10010,10011,10012,10013')
	scaleObject('crowdBottomLeftT', 0.85, 0.85)
	addLuaSprite('crowdBottomLeftT', false)

	makeAnimatedLuaSprite('crowdBottomRightT', 'gym/Crowd Day', 1300, 315)
	addAnimationByIndices('crowdBottomRightT', 'bop', 'day crowd 4  instance ', '10000,10001,10002,10003,10004,10005,10006,10007,10008,10009,10010,10011,10012,10013')
	scaleObject('crowdBottomRightT', 0.85, 0.85)
	addLuaSprite('crowdBottomRightT', false)

	makeLuaSprite('main', 'gym/dusk/front', -888, -661)
	scaleObject('main', 1.4, 1.4)
	addLuaSprite('main', false)

	makeLuaSprite('mainT', 'gym/front', -888, -661)
	scaleObject('mainT', 1.4, 1.4)
	addLuaSprite('mainT', false)

	setPropertyFromClass('GameOverSubstate', 'characterName', 'VoltzButDead')
	setPropertyFromClass('GameOverSubstate', 'loopSoundName', 'voltzGameOver')
	setPropertyFromClass('GameOverSubstate', 'endSoundName', 'voltzGameOverEnd')
	setPropertyFromClass('GameOverSubstate', 'deathSoundName', 'voltz_death')
end

function onCountdownStarted()
	setProperty('skyT.alpha', 0)
	setProperty('standTopLeftT.alpha', 0)
	setProperty('standTopRightT.alpha', 0)
	setProperty('crowdTopLeftT.alpha', 0)
	setProperty('crowdTopRightT.alpha', 0)
	setProperty('standBottomLeftT.alpha', 0)
	setProperty('standBottomRightT.alpha', 0)
	setProperty('screenT.alpha', 0)
	setProperty('crowdTopLeftHandT.alpha', 0)
	setProperty('crowdBottomLeftT.alpha', 0)
	setProperty('crowdBottomRightT.alpha', 0)
	setProperty('mainT.alpha', 0)
end

function onBeatHit()
	objectPlayAnimation('crowdBottomLeft', 'bop', true)
	objectPlayAnimation('crowdBottomRight', 'bop', true)
	objectPlayAnimation('crowdTopLeft', 'bop', true)
	objectPlayAnimation('crowdTopRight', 'bop', true)
end

function onDialogue(t)
	if t == 'true' then
		doTweenAlpha('fade1', 'skyT', 0, 1.65, 'smootherStepInOut')
		doTweenAlpha('fade2', 'standTopLeftT', 0, 1.65, 'smootherStepInOut')
		doTweenAlpha('fade3', 'standTopRightT', 0, 1.65, 'smootherStepInOut')
		doTweenAlpha('fade4', 'crowdTopLeftT', 0, 1.65, 'smootherStepInOut')
		doTweenAlpha('fade5', 'crowdTopRightT', 0, 1.65, 'smootherStepInOut')
		doTweenAlpha('fade6', 'standBottomLeftT', 0, 1.65, 'smootherStepInOut')
		doTweenAlpha('fade7', 'standBottomRightT', 0, 1.65, 'smootherStepInOut')
		doTweenAlpha('fade8', 'screenT', 0, 1.65, 'smootherStepInOut')
		doTweenAlpha('fade9', 'crowdTopLeftHandT', 0, 1.65, 'smootherStepInOut')
		doTweenAlpha('fade10', 'crowdBottomLeftT', 0, 1.65, 'smootherStepInOut')
		doTweenAlpha('fade11', 'crowdBottomRightT', 0, 1.65, 'smootherStepInOut')
		doTweenAlpha('fade12', 'mainT', 0, 1.65, 'smootherStepInOut')
	else
		setProperty('skyT.alpha', 0)
		setProperty('standTopLeftT.alpha', 0)
		setProperty('standTopRightT.alpha', 0)
		setProperty('crowdTopLeftT.alpha', 0)
		setProperty('crowdTopRightT.alpha', 0)
		setProperty('standBottomLeftT.alpha', 0)
		setProperty('standBottomRightT.alpha', 0)
		setProperty('screenT.alpha', 0)
		setProperty('crowdTopLeftHandT.alpha', 0)
		setProperty('crowdBottomLeftT.alpha', 0)
		setProperty('crowdBottomRightT.alpha', 0)
		setProperty('mainT.alpha', 0)
	end
end

function onCountdownTick()
	onBeatHit()
end