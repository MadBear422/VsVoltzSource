-- there's things here, Come In!
function onCreatePost()
	for b = 0, getProperty('unspawnNotes.length') - 1 do
		if getPropertyFromGroup('unspawnNotes', b, 'noteType') == 'ORANGE' then
			setPropertyFromGroup('unspawnNotes', b, 'texture', 'orangeNotes')
			setPropertyFromGroup('unspawnNotes', b, 'noteSplashTexture', 'orangeSplashes')
		end
	end
end	