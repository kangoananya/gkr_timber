MODULE A073_Jogging_Rob11
    !***********************************************************************************
    !
    ! ETH Zurich / Robotic Fabrication Lab
    ! HIB C 13 / Stefano-Franscini-Platz 1
    ! CH-8093 Zurich
    !
    !***********************************************************************************
    !
    ! PROJECT     :  A073 Impact-Printing
    !
    ! FUNCTION    :  Project specific instructions 
    !
    ! AUTHOR      :  Philippe Fleischmann
    !
    ! EMAIL       :  fleischmann@arch.ethz.ch
    !
    ! HISTORY     :  2022.06.13
    !
    ! Copyright   :  ETH Zurich (CH) 2022
    !
    !***********************************************************************************

    !************************************************
    ! Function    :     Move to initial position
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2022.06.13
    !***************** ETH Zürich *******************
    !
    PROC r_A073_GoToInitPos()
        !
        ! Move to initial position
        MoveAbsJ jp_A073_InitPos\NoEOffs,v_A073_Init,fine,tool0\WObj:=wobj0;
        RETURN ;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Jogging of Gantry-Axis 
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2022.06.13
    !***************** ETH Zürich *******************
    !
    PROC r_A073_Jogging()
        !
        ! Synchronisation 
        WaitSyncTask id_A073_Joging_Start,tl_A073_CtrlRob;
        !
        ! Manual jogging 
        WHILE b_A073_Jogging=TRUE DO
            !
            ! Check move direction
            IF b_A073_Jog_Z_Pos=TRUE OR b_A073_Jog_Z_Neg=TRUE THEN
                !
                ! Move Z-Axis
                r_A073_JogZ;
            ELSE
                !
                ! Crance cycle time 
                WaitTime n_A073_Jog_CycleTime;
            ENDIF
        ENDWHILE
        !
        ! Synchronisation 
        WaitSyncTask id_A073_Joging_End,tl_A073_CtrlRob;
        RETURN ;
    ENDPROC

    !************************************************
    ! Function    :     Jogging of Z-Axis 
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2022.06.13
    !***************** ETH Zürich *******************
    !
    PROC r_A073_JogZ()
        !
        ! Synchronisation 
        WaitSyncTask id_A073_Jog_Z_Start,tl_A073_CtrlRob;
        !
        ! Read current position
        jp_A073_Jog_Z:=CJointT();
        !
        ! Loop for positive movmend
        WHILE b_A073_Jog_Z_Pos=TRUE DO
            !
            ! Speed and step update
            IF b_A073_Jog_Fast=TRUE THEN
                v_A073_Act:=v_A073_Jog_Z_High;
                n_A073_ActStep:=n_A073_Z_MoveStepHigh;
                z_A073_Act:=z5;
            ELSE
                v_A073_Act:=v_A073_Jog_Z_Low;
                n_A073_ActStep:=n_A073_Z_MoveStepLow;
                z_A073_Act:=z1;
            ENDIF
            !
            ! Positive movmend
            jp_A073_Jog_Z.extax.eax_c:=jp_A073_Jog_Z.extax.eax_c+n_A073_ActStep;
            MoveAbsJ jp_A073_Jog_Z\ID:=idn_A073_Jog_Z_Pos\NoEOffs,v_A073_Act,z_A073_Act,tCurrent;
        ENDWHILE
        !
        ! Wait until movmend finish
        WaitRob\InPos;
        !
        ! Loop for negative movment 
        WHILE b_A073_Jog_Z_Neg=TRUE DO
            !
            ! Speed and step update
            IF b_A073_Jog_Fast=TRUE THEN
                v_A073_Act:=v_A073_Jog_Z_High;
                n_A073_ActStep:=n_A073_Z_MoveStepHigh;
                z_A073_Act:=z5;
            ELSE
                v_A073_Act:=v_A073_Jog_Z_Low;
                n_A073_ActStep:=n_A073_Z_MoveStepLow;
                z_A073_Act:=z1;
            ENDIF
            !
            ! Negative movmend
            jp_A073_Jog_Z.extax.eax_c:=jp_A073_Jog_Z.extax.eax_c-n_A073_ActStep;
            MoveAbsJ jp_A073_Jog_Z\ID:=idn_A073_Jog_Z_Neg\NoEOffs,v_A073_Act,z_A073_Act,tCurrent;
        ENDWHILE
        !
        ! Wait until movmend finish
        WaitRob\InPos;
        !
        ! Synchronisation 
        WaitSyncTask id_A073_Jog_Z_End,tl_A073_CtrlRob;
        RETURN ;
    ENDPROC



ENDMODULE