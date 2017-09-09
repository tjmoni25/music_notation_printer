trebleNotes = {
	\tempo 4 = 120
	\time 3/4
	\clef treble
	c''''8 c''''8 d''''4 e''''4 f''''4 g''''2 b''''4 b''''8 
}
bassNotes = {
	\clef bass
	R8 R8 R4 R4 R4 R2 R4 R8 
}
<<
	\new Staff \trebleNotes
	\new Staff \bassNotes
>>