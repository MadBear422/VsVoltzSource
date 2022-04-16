function onCreatePost()
	makeAnimatedLuaSprite('fakeVoltz', 'electroshock_animations', defaultBoyfriendX - 150, defaultBoyfriendY + 190)
	addAnimationByPrefix('fakeVoltz', 'shock', 'Voltz electroshock0', 24, false)
	addAnimationByPrefix('fakeVoltz', 'shockS', 'Voltz electroshock s', 24, false)
	setProperty('fakeVoltz.visible', false)
	addLuaSprite('fakeVoltz', true)	
	
	setPropertyFromClass('GameOverSubstate', 'characterName', 'VoltzButDead')
	setPropertyFromClass('GameOverSubstate', 'loopSoundName', 'voltzGameOver')
	setPropertyFromClass('GameOverSubstate', 'endSoundName', 'voltzGameOverEnd')
	setPropertyFromClass('GameOverSubstate', 'deathSoundName', 'voltz_death')
end

function noteMiss(id, dir, NT, isSus)
    if NT == 'Electric Note' then
		setProperty('boyfriendGroup.visible', false)
		setProperty('boyfriend.visible', false) -- fail safes
		setProperty('fakeVoltz.visible', true)
		if flashingLights then
			objectPlayAnimation('fakeVoltz', 'shock', true)
		else
			objectPlayAnimation('fakeVoltz', 'shockS', true)
		end
		characterPlayAnim('boyfriend', 'idle', false)
    end
end

function onSongStart()
	setPropertyFromClass('GameOverSubstate', 'characterName', 'VoltzButDead')
	setPropertyFromClass('GameOverSubstate', 'loopSoundName', 'voltzGameOver')
	setPropertyFromClass('GameOverSubstate', 'endSoundName', 'voltzGameOverEnd')
	setPropertyFromClass('GameOverSubstate', 'deathSoundName', 'voltz_death')
end

function onUpdatePost(elapsed)
	if getProperty('fakeVoltz.animation.curAnim.finished') and getProperty('fakeVoltz.visible') then
		setProperty('fakeVoltz.visible', false)
		setProperty('boyfriendGroup.visible', true)
		setProperty('boyfriend.visible', true)
		characterPlayAnim('boyfriend', 'idle', false)
	end
end

function onGameOver() -- Fix BF being off center on Death
	setCharacterY('boyfriend', getCharacterY('boyfriend') - 95)
	setCharacterX('boyfriend', getCharacterX('boyfriend') - 20)
	return Function_Continue;
end