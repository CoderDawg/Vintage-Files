10 KEY OFF : WIDTH 80 : SCREEN 0,0,0 : COLOR 7,0 : RESTORE : CLEAR : CLS
20 'ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
30 'º                                                             º
40 'º            PROGRAM: HEADER FOR THE IBM PC.                  º
50 'º            CREATED BY:  John Doe (CoderDawg)                º
60 'º                        (C) 1981                             º
70 'ÌÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹
80 'º                                                             º
90 'º                                                             º
100 REM
120 PRINT "DO YOU WANT YOUR PICTURE ON THE (P)RINTER OR THE (S)CREEN ";
130 QQ$=INPUT$(1)
140 IF QQ$="S" OR QQ$="s" THEN OP$="SCRN:":GOTO 190
150 IF QQ$="P" OR QQ$="p" THEN OP$="LPT1:":GOTO 190
160 IF QQ$="Q" OR QQ$="q" THEN GOTO 410
170 PRINT
180 GOTO 120
190 OPEN OP$ FOR OUTPUT AS #1
200 PRINT #1, "                                       __                "
210 PRINT #1, "                          //         AA,}@               "
220 PRINT #1, "                       ($$)         AB^7B}@              "
230 PRINT #1, "                     ___II__.__  (*88*=+B8}@             "
240 PRINT #1, "                    `.--^^------`  =2QBBBBB}@@           "
250 PRINT #1, "                            !|#       IIII   {@          "
260 PRINT #1, "                             ~#Ii,..:#88888:,.           "
270 PRINT #1, "                                 #8#5T8B8B8Bii:.         "
280 PRINT #1, "                                    ((o)(o)) :iX,.       "
290 PRINT #1, "                                     L8B8B8   ~{+>       "
300 PRINT #1, "                                      CXX7  .,#%''       "
310 PRINT #1, "                                    PBB##BB)^^`          "
320 PRINT #1, "                                   [[^###^N))            "
330 PRINT #1, "                                  .i8'   `I79            "
340 PRINT #1, "                                  {|&    &&}}            "
350 PRINT #1, "                                   888   ;II             "
360 PRINT #1, "                                   777    TIT            "
370 PRINT #1, "                                    HH    HH             "
380 PRINT #1, "                                     %     %             "
390 PRINT #1, "                                  .,4i:.  .il:,.         "
400 CLOSE #1
410 END