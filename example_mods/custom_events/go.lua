-- Event notes hooks
function onCreate()
	precacheImage('buzz')
end

function onEvent(name, value1, value2)
	if name == 'go' then
		makeLuaSprite('goo', 'VGO', 0, 0)
		makeAnimatedLuaSprite('buzz', 'buzz', 0, 140)
		addAnimationByPrefix('buzz', 'buzz', 'buzz', 15, false)
		scaleObject('buzz', 0.7, 0.7)
		scaleObject('goo', 0.7, 0.7)
		setObjectCamera('buzz', 'other')
		setObjectCamera('goo', 'other')
		screenCenter('goo')
		addLuaSprite('buzz', true)
		addLuaSprite('goo', true)
		objectPlayAnimation('buzz', 'buzz', false)
		doTweenAlpha('goTween', 'goo', 0, crochet / 600, 'cubeInOut')
		doTweenX('gXS', 'goo.scale', 0.5, 0.2, 'cubeOut')
		doTweenY('gYS', 'goo.scale', 0.5, 0.2, 'cubeOut')
	end
end