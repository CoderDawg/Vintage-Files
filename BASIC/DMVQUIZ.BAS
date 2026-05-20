10 KEY OFF : WIDTH 80 : SCREEN 0,0,0 : COLOR 7,0 : RESTORE : CLEAR : CLS
20 LOCATE 10,11 : PRINT "California Department of Motor Vehicle Rules and Regulations"
30 FOR LCV = 1 TO 1200 : NEXT
40 BEEP : CLS
50 COUNT% = 1 : FINAL% = 46 : SCORE% = 0
60 DIM ANSWER$(FINAL%)
70 FOR LCV = 1 TO FINAL%
80 READ A$
90 ANSWER$(LCV) = A$
100 NEXT
110 LOCATE 10,1 : PRINT "The first safety measure you preform when you enter an automobile is:  "
120 LOCATE 12,10 : PRINT "A)  Check Fuel Guage      C)  Adjust Mirrors"
130 LOCATE 13,10 : PRINT "B)  Buckle Seat Belt      D)  Release Parking Brake"
140 GOSUB 2960
150 GOSUB 3010
160 CLS
170 LOCATE 10,1 : PRINT "While pulling away from a curb, after you preform all the necessary safety      checks you have a coliision who is liable?"
180 LOCATE 13,10 : PRINT "A)  The passenger         C)  The driver (you)"
190 LOCATE 14,10 : PRINT "B)  The spectator         D)  The other driver"
200 GOSUB 2960
210 GOSUB 3010
220 CLS
230 LOCATE 10,1 : PRINT "In city traffic you should signal how many feet before reaching your turning    point?"
240 LOCATE 13,10 : PRINT "A)  50 ft                 C)  200 ft"
250 LOCATE 14,10 : PRINT "B)  100 ft                D)  500 ft"
260 GOSUB 2960
270 GOSUB 3010
280 CLS
290 LOCATE 10,1 : PRINT "At higher speeds, such as on a freeway, you should signal how many seconds      before making a maneuver?"
300 LOCATE 13,10 : PRINT "A)  3 Seconds            C)  30 Seconds"
310 LOCATE 14,10 : PRINT "B)  10 Seconds           D)  5 Seconds"
320 GOSUB 2960
330 GOSUB 3010
340 CLS
350 LOCATE 10,1 : PRINT "The hand and arm signal should... while turning."
360 LOCATE 12,10 : PRINT "A)  be continued          B)  not be continued"
370 GOSUB 2960
380 GOSUB 3010
390 CLS
400 LOCATE 10,1 : PRINT "When approaching a flashing railroad crossing how many feet back must you stop?"
410 LOCATE 12,10 : PRINT "A)  15 ft                 C)  25 ft"
420 LOCATE 13,10 : PRINT "B)  35 ft                 D)  45 ft"
430 GOSUB 2960
440 GOSUB 3010
450 CLS
460 LOCATE 10,1 : PRINT "What color cane does a legally blind person carry?"
470 LOCATE 12,10 : PRINT "A)  Red                   C)  White"
480 LOCATE 13,10 : PRINT "B)  Blue                  D)  Yellow"
490 GOSUB 2960
500 GOSUB 3010
510 CLS
520 LOCATE 10,1 : PRINT "While passing to the right of a vehicle it is illegal if you move into or onto.."
530 LOCATE 12,10 : PRINT "A)  a bycycle lane.       C)  a passing lane.
540 LOCATE 13,10 : PRINT "B)  a right lane.         D)  the soft shoulder of the road."
550 GOSUB 2960
560 GOSUB 3010
570 CLS
580 LOCATE 10,1 : PRINT "You are allowed to pass another vehicle if there is..."
590 LOCATE 12,10 : PRINT "A)  a broken yellow line. C)  a bridge within a 100 ft."
600 LOCATE 13,10 : PRINT "B)  a street crossing.    D)  a railroad crossing within a 100 ft."
610 GOSUB 2960
620 GOSUB 3010
630 CLS
640 LOCATE 10,1 : PRINT "What condition does NOT effect your driving speed?"
650 LOCATE 12,10 : PRINT "A)  Roadway Surface.      C)  Weather conditions."
660 LOCATE 13,10 : PRINT "B)  Your age.             D)  How far ahead you can see."
670 GOSUB 2960
680 GOSUB 3010
690 CLS
700 LOCATE 10,1 : PRINT "Where are you NOT legally obliged to reduce your speed to 15 MPH?"
710 LOCATE 12,10 : PRINT "A)  In a hospital zone.   C)  At a 'Blind Intersection'"
720 LOCATE 13,10 : PRINT "B)  In an alley.          D)  At a railroad crossing within a 100 ft."
730 GOSUB 2960
740 GOSUB 3010
750 CLS
760 LOCATE 10,1 : PRINT "Where must you legally reduce your speed to 25 MPH even if there are no signs   posted?"
770 LOCATE 12,10 : PRINT "A)  Hospital zone.        C)  Construction area."
780 LOCATE 13,10 : PRINT "B)  Toll bridge.          D)  Residential or business district."
790 GOSUB 2960
800 GOSUB 3010
810 CLS
820 LOCATE 10,1 : PRINT "What is the maximum legal parking distance from a curb to either front or rear  wheel of a car?"
830 LOCATE 12,10 : PRINT "A)  2 ft.                 C)  12 in."
840 LOCATE 13,10 : PRINT "B)  18 in.                D)  20 in."
850 GOSUB 2960
860 GOSUB 3010
870 CLS
880 LOCATE 10,1 : PRINT "Where are you ALLOWED to park legally?"
890 LOCATE 12,1 : PRINT "A)  Within an intersection.    C)  In a tunnel, Tube or Bridge."
900 LOCATE 13,1 : PRINT "B)  20 ft from a fire hydrant. D)  Whithin 15 ft of a fire house driveway."
910 GOSUB 2960
920 GOSUB 3010
930 CLS
940 LOCATE 10,1 : PRINT "When you are approaching an orange warning sign it means..."
950 LOCATE 12,10 : PRINT "A)  construction ahead.   C)  yield the right of way.
960 LOCATE 13,10 : PRINT "B)  school zone ahead.    D)  Railroad crossing ahead.
970 GOSUB 2960
980 GOSUB 3010
990 CLS
1000 LOCATE 10,1 : PRINT "During night driving at what distance from a car in front of you should you     switch to low beams?"
1010 LOCATE 12,10 : PRINT "A)  100 ft away              C)  300 ft away
1020 LOCATE 13,10 : PRINT "B)  200 ft away              D)  400 ft away
1030 GOSUB 2960
1040 GOSUB 3010
1050 CLS
1060 LOCATE 10,1 : PRINT "If while driving you become tired, drowsy, or sleepy you should?"
1070 LOCATE 12,10 : PRINT "A)  Take a stimulant.     C)  Drink some coffee.
1080 LOCATE 13,10 : PRINT "B)  Open the window.      D)  Pull off the road and rest.
1090 GOSUB 2960
1100 GOSUB 3010
1110 CLS
1120 LOCATE 10,1 : PRINT "When two cars meet on a steep, narrow road who has the right of way?"
1130 LOCATE 12,10 : PRINT "A)  The car going downhill.  C)  Niether car.
1140 LOCATE 13,10 : PRINT "B)  The car going uphill.    D)  Both cars.
1150 GOSUB 2960
1160 GOSUB 3010
1170 CLS
1180 LOCATE 10,1 : PRINT "When driving at night in fog, it is best to use your..."
1190 LOCATE 12,10 : PRINT "A)  horn.            C)  low beams.
1200 LOCATE 13,10 : PRINT "B)  parking lights.  D)  high beams.
1210 GOSUB 2960
1220 GOSUB 3010
1230 CLS
1240 LOCATE 10,1 : PRINT "Which is NOT considered a drug?"
1250 LOCATE 12,10 : PRINT "A)  Diet Pills.      C)  Sleeping Pills.
1260 LOCATE 13,10 : PRINT "B)  Cold Medicine.   D)  Vitamin Pills.
1270 GOSUB 2960
1280 GOSUB 3010
1290 CLS
1300 LOCATE 10,1 : PRINT "Which test for alcohol may be taken if arrested?"
1310 LOCATE 12,10 : PRINT "A)  Blood test.      C)  Breath test.
1320 LOCATE 13,10 : PRINT "B)  Urine Test.      D)  One of the three above.
1330 GOSUB 2960
1340 GOSUB 3010
1350 CLS
1360 LOCATE 10,1 : PRINT "Hhat is the minimum insurance coverage that should be carried?"
1370 LOCATE 12,1 : PRINT "A)  $15,000 for death or injury.  C)  $30,000 for more than one injury.
1380 LOCATE 13,1 : PRINT "B)  $5,000 for property damage.   D)  All of the above.
1390 GOSUB 2960
1400 GOSUB 3010
1410 CLS
1420 LOCATE 10,1 : PRINT " Who is NOT eligible for a specially marked license plate?"
1430 LOCATE 12,10 : PRINT "A)  Disabled Veteran. C)  Handicapped Person
1440 LOCATE 13,10 : PRINT "B)  Senior Citizen.   D)  Licensed operators of CB's
1450 GOSUB 2960
1460 GOSUB 3010
1470 CLS
1480 LOCATE 10,1 : PRINT "If an officer of the law directs you to do something which is in direct         violation of the law you should..."
1490 LOCATE 13,10 : PRINT "A)  Ignore him, and do whats legal.      B)  Comply with his orders
1500 GOSUB 2960
1510 GOSUB 3010
1520 CLS
1530 LOCATE 10,1 : PRINT "What color curb is usaully next to a mailbox?"
1540 LOCATE 12,10 : PRINT "A)  White  C)  Yellow
1550 LOCATE 13,10 : PRINT "B)  Green  D)  Blue
1560 GOSUB 2960
1570 GOSUB 3010
1580 CLS
1590 LOCATE 10,1 : PRINT "What color curb marks a loading zone?"
1600 LOCATE 12,10 : PRINT "A)  White  C)  Yellow
1610 LOCATE 13,10 : PRINT "B)  Green  D)  Blue
1620 GOSUB 2960
1630 GOSUB 3010
1640 CLS
1650 LOCATE 10,1 : PRINT "What color curb marks a handicapped zone?"
1660 LOCATE 12,10 : PRINT "A)  White  C)  Yellow
1670 LOCATE 13,10 : PRINT "B)  Green  D)  Blue
1680 GOSUB 2960
1690 GOSUB 3010
1700 CLS
1710 LOCATE 10,1 : PRINT "What color curb means limited parking time allowed?"
1720 LOCATE 12,10 : PRINT "A)  White  C)  Blue
1730 LOCATE 13,10 : PRINT "B)  Green  D)  Red
1740 GOSUB 2960
1750 GOSUB 3010
1760 CLS
1770 LOCATE 10,1 : PRINT "What color curb marks a NO Stopping, Standing or Parking?"
1780 LOCATE 12,10 : PRINT "A)  White  C)  Blue
1790 LOCATE 13,10 : PRINT "B)  Green  D)  Red
1800 GOSUB 2960
1810 GOSUB 3010
1820 CLS
1830 LOCATE 10,1 : PRINT "Which is NOT a required equipment on a new automobile?"
1840 LOCATE 12,10 : PRINT "A)  Smog control devices. C)  Fenders.
1850 LOCATE 13,10 : PRINT "B)  Fog lights.           D)  Two headlights.
1860 GOSUB 2960
1870 GOSUB 3010
1880 CLS
1890 LOCATE 10,1 : PRINT "While walking along a roadway in which direction do pedestrians travel?"
1900 LOCATE 12,10 : PRINT "A)  With traffic.         C)  Across traffic.
1910 LOCATE 13,10 : PRINT "B)  Against traffic.      D)  In either direction.
1920 GOSUB 2960
1930 GOSUB 3010
1940 CLS
1950 LOCATE 10,1 : PRINT "while riding along a roadway in which direction do bike riders travel?"
1960 LOCATE 12,10 : PRINT "A)  With traffic.         C)  Beside traffic.
1970 LOCATE 13,10 : PRINT "B)  Against traffic.      D)  In either direction.
1980 GOSUB 2960
1990 GOSUB 3010
2000 CLS
2010 LOCATE 10,1 : PRINT "Before proceeding through an intersection, always look..."
2020 LOCATE 12,10 : PRINT "A)  Left - Right          C)  Left - Right - Left
2030 LOCATE 13,10 : PRINT "B)  Right - Left          D)  Right - Left - Right
2040 GOSUB 2960
2050 GOSUB 3010
2060 CLS
2070 LOCATE 10,1 : PRINT "Select the best choice... "
2080 LOCATE 12,1 : PRINT "A)  Always assume the other driver will yield if you legally have the Right         Away."
2090 LOCATE 14,1 : PRINT "B)  Never assume the other driver will yield if you legally have the Right          Away."
2100 GOSUB 2960
2110 GOSUB 3010
2120 CLS
2130 LOCATE 10,1 : PRINT "List the order, from top to bottom, the colors of a stop light?"
2140 LOCATE 12,10 : PRINT "A)  Green - Yellow - Red  C)  Yellow - Green - Red
2150 LOCATE 13,10 : PRINT "B)  Red - Yellow - Green  D)  Red - Green - Yellow
2160 GOSUB 2960
2170 GOSUB 3010
2180 CLS
2190 LOCATE 10,1 : PRINT "What is the legal limit for blood alchohol percentage?"
2200 LOCATE 12,10 : PRINT "A)  1.0 %  C)  0.01 %
2210 LOCATE 13,10 : PRINT "B)  0.1 %  D)  0.001 %
2220 GOSUB 2960
2230 GOSUB 3010
2240 CLS
2250 LOCATE 10,1 : PRINT "When does a legally blind person have the right of way?"
2260 LOCATE 12,10 : PRINT "A)  Always.      C)  Seldom.
2270 LOCATE 13,10 : PRINT "B)  It depends.  D)  Never.
2280 GOSUB 2960
2290 GOSUB 3010
2300 CLS
2310 LOCATE 10,1 : PRINT "What is the total stopping distance for an automobile traveling at 55 MPH?"
2320 LOCATE 12,10 : PRINT "A)  61.7 ft      C)  161.5 ft
2330 LOCATE 13,10 : PRINT "B)  106.0 ft     D)  228.0 ft
2340 GOSUB 2960
2350 GOSUB 3010
2360 CLS
2370 LOCATE 10,1 : PRINT "What should you do if an emergency vehicle with flashing red lights and a siren pulls up behind you?"
2380 LOCATE 13,1 : PRINT "A)  Pull over to the right and stop.   C)  Stop, and wait.
2390 LOCATE 14,1 : PRINT "B)  Pull over to the left and stop.    D)  Nothing.
2400 GOSUB 2960
2410 GOSUB 3010
2420 CLS
2430 LOCATE 10,1 : PRINT "What must you do to park on a hill when the front of your car points down?"
2440 LOCATE 12,1 : PRINT "A)  Set your parking brake.   C)  Curb your wheels toward the right.
2450 LOCATE 13,1 : PRINT "B)  Shift to park or reverse  D)  All of the above A, B, and C.
2460 GOSUB 2960
2470 GOSUB 3010
2480 CLS
2490 LOCATE 10,1 : PRINT "Whom must you yeild the right of way to, if you are making a left at an         intersection?"
2500 LOCATE 13,1 : PRINT "A)  Nobody.    C)  All drivers coming from the opposite direction.
2510 LOCATE 14,1 : PRINT "B)  Everybody. D)  Only cars on the right.
2520 GOSUB 2960
2530 GOSUB 3010
2540 CLS
2550 LOCATE 10,1 : PRINT "When may you cross or drive in a specially marked bike lane?"
2560 LOCATE 12,10 : PRINT "A)  To park.     C)  To Make a turn.
2570 LOCATE 13,10 : PRINT "B)  To Pass.     D)  Both A and C.
2580 GOSUB 2960
2590 GOSUB 3010
2600 CLS
2610 LOCATE 10,1 : PRINT "How can you tell if a car is in your blind spot?"
2620 LOCATE 12,10 : PRINT "A)  Glance over your shoulder.  C)  Use your side mirrors.
2630 LOCATE 13,10 : PRINT "B)  Use your rear view mirror.  D)  Both B and C.
2640 GOSUB 2960
2650 GOSUB 3010
2660 CLS
2670 LOCATE 10,1 : PRINT "What is meant by the 'BASIC SPEED LAW'?"
2680 LOCATE 12,1 : PRINT "A)  Never drive faster than it is safe. C)  Never travel faster than 55 MPH."
2690 LOCATE 13,1 : PRINT "B)  Never go slower than traffic.       D)  Obey the legal posted speed limit."
2700 GOSUB 2960
2710 GOSUB 3010
2720 CLS
2730 LOCATE 10,1 : PRINT "What does a flashing red light mean at an intersection?"
2740 LOCATE 12,10 : PRINT "A)  Stop and Wait.       C)  Caution - slow down.
2750 LOCATE 13,10 : PRINT "B)  Stop then continue.  D)  Construction ahead.
2760 GOSUB 2960
2770 GOSUB 3010
2780 CLS
2790 LOCATE 10,1 : PRINT "What is the minimum speed limit on a freeway?"
2800 LOCATE 12,10 : PRINT "A)  25 MPH    C)  35 MPH "
2810 LOCATE 13,10 : PRINT "B)  40 MPH    D)  45 MPH"
2820 GOSUB 2960
2830 GOSUB 3010
2840 CLS
2850 LOCATE 10,10 : PRINT "Total Number of questions:     "; : COLOR 15,0 : PRINT FINAL%
2860 COLOR 7
2870 LOCATE 11,10 : PRINT "Total Number of Right Answers: "; : COLOR 15,0 : PRINT SCORE%
2880 COLOR 7 : LOCATE 12,10 : PRINT "Percentage of Questions Right: "; : COLOR 15,0 : PRINT INT (SCORE%/FINAL%*100)
2890 COLOR 7 : LOCATE 14,10
2900 IF SCORE% = FINAL% THEN PRINT "EXTREMELY GOOD -- NO SWEAT!!"
2910 IF INT(SCORE%/FINAL%*100)>90 AND SCORE%<>FINAL% THEN PRINT "PRETTY GOOD -- KEEP UP THE GOOD WORK!"
2920 IF SCORE% >38 AND INT(SCORE%/FINAL%*100)<90 THEN PRINT "YOU PASS -- BUT YOU NEED TO STUDY SOME MORE."
2930 IF SCORE%<=38 THEN PRINT "SORRY -- YOU NEED TO HIT THE OLD TEXT BOOKS SOME MORE..."
2940 KEY ON
2950 END
2960 CHAR$=INPUT$(1)
2970 IF CHAR$<"a" OR CHAR$>"z" THEN 2990
2980 CHAR$=CHR$(ASC(CHAR$)-32)
2990 IF CHAR$<"A" OR CHAR$>"D" THEN GOTO 2960
3000 RETURN
3010 COLOR 0,15
3020 IF CHAR$ <> ANSWER$(COUNT%) THEN LOCATE 23,30 : SOUND 200,10 : PRINT "WRONG ANSWER!"
3030 COLOR 15,0
3040 IF CHAR$ = ANSWER$(COUNT%) THEN LOCATE 23,30 : SOUND 1000,10 : PRINT "RIGHT ANSWER -- VERY GOOD!!!" : SCORE% = SCORE% + 1
3050 COLOR 7 : COUNT% = COUNT% + 1
3060 FOR LCV = 1 TO 700 : NEXT
3070 RETURN
3080 DATA B,C,B,D,B,A,C,D,A,B,A,D,B,B,A,C,D,A,C,D,D,D,B,B,A,C,D,B,D,B
3090 DATA B,A,C,B,B,B,A,D,A,D,C,D,A,A,B,D