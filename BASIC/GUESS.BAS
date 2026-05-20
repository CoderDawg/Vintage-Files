100 REM PROGRAM TITLE:  Respect Your Computer
150 CLS
160 DIM A(10)
200 RESTORE : P=1 : Q=1 : X=10: IF WW=1 THEN 900
250 PRINT "Naturally you should have some"
300 PRINT "respect for your computer, even"
350 PRINT "though it is only a machine."
400 PRINT "This machine will now test your"
450 PRINT "patience just to see how much"
500 PRINT "respect you do have for this"
550 PRINT "machine.  You see, this"
600 PRINT "is one game that your computer"
650 PRINT "will stake its circuits on"
700 PRINT "you cannot and will not "
750 PRINT "beat it or strike it !!!"
800 PRINT
850 INPUT "Press <<ENTER>>....Please";XX
900 CLS
950 PRINT "If you are ready, we will now"
1000 PRINT "begin.  I have selected a number"
1050  PRINT "between 1 and ";X;".  Tell me"
1100 INPUT "the number ";N
1150 IF N<1 OR N>X THEN 1100
1200 PRINT "Your number:  ";N
1250 FOR I =1 TO 800 : NEXT I
1300 PRINT CHR$(83);CHR$(79);CHR$(82);
1350 PRINT CHR$(82);CHR$(89);CHR$(33)
1400 PRINT
1450 A(P)=N
1500 PRINT "Numbers guessed:  ";
1550 FOR I = 1 TO P
1555 PRINT A(I);
1560 NEXT I
1600 PRINT:P=P+1
1625 READ INSULT$
1650 PRINT "Guess again, ";INSULT$;"...."
1670 DATA DUMMY,IDIOT,TURKEY,STUPID,UGLY,MORON,PUTZ,JERK,FOOL,SUCKER
1671 DATA MEATHEAD,BUM,NEOPHYTE,RETARD,DIRTBAG,HAIRBALL,AIR HEAD
1700 IF P>=X THEN 1900
1800 PRINT
1850 GOTO 1100
1900 PRINT
1950 PRINT "Never mind...."
2000 PRINT "The number I had selected was:  ";
2050 A=X
2100 FOR I=1 TO P-1
2150 IF A<>A(I) THEN NEXT I:GOTO 2250
2200 A=A-1:GOTO 2100
2250 REM print number
2300 PRINT A:PRINT
2350 PRINT "Your guesses were:  ";
2400 FOR I=1 TO P-1
2450 PRINT A(I);:NEXT
2500 PRINT
2550 Q=Q+1:TP=TP+P-1
2600 IF Q>=1 THEN 3000
2650 PRINT "Let's try ";
2700 IF Q=3 THEN PRINT "once more....":GOTO 2800
2750 PRINT "again...."
2800 FOR I=1 TO 1200 : NEXT I
2850 PRINT:P=1
2900 GOTO 850
3000 PRINT
3050 PRINT "Of the ";TP;" guesses you made,"
3100 PRINT "none of them matched the"
3150 PRINT "number I had selected......"
3200 FOR I=1 TO 2000:NEXT I:Z=X
3250 REM more ?
3300 IF X=10 THEN X=5:GOTO 3450
3350 IF X=5 THEN X=3:GOTO 3450
3400 A=0 : GOTO 3850
3450 PRINT : P=1 : Q=1 : IF X=3 GOTO 3600
3500 PRINT "To take this a step further,"
3550 PRINT "let's try something different."
3600 PRINT "Instead of 1 and ";Z;" I will"
3650 PRINT "select between 1 and ";X;" and"
3700 PRINT "give you ";X-1;" tries...."
3750 PRINT
3800 GOTO 850
3850 PRINT
3900 PRINT "This is really hard to believe...."
3950 PRINT "You made ";TP;" guesses, I gave"
4000 PRINT "you three different breaks and"
4050 PRINT "you matched ";A;" of the numbers"
4100 PRINT "that I selected !!!"
4150 FOR I= 1 TO 3000 : NEXT I
4200 CLS
4250 COLOR 15,0 : PRINT "You can't win......"
4300 PRINT :PRINT "SUCKER !!": COLOR 7
4350 FOR I = 1 TO 1500 : NEXT I:CLS
4400 PRINT "Ready to try again, you'll"
4450 PRINT "get the same breaks as before Y/N:  ?";
4500 X$=INPUT$(1)
4550 IF X$="N" OR X$="n" THEN GOTO 4650
4600 WW=1: GOTO 160
4650 CLS:PRINT CHR$(23)
4700 PRINT "CHICKEN ..."
4750 GOTO 4750