10 KEY OFF : WIDTH 80 : SCREEN 0,0,0 : COLOR 7,0 : RESTORE : CLEAR : CLS
20 'ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
30 'º                                                             º
40 'º            PROGRAM: HEADER FOR THE IBM PC.                  º
50 'º            CREATED BY:  John Doe (CoderDawg)                º
60 'º                        (C) 1981                             º
70 'ÌÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹
80 'º                                                             º
90 'º                                                             º
100 ON ERROR GOTO 390
110 PRINT "DO YOU WANT THE OUTPUT ON THE (P)RINTER OR THE (S)CREEN ";
120 QQ$=INPUT$(1)
130 IF QQ$="S" OR QQ$="s" THEN OP$="SCRN:":GOTO 180
140 IF QQ$="P" OR QQ$="p" THEN OP$="LPT1:":GOTO 180
150 IF QQ$="Q" OR QQ$="q" THEN GOTO 420
160 PRINT
170 GOTO 110
180 OPEN OP$ FOR OUTPUT AS #1
190 PRINT #1, ""
200 READ COUNT
210 PRINT #1, "DEGREES";TAB(10);"RADIANS";TAB(24);"FUNCTION";TAB(37);"5-TERM SERIES"
220 FOR LCV=1 TO COUNT
230 READ J
240 X = J*3.1415927#/180!
250 T = 9!
260 I = 3
270 S = +1!
280 FACT = 1!
290 ANSWER = X
300 S = S * (-1)
310 FACT = FACT * (I-1) * I
320 ANSWER = ANSWER + X ^ I/FACT * S
330 I = I + 2
340 IF I <= T GOTO 300
350 PRINT #1, USING "###      #.######      #.######    ##.######"; J; X; SIN(X); ANSWER
360 NEXT
370 GOTO 410
380 DATA 7,15,95,60,45,90,0,30
390 'HANDLE ERRORS
400 PRINT "== OUTPUT ERROR =="
410 CLOSE #1
420 END