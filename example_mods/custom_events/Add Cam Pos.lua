local X = 0
local Y = 0
function onEvent(name, value1, value2)
	if name == 'Add Cam Pos' then
		newCamX = tonumber(value1);
		newCamY = tonumber(value2);
		X = newCamX
		Y = newCamY
	end
end

function onMoveCamera(focus)
	setProperty('camFollow.x', getProperty('camFollow.x') + X)
	setProperty('camFollow.y', getProperty('camFollow.y') + Y)
end
