10 CLS : RESTORE : CLEAR
20 '****** THIS PROGRAM FOR USE WITH EPSON OR IBM GRAPHICS PRINTER ******
30 '
40 '****** WRITTEN BY:  JOHN DOE (CODERDAWG) *******
50 '
60 '****** GENERAL PRINTER CONTROL *******
70 HORN$ = CHR$(7) '                   Sounds printer horn.
80 CLEARBF$ = CHR$(24) '               Clear printer buffer.
90 XFORMOUT$ = CHR$(27) + CHR$(56) '   Disable paper-out switch.
100 FORMOUT$ = CHR$(27) + CHR$(57) '   Enable paper out switch
110 '****** FORMS CONTROL *******
120 FORMFEED$ = CHR$(12) '             Form feed.
130 FORMLINE$ = CHR$(27) + CHR$(67) '  Set forms to "N" lines.
140 '****** VERTICAL LINE-FEED CONTROL ******
150 LINEFEED$ = CHR$(10) '             One line feed.
160 VTAB$ = CHR$(11) '                 One vertical tab.
170 SETVTAB$ = CHR$(27) + CHR$(66) '   Set vertical tabs at "N1..N2..etc."
180 SPC6LPI$ = CHR$(27) + CHR$(50) '   Set line feed at 6 LPI.
190 SPC8LPI$ = CHR$(27) + CHR$(48) '   Set spaces at 1/8" (8 LPI).
200 SPC10LPI$ = CHR$(27) + CHR$(49) '  Set spaces at 7/72" (10 LPI).
210 SPCN72$ = CHR$(27) + CHR$(65) '    Set line feed "N"/72".
220 '****** HORIZONTAL HEAD CONTROL ******
230 CR$ = CHR$(13) '                   Carriage return.
240 HT$ = CHR$(9) '                    One horizontal tab.
250 SETHT$ = CHR$(27) + CHR$(68) '     Set horizontal tabs at "N1..N2..etc."
260 '****** CHARACTER-FONT AND PRINT-CONTROL ******
270 COMP$ = CHR$(15) '                 Enable compressed characters.
280 XCOMP$ = CHR$(18) '                Disable compressed characters.
290 WIDE$ = CHR$(14) '                 Enable wide characters (5 CPI).
300 XWIDE$ = CHR$(20) '                Disable wide characters.
310 EMPHIZE$ = CHR$(27) + CHR$(69) '   Enable emphasized characters.
320 XEMPHIZE$ = CHR$(27) + CHR$(70) '  Disable emphasized characters.
330 DOUBLE$ = CHR$(27) + CHR$(71) '    Enable double-strike characters.
340 XDOUBLE$ = CHR$(27) + CHR$(72) '   Disable double-strike characters.
350 END
