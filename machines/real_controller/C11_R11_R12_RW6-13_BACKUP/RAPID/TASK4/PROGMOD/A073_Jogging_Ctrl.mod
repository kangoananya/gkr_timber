MODULE A073_Jogging_Ctrl
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
            ! Check selected modus
            IF st_A073_Modus<>"Jogging" THEN
                !
                ! End jogging mode 
                b_A073_Jogging:=FALSE;
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
        ! Loop for positive movmend
        WHILE b_A073_Jog_Z_Pos=TRUE OR b_A073_Jog_Z_Neg=TRUE DO
            !
            ! Speed and step update
        ENDWHILE
        !
        ! Synchronisation 
        WaitSyncTask id_A073_Jog_Z_End,tl_A073_CtrlRob;
        RETURN ;
    ENDPROC


ENDMODULE