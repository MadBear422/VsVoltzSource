function onEvent(name, value1, value2)
    if name == 'zoomcam' then
		--doTweenZoom('gamezoom', 'camGame', value1, value2, 'expoOut');
		setProperty('defaultCamZoom', value1);
	end
end
