100 KEY OFF : WIDTH 80 : SCREEN 0,0,0 : COLOR 7,0 : RESTORE : CLEAR : CLS
110 '
510 REM ============================================================
520 REM STARFIELD COCKPIT VIEW - FAST VIDEO MEMORY RENDERER
530 REM GW-BASIC / IBM PC TEXT MODE
540 REM ============================================================
600 DEFINT A-Z
610 RANDOMIZE TIMER
900 REM ============================================================
910 REM ** SETUP **
920 REM ============================================================
1000 REM USE MAINLY FAST VIDEO RENDERER (-1) OR SLOWER PRINT (0)
1010 USEFASTDRAW% = 0
1020 REM ** SETUP **
1030 MAXCOL = 80
1040 VIEWROWS = 14
1050 WINLEFT = 2
1060 WINTOP = 2
1070 WINW = 78
1090 WINH = 13
1100 FIELDW = MAXCOL * 4 - 2
1110 FIELDH = VIEWROWS * 3 - 2

1200 REM ============================================================
1210 REM ** 
1220 REM ============================================================
1230 DIM TX(50), TY(50), TT(50), FB(18)

1240 NUMSTARS = 160
1250 DIM SX(NUMSTARS), SY(NUMSTARS), ST(NUMSTARS), SB(NUMSTARS)

1260 FOR I = 1 TO NUMSTARS
1270   SX(I) = INT(RND * FIELDW) + 1
1280   SY(I) = INT(RND * FIELDH) + 1
1290   ST(I) = INT(RND * 5) + 1

1290   ST(I) = INT(RND * 5) + 1
1293   ' TEST BLINKING
1295   IF INT(RND * 3) = 0 THEN SB(I) = 1 ELSE SB(I) = 0
1296   ' NORMAL BLINKING
1298   'IF INT(RND * 8) = 0 THEN SB(I) = 1 ELSE SB(I) = 0
1300 NEXT I

1600 REM ** START VIEW IN CENTER OF SPACE **
1610 VX = (FIELDW - WINW) \ 2 + 1
1620 VY = (FIELDH - WINH) \ 2 + 1
1730 REM ** DRAW COCKPIT FRAME **
1740 GOSUB 10000
1750 REM ** DRAW INITIAL STARFIELD VIEW **
1760 GOSUB 5000
1770 REM ** INITIALIZE STATUS FIELDS **
1780 GOSUB 7000

2000 REM ============================================================
2010 REM MAIN LOOP
2020 REM ============================================================
2100 A$ = ""
2110 A$ = INKEY$
2120 IF A$ <> "" THEN 2140
2130 GOTO 2110
2140 REM ** FLUSH EXTRA KEY BUFFER **
2150 B$ = INKEY$
2160 IF B$ <> "" THEN A$ = B$ : GOTO 2150
2170 IF A$ = CHR$(27) THEN GOTO 9000
2175 IF A$ = " " THEN GOSUB 5600 : GOTO 2100
2180 DX = 0
2190 DY = 0

2200 REM ** NUMBER KEYS / KEYPAD WITH NUMLOCK **
2203 REM ** TURN ON NUMLOCK Key
2205 REM DEF SEG = 0 : POKE 1047,32
2210 IF A$ = "7" THEN DX = -1 : DY = -1
2220 IF A$ = "8" THEN DY = -1
2230 IF A$ = "9" THEN DX = 1 : DY = -1
2240 IF A$ = "4" THEN DX = -1
2250 IF A$ = "6" THEN DX = 1
2260 IF A$ = "1" THEN DX = -1 : DY = 1
2270 IF A$ = "2" THEN DY = 1
2280 IF A$ = "3" THEN DX = 1 : DY = 1

2300 REM ** EXTENDED ARROW / KEYPAD KEYS **
2310 IF LEN(A$) = 2 THEN K = ASC(RIGHT$(A$,1)) ELSE K = 0
2320 IF K = 72 THEN DY = -1
2330 IF K = 80 THEN DY = 1
2340 IF K = 75 THEN DX = -1
2350 IF K = 77 THEN DX = 1
2360 IF K = 71 THEN DX = -1 : DY = -1
2370 IF K = 73 THEN DX = 1 : DY = -1
2380 IF K = 79 THEN DX = -1 : DY = 1
2390 IF K = 81 THEN DX = 1 : DY = 1

2400 IF DX = 0 AND DY = 0 THEN 2100

2500 REM ** MOVE VIEW THROUGH SPACE, NOT THE SHIP **
2510 VX = VX + DX
2520 VY = VY + DY

2530 REM ** KEEP VIEW INSIDE WORLD **
2540 IF VX < 1 THEN VX = 1
2550 IF VY < 1 THEN VY = 1
2560 IF VX > FIELDW - WINW + 1 THEN VX = FIELDW - WINW + 1
2570 IF VY > FIELDH - WINH + 1 THEN VY = FIELDH - WINH + 1
2575 BP = 1 - BP

