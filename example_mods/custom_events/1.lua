-- Event notes hooks
function onEvent(name, value1, value2)
	if name == '1' then
		makeLuaSprite('sett', 'VNUM1', -310, -350)
		setObjectCamera('sett', 'other')
		scaleObject('sett', 1.5, 1.5)
		addLuaSprite('sett', true)
		doTweenY('t', 'sett', -200, 0.3, 'quadOut')
		doTweenAlpha('setTween', 'sett', 0, crochet / 800, 'cubeInOut')
	end
end