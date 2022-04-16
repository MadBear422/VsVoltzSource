local OGSNC0 = 0
local OGSNC1 = 1
local OGSNC2 = 2
local OGSNC3 = 3
local Sunlock0 = true -- unlock em
local Sunlock1 = true -- unlock em
local Sunlock2 = true -- unlock em
local Sunlock3 = true -- unlock em
local STWN0 = false
local STWN1 = false
local STWN2 = false
local STWN3 = false

function onCountdownTick(counter)
	if counter == 1 then
		OGSNC0 = getPropertyFromGroup('playerStrums', 0, 'color')
		OGSNC1 = getPropertyFromGroup('playerStrums', 1, 'color')
		OGSNC2 = getPropertyFromGroup('playerStrums', 2, 'color')
		OGSNC3 = getPropertyFromGroup('playerStrums', 3, 'color')
		
		for nS = 0, 3 do
			makeAnimatedLuaSprite('fakeNS'..nS, 'NOTE_flicker-special', getPropertyFromGroup('playerStrums', nS, 'x') - 30, getPropertyFromGroup('playerStrums', nS, 'y'))
			setProperty('fakeNS0.angle', -90)
			if not downscroll then
				if not middlescroll then
					setProperty('fakeNS0.offset.x', 35.5)
				else
					setProperty('fakeNS0.offset.x', 36.5)
				end
				setProperty('fakeNS3.y', 17)
			else
				if not middlescroll then
					setProperty('fakeNS0.offset.x', 36.5)
				else
					setProperty('fakeNS0.offset.x', 35.7)
				end
				setProperty('fakeNS3.y', 536.5)
			end
			setProperty('fakeNS0.offset.y', 18)
			setProperty('fakeNS1.offset.x', 57.5)
			setProperty('fakeNS1.offset.y', 35.5)
			setProperty('fakeNS2.offset.x', 55)
			setProperty('fakeNS2.offset.y', 35)
			setProperty('fakeNS1.flipY', true)
			setProperty('fakeNS3.angle', 90)
			if not middlescroll then
				setProperty('fakeNS3.x', 1043)
			else
				setProperty('fakeNS3.x', 723)
			end
			addAnimationByPrefix('fakeNS'..nS, 'static', 'static', 60, false)
			setObjectCamera('fakeNS'..nS, 'hud')
			scaleObject('fakeNS'..nS, getPropertyFromGroup('playerStrums', nS, 'scale.x'), getPropertyFromGroup('playerStrums', nS, 'scale.y'))
			setProperty('fakeNS'..nS..'.visible', false)
			addLuaSprite('fakeNS'..nS, true)
			makeLuaSprite('fakeobjS'..nS, 'combo', 0, 0)
			if not downscroll then
				makeLuaText('timS'..nS, 5, 1000, 287, 86)
			else
				makeLuaText('timS'..nS, 5, 1000, 287, 605)
			end
			setTextSize('timS'..nS, 32);
			setTextColor('timS0', 'AE00FF')
			setTextColor('timS1', '00C5FF')
			setTextColor('timS2', '00FF15')
			setTextColor('timS3', 'FF0000')
			addLuaText('timS'..nS)
			setProperty('timS'..nS..'.visible', false)
		end
	end
end

function noteMiss(id, dir, NT, isSus)
    if NT == 'Electric Note Special' then
		setProperty('fakeobjS'..dir..'.color', 'FFFFFF')
		setProperty('timS'..dir..'.visible', true)
		if dir == 0 then
			Sunlock0 = false
			if middlescroll then
				setProperty('timS0.x', getProperty('fakeNS0.x') - 418)
			end
		end
		if dir == 1 then
			Sunlock1 = false
			setProperty('timS1.x', getProperty('fakeNS1.x') - 418)
		end
		if dir == 2 then
			Sunlock2 = false
			setProperty('timS2.x', getProperty('fakeNS2.x') - 417)
		end
		if dir == 3 then
			Sunlock3 = false
			setProperty('timS3.x', getProperty('fakeNS3.x') - 415)
		end
		runTimer('ULS'..dir, 1, 5)
		setProperty('locked'..dir, true)
		setProperty('fakeNS'..dir..'.visible', true)
		objectPlayAnimation('fakeNS'..dir, 'static', false)
		setPropertyFromGroup('playerStrums', dir, 'visible', false)
		setPropertyFromGroup('playerStrums', dir, 'color', getProperty('fakeobjS'..dir..'.color'))
		sSoundName = string.format('Elec%i', math.random(1, 3));
		playSound(sSoundName, getRandomFloat(0.3, 0.4), 'ESMiss');
    end
