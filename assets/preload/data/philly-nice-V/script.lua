function onSongStart()
	if not isStoryMode then
		setProperty('fakeN0.offset.y', 16.5)
		setProperty('fakeN0.offset.x', 36.5)
	else
		setProperty('fakeN0.offset.y', 20.5)
		setProperty('fakeN0.offset.x', 36.5)
		setProperty('fakeN1.offset.y', 38)
		setProperty('fakeN2.offset.y', 45)
	end
end

