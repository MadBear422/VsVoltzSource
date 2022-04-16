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