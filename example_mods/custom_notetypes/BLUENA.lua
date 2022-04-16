-- there's things here, Come In!
function onCreatePost()
	for b = 0, getProperty('unspawnNotes.length') - 1 do
		if getPropertyFromGroup('unspawnNotes', b, 'noteType') == 'BLUENA' then
			setPropertyFromGroup('unspawnNotes', b, 'texture', 'blueNotes')
			setPropertyFromGroup('unspawnNotes', b, 'noteSplashTexture', 'blueSplashes')
			setPropertyFromGroup('unspawnNotes', b, 'noAnimation', true)
		end
	end
end	