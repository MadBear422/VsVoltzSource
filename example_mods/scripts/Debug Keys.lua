function onUpdatePost(elapsed)
	if not getProperty('startingSong') or not getProperty('endingSong') then
		if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.F1')  then
			endSong()
		elseif getPropertyFromClass('flixel.FlxG', 'keys.justPressed.F2') then
			setPropertyFromClass('Conductor', 'songPosition', getPropertyFromClass('Conductor', 'songPosition') + 5000) 
			setPropertyFromClass('flixel.FlxG', 'sound.music.time', getPropertyFromClass('Conductor', 'songPosition'))
			setProperty('vocals.time', getPropertyFromClass('Conductor', 'songPosition'))
		elseif getPropertyFromClass('flixel.FlxG', 'keys.justPressed.F3') then
			if not getProperty('cpuControlled') then
				setProperty('cpuControlled', true)
				debugPrint("botPlay On")
				setProperty('botplayTxt.visible', true)
			else
				setProperty('cpuControlled', false)
				setProperty('botplayTxt.visible', false)
				debugPrint("botPlay Off")
			end
		elseif getPropertyFromClass('flixel.FlxG', 'keys.justPressed.F4') then
			setProperty('defaultCamZoom', getProperty('defaultCamZoom') + 0.1)
			doTweenZoom('c', 'camGame', getProperty('defaultCamZoom') + 0.1, 0.1, 'quadInOut')
		elseif getPropertyFromClass('flixel.FlxG', 'keys.justPressed.F5') then
			setProperty('defaultCamZoom', getProperty('defaultCamZoom') - 0.1)
			doTweenZoom('c', 'camGame', getProperty('defaultCamZoom') - 0.1, 0.1, 'quadInOut')
		end
	end
end