1 '   LIFE = The game of LIFE by John Conway - a simulation
2 '    This version by John Sigle        2/21/83
50  ' Initialization
51     DEFINT A-Z
52     C=0:R=0:CUR=0:NXT=1:NN=0:CR=0:RN=0       'Mention early for efficiency
53     NROWS=21:NCOLS=78
55     DIM G(NROWS+1,NCOLS+1,1)
58     DIM CLIST(1,1500,1), LLEN(1)
60     DIM CH$(1):CH$(0)="X" : CH$(1)="O"
70     KEY OFF
100 ' Present instructions
101    GOSUB 1000
151 ' Clear screen and draw box
152    GOSUB 2500
200 ' Get and display new pattern from player
202    GOSUB 2000
250 ' Begin or continue evolution
255     LOCATE 24,1 : PRINT SPACE$(79);
256     LOCATE 24,1 : COLOR 0,7:PRINT " RUN mode ";:COLOR 7,0
260     LOCATE 25,1 : PRINT SPACE$(79);
261     LOCATE 25,1 : COLOR 15:PRINT " E";:COLOR 7:PRINT"=Edit, ";:COLOR 15:PRINT"space";:COLOR 7:PRINT"=Pause, ";:COLOR 15:PRINT"C";:COLOR 7:PRINT"=Continue, ";:COLOR 15:PRINT"Q";:COLOR 7:PRINT"=Quit";" #";ALC;
300 ' Repeat until key is pressed
350 '   Calculate and display next generation
352      GOSUB 4000
375 '   Advance to new generation
376      SWAP CUR,NXT
378      SOUND 700,.1 : FOR K=1 TO 2000 : NEXT K
380 '   Check for key pressed
385      C$=INKEY$:IF C$="" THEN GOTO 250
500 ' What did player press?
501    IF C$="E" OR C$="e" THEN GOTO 200
502    IF C$="Q" OR C$="q" THEN CLS:    GOTO 65000
503    IF C$="C" OR C$="c" THEN GOTO 250
504    IF C$=" " THEN C$=INPUT$(1):GOTO 501
505    GOTO 385
1000 ' Routine to present instructions
1006 CLS :PRINT
1008 PRINT "                               L  I  F  E"
1009 PRINT
1010 PRINT "   The original game of life was invented by mathematician John Conway."
1011 PRINT " The idea is to initialize the screen with a pattern of bacteria "
1112 PRINT " in 'EDIT' mode.  The 'RUN' mode then brings life to the colony."
1114 PRINT " The population increases and decreases according to fixed rules "
1116 PRINT " which affect the birth and death of individual bacterium. "
1118 PRINT " A rectangular grid (2-dimensional matrix) will be shown on the screen."
1120 PRINT " Each cell in the grid can contain a bacterium or be empty.  Each cell"
1122 PRINT " has 8 neighbors except that cells on the boundry have less than 8 "
1124 PRINT " neighbors.  The existance of cells from one generation to the next"
1126 PRINT " is determined by the following rules:"
1128 PRINT:PRINT "  1.  A bacteria with 2 or 3 neighbors survives from one generation to "
1130 PRINT "      the next.  A bacterium with fewer neighbors dies of isolation."
1132 PRINT "      One with more neighbors dies of overcrowding."
1134 PRINT:PRINT "  2.  An empty cell spawns a bacteria if it has exactly three "
1136 PRINT "      neighboring cells which contain bacteria."
1150 PRINT:PRINT
1152 PRINT "   Press the spacebar to continue";:ANS$=INPUT$(1)
1154 CLS : PRINT:PRINT
1170 PRINT " In EDIT mode the following commands are available:"
1172 PRINT : PRINT
1174 PRINT "  ";CHR$(24);CHR$(25);CHR$(26);CHR$(27);"         to move the cursor"
1176 PRINT "  M            to Mark a cell as having a bacterium"
1178 PRINT "  space        to erase a mark from a cell"
1180 PRINT "  R            to enter the RUN mode (i.e. start the evolutionary process)"
1182 PRINT "  C            to Clear the grid in order to create a new pattern"
1184 PRINT "  Q            to Quit the game of LIFE"
1186 PRINT : PRINT
1188 PRINT" In RUN mode the following commands are available:"
1190 PRINT
1192 PRINT "  E            to enter the EDIT mode to create or change the pattern"
1194 PRINT "  space        to pause"
1196 PRINT "  C            to Continue the execution after a pause"
1198 PRINT "  Q            to Quit the game of LIFE"
1199 PRINT : PRINT "The EDIT, pause and Quit commands take effect only at the end of a cycle."
1204 PRINT : PRINT "Press spacebar to continue";:ANS$=INPUT$(1)  : RETURN
2000 ' Routine to get and display a pattern
2010 '  Print instructions on line 25
2011     LOCATE 24,1 : PRINT SPACE$(79);
2012     LOCATE 24,1 : COLOR 0,7 :PRINT " EDIT mode ";:COLOR 7,0
2013     LOCATE 25,1 : PRINT SPACE$(79);
2014     LOCATE 25,1 : PRINT "Use ";:COLOR 15:PRINT CHR$(24);CHR$(25);CHR$(26);    CHR$(27);:COLOR 7:PRINT" to move cursor, ";
2015 COLOR 15:PRINT"M";:COLOR 7:PRINT"=mark, ";:COLOR 15:PRINT"space";:COLOR 7:PRINT"=erase, ";:COLOR 15:PRINT"R";:COLOR 7:PRINT "=Run, ";:COLOR 15:PRINT"C";:  COLOR 7:PRINT"=Clear screen, ";:COLOR 15:PRINT"Q";:COLOR 7:PRINT "=quit";
2016     DEF SEG=0:POKE 1052,PEEK(1050):DEF SEG
2020 '  Initialize cursor
2022     RN=11:CN=39:LOCATE RN+1,CN+1,1
2030 '  Top of input loop
2031     C$=INKEY$:IF C$="" THEN 2031
2032     IF LEN(C$)=2 THEN GOTO 2040
2033      IF C$="M" OR C$="m" THEN GOSUB 2080:GOTO 2031
2034      IF C$=" " THEN GOSUB 2070:GOTO 2031
2035      IF C$="R" OR C$="r" THEN RETURN
2036      IF C$="C" OR C$="c" THEN GOSUB 2110:GOTO 2031
2038      IF C$="Q" OR C$="q" THEN GOTO 65000
2039      GOTO 2031
2040     CC=ASC(RIGHT$(C$,1))                   'Two char. code
2041      IF CC=72 THEN GOSUB 2050:GOTO 2031
2042      IF CC=75 THEN GOSUB 2055:GOTO 2031
2043      IF CC=77 THEN GOSUB 2060:GOTO 2031
2044      IF CC=80 THEN GOSUB 2065:GOTO 2031
2045      GOTO 2031
2050 '  Up arrow
2051     IF RN>1 THEN RN=RN-1:LOCATE RN+1,CN+1,1
2052     RETURN
2055 '  Left arrow
2056     IF CN>1 THEN CN=CN-1:LOCATE RN+1,CN+1,1
2057     RETURN
2060 '  Right arrow
2061     IF CN<NCOLS THEN CN=CN+1:LOCATE RN+1,CN+1,1
2062     RETURN
2065 '  Down arrow
2066     IF RN<NROWS THEN RN=RN+1:LOCATE RN+1,CN+1,1
2067     RETURN
2070 '  Spacebar = erase
2071     IF G(RN,CN,CUR)=0 THEN RETURN
2072     FOR K=LLEN(CUR) TO 1 STEP -1
2073       IF CLIST(0,K,CUR)=RN AND CLIST(1,K,CUR)=CN THEN GOTO 2075
2074     NEXT K  :  STOP
2075     FOR J=K TO LLEN(CUR)-1
2076      CLIST(0,J,CUR)=CLIST(0,J+1,CUR):CLIST(1,J,CUR)=CLIST(1,J+1,CUR)
2077     NEXT
2078     G(RN,CN,CUR)=0:PRINT " ";:LOCATE RN+1,CN+1,1:ALC=ALC-1:RETURN
2080 '  Any letter
2081     IF G(RN,CN,CUR)=1 THEN RETURN
2082     G(RN,CN,CUR)=1:ALC=ALC+1
2084     LLEN(CUR)=LLEN(CUR)+1
2086     CLIST(0,LLEN(CUR),CUR)=RN:CLIST(1,LLEN(CUR),CUR)=CN
2087     LOCATE RN+1,CN+1,1:PRINT CH$(CUR);:LOCATE RN+1,CN+1,1
2089     RETURN
2110 '  Routine to clear screen
2112     FOR K=1 TO LLEN(CUR)
2114        RN=CLIST(0,K,CUR):CN=CLIST(1,K,CUR):G(RN,CN,CUR)=0
2115        LOCATE RN+1,CN+1:PRINT " ";
2116     NEXT K
2118     LLEN(CUR)=0
2119     RETURN
2500 ' Routine to clear screen and print box
2502    CLS
2504    PRINT CHR$(218);
2506    FOR K=1 TO NCOLS:PRINT CHR$(196);:NEXT:PRINT CHR$(191);
2508    FOR K=2 TO NROWS+1:LOCATE K,NCOLS+2:PRINT CHR$(179);:NEXT
2510    FOR K=2 TO NROWS+1:LOCATE K,1:PRINT CHR$(179);:NEXT
2512    LOCATE NROWS+2,1:PRINT CHR$(192);
2514    FOR K=1 TO NCOLS:PRINT CHR$(196);:NEXT:PRINT CHR$(217);
2599    RETURN
4000 '^ Routine to calculate and display next generation
4001     LOCATE ,,0
4002 '  Zero out last generation
4004     FOR K=1 TO LLEN(NXT)
4006        RN=CLIST(0,K,NXT):CN=CLIST(1,K,NXT):G(RN,CN,NXT)=0
4007     NEXT K
4008     LLEN(NXT)=0 :LL=0
4010 '  Repeat for each cell on the current CLIST
4012     FOR K=1 TO LLEN(CUR)
4020 '    Determine if it lives, put it on list and display it.
4022       RN=CLIST(0,K,CUR):CN=CLIST(1,K,CUR)
4023       R=RN:C=CN:GOSUB 4100    ' Count its neighbors
4025       IF NN=2 OR NN=3 THEN GOTO 4030
4026 '       Cell dies
4027         G(RN,CN,NXT)=0:LOCATE RN+1,CN+1:PRINT " ";:ALC=ALC-1
4029         GOTO 4040
4030 '       Cell lives
4031         LL=LL+1:CLIST(0,LL,NXT)=RN:CLIST(1,LL,NXT)=CN:G(RN,CN,NXT)=1
4032         LOCATE RN+1,CN+1 : PRINT CH$(NXT);:ALC=ALC+1
4040 '    Consider each of its neighbors
4041       R=RN-1:C=CN:GOSUB 4200
4042       R=RN-1:C=CN+1:GOSUB 4200
4043       R=RN:C=CN+1:GOSUB 4200
4044       R=RN+1:C=CN+1:GOSUB 4200
4045       R=RN+1:C=CN:GOSUB 4200
4046       R=RN+1:C=CN-1:GOSUB 4200
4047       R=RN:C=CN-1:GOSUB 4200
4048       R=RN-1:C=CN-1:GOSUB 4200
4060     NEXT K
4062     LLEN(NXT)=LL
4099    RETURN
4100 ' Routine to count current neighbors of cell at r,c
4102    NN=G(R-1,C,CUR)+G(R-1,C+1,CUR)+G(R,C+1,CUR)+G(R+1,C+1,CUR)+                        G(R+1,C,CUR)+G(R+1,C-1,CUR)+G(R,C-1,CUR)+G(R-1,C-1,CUR) :RETURN
4200 ' Routine to analyze and manipulate a neighbor of cell at rn,cn
4203    IF G(R,C,CUR)=1 THEN RETURN  'Cell is currently alive
4211    IF R=0 OR R>NROWS OR C=0 OR C>NCOLS THEN RETURN 'Cell on border
4213    IF G(R,C,NXT)=1 THEN RETURN  'Cell already added
4221    GOSUB 4100  'Count its neighbors
4230 '  if nn=3 then cell becomes alive
4231     IF NN=3 THEN                                                                       LL=LL+1:CLIST(0,LL,NXT)=R:CLIST(1,LL,NXT)=C:G(R,C,NXT)=1 :                      LOCATE R+1,C+1:PRINT CH$(NXT);
4299    RETURN
65000 ' Return to Magazette
65001 LOCATE 24,1:PRINT SPACE$(79);:LOCATE 24,1:PRINT "  Press ESC key to continue ";:ANS$=INPUT$(1):IF ASC(ANS$)<>27 THEN 65001
65002 IF ADDR.%<>0 THEN RUN "START"
65005 END