function onEvent(name)
	if name == 'spin notes' then
		for note=0,7 do
			noteTweenAngle('spinnyTheNotes'..note, note, 720, 0.15, 'linear')
			runTimer('spinCancelDelay', 0.16)
		end
	end
end

function onTimerCompleted(tag)
	if tag == 'spinCancelDelay' then
		cancelTween('spinnyTheNotes')
	end
end
