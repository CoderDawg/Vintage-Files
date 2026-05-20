10 CLS : KEY OFF : RESTORE : SCREEN 0,0,0 : WIDTH 80 : COLOR 7
20 LOCATE 10,20 : PRINT "*** HTH POOL WATER TESTER ***"
30 PRINT : PRINT : PRINT
80 INPUT "What is the temperature of the pool water (degrees 'F')";F
90 IF F<60 GOTO 690
100 IF F>95 GOTO 690
110 INPUT "How many gallons in the pool";G
120 INPUT "What is the PH of the pool (7.2-7.6)";P1
130 INPUT "What is the Hardness (PPM 200-1000)";H
140 IF H>1000 THEN GOTO 640
150 INPUT "What is the alkalinity (PPM 50-125)";A
160 INPUT "What is the stabilizer level (PPM approx. 25-50)";S
170 INPUT "What is the free available chlorine level (PPM)";C
180 INPUT "What is the combined chlorine level (PPM)";X
190 CLS
200 IF S>= 50 THEN A=A-INT(5/3)
210 IF F>85 THEN GOTO 710
220 IF F>80 THEN GOTO 730
230 P2=P1-.1
240 REM
250 IF H>700 THEN GOTO 770
260 IF H>500 THEN GOTO 790
270 IF H>325 THEN GOTO 810
280 IF H>250 THEN GOTO 830
290 IF H<200 THEN GOTO 750
300 P2=7.6
310 REM
320 IF P2=7.2 THEN T=50000!/H
330 IF P2=7.3 THEN T=40000!/H
340 IF P2=7.4 THEN T=30000/H
350 IF P2=7.5 THEN T=25000/H
360 IF P2=7.6 THEN T=20000/H
370 IF P1<7.2 THEN P2=7.4
380 IF P1>7.6 THEN P2=7.4
390 IF T<50 GOTO 850
400 IF T>125 THEN GOTO 870
410 PRINT "The PH is:  ";P1;", it should be:  ";P2
415 PRINT "The calcium hardness is:  ";H;", it should be 200-1000 PPM."
420 PRINT "Total alkalinity, adjusted for stabilizer, is:  ";A;", it should be:  ";INT(T)
425 PRINT "plus or minus 5 PPM."
440 IF S=0 THEN PRINT "Pool not stabilized, to stabilize, add:  ";INT(G/10000*4);"LB of HTH stabilizer."
450 IF S>0 THEN PRINT "The stabilizer level is:  ";S;", it should be 25-50 PPM."
460 PRINT
470 PRINT "To balance your pool do the following:  "
480 IF H<200 THEN PRINT "Calcium hardness is too low, add:  ";INT(1.4*(250-H)*G/10000*4);"OZ. of HTH calcium plus."
490 IF A<T-5 THEN GOTO 950
500 IF A>T+5 THEN GOTO 890
510 IF P1=P2 THEN PRINT "The PH is OK!"
520 IF P1>P2 THEN PRINT "Add:  ";INT(20*(P1-P2)*G/10000);"OZ. of HTH PH minus."
530 IF P1<6.4 THEN PRINT "Add:  ";INT(110*(P2-P1)*G/10000);"OZ. of HTH PH plus.  Retest after 4 HRS and adjust."
540 IF P1<6.4 THEN GOTO 580
550 IF P1<6.6 THEN PRINT "Add:  ";INT(80*(P2-P1)*G/10000);"OZ. of HTH PH plus.  Retest after 4 HRS and adjust."
560 IF P1<6.6 THEN GOTO 580
570 IF P1<P2 THEN PRINT "Add:  ";INT(25*(P2-P1)*G/10000);"OZ. of HTH PH plus.  Retest after 4 HRS and adjust."
580 IF C<1 THEN GOSUB 980
590 IF X>.3 THEN GOSUB 1010
600 IF S=0 THEN GOTO 1040
610 PRINT "Pool is stabilized add:  ";INT(3*G/10000);"OZ. of HTH dry chlorinator every other day."
620 PRINT "Superchlorinate with HTH shock as per label instructions."
630 END
640 PRINT "The hardness is to high, drain:  "; INT(((H-950)/H)*G);" GALLONS of pool water and replace with soft water."
650 PRINT
660 PRINT "Retest pool water after 4 HOURS and rerun program."
670 COLOR 15,0 : PRINT "DO NOT ADD ANY MORE CHEMICALS UNTIL YOU HAVE RETESTED WATER!"
675 COLOR 7
680 END
690 COLOR 0,15 : PRINT "INVALID DATA, PLEASE RE-ENTER!" : COLOR 7
700 GOTO 80
710 P2=P1+.1
720 GOTO 240
730 P2=P1
740 GOTO 240
750 T=25000/250
760 GOTO 370
770 P2=7.2
780 GOTO 310
790 P2=7.3
800 GOTO 310
810 P2=7.4
820 GOTO 310
830 P2=7.5
840 GOTO 310
850 P2=P2-.1
860 GOTO 310
870 P2=P2+.1
880 GOTO 310
890 PRINT "The total alkalinity is HIGH, to lower, do the following:"
900 PRINT "Add:  ";INT(3.2*(A-T)*G/10000);" OZ. of HTH PH minus."
910 PRINT "Add no more than 1-2 LB. (16-32OZ.) per day.  Add at one spot in"
920 PRINT "the deepest part of the pool."
930 PRINT
940 GOTO 510
950 PRINT "The total alkalinity is LOW, add:  ";INT(2.4*(T-A)*G/10000);" OZ. of HTH alkalinity plus."
960 PRINT "This will raise the PH somewhat, recheck the PH after 4 HOURS."
965 PRINT
970 GOTO 510
980 PRINT "The total avail. chlorine is:  ";C;" it should be kept at 1-1.5 PPM."
990 PRINT "Add:  ";INT((1-C)*G/10000*(8));" OZ. of HTH dry chlorinator."
995 PRINT
1000 RETURN
1010 PRINT "The total avail. chlorine is too high, shock treat the pool by adding"
1020 PRINT INT(20*G/10000);" OZ. OF HTH SHOCK!"
1024 PRINT
1030 RETURN
1040 PRINT "Add:  ";INT(8*G/10000);" OZ. of HTH dry chlorinator daily."
1050 PRINT "Shock treat per label instructions.
1060 END
1070 REM