function onCreatePost()
	makeAnimatedLuaSprite('fakeVoltz', 'electroshock_P', defaultBoyfriendX - 30, defaultBoyfriendY + 380)
	setProperty('fakeVoltz.scale.x', getProperty('boyfriend.scale.x'))
	setProperty('fakeVoltz.scale.y', getProperty('boyfriend.scale.y'))
	addAnimationByPrefix('fakeVoltz', 'shock', 'Shock0', 40, false)
	addAnimationByPrefix('fakeVoltz', 'shockS', 'ShockNoFlash', 40, false)
	setProperty('fakeVoltz.antialiasing', false)
	setProperty('fakeVoltz.visible', false)
	addLuaSprite('fakeVoltz', true)	
	
	setPropertyFromClass('GameOverSubstate', 'characterName', 'PixelVoltz-dead')
	setPropertyFromClass('GameOverSubstate', 'loopSoundName', 'voltzGameOver-pixel')
	setPropertyFromClass('GameOverSubstate', 'endSoundName', 'voltzGameOverEnd-pixel')
	setPropertyFromClass('GameOverSubstate', 'deathSoundName', 'voltz_death_pixel')
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

function onUpdatePost(elapsed)
	if getProperty('fakeVoltz.animation.curAnim.finished') and getProperty('fakeVoltz.visible') then
		setProperty('fakeVoltz.visible', false)
		setProperty('boyfriendGroup.visible', true)
		setProperty('boyfriend.visible', true)
		characterPlayAnim('boyfriend', 'idle', false)
	end
end

function onGameOver() -- Fix BF being off center on Death
	setCharacterY('boyfriend', getCharacterY('boyfriend') + 32)
	--setCharacterX('boyfriend', getCharacterX('boyfriend') - 60)
	return Function_Continue;
end