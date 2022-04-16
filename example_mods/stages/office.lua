function onCreate()
	makeLuaSprite('bg_main', 'office/office-main', -267, -227)
	scaleObject('bg_main', 0.8, 0.8)
	addLuaSprite('bg_main', false)
	
	makeLuaSprite('bg-top', 'office/office-top', -390, -451)
	scaleObject('bg-top', 0.9)
	setScrollFactor('bg-top', 1, 1)
	addLuaSprite('bg-top', true)

	makeAnimatedLuaSprite('bg-boppers', 'office/boppers', 366, 266)
	addAnimationByPrefix('bg-boppers', 'bop', 'people', 24, true)
	scaleObject('bg-boppers', 0.8, 0.8)
	addLuaSprite('bg-boppers', false)

	makeLuaSprite('void', 'void', -267, -227)
	scaleObject('void', 10, 10)
	addLuaSprite('void', false)

end

function onStartCountdown()
	setProperty('gf.alpha', 0)
end

function onStepHit()
	if curStep == 48 then
		doTweenAlpha('voidFade', 'void', 0, 1.41, 'linear')
	end
end