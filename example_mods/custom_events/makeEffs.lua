function onEvent(name, value1, value2)
    if name == 'makeEffs' then
		if flashingLights then
		cameraFlash('hud', 'FFFFFF', 0.15)
		end
		addGrayscaleEffect('camGame')
		addGrayscaleEffect('camHUD')
		triggerEvent("Add Camera Zoom")
	end
end
