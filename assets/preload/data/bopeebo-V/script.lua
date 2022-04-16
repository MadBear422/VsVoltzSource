function onSongStart()
	if not isStoryMode then
		setProperty('fakeN2.offset.y', 42)
	else
		setProperty('fakeN2.offset.y', 45)
	end
end

