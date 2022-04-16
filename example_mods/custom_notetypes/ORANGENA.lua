-- there's things here, Come In!
function onCreatePost()
	for b = 0, getProperty('unspawnNotes.length') - 1 do
		if getPropertyFromGroup('unspawnNotes', b, 'noteType') == 'ORANGENA' then
			setPropertyFromGroup('unspawnNotes', b, 'texture', 'orangeNotes')
			setPropertyFromGroup('unspawnNotes', b, 'noteSplashTexture', 'orangeSplashes')
			setPropertyFromGroup('unspawnNotes', b, 'noAnimation', true)
		end
	end
end	