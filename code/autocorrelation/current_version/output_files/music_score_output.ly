trebleNotes = {
	\tempo 4 = 180
	\time 4/4
	\clef treble
	c'4 f'4 f'8 g'8 f'8 e'8 d'4 d'4 d'4 g'4 g'8 a'8 g'8 f'8 e'4 c'4 c'4 a'4 a'8 ais'8 a'8 g'8 f'4 d'4 c'8 c'8 d'4 g'4 e'4 f'4 
}
bassNotes = {
	\clef bass
	R4 R4 R8 R8 R8 R8 R4 R4 R4 R4 R8 R8 R8 R8 R4 R4 R4 R4 R8 R8 R8 R8 R4 R4 R8 R8 R4 R4 R4 R4 
}
<<
	\new Staff \trebleNotes
	\new Staff \bassNotes
>>