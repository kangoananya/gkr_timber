MODULE A088_Control_Rob
    !***********************************************************************************
    !
    ! ETH Zurich / Robotic Fabrication Lab
    ! HIB C 13 / Stefano-Franscini-Platz 1
    ! CH-8093 Zurich
    !
    !***********************************************************************************
    !
    ! PROJECT     :  A088 RSL-Mitholz
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
    ! Function    :     Main function (start project) 
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2019.11.29
    !***************** ETH Zurich *******************
    !
    PROC r_A088_Main()
        !
        ! Synchronize with controller 
        WaitSyncTask id_A088_MainSta,tl_RFL_All;
        !
        ! Message to user
        TPWrite "A088 Main";
        !
        ! Initialize task for Project
        r_A088_InitTask;
        !
        ! Execution loop
        WHILE b_A088_Run=TRUE DO
            !
            ! Use RRC
            r_RRC_Main;
        ENDWHILE
        !
        ! Message to user 
        TPWrite "A088 End";
        !
        ! Synchronize with controller 
        WaitSyncTask id_A088_MainEnd,tl_RFL_All;
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
    PROC r_A088_InitTask()
        ! 
        WaitSyncTask id_A088_InitTaskSta,tl_RFL_All;
        !
        ! Initialize speed
        r_A088_InitSpeed;
        !
        ! Initialize signals
        r_A088_InitSig;
        !
        ! Initalize variables
        r_A088_InitVar;
        !
        WaitSyncTask id_A088_InitTaskEnd,tl_RFL_All;
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
    PROC r_A088_InitSig()
        !
        WaitSyncTask id_A088_InitSigSta,tl_RFL_All;
        !
        !
        WaitSyncTask id_A088_InitSigEnd,tl_RFL_All;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Initialize variables for project
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2022.01.20
    !***************** ETH Zurich *******************
    !
    PROC r_A088_InitVar()
        ! 
        WaitSyncTask id_A088_InitVarSta,tl_RFL_All;
        ! 
        ! Placeholder
        !
        WaitSyncTask id_A088_InitVarEnd,tl_RFL_All;
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
    PROC r_A088_InitSpeed()
        !
        WaitSyncTask id_A088_InitSpeedSta,tl_RFL_All;
        !
        ! Set speed limits
        r_RFL_SetSpeedLimit slim_A088_Ctrl;
        !
        ! Safety time
        WaitTime\InPos,1.0;
        !
        WaitSyncTask id_A088_InitSpeedSet,tl_RFL_All;
        RETURN ;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

ENDMODULE