2580 GOSUB 5000
2590 GOSUB 7000
2600 GOTO 2100

5000 REM ============================================================
5010 REM FAST STARFIELD - CLEAR VIEW, THEN DRAW ONLY STARS
5020 REM ============================================================
5025  STARTTIME! = TIMER
5026  DEF SEG = &HB800

5030 REM ** CLEAR VIEW WINDOW **
5040 FOR SR = WINTOP TO WINTOP + WINH - 1
5050   OFS = ((SR - 1) * 80 + WINLEFT - 1) * 2
5060   FOR SX = 1 TO WINW
5070     POKE OFS, 32
5080     POKE OFS + 1, 7
5090     OFS = OFS + 2
5100   NEXT SX
5110 NEXT SR

5120 REM ** DRAW ONLY VISIBLE STARS **
5130 FOR I = 1 TO NUMSTARS
5140   IF SX(I) < VX THEN 5260
5150   IF SX(I) > VX + WINW - 1 THEN 5260
5160   IF SY(I) < VY THEN 5260
5170   IF SY(I) > VY + WINH - 1 THEN 5260
5180   SC = WINLEFT + SX(I) - VX
5190   SR = WINTOP + SY(I) - VY

5200   IF ST(I) = 1 THEN CH = 250 : AT = 8
5210   IF ST(I) = 2 THEN CH = 249 : AT = 15
5220   IF ST(I) = 3 THEN CH = 42  : AT = 14
5221   IF ST(I) = 4 THEN CH = 250 : AT = 9    ' LIGHT BLUE
5222   IF ST(I) = 5 THEN CH = 250 : AT = 12   ' LIGHT RED
5224   ' NEXT MAKES BLINKING TOGETHER
5225   'IF SB(I) = 1 AND BP = 0 THEN CH = 32 : AT = 7
5226   ' NEXT LINE MAKES BLINKING RANDOMLY
5227   IF SB(I) = 1 AND INT(RND * 4) = 0 THEN CH = 32 : AT = 7
5228   ' TEMPORARILY USE HARDWARE BLINKING
5229   IF SB(I) = 1 THEN AT = AT + 128
5230   OFS = ((SR - 1) * 80 + (SC - 1)) * 2
5240   POKE OFS, CH
5250   POKE OFS + 1, AT
5260 NEXT I
5280 ENDTIME! = TIMER
5290 IF ENDTIME! < STARTTIME! THEN ENDTIME! = ENDTIME! + 86400
5320 ' --- CALCULATE AND PRINT ---
5330 EXECUTIONTIME! = ENDTIME! - STARTTIME!
5340 'PRINT "Execution time: "; EXECUTIONTIME!; " seconds";
5350 DEF SEG = 0
5360 RETURN

5500 REM ============================================================
5510 REM MAKE OBJECT BLINK 25% OF THE TIME
5520 REM ============================================================
5530 IF INT(RND * 4) = 0 THEN AT = AT + 128
5540 RETURN

5600 REM ============================================================
5610 REM SMALL DIRECT VIDEO FLASH
5620 REM ============================================================
5630 DEF SEG = &HB800
5640 BASE = ((7 - 1) * 80 + (38 - 1)) * 2
5650 N = 1
5660 FOR R = 0 TO 2
5670   OFS = BASE + R * 160
5680   FOR C = 0 TO 2
5690     FB(N) = PEEK(OFS + C * 2)
5700     FB(N + 1) = PEEK(OFS + C * 2 + 1)
5710     POKE OFS + C * 2, 219
5720     POKE OFS + C * 2 + 1, 15
5730     N = N + 2
5740   NEXT C
5750 NEXT R
5760 BEEP
5770 FOR D = 1 TO 40 : NEXT D
5780 N = 1
5790 FOR R = 0 TO 2
5800   OFS = BASE + R * 160
5810   FOR C = 0 TO 2
5820     POKE OFS + C * 2, FB(N)
5830     POKE OFS + C * 2 + 1, FB(N + 1)
5840     N = N + 2
5850   NEXT C
5860 NEXT R
5870 DEF SEG = 0
5880 RETURN

6000 REM ============================================================
6010 REM SCROLL VIEW ONLY WHEN PLAYER NEARS EDGE
6020 REM ============================================================
6030 PSX = PX - VX + 1
6040 PSY = PY - VY + 1
6050 IF PSX < 25 THEN VX = VX - 1
6060 IF PSX > 54 THEN VX = VX + 1
6070 IF PSY < 4 THEN VY = VY - 1
6080 IF PSY > 10 THEN VY = VY + 1
6090 IF VX < 1 THEN VX = 1
6100 IF VY < 1 THEN VY = 1
6110 IF VX > FIELDW - WINW + 1 THEN VX = FIELDW - WINW + 1
6120 IF VY > FIELDH - WINH + 1 THEN VY = FIELDH - WINH + 1
6130 RETURN

