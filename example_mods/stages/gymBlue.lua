function onCreate()
	makeLuaSprite('sky', 'gym/night/sky_HS', -888, -661)
	scaleObject('sky', 0.84, 0.84)
	addLuaSprite('sky', false)
	
	makeLuaSprite('Nsky', 'gym/night/not_sky_hs', -888, -661)
	scaleObject('Nsky', 0.84, 0.84)
	addLuaSprite('Nsky', false)
	
	makeLuaSprite('standTop', 'gym/night/standTop', -888, -661)
	scaleObject('standTop', 1.4, 1.4)
	addLuaSprite('standTop', false)

	makeAnimatedLuaSprite('crowdTopLeft', 'gym/night/Crowd Night', -990, -10)
	addAnimationByIndices('crowdTopLeft', 'bop', 'night crowd 1 instance ', '10000,10001,10002,10003,10004,10005,10006,10007,10008,10009,10010,10011,10012,10013')
	scaleObject('crowdTopLeft', 0.87, 0.87)
	addLuaSprite('crowdTopLeft', false)

	makeAnimatedLuaSprite('crowdTopRight', 'gym/night/Crowd Night', 1300, -69.420) --nice
	addAnimationByIndices('crowdTopRight', 'bop', 'night crowd 2 instance ', '10000,10001,10002,10003,10004,10005,10006,10007,10008,10009,10010,10011,10012,10013')
	scaleObject('crowdTopRight', 0.87, 0.87)
	addLuaSprite('crowdTopRight', false)

	makeLuaSprite('standBottom', 'gym/night/standBottom', -888, -661)
	scaleObject('standBottom', 1.4, 1.4)
	addLuaSprite('standBottom', false)

	makeAnimatedLuaSprite('bird', 'gym/screens/freebirds', -0, -361)
	scaleObject('bird', 1.85, 2)
	addAnimationByPrefix('bird', 'moop', 'birds', 24, true)
	addLuaSprite('bird', false)

	makeLuaSprite('screen', 'gym/night/screen', -888, -661)
	scaleObject('screen', 1.4, 1.4)
	addLuaSprite('screen', false)

	makeAnimatedLuaSprite('crowdBottomLeft', 'gym/night/Crowd Night', -970, 235)
	addAnimationByIndices('crowdBottomLeft', 'bop', 'night crowd 3 instance ', '10000,10001,10002,10003,10004,10005,10006,10007,10008,10009,10010,10011,10012,10013')
	scaleObject('crowdBottomLeft', 0.85, 0.85)
	addLuaSprite('crowdBottomLeft', false)

	makeAnimatedLuaSprite('crowdBottomRight', 'gym/night/Crowd Night', 1300, 315)
	addAnimationByIndices('crowdBottomRight', 'bop', 'night crowd 4 instance', '10000,10001,10002,10003,10004,10005,10006,10007,10008,10009,10010,10011,10012,10013')
	scaleObject('crowdBottomRight', 0.87, 0.87)
	addLuaSprite('crowdBottomRight', false)

	makeLuaSprite('main', 'gym/night/front', -888, -661)
	scaleObject('main', 1.4, 1.4)
	addLuaSprite('main', false)

	setPropertyFromClass('GameOverSubstate', 'characterName', 'VoltzButDead')
	setPropertyFromClass('GameOverSubstate', 'loopSoundName', 'voltzGameOver')
	setPropertyFromClass('GameOverSubstate', 'endSoundName', 'voltzGameOverEnd')
	setPropertyFromClass('GameOverSubstate', 'deathSoundName', 'voltz_death')
end

function onBeatHit()
	objectPlayAnimation('crowdBottomLeft', 'bop', true)
	--objectPlayAnimation('crowdTopLeftBurger', 'bop', true)
	objectPlayAnimation('crowdBottomRight', 'bop', true)
	objectPlayAnimation('crowdTopLeft', 'bop', true)
	objectPlayAnimation('crowdTopRight', 'bop', true)

	if curBeat == 356 then
		setProperty('gr.visible', true)
		setProperty('ki.alpha', 1.0);
	end
end

function onCountdownTick()
	onBeatHit()
end