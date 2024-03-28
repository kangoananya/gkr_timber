MODULE A073_DataGlobal
    !***********************************************************************************
    !
    ! ETH Zurich / NCCR Digital Fabrication
    ! HIB C51 / Stefano-Franscini-Platz 1
    ! CH-8093 Zurich
    !
    !***********************************************************************************
    !
    ! PROJECT     :  A073 Impact-Printing
    !
    ! FUNCTION    :  Includ all Global Data's for Project
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
    !
    !************************************************
    ! Declaration :     bool
    !************************************************
    !
    PERS bool b_A073_GantrySyncOn;
    !
    PERS bool b_A073_Run;
    PERS bool b_A073_CtrlWaitForJob;
    PERS bool b_A073_CtrlInUse;

    !************************************************
    ! Declaration :     num
    !************************************************
    !
    PERS num n_A073_AccRamp;

    !************************************************
    ! Declaration :     string
    !************************************************
    !
    PERS string st_A073_JobForCtrl;

    !************************************************
    ! Declaration :     speeddata
    !************************************************
    !
    PERS speeddata v_A073_Max;
    PERS speeddata v_A073_Med;
    PERS speeddata v_A073_Min;

    !************************************************
    ! Declaration :     speedlimdata
    !************************************************
    !
    PERS speedlimdata slim_A073_Ctrl;

    !************************************************
    ! Declaration :     syncident
    !************************************************
    !
    !
    VAR syncident id_A073_MainSta;
    VAR syncident id_A073_MainEnd;

    VAR syncident id_A073_InitTaskSta;
    VAR syncident id_A073_InitTaskEnd;
    !
    VAR syncident id_A073_InitVarSta;
    VAR syncident id_A073_InitVarEnd;
    !
    VAR syncident id_A073_InitSigSta;
    VAR syncident id_A073_InitSigEnd;
    !
    VAR syncident id_A073_InitSpeedSta;
    VAR syncident id_A073_InitSpeedSet;
    VAR syncident id_A073_InitSpeedEnd;

ENDMODULE