7000 REM ============================================================
7010 REM STATUS DISPLAY
7020 REM ============================================================
7030 AT = 10
7040 ROW = 17 : COL = 10 : TEXT$ = "000000"  : GOSUB 14000
7050 ROW = 18 : COL = 10 : TEXT$ = "GREEN"   : GOSUB 14000
7060 ROW = 19 : COL = 9 : TEXT$ = STR$(VX) + " " + STR$(VY) : GOSUB 14000
7070 ROW = 20 : COL = 9 : TEXT$ = STR$(SC) + " " + STR$(SR) : GOSUB 14000
7080 ROW = 21 : COL = 10 : TEXT$ = "XXXXXXX" : GOSUB 14000
7090 RETURN

9000 REM ============================================================
9010 REM END OF PROGRAM
9020 REM ============================================================
9030 DEF SEG = 0
9040 COLOR 7,0
9050 SCREEN 0 : WIDTH 80 : CLS : LOCATE ,,1
9060 END

10000 REM ============================================================
10010 REM ** CREATE COCKPIT VIEW - FAST VIDEO MEMORY OUTPUT **
10020 REM ============================================================
10040 COL = 1
10050 ROW = 1

10060 REM ============================================================
10070 REM ** TOP BORDER **
10080 REM ============================================================
10090 FOR X = 1 TO MAXCOL
10100   CH = 205 : AT = 11
10110   GOSUB 15000
10120 NEXT X

10130 REM ============================================================
10140 REM ** VIEW WINDOW SIDES **
10150 REM ============================================================
10160 TOTALROWS = VIEWROWS
10170 FOR ROW = 2 TO TOTALROWS
10180   X = 1 : CH = 186 : AT = 11 : GOSUB 15000
10190   X = MAXCOL : CH = 186 : AT = 11 : GOSUB 15000
10200 NEXT ROW

10210 REM ============================================================
10220 REM ** BOTTOM OF VIEW AREA **
10230 REM ============================================================
10240 ROW = VIEWROWS + 1
10250 X = 1 : CH = 186 : AT = 11 : GOSUB 15000
10260 X = MAXCOL : CH = 186 : AT = 11 : GOSUB 15000

10270 REM ============================================================
10280 REM ** DIVIDER LINE **
10290 REM ============================================================
10300 ROW = ROW + 1
10310 FOR X = 1 TO MAXCOL
10320   CH = 205 : AT = 11
10330   GOSUB 15000
10340 NEXT X

10350 REM ============================================================
10360 REM ** DRAW VERTICAL LINES OF STATUS WINDOW **
10370 REM ============================================================
10380 ROWSAVED = ROW
10390 FOR R = 1 TO 5
10400   CH = 186 : AT = 11
10410   ROW = R + ROWSAVED
10420	X = 1
10430	GOSUB 15000
10440   X = COL + 22
10450   GOSUB 15000
10460   X = MAXCOL - 23
10470	GOSUB 15000
10480   X = MAXCOL
10490	GOSUB 15000
10500 NEXT R

10520 REM ============================================================
10530 REM ** BOTTOM BORDER **
10540 REM ============================================================
10550 ROW = 22
10560 FOR X = 1 TO MAXCOL
10570   CH = 205 : AT = 11
10580   GOSUB 15000
10590 NEXT X

10600 REM ============================================================
10610 REM ** DRAW 10 CORNERS USING DECORATOR CHAR FOR VIEW WINDOW **
10620 REM ============================================================
10630 ROW = 1 
10640 X = 1
10645 AT = 11
10650 CH = 201
10660 GOSUB 15000
10670 ROW = 22 
10680 X = 1 
10690 CH = 200
10700 GOSUB 15000
10710 X = 1
10720 ROW = 16
10730 CH = 204
10740 GOSUB 15000
10750 X = MAXCOL
10760 ROW = 1
10770 CH = 187
10780 GOSUB 15000
10790 ROW = 16
10800 X = 23
10810 CH = 203
10820 GOSUB 15000
10830 ROW = 22
10840 X = 23
10850 CH = 202
10860 GOSUB 15000
10870 ROW = 16
10880 X = MAXCOL
10890 CH = 185
10900 GOSUB 15000
10910 ROW = 22
10920 X = MAXCOL
10930 CH = 188
10940 GOSUB 15000
10950 ROW = 16
10960 X = MAXCOL - 23
10970 CH = 203
10980 GOSUB 15000
10990 ROW = 22
11000 X = MAXCOL - 23
11010 CH = 202
11020 GOSUB 15000
11030 REM ============================================================
11040 REM ** CREATE TEXT STATUS FIELDS **
11050 REM ============================================================
11060 AT = 11
11070 ROW = 17 : COL = 3  : TEXT$ = "SCORE:"  : GOSUB 14000
11080 ROW = 18 : COL = 3  : TEXT$ = "ALERT:"  : GOSUB 14000
11090 ROW = 19 : COL = 4  : TEXT$ = "SHIP:"   : GOSUB 14000
11100 ROW = 20 : COL = 4  : TEXT$ = "VIEW:"   : GOSUB 14000
11110 ROW = 21 : COL = 4  : TEXT$ = "WARP:"   : GOSUB 14000
11130 ROW = 17 : COL = 58 : TEXT$ = "FUEL"    : GOSUB 14000
11140 ROW = 18 : COL = 59 : TEXT$ = "F"       : GOSUB 14000
11150 ROW = 19 : COL = 59 : TEXT$ = CHR$(171) : GOSUB 14000
11160 ROW = 20 : COL = 59 : TEXT$ = CHR$(172) : GOSUB 14000
11170 ROW = 21 : COL = 59 : TEXT$ = "E"       : GOSUB 14000
11180 RETURN

14000 REM ============================================================
14010 REM ** WRITES FULL TEXT$ AT ROW, COL **
14020 REM ============================================================
14030 IF USEFASTDRAW% <> 0 THEN GOSUB 16000 ELSE GOSUB 18000 
14400 RETURN

15000 REM ============================================================
15010 REM ** WRITES ONE CHARACTER (CH) ROW, X, AND COLOR (AT)
15020 REM ============================================================
15030 IF USEFASTDRAW% <> 0 THEN GOSUB 17000 ELSE GOSUB 19000 
15400 RETURN

16000 REM ============================================================
16010 REM ** WRITE TEXT$ TO VIDEO MEMORY ROW, COL, AND COLOR (AT) **
16030 REM ============================================================
16040 FOR TX = 1 TO LEN(TEXT$)
16050   X = COL + TX - 1
16060   CH = ASC(MID$(TEXT$, TX, 1))
16070   GOSUB 15000
16080 NEXT TX
16090 RETURN

17000 REM ============================================================
17010 REM ** WRITE ONE CHARACTER TO VIDEO MEMORY **
17020 REM ============================================================
17030 OFS = ((ROW - 1) * 80 + (X - 1)) * 2
17040 POKE OFS, CH
17050 POKE OFS + 1, AT
17060 RETURN

18000 REM ============================================================
18010 REM ** PRINT TEXT$ ROW, COL, AND COLOR (AT) **
18020 REM ============================================================
18030 REM SET THE COLOR
18040 GOSUB 20100
18060 LOCATE ROW,COL
18070 PRINT TEXT$;
18080 RETURN

19000 REM ============================================================
19010 REM ** PRINT ONE CHARACTER (CH) ROW, X, COLOR (AT) **
19020 REM ============================================================
19030 REM SET THE COLOR
19040 GOSUB 20100
19060 LOCATE ROW,X
19070 PRINT CHR$(CH);
19080 RETURN 

20000 REM ============================================================
20010 REM ** LEFT SPACE PAD TEXT$ HAS TEXT STRING TO PAD, FLEN% HAS FIELD LENGTH **
20020 REM ============================================================
20030 TEXT$ = RIGHT$(SPACE$(FLEN%) + TEXT$, FLEN%)
20040 RETURN
20050 REM ============================================================
20060 REM ** RIGHT SPACE PAD TEXT$ HAS TEXT STRING TO PAD, FLEN% HAS FIELD LENGTH **
20070 REM ============================================================
20080 TEXT$ = LEFT$(TEXT$ + SPACE$(FLEN%), FLEN%)
20090 RETURN

20100 REM ============================================================
20110 REM ** CONVERT VIDEO ATTRIBUTE AT TO COLOR FG,BG **
20120 REM ============================================================
20130 A = AT
20140 IF A >= 128 THEN A = A - 128
20150 FG = A MOD 16
20160 BG = A \ 16
20170 COLOR FG, BG
20180 RETURN

20300 REM ** DATA FLASH SCREEN ROUTINE **
20310 DATA &H50,&H53,&H51,&H52,&H57,&H06
20320 DATA &HB8,&H00,&HB8
20330 DATA &H8E,&HC0
20340 DATA &HB3,&H0D
20350 DATA &HBA,&H0D,&H00
20360 DATA &HBF,&HA3,&H00
20370 DATA &HB9,&H4E,&H00
20380 DATA &H26,&H88,&H1D
20390 DATA &H83,&HC7,&H02
20400 DATA &HE2,&HF8
20410 DATA &H83,&HC7,&H04
20420 DATA &H4A
20430 DATA &H75,&HEF
20440 DATA &H07,&H5F,&H5A,&H59,&H5B,&H58,&HCB
