trebleNotes = {
	\tempo 4 = 80
	\time 4/4
	\clef treble
	R4 R4 R4 R4 R4 e'''4 R4 dis'1 R4 R4 R4 R4 g'4 a'4 R4 c'1 c'4 d'4 e''4 f'4 g'4 a'4 b'4 c''1 c''4 d''4 e''4 f''4 g''4 a''4 b''4 c'''1 c'''4 dis'''2 gis'''2 b'''4 c''''16 
}
bassNotes = {
	\clef bass
	c,4 d,4 fis4 f4 g4 R4 b,4 R1 c4 d4 e4 f4 R4 R4 b4 R1 R4 R4 R4 R4 R4 R4 R4 R1 R4 R4 R4 R4 R4 R4 R4 R1 R4 R2 R2 R4 R16 
}
<<
	\new Staff \trebleNotes
	\new Staff \bassNotes
>>