end


function onUpdatePost(elapsed) -- biggest if pile, since using "do" statements breaks them for some reason
	if getProperty('fakeNS0.animation.curAnim.finished') and getProperty('fakeNS0.visible') then
		setProperty('fakeNS0.visible', false)
		setPropertyFromGroup('playerStrums', 0, 'visible', true)
	end
	if getProperty('fakeNS1.animation.curAnim.finished') and getProperty('fakeNS1.visible') then
		setProperty('fakeNS1.visible', false)
		setPropertyFromGroup('playerStrums', 1, 'visible', true)
	end
	if getProperty('fakeNS2.animation.curAnim.finished') and getProperty('fakeNS2.visible') then
		setProperty('fakeNS2.visible', false)
		setPropertyFromGroup('playerStrums', 2, 'visible', true)
	end
	if getProperty('fakeNS3.animation.curAnim.finished') and getProperty('fakeNS3.visible') then
		setProperty('fakeNS3.visible', false)
		setPropertyFromGroup('playerStrums', 3, 'visible', true)
	end
	if STWN0 then
		setPropertyFromGroup('playerStrums', 0, 'color', getProperty('fakeobjS0.color'))
	end
	if STWN1 then
		setPropertyFromGroup('playerStrums', 1, 'color', getProperty('fakeobjS1.color'))
	end
	if STWN2 then
		setPropertyFromGroup('playerStrums', 2, 'color', getProperty('fakeobjS2.color'))
	end
	if STWN3 then
		setPropertyFromGroup('playerStrums', 3, 'color', getProperty('fakeobjS3.color'))
	end
end


function onTweenCompleted(tag) -- see onUpdatePost
	if tag == 'ftS0' then
		--setProperty('locked0', false)
		STWN0 = false
	end
	if tag == 'ftS1' then
		--setProperty('locked1', false)
		STWN1 = false
	end
	if tag == 'ftS2' then
		--setProperty('locked2', false)
		STWN2 = false
	end
	if tag == 'ftS3' then
		--setProperty('locked3', false)
		STWN3 = false
	end
end

function onTimerCompleted(tag, loops, loopsLeft)
	for tmS = 0, 3 do
		if tag == 'ULS'..tmS then
			if loopsLeft == 4 then
				setTextString('timS'..tmS, 4)
			elseif loopsLeft == 3 then
				setTextString('timS'..tmS, 3)
			elseif loopsLeft == 2 then
				setTextString('timS'..tmS, 2)
			elseif loopsLeft == 1 then
				setTextString('timS'..tmS, 1)
			elseif loopsLeft < 1 then
				if tmS == 0 then -- see onUpdatePost
					STWN0 = true
					doTweenColor('ftS'..tmS, 'fakeobjS'..tmS, OGSNC0, 0.3, 'bounceOut')
				end
				if tmS == 1 then
					STWN1 = true
					doTweenColor('ftS'..tmS, 'fakeobjS'..tmS, OGSNC1, 0.3, 'bounceOut')
				end
				if tmS == 2 then
					STWN2 = true
					doTweenColor('ftS'..tmS, 'fakeobjS'..tmS, OGSNC2, 0.3, 'bounceOut')
				end
				if tmS == 3 then
					STWN3 = true
					doTweenColor('ftS'..tmS, 'fakeobjS'..tmS, OGSNC3, 0.3, 'bounceOut')
				end
				--doTweenColor('ft'..tmS, 'fakeobjS'..tm, OGNC, 0.3, 'bounceOut')
				setProperty('locked'..tmS, false)
				setProperty('timS'..tmS..'.visible', false)
				setTextString('timS'..tmS, 5)
			end
		end
	end
end