local OGNC0 = 0
local OGNC1 = 1
local OGNC2 = 2
local OGNC3 = 3
local unlock0 = true -- unlock em
local unlock1 = true -- unlock em
local unlock2 = true -- unlock em
local unlock3 = true -- unlock em
local TWN0 = false
local TWN1 = false
local TWN2 = false
local TWN3 = false

local anims = {'Left electrofied', 'Down electrofied', 'Up electrofied', 'Right electrofied'}
function onCountdownTick(counter)
	if counter == 1 then
		OGNC0 = getPropertyFromGroup('playerStrums', 0, 'color')
		OGNC1 = getPropertyFromGroup('playerStrums', 1, 'color')
		OGNC2 = getPropertyFromGroup('playerStrums', 2, 'color')
		OGNC3 = getPropertyFromGroup('playerStrums', 3, 'color')
		
		for n = 0, 3 do
			if not getPropertyFromClass('PlayState', 'isPixelStage') then
				makeAnimatedLuaSprite('fakeN'..n, 'NOTE_flicker', getPropertyFromGroup('playerStrums', n, 'x') - 30, getPropertyFromGroup('playerStrums', n, 'y'))
				setProperty('fakeN0.angle', -90)
				if not downscroll then
					if not middlescroll then
						setProperty('fakeN0.offset.x', 35.5)
					else
						setProperty('fakeN0.offset.x', 36.5)
					end
					setProperty('fakeN3.y', 17)
				else
					if not middlescroll then
						setProperty('fakeN0.offset.x', 36.5)
					else
						setProperty('fakeN0.offset.x', 35.7)
					end
					setProperty('fakeN3.y', 536.5)
				end
				setProperty('fakeN0.offset.y', 18)
				setProperty('fakeN1.offset.x', 57.5)
				setProperty('fakeN1.offset.y', 35.5)
				setProperty('fakeN2.offset.x', 55)
				setProperty('fakeN2.offset.y', 35)
				setProperty('fakeN1.flipY', true)
				setProperty('fakeN3.angle', 90)
				if not middlescroll then
					setProperty('fakeN3.x', 1043)
				else
					setProperty('fakeN3.x', 723)
				end
				addAnimationByPrefix('fakeN'..n, 'static', 'static', 60, false)
				if not downscroll then
					makeLuaText('tim'..n, 5, 1000, 287, 86)
				else
					makeLuaText('tim'..n, 5, 1000, 287, 605)
				end
			else
				makeAnimatedLuaSprite('fakeN'..n, 'NOTE_flickerP', getPropertyFromGroup('playerStrums', n, 'x') - 24, getPropertyFromGroup('playerStrums', n, 'y') - 23)
				addAnimationByPrefix('fakeN'..n, 'static',  anims[n+1], 50, false)
				setProperty('fakeN'..n..'.antialiasing', false)
				setProperty('fakeN1.offset.y', -64)
				setProperty('fakeN2.offset.y', -67)
				if not downscroll then
					setProperty('fakeN3.y', 26)
				else
					setProperty('fakeN3.y', 546.5)
				end
				--setProperty('fakeN1.offset.x', -64)
				if not downscroll then
					makeLuaText('tim'..n, 5, 1000, 283, 80)
				else
					makeLuaText('tim'..n, 5, 1000, 283, 605)
				end
			end
			setObjectCamera('fakeN'..n, 'hud')
			scaleObject('fakeN'..n, getPropertyFromGroup('playerStrums', n, 'scale.x'), getPropertyFromGroup('playerStrums', n, 'scale.y'))
			setProperty('fakeN'..n..'.visible', false)
			addLuaSprite('fakeN'..n, true)
			makeLuaSprite('fakeobj'..n, 'combo', 0, 0)
			setTextSize('tim'..n, 32);
			setTextColor('tim'..n, 'FFE500')
			addLuaText('tim'..n)
			setProperty('tim'..n..'.visible', false)
		end
	end
end

function noteMiss(id, dir, NT, isSus)
    if NT == 'Electric Note' then
		setProperty('fakeobj'..dir..'.color', 'FFFFFF')
		setProperty('tim'..dir..'.visible', true)
		if dir == 0 then
			unlock0 = false
			if middlescroll then
				setProperty('tim0.x', getProperty('fakeN0.x') - 418)
			end
		end
		if dir == 1 then
			unlock1 = false
			if not getPropertyFromClass('PlayState', 'isPixelStage') then
				setProperty('tim1.x', getProperty('fakeN1.x') - 418)
			else
				setProperty('tim1.x', getProperty('fakeN1.x') - 427)
			end
		end
		if dir == 2 then
			unlock2 = false
			if not getPropertyFromClass('PlayState', 'isPixelStage') then
				setProperty('tim2.x', getProperty('fakeN2.x') - 417)
			else
				setProperty('tim2.x', getProperty('fakeN2.x') - 427)
			end
		end
		if dir == 3 then
			unlock3 = false
			if not getPropertyFromClass('PlayState', 'isPixelStage') then
				setProperty('tim3.x', getProperty('fakeN3.x') - 415)
			else
				setProperty('tim3.x', getProperty('fakeN3.x') - 425)
			end
		end
		runTimer('UL'..dir, 1, 5)
		setProperty('locked'..dir, true)
		setProperty('fakeN'..dir..'.visible', true)
		objectPlayAnimation('fakeN'..dir, 'static', false)
		setPropertyFromGroup('playerStrums', dir, 'visible', false)
		setPropertyFromGroup('playerStrums', dir, 'color', getProperty('fakeobj'..dir..'.color'))
		soundName = string.format('Elec%i', math.random(1, 3));
		playSound(soundName, getRandomFloat(0.3, 0.4), 'EMiss');
    end
end


function onUpdatePost(elapsed) -- biggest if pile, since using "do" statements breaks them for some reason
	if getProperty('fakeN0.animation.curAnim.finished') and getProperty('fakeN0.visible') then
		setProperty('fakeN0.visible', false)
		setPropertyFromGroup('playerStrums', 0, 'visible', true)
	end
	if getProperty('fakeN1.animation.curAnim.finished') and getProperty('fakeN1.visible') then
		setProperty('fakeN1.visible', false)
		setPropertyFromGroup('playerStrums', 1, 'visible', true)
	end
	if getProperty('fakeN2.animation.curAnim.finished') and getProperty('fakeN2.visible') then
		setProperty('fakeN2.visible', false)
		setPropertyFromGroup('playerStrums', 2, 'visible', true)
	end
	if getProperty('fakeN3.animation.curAnim.finished') and getProperty('fakeN3.visible') then
		setProperty('fakeN3.visible', false)
		setPropertyFromGroup('playerStrums', 3, 'visible', true)
	end
	if TWN0 then
		setPropertyFromGroup('playerStrums', 0, 'color', getProperty('fakeobj0.color'))
	end
	if TWN1 then
		setPropertyFromGroup('playerStrums', 1, 'color', getProperty('fakeobj1.color'))
	end
	if TWN2 then
		setPropertyFromGroup('playerStrums', 2, 'color', getProperty('fakeobj2.color'))
	end
	if TWN3 then
		setPropertyFromGroup('playerStrums', 3, 'color', getProperty('fakeobj3.color'))
	end
end


function onTweenCompleted(tag) -- see onUpdatePost
	if tag == 'ft0' then
		--setProperty('locked0', false)
		TWN0 = false
	end
	if tag == 'ft1' then
		--setProperty('locked1', false)
		TWN1 = false
	end
	if tag == 'ft2' then
		--setProperty('locked2', false)
		TWN2 = false
	end
	if tag == 'ft3' then
		--setProperty('locked3', false)
		TWN3 = false
	end
end

function onTimerCompleted(tag, loops, loopsLeft)
	for tm = 0, 3 do
		if tag == 'UL'..tm then
			if loopsLeft == 4 then
				setTextString('tim'..tm, 4)
			elseif loopsLeft == 3 then
				setTextString('tim'..tm, 3)
			elseif loopsLeft == 2 then
				setTextString('tim'..tm, 2)
			elseif loopsLeft == 1 then
				setTextString('tim'..tm, 1)
			elseif loopsLeft < 1 then
				if tm == 0 then -- see onUpdatePost
					TWN0 = true
					doTweenColor('ft'..tm, 'fakeobj'..tm, OGNC0, 0.3, 'bounceOut')
				end
				if tm == 1 then
					TWN1 = true
					doTweenColor('ft'..tm, 'fakeobj'..tm, OGNC1, 0.3, 'bounceOut')
				end
				if tm == 2 then
					TWN2 = true
					doTweenColor('ft'..tm, 'fakeobj'..tm, OGNC2, 0.3, 'bounceOut')
				end
				if tm == 3 then
					TWN3 = true
					doTweenColor('ft'..tm, 'fakeobj'..tm, OGNC3, 0.3, 'bounceOut')
				end
				--doTweenColor('ft'..tm, 'fakeobj'..tm, OGNC, 0.3, 'bounceOut')
				setProperty('locked'..tm, false)
				setProperty('tim'..tm..'.visible', false)
				setTextString('tim'..tm, 5)
			end
		end
	end
end