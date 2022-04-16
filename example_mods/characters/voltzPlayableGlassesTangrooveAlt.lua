function onCreatePost()
	makeAnimatedLuaSprite('fakeVoltzS', 'Voltz_electroshock_animationsS', defaultBoyfriendX - 150, defaultBoyfriendY + 190)
	addAnimationByPrefix('fakeVoltzS', 'shock', 'Voltz electroshock0', 24, false)
	addAnimationByPrefix('fakeVoltzS', 'shockS', 'Voltz electroshock s', 24, false)
	setProperty('fakeVoltzS.visible', false)
	addLuaSprite('fakeVoltzS', true)	
end

function noteMiss(id, dir, NT, isSus)
    if NT == 'Electric Note Special' then
		setProperty('boyfriendGroup.visible', false)
		setProperty('boyfriend.visible', false) -- fail safes
		setProperty('boyfriend.alpha', 0) -- fail safes
		setProperty('fakeVoltzS.visible', true)
		if flashingLights then
			objectPlayAnimation('fakeVoltzS', 'shock', true)
		else
			objectPlayAnimation('fakeVoltzS', 'shockS', true)
		end
		characterPlayAnim('boyfriend', 'idle', false)
    end
end

function onUpdatePost(elapsed)
	if getProperty('fakeVoltzS.animation.curAnim.finished') and getProperty('fakeVoltzS.visible') then
		setProperty('fakeVoltzS.visible', false)
		setProperty('boyfriendGroup.visible', true)
		setProperty('boyfriend.visible', true)
		setProperty('boyfriend.alpha', 1)
		characterPlayAnim('boyfriend', 'idle', false)
	end
end