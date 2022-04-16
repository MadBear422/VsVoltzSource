-- Event notes hooks
function onEvent(name, value1, value2)
	if name == '3' then
		makeLuaSprite('three', 'Vnum3', 0, -150)
		makeLuaSprite('Ve', 'voltz eyes', 160, 150)
		scaleObject('Ve', 0.3, 0.3)
		setObjectCamera('Ve', 'other')
		setObjectCamera('three', 'other')
		addLuaSprite('Ve', true)
		addLuaSprite('three', true)
		doTweenAlpha('VTween', 'Ve', 0, crochet / 800, 'cubeInOut')
		doTweenY('t', 'three', 0, 0.2, 'quadOut')
		doTweenAlpha('threeTween', 'three', 0, crochet / 800, 'cubeInOut')
	end
end