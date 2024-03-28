MODULE RFL_Fat_11
    !***********************************************************************************
    !
    ! ETH Zurich / NCCR Digital Fabrication
    ! HIB C 13 / Stefano-Franscini-Platz 1 
    ! CH-8093 Zurich
    !
    !***********************************************************************************
    !
    ! PROJECT     :  A011_RFL
    !
    ! FUNCTION    :  Routines for ETH Factary acceptance test
    !
    ! AUTHOR      :  Philippe Fleischmann
    !
    ! EMAIL       :  fleischmann@arch.ethz.ch
    !
    ! HISTORY     :  2016.11.14 Draft
    !
    ! Copyright   :  ETH Zurich (CH) 2016
    !
    !***********************************************************************************

    !************************************************
    ! Function    :     Master rFacAccTest Routine form ETH
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2016.11.14
    ! **************** ETH Zurich *******************
    !
    PROC rFacAccTest()
        ! 
        ! Started Job from Master 
        WaitSyncTask idETH_FatSta,tlAll;
        !
        ! Loop for specific FAT's 
        WHILE bFatMaOn=TRUE DO
            !
            ! Wait for User decision
            WaitSyncTask idETH_FatUserDecision,tlAll;
            ! 
            ! Check for Job
            IF bFatMaOn=TRUE THEN
                ! 
                ! Exectue the Job
                %stJobFat %;
                !
                ! Sync executing end
                WaitSyncTask idETH_FatExeEnd,tlAll;
            ENDIF
        ENDWHILE
        !
        ! Specific Job is finish
        WaitSyncTask idETH_FatEnd,tlAll;
        !
        RETURN ;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC



    !************************************************
    ! Function    :     Test Relativ Task X-, Y-, Z-Axis 
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2016.11.14
    ! **************** ETH Zurich *******************
    !
    PROC rRelativ()
        !
        ! Wait for Rob in pos an read current position
        WaitRob\InPos;
        jpTemp:=CJointT();
        !       
        ! Activate test loop
        bFatTaOn:=TRUE;
        !
        ! Test loop for relativ move 
        WHILE bFatTaOn=TRUE DO
            !
            ! Choose the moveable axis or exit the procedure 
            nUiListItem:=UIListView(
                    \Result:=btnAnswer
                    \Header:="T_ROB11 Test: Relativ",
                    liFacAccTestRel
                    \Buttons:=btnOKCancel
                    \Icon:=iconInfo
                    \DefaultIndex:=1);
            !
            ! Check the answer
            IF btnAnswer=resOK THEN
                !
                ! User has decided for a item
                !
                ! Ask user for moveable value
                nTempRelValue:=UINumEntry(
                \Header:="Relativ Step"
                \Message:="How many mm do you want move?"
                \Icon:=iconInfo
                \InitValue:=nTempRelValue
                \MinValue:=-30000
                \MaxValue:=30000
                \AsInteger);
                !
                ! Execute the decision
                TEST nUiListItem
                CASE 1:
                    !
                    ! Item X-Achse
                    ! Calculate new position for X-Axis
                    jpTemp.extax.eax_a:=jpTemp.extax.eax_a+nTempRelValue;
                    !
                CASE 2:
                    !
                    ! Item Y-Achse
                    ! Calculate new position for Y-Axis
                    jpTemp.extax.eax_b:=jpTemp.extax.eax_b+nTempRelValue;
                    !
                CASE 3:
                    !
                    ! Item Z-Achse
                    ! Calculate new position for Z-Axis
                    jpTemp.extax.eax_c:=jpTemp.extax.eax_c+nTempRelValue;
                    !
                DEFAULT:
                    !
                    ! Undefined Item 
                    r_RFL_ProgError;
                ENDTEST
                !
                ! Set accelarion
                AccSet nAccRamp,nAccRamp;
                !
                ! Reset stop clock
                ClkReset clkRob11;
                !
                ! Start clock
                ClkStart clkRob11;
                !
                ! Execute move
                MoveAbsJ jpTemp,vFatRel,fine,tool0;
                ! 
                ! Stop clock
                ClkStop clkRob11;
                !
                ! Show Msg with stop time with speeddata and nTempRelValue
                UIMsgBox
                \Header:="Relative Output "," "
                \MsgLine2:="Time  : "+NumToStr(ClkRead(clkRob11),2)+" [s]"
                \MsgLine3:="Speed : "+NumToStr(vFatRel.v_leax,0)+" [mm/s]"
                \MsgLine4:="Step  : "+NumToStr(nTempRelValue,0)+" [mm]"
                \Buttons:=btnOK
                \Icon:=iconInfo;
            ELSE
                !
                ! User has select Cancel
                ! 
                ! End Task Loop
                bFatTaOn:=FALSE;
            ENDIF
        ENDWHILE
        !
        ! End procedur
        RETURN ;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Test Workspace 
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2016.11.14
    ! **************** ETH Zurich *******************
    !
    PROC rWorkspace()
        !
        ! Wait for Rob in pos an read current position
        WaitRob\InPos;
        jpTemp:=CJointT();
        !
        ! Start with Rob11
        !
        ! Move only robot in safe pos
        jpTemp.robax:=jpSafePosWorSpa.robax;
        MoveAbsJ jpTemp,vFatWorSpa,fine,tool0;
        ! 
        ! Rob 11 done
        WaitSyncTask idETH_FatSafePosR11,tlAll;
        WaitSyncTask idETH_FatSafePosR12,tlAll;
        WaitSyncTask idETH_FatSafePosR21,tlAll;
        WaitSyncTask idETH_FatSafePosR22,tlAll;
        !
        ! Start with Gantry11 Z-Axis
        !
        ! Move Z-Axis down
        jpTemp.extax.eax_c:=nMaxValueZ;
        MoveAbsJ jpTemp,vFatWorSpa,fine,tool0;
        !
        ! Move z-Axis up
        jpTemp.extax.eax_c:=nMinValueZ;
        MoveAbsJ jpTemp,vFatWorSpa,fine,tool0;
        !
        ! Gantry 11 Z-Axis done
        WaitSyncTask idETH_FatMoveMinMaxDoneZ11,tlAll;
        WaitSyncTask idETH_FatMoveMinMaxDoneZ12,tlAll;
        WaitSyncTask idETH_FatMoveMinMaxDoneZ21,tlAll;
        WaitSyncTask idETH_FatMoveMinMaxDoneZ22,tlAll;
        !
        ! Start with Gantry11 Y-Axis Max
        !
        ! Move Y-Axis to Windowside
        jpTemp.extax.eax_b:=nMaxValueY;
        MoveAbsJ jpTemp,vFatWorSpa,fine,tool0;
        !
        ! Gantry 11 Y-Axis done
        WaitSyncTask idETH_FatMoveMaxDoneY11,tlAll;
        WaitSyncTask idETH_FatMoveMaxDoneY12,tlAll;
        WaitSyncTask idETH_FatMoveMaxDoneY21,tlAll;
        WaitSyncTask idETH_FatMoveMaxDoneY22,tlAll;
        !
        ! Wait for Gantry12 Y-Axis Min
        WaitSyncTask idETH_FatMoveMinDoneY12,tlAll;
        !
        ! Move Y-Axis to Panelside
        jpTemp.extax.eax_b:=nMinValueY;
        MoveAbsJ jpTemp,vFatWorSpa,fine,tool0;
        !
        ! Gantry 11 Y-Axis done
        WaitSyncTask idETH_FatMoveMinDoneY11,tlAll;
        WaitSyncTask idETH_FatMoveMinDoneY22,tlAll;
        WaitSyncTask idETH_FatMoveMinDoneY21,tlAll;
        !
        ! Start with Gantry11 X-Axis Min
        !
        ! Move X-Axis to Liftside
        jpTemp.extax.eax_a:=nMinValueX;
        MoveAbsJ jpTemp,vFatWorSpa,fine,tool0;
        !
        ! Gantry 11 X-Axis done
        WaitSyncTask idETH_FatMoveMinDoneX11,tlAll;
        WaitSyncTask idETH_FatMoveMinDoneX21,tlAll;
        !
        ! Wait for Gantry21 X-Axis Max
        WaitSyncTask idETH_FatMoveMaxDoneX21,tlAll;
        !
        ! Move X-Axis to Officeside
        jpTemp.extax.eax_a:=nMaxValueX;
        MoveAbsJ jpTemp,vFatWorSpa,fine,tool0;
        !
        ! Gantry 11 X-Axis done
        WaitSyncTask idETH_FatMoveMaxDoneX22,tlAll;
        ! End procedur
        RETURN ;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Test Repeatability Move to RefPoint  
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2016.11.14
    ! **************** ETH Zurich *******************
    !
    PROC rRefPoint()
        !
        ! Test loop for relativ move 
        WHILE bFatRefPointOn=TRUE DO
            !
            ! Wait for user desicion
            WaitSyncTask idETH_Fat3UserDecision,tlAll;
            !
            ! check the desicion
            IF bNoJobROB11=FALSE THEN
                !
                ! X-Axis is very close to RefPoint value
                !
                ! Msg Warnig X-Axis must move
                ! Show Msg with stop time with speeddata and nTempRelValue
                UIMsgBox
                \Header:="Warnig X-Axis will move!","Check please:"
                \MsgLine2:="ROB11 is free to move?"
                \MsgLine3:="ROB12 is free to move?"
                \MsgLine4:="Is one of them not free so select No and jog it free!"
                \MsgLine5:="(After this step Robot, Y- and Z-Axis will move to RefPoint without a Msg)"
                \Buttons:=btnYesNo
                \Icon:=iconWarning
                \Result:=btnAnswer;
                ! 
                ! Check the user answer
                IF btnAnswer=resYes THEN
                    ! User said Robot free to move
                    !
                    ! Move X-Axis
                    jpTemp:=CJointT();
                    jpTemp.extax.eax_a:=pRefPoint.extax.eax_a;
                    MoveAbsJ jpTemp,vRefPointMax,z100,tool0;
                    !
                    ! Set a big externel offset 
                    EOffsSet [0,0,(nRefPointZOffs*(-1)),0,0,0];
                    !
                    ! Move with a big offset over the Refpoint 
                    MoveJ Offs(RelTool(pRefPoint,0,0,-110),0,0,nRefPointZOffs),vRefPointMax,z10,tTeachTip;
                    !
                    ! Deactivate externel offset
                    EOffsOff;
                    !
                    ! Move fast to Refpoint with a RelTool Z offset
                    MoveJ RelTool(pRefPoint,0,0,-110),vRefPointMax,z10,tTeachTip;
                    !
                    ! Move slow to Refpoint with small RelTool Z offset
                    MoveJ RelTool(pRefPoint,0,0,-10),vRefPointMed,z0,tTeachTip;
                    !
                    ! Msg to User shod be Move to RefPoint?
                    UIMsgBox
                    \Header:="Warnig the TeachTip","Currently is an Offset of 10mm to the RefPoint."
                    \MsgLine2:=""
                    \MsgLine3:="Can the Robot 10mm move in Z-Direction?"
                    \MsgLine4:=""
                    \MsgLine5:=""
                    \Buttons:=btnYesNo
                    \Icon:=iconWarning
                    \Result:=btnAnswer;
                    ! 
                    ! Check the user answer
                    IF btnAnswer=resYes THEN
                        !
                        ! Move to Refpoint
                        MoveL pRefPoint,vRefPointMin,fine,tTeachTip;
                        !
                        ! Msg Robot in RefPos
                        UIMsgBox
                        \Header:="Referenz Position "," "
                        \MsgLine2:="The Robot is now in his referenz position"
                        \MsgLine3:="push Ok to continue."
                        \MsgLine4:=""
                        \Buttons:=btnOK
                        \Icon:=iconInfo;
                    ELSE
                        !
                        ! Break up and move not to RefPoint
                    ENDIF
                    !
                    ! Move slow away from Refpoint with small RelTool Z offset
                    MoveL RelTool(pRefPoint,0,0,-10),vRefPointMin,z0,tTeachTip;
                    !
                    ! Move fast away from Refpoint with a RelTool Z offset
                    MoveJ RelTool(pRefPoint,0,0,-110),vRefPointMed,z10,tTeachTip;
                    !
                    ! Set a big externel offset 
                    EOffsSet [0,0,(nRefPointZOffs*(-1)),0,0,0];
                    !
                    ! Move with a big offset over the Refpoint 
                    MoveJ Offs(RelTool(pRefPoint,0,0,-110),0,0,nRefPointZOffs),vRefPointMax,z10,tTeachTip;
                    !
                ELSE
                    ! User said Robot not free to move
                ENDIF
            ENDIF
            !
            ! Sync the end
            WaitSyncTask idETH_Fat3ExeEnd,tlAll;
        ENDWHILE
        RETURN ;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC
















    !************************************************
    ! Function    :     Test World Coordinates 
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2016.11.18
    ! **************** ETH Zurich *******************
    !
    PROC rWorldCoordinates()
        !
        ! Move fast to World point with big RelTool Z offset
        !MoveJ pPreWorldPoint,vWordPointMax,z10,tTeachTip;
        !
        ! Move slow to Word point with small RelTool Z offset
        MoveJ RelTool(pWorldPoint,0,0,-100),vWordPointMed,z0,tTeachTip;
        !
        ! Move slow to Word point 
        MoveJ pWorldPoint,vWordPointMin,fine,tTeachTip;
        !
        ! Msg Robot in RefPos
        UIMsgBox
        \Header:="World Position "," "
        \MsgLine2:="The Robot is now in his World position"
        \MsgLine3:="push Ok to continue."
        \MsgLine4:=""
        \Buttons:=btnOK
        \Icon:=iconInfo;
        !
        ! Move away from Word point 
        MoveJ RelTool(pWorldPoint,0,0,-100),vWordPointMed,z0,tTeachTip;
        !
        ! Move to PrePos from World point 
        !MoveJ pPreWorldPoint,vWordPointMax,z10,tTeachTip;
        RETURN ;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Test MultiMove 
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2016.11.22
    ! **************** ETH Zurich *******************
    !
    PROC rMultiMove()
        !
        ! Move ROB slow to pre start position 
        MoveJ pPreMultMove,vMultiMoveMax,fine,tTeachTip;
        ! 
        ! Sync all Robots
        WaitSyncTask idETH_Fat5MMPrePos,tlAll;
        !
        ! Move ROB11 slow to Start point 
        MoveJ pMultMove,vMultiMoveMin,fine,tTeachTip;
        ! 
        !
        !
        ! Sync ROB11 in posistion and wait for ROB12, ROB21, and ROB22 in posistion
        WaitSyncTask idETH_Fat5MMPosR11,tlAll;
        WaitSyncTask idETH_Fat5MMPosR12,tlAll;
        WaitSyncTask idETH_Fat5MMPosR21,tlAll;
        WaitSyncTask idETH_Fat5MMPosR22,tlAll;
        !
        ! Start MultiMove
        SyncMoveOn idETH_Fat5MMStart,tlAllRob;
        !
        ! Deactivate configuration
        ConfL\Off;
        !
        ! Move in X (+/-)
        MoveL RelTool(pMultMove,100,0,0)\ID:=100,vMultiMoveMin,fine,tTeachTip;
        MoveL RelTool(pMultMove,-100,0,0)\ID:=110,vMultiMoveMin,fine,tTeachTip;
        MoveL RelTool(pMultMove,0,0,0)\ID:=120,vMultiMoveMin,fine,tTeachTip;
        !
        ! Move in Y (+/-)
        MoveL RelTool(pMultMove,0,100,0)\ID:=200,vMultiMoveMin,fine,tTeachTip;
        MoveL RelTool(pMultMove,0,-100,0)\ID:=210,vMultiMoveMin,fine,tTeachTip;
        MoveL RelTool(pMultMove,0,0,0)\ID:=220,vMultiMoveMin,fine,tTeachTip;
        !
        ! Move in Z (+/-)
        MoveL RelTool(pMultMove,0,0,100)\ID:=300,vMultiMoveMin,fine,tTeachTip;
        MoveL RelTool(pMultMove,0,0,-100)\ID:=310,vMultiMoveMin,fine,tTeachTip;
        MoveL RelTool(pMultMove,0,0,0)\ID:=320,vMultiMoveMin,fine,tTeachTip;
        !
        ! Rotate around X (+/-)
        MoveL RelTool(pMultMove,0,0,0\Rx:=15\Ry:=0\Rz:=0)\ID:=400,vMultiMoveMin,fine,tTeachTip;
        MoveL RelTool(pMultMove,0,0,0\Rx:=-15\Ry:=0\Rz:=0)\ID:=410,vMultiMoveMin,fine,tTeachTip;
        MoveL RelTool(pMultMove,0,0,0\Rx:=0\Ry:=0\Rz:=0)\ID:=420,vMultiMoveMin,fine,tTeachTip;
        !
        ! Rotate around Y (+/-)
        MoveL RelTool(pMultMove,0,0,0\Rx:=0\Ry:=15\Rz:=0)\ID:=500,vMultiMoveMin,fine,tTeachTip;
        MoveL RelTool(pMultMove,0,0,0\Rx:=0\Ry:=-15\Rz:=0)\ID:=510,vMultiMoveMin,fine,tTeachTip;
        MoveL RelTool(pMultMove,0,0,0\Rx:=0\Ry:=0\Rz:=0)\ID:=520,vMultiMoveMin,fine,tTeachTip;
        !
        ! Rotate around Z (+/-)
        MoveL RelTool(pMultMove,0,0,0\Rx:=0\Ry:=0\Rz:=15)\ID:=600,vMultiMoveMin,fine,tTeachTip;
        MoveL RelTool(pMultMove,0,0,0\Rx:=0\Ry:=0\Rz:=-15)\ID:=610,vMultiMoveMin,fine,tTeachTip;
        MoveL RelTool(pMultMove,0,0,0\Rx:=0\Ry:=0\Rz:=0)\ID:=620,vMultiMoveMin,fine,tTeachTip;
        !
        ! Move all externel axis X (+/-)
        EOffsSet [100,0,0,0,0,0];
        MoveL RelTool(pMultMove,0,0,0\Rx:=0\Ry:=0\Rz:=0)\ID:=700,vMultiMoveMin,fine,tTeachTip;
        EOffsSet [-100,0,0,0,0,0];
        MoveL RelTool(pMultMove,0,0,0\Rx:=0\Ry:=0\Rz:=0)\ID:=710,vMultiMoveMin,fine,tTeachTip;
        EOffsOff;
        MoveL RelTool(pMultMove,0,0,0\Rx:=0\Ry:=0\Rz:=0)\ID:=720,vMultiMoveMin,fine,tTeachTip;
        !
        ! Move all externel axis Y (+/-)
        EOffsSet [0,100,0,0,0,0];
        MoveL RelTool(pMultMove,0,0,0\Rx:=0\Ry:=0\Rz:=0)\ID:=800,vMultiMoveMin,fine,tTeachTip;
        EOffsSet [0,-100,0,0,0,0];
        MoveL RelTool(pMultMove,0,0,0\Rx:=0\Ry:=0\Rz:=0)\ID:=810,vMultiMoveMin,fine,tTeachTip;
        EOffsOff;
        MoveL RelTool(pMultMove,0,0,0\Rx:=0\Ry:=0\Rz:=0)\ID:=820,vMultiMoveMin,fine,tTeachTip;
        !
        ! Move all externel axis Z (+/-)
        EOffsSet [0,0,100,0,0,0];
        MoveL RelTool(pMultMove,0,0,0\Rx:=0\Ry:=0\Rz:=0)\ID:=900,vMultiMoveMin,fine,tTeachTip;
        EOffsSet [0,0,-100,0,0,0];
        MoveL RelTool(pMultMove,0,0,0\Rx:=0\Ry:=0\Rz:=0)\ID:=910,vMultiMoveMin,fine,tTeachTip;
        EOffsOff;
        MoveL RelTool(pMultMove,0,0,0\Rx:=0\Ry:=0\Rz:=0)\ID:=920,vMultiMoveMin,fine,tTeachTip;
        !
        ! Use all RelTool options (+/-)
        MoveL Offs(RelTool(pMultMove,0,0,0\Rx:=0\Ry:=0\Rz:=0),0,0,700)\ID:=1000,vMultiMoveMin,fine,tTeachTip;
        MoveL Offs(RelTool(pMultMove,100,100,100\Rx:=15\Ry:=15\Rz:=15),0,0,700)\ID:=1010,vMultiMoveMin,fine,tTeachTip;
        MoveL Offs(RelTool(pMultMove,-100,-100,-100\Rx:=-15\Ry:=-15\Rz:=-15),0,0,700)\ID:=1020,vMultiMoveMin,fine,tTeachTip;
        MoveL Offs(RelTool(pMultMove,0,0,0\Rx:=0\Ry:=0\Rz:=0),0,0,700)\ID:=1030,vMultiMoveMin,fine,tTeachTip;
        !
        ! Use all RelTool options and all externel options (+/-)
        EOffsSet [100,100,100,0,0,0];
        MoveL Offs(RelTool(pMultMove,100,100,100\Rx:=15\Ry:=15\Rz:=15),0,0,700)\ID:=1100,vMultiMoveMin,fine,tTeachTip;
        EOffsSet [-100,-100,-100,0,0,0];
        MoveL Offs(RelTool(pMultMove,-100,-100,-100\Rx:=-15\Ry:=-15\Rz:=-15),0,0,700)\ID:=1110,vMultiMoveMin,fine,tTeachTip;
        EOffsOff;
        MoveL Offs(RelTool(pMultMove,0,0,-100\Rx:=0\Ry:=0\Rz:=0),0,0,700)\ID:=1120,vMultiMoveMin,fine,tTeachTip;
        !
        ! Activate configuration
        ConfL\On;
        !
        ! End MultiMove
        SyncMoveOff idETH_Fat5MMEnd;
        !
        ! Move ROB11 slow to Start point 
        MoveL pPreMultMove,vMultiMoveMax,fine,tTeachTip;
        !
        RETURN ;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

ENDMODULE