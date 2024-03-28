MODULE A073_Control_Ctrl
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
    ! FUNCTION    :  Control modul and project main
    !
    ! AUTHOR      :  Philippe Fleischmann
    !
    ! EMAIL       :  fleischmann@arch.ethz.ch
    !
    ! HISTORY     :  2022.01.20
    !
    ! Copyright   :  ETH Zurich (CH) 2022
    !
    !***********************************************************************************

    !************************************************
    ! Function    :     Project main 
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2022.01.20
    !***************** ETH Zurich *******************
    !
    PROC r_A073_Main()
        !
        ! Synchronize with controller 
        WaitSyncTask id_A073_MainSta,tl_RFL_All;
        !
        ! Message to user
        TPWrite "A073 Main";
        !
        ! Initialize task for Project
        r_A073_InitTask;
        !
        ! Execution loop
        WHILE b_A073_Run=TRUE DO
            !
            ! Check current mode 
            TEST st_A073_Modus
            CASE "Setup":
                !
                ! Set modus
                st_A073_Status:="*** Setup ***";
                b_A073_Setup:=TRUE;
                b_A073_Jogging:=FALSE;
                b_A073_RRC:=FALSE;
                n_A073_Modus:=1;
                !
                ! Start Setup
                r_A073_Setup;
            CASE "Jogging":
                !
                ! Set modus
                st_A073_Status:="*** Jogging ***";
                b_A073_Setup:=FALSE;
                b_A073_Jogging:=TRUE;
                b_A073_RRC:=FALSE;
                n_A073_Modus:=2;
                !
                ! Start Jogging
                r_A073_Jogging;
            CASE "RRC":
                !
                ! Set modus
                st_A073_Status:="*** COMPAS_RRC ***";
                b_A073_Setup:=FALSE;
                b_A073_Jogging:=FALSE;
                b_A073_RRC:=TRUE;
                n_A073_Modus:=3;
                !
                ! Start RRC
                r_RRC_Main;
            DEFAULT:
                !
                ! Set modus
                st_A073_Status:="Modus not selected.";
                b_A073_Setup:=FALSE;
                b_A073_Jogging:=FALSE;
                b_A073_RRC:=FALSE;
                n_A073_Modus:=0;
            ENDTEST
        ENDWHILE
        !
        ! Message to user 
        TPWrite "A073 End";
        !
        ! Synchronize with controller 
        WaitSyncTask id_A073_MainEnd,tl_RFL_All;
        !
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Initialize task for project
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2022.01.20
    ! **************** ETH Zurich *******************
    !
    PROC r_A073_InitTask()
        ! 
        WaitSyncTask id_A073_InitTaskSta,tl_RFL_All;
        !
        ! Initialize speed
        r_A073_InitSpeed;
        !
        ! Initialize signals
        r_A073_InitSig;
        !
        ! Initalize variables
        r_A073_InitVar;
        !
        ! Synchronize Gantry
        IF b_A073_GantrySyncOn r_A073_SyncGantry;
        !
        WaitSyncTask id_A073_InitTaskEnd,tl_RFL_All;
        ! 
        RETURN ;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Initialize signals for project
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2022.01.20
    ! **************** ETH Zurich *******************
    !
    PROC r_A073_InitSig()
        !
        WaitSyncTask id_A073_InitSigSta,tl_RFL_All;
        !
        !
        WaitSyncTask id_A073_InitSigEnd,tl_RFL_All;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Initialize variables for project
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2022.01.20
    !***************** ETH Zurich *******************
    !
    PROC r_A073_InitVar()
        ! 
        WaitSyncTask id_A073_InitVarSta,tl_RFL_All;
        ! 
        ! Placeholder
        st_A073_Modus:="";
        !
        b_A073_Setup:=FALSE;
        b_A073_Jogging:=FALSE;
        b_A073_RRC:=FALSE;
        !
        b_A073_Init:=FALSE;
        b_A073_PickTool:=FALSE;
        b_A073_PlaceTool:=FALSE;
        !
        WaitSyncTask id_A073_InitVarEnd,tl_RFL_All;
        RETURN ;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Initialize speed settings for project
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2022.01.20
    !***************** ETH Zurich *******************
    !
    PROC r_A073_InitSpeed()
        !
        WaitSyncTask id_A073_InitSpeedSta,tl_RFL_All;
        !
        ! Speed limit off
        r_RFL_SpeedLimitOff;
        !
        WaitSyncTask id_A073_InitSpeedSet,tl_RFL_All;
        !
        ! Speed limit on
        r_RFL_SpeedLimitOn;
        RETURN ;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Synchronize Gantry
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2022.06.14
    !***************** ETH Zurich *******************
    !
    PROC r_A073_SyncGantry()
        !
        WaitSyncTask id_A073_InitSyncSta,tl_A073_CtrlRob;
        !
        ! Activate synchronization
        !
        WaitSyncTask id_A073_InitSyncEnd,tl_A073_CtrlRob;
        !
        ! Event log for robot studio output        
        r_RFL_EvLogMsg "A073","Sync Gantry, done.";
        RETURN ;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Unsynchronize Gantry
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2022.06.14
    !***************** ETH Zurich *******************
    !
    PROC r_A073_UnsyncGantry()
        !
        WaitSyncTask id_A073_InitUnsyncSta,tl_A073_CtrlRob;
        !
        ! Dectivate synchronization
        !
        WaitSyncTask id_A073_InitUnsyncEnd,tl_A073_CtrlRob;
        !
        ! Event log for robot studio output        
        r_RFL_EvLogMsg "A073","Unsync Gantry, done.";
        RETURN ;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC
ENDMODULE