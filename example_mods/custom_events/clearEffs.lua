function onEvent(name, value1, value2)
    if name == 'clearEffs' then
		cameraFlash('hud', 'FFFFFF', 0.15)
		clearEffects('camHUD')
		clearEffects('camGame')
		triggerEvent("Add Camera Zoom")
	end
end
