function onCreatePost()
	makeAnimatedLuaSprite('fakeBF', 'electroshock_animations', defaultBoyfriendX - 100, defaultBoyfriendY + 210)
	addAnimationByPrefix('fakeBF', 'shock', 'BF electroshock0', 24, false)
	addAnimationByPrefix('fakeBF', 'shockS', 'BF electroshock s', 24, false)
	setProperty('fakeBF.visible', false)
	addLuaSprite('fakeBF', true)	
end

function noteMiss(id, dir, NT, isSus)
    if NT == 'Electric Note' or NT == 'Elecric Note Special' then
		setProperty('boyfriendGroup.visible', false)
		setProperty('fakeBF.visible', true)
		if flashingLights then
			objectPlayAnimation('fakeBF', 'shock', true)
		else
			objectPlayAnimation('fakeBF', 'shockS', true)
		end
		characterPlayAnim('boyfriend', 'idle', false)
    end
end

function onUpdatePost(elapsed)
	if getProperty('fakeBF.animation.curAnim.finished') and getProperty('fakeBF.visible') then
		setProperty('fakeBF.visible', false)
		setProperty('boyfriendGroup.visible', true)
		characterPlayAnim('boyfriend', 'idle', false)
	end
end