local allowCountdown = false
function onStartCountdown()
	if not allowCountdown and not seenCutscene then --Block the first countdown
		startVideo('Slightswing');
		allowCountdown = true;
		return Function_Stop;
	end
	return Function_Continue;
end

function onEvent(n, v1, v2)
	if n == 'Blammed Lights' then
		makeLuaSprite('dark', nil, screenWidth * -0.5, screenHeight * -0.5)
		makeGraphic('dark', screenWidth  * 2, screenHeight * 2, '000000')
		setProperty('dark.alpha', 0)
		addLuaSprite('dark')
		setObjectOrder('dark', getObjectOrder('gfGroup') - 1)
		for i = 0, 5 do
			makeLuaSprite('light'..i, 'philly/win'..i, -10, 0);
			setScrollFactor('light'..i, 0.3, 0.3);
			scaleObject('light'..i, 0.85, 0.85);
			setProperty('light'..i..'.visible', false)
			addLuaSprite('light'..i, false);
			setObjectOrder('light', getObjectOrder('gfGroup') - 1)
		end
		curL = getProperty('curLightEvent') - 1
			setProperty('light'..curL..'.visible', true)
		if getProperty('curLightEvent') > 0 then
			if getProperty('city.alpha') > 0.1 then
				doTweenAlpha('ct', 'city', 0, 1, 'quadInOut')
				doTweenAlpha('st', 'street', 0, 1, 'quadInOut')
				doTweenAlpha('bt', 'behindTrain', 0, 1, 'quadInOut')
				doTweenAlpha('sk', 'sky', 0, 1, 'quadInOut')
				doTweenAlpha('bd', 'dark', 1, 1, 'quadInOut')
			end
		else
			if getProperty('city.alpha') < 0.1 then
				doTweenAlpha('ct', 'city', 1, 1, 'quadInOut')
				doTweenAlpha('st', 'street', 1, 1, 'quadInOut')
				doTweenAlpha('bt', 'behindTrain', 1, 1, 'quadInOut')
				doTweenAlpha('sk', 'sky', 1, 1, 'quadInOut')
				doTweenAlpha('bd', 'dark', 0, 1, 'quadInOut')
			end
		end
	end
end