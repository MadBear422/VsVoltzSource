function onCreate()
	makeLuaSprite('sky', 'gym/background', -888, -661)
	scaleObject('sky', 1.4, 1.4)
	addLuaSprite('sky', false)
	
	makeLuaSprite('standTopLeft', 'gym/topStandLeft', -888, -661)
	scaleObject('standTopLeft', 1.4, 1.4)
	addLuaSprite('standTopLeft', false)

	makeLuaSprite('standTopRight', 'gym/topStandRight', -888, -661)
	scaleObject('standTopRight', 1.4, 1.4)
	addLuaSprite('standTopRight', false)


	makeAnimatedLuaSprite('crowdTopLeft', 'gym/Crowd Day', -890, -26)
	addAnimationByIndices('crowdTopLeft', 'bop', 'crowd 1 instance ', '10000,10001,10002,10003,10004,10005,10006,10007,10008,10009,10010,10011,10012,10013')
	scaleObject('crowdTopLeft', 0.87, 0.87)
	addLuaSprite('crowdTopLeft', false)

	makeAnimatedLuaSprite('crowdTopRight', 'gym/Crowd Day', 1350, 80)
	addAnimationByIndices('crowdTopRight', 'bop', 'crowd 2 instance ', '10000,10001,10002,10003,10004,10005,10006,10007,10008,10009,10010,10011,10012,10013')
	scaleObject('crowdTopRight', 0.87, 0.87)
	addLuaSprite('crowdTopRight', false)

	makeLuaSprite('standBottomLeft', 'gym/bottomStandLeft', -888, -661)
	scaleObject('standBottomLeft', 1.4, 1.4)
	addLuaSprite('standBottomLeft', false)

	makeLuaSprite('standBottomRight', 'gym/bottomStandRight', -888, -661)
	scaleObject('standBottomRight', 1.4, 1.4)
	addLuaSprite('standBottomRight', false)

	makeLuaSprite('screen', 'gym/screen', -888, -661)
	scaleObject('screen', 1.4, 1.4)
	addLuaSprite('screen', false)

	makeAnimatedLuaSprite('crowdTopLeftHand', 'gym/Crowd Day Hand', -890, -26)
	addAnimationByIndices('crowdTopLeftHand', 'bop2', 'crowd 1 instance ', '10000,10001,10002,10003,10004,10005,10006,10007,10008,10009,10010,10011,10012,10013')
	scaleObject('crowdTopLeftHand', 0.87, 0.87)
	addLuaSprite('crowdTopLeftHand', false)

	makeAnimatedLuaSprite('crowdBottomLeft', 'gym/Crowd Day', -870, 260)
	addAnimationByIndices('crowdBottomLeft', 'bop', 'crowd 3 instance ', '10000,10001,10002,10003,10004,10005,10006,10007,10008,10009,10010,10011,10012,10013')
	scaleObject('crowdBottomLeft', 0.85, 0.85)
	addLuaSprite('crowdBottomLeft', false)

	makeAnimatedLuaSprite('crowdBottomRight', 'gym/Crowd Day', 1300, 315)
	addAnimationByIndices('crowdBottomRight', 'bop', 'day crowd 4  instance ', '10000,10001,10002,10003,10004,10005,10006,10007,10008,10009,10010,10011,10012,10013')
	scaleObject('crowdBottomRight', 0.85, 0.85)
	addLuaSprite('crowdBottomRight', false)

	makeLuaSprite('main', 'gym/front', -888, -661)
	scaleObject('main', 1.4, 1.4)
	addLuaSprite('main', false)

	setPropertyFromClass('GameOverSubstate', 'characterName', 'VoltzButDead')
	setPropertyFromClass('GameOverSubstate', 'loopSoundName', 'voltzGameOver')
	setPropertyFromClass('GameOverSubstate', 'endSoundName', 'voltzGameOverEnd')
	setPropertyFromClass('GameOverSubstate', 'deathSoundName', 'voltz_death')
end

function onBeatHit()
	objectPlayAnimation('crowdBottomLeft', 'bop', true)
	objectPlayAnimation('crowdTopLeftHand', 'bop2', true)
	objectPlayAnimation('crowdBottomRight', 'bop', true)
	objectPlayAnimation('crowdTopLeft', 'bop', true)
	objectPlayAnimation('crowdTopRight', 'bop', true)
end

function onCountdownTick()
	onBeatHit()
end