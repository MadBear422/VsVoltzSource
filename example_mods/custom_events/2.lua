-- Event notes hooks
function onEvent(name, value1, value2)
	if name == '2' then
		makeLuaSprite('ready', 'Vnum2', -140, -250)
		makeLuaSprite('Be', 'bf eyes', 870, 180)
		scaleObject('ready', 1.2, 1.2)
		scaleObject('Be', 0.3, 0.3)
		setObjectCamera('Be', 'other')
		setObjectCamera('ready', 'other')
		addLuaSprite('Be', true)
		addLuaSprite('ready', true)
		doTweenY('t', 'ready', -70, 0.2, 'quadOut')
		doTweenAlpha('BTween', 'Be', 0, crochet / 800, 'cubeInOut')
		doTweenAlpha('readyTween', 'ready', 0, crochet / 800, 'cubeInOut')
	end
end