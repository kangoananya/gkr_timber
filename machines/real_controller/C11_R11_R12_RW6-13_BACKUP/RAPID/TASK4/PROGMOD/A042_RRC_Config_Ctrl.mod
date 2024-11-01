MODULE A042_RRC_Config_Ctrl
    !***********************************************************************************
    !
    ! ETH Zurich / Robotic Fabrication Lab
    ! HIB C 13 / Stefano-Franscini-Platz 1
    ! CH-8093 Zurich
    !
    !***********************************************************************************
    !
    ! PROJECT     :  RRC - Rapid Robot Communication
    !
    ! FUNCTION    :  Configuration modul for the project 
    !
    ! AUTHOR      :  Philippe Fleischmann
    !
    ! EMAIL       :  rrc@arch.ethz.ch
    !
    ! HISTORY     :  2019.02.22
    !
    ! Copyright   :  ETH Zurich (CH) 2019
    !                - Philippe Fleischmann
    !                - Michael Lyrenmann
    !                - Gonzalo Casas
    !
    ! License     :  This code base is governed by an EULA (End-User License Agreement)
    !                which you have received together with the software.
    !                You are not allowed to use the software on a real robots
    !                without a signed EULA.
    !
    !                A copy of the EULA content is in the controller task (T_CTRL).
    !
    !***********************************************************************************

    !************************************************
    ! Function    :     Initialize Cell
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2019.02.22
    !***************** ETH Zurich *******************
    !
    PROC r_A042_RRC_Config()
        !
        ! Current controller job, used from the RFL Controller project selection (st_RFL_CurCtrlJob)
        ! Default value "RRC"
        st_RRC_CurCtrlJob:=stCurMaJob;
        !
        ! Tasklists 
        tl_RRC_All:=[["T_CTRL"],["T_RX"],["T_TX"],["T_ROB11"],["T_ROB12"],[""],[""]];
        !
        ! Channel 1
        ch_RRC_Channels.Ch_1.T_Name:="T_ROB11";
        ch_RRC_Channels.Ch_1.Ch_Nr:=1;
        !
        ! Channel 2
        ch_RRC_Channels.Ch_2.T_Name:="T_ROB12";
        ch_RRC_Channels.Ch_2.Ch_Nr:=2;
        !
        ! Channel 3
        ch_RRC_Channels.Ch_3.T_Name:="T_ROB3";
        ch_RRC_Channels.Ch_3.Ch_Nr:=3;
        !
        ! Channel 4
        ch_RRC_Channels.Ch_4.T_Name:="T_ROB4";
        ch_RRC_Channels.Ch_4.Ch_Nr:=4;
        !
        ! IP Address
        b_RRC_AutoIPAddress:=TRUE;
        st_RRC_IP_AddressMan:="192.168.125.1";
        !
        ! Ports 
        b_RRC_VirtualCustomPorts:=FALSE;
        n_RRC_ViCustomSocketPortRec:=[31101,31102,31103,31104];
        n_RRC_ViCustomSocketPortSen:=[31201,31202,31203,31204];
        !
        ! Roboter 1
        b_RRC_Com{n_RRC_R1_ChaNr}:=TRUE;
        b_RRC_SIDCheck{n_RRC_R1_ChaNr}:=TRUE;
        b_RRC_SIDErrorStop{n_RRC_R1_ChaNr}:=FALSE;
        b_RRC_LogPro{n_RRC_R1_ChaNr}:=FALSE;
        !
        ! Roboter 2
        b_RRC_Com{n_RRC_R2_ChaNr}:=FALSE;
        b_RRC_SIDCheck{n_RRC_R2_ChaNr}:=FALSE;
        b_RRC_SIDErrorStop{n_RRC_R2_ChaNr}:=FALSE;
        b_RRC_LogPro{n_RRC_R2_ChaNr}:=FALSE;
        !
        ! Roboter 3
        b_RRC_Com{n_RRC_R3_ChaNr}:=FALSE;
        b_RRC_SIDCheck{n_RRC_R3_ChaNr}:=FALSE;
        b_RRC_SIDErrorStop{n_RRC_R3_ChaNr}:=FALSE;
        b_RRC_LogPro{n_RRC_R3_ChaNr}:=FALSE;
        !
        ! Roboter 4
        b_RRC_Com{n_RRC_R4_ChaNr}:=FALSE;
        b_RRC_SIDCheck{n_RRC_R4_ChaNr}:=FALSE;
        b_RRC_SIDErrorStop{n_RRC_R4_ChaNr}:=FALSE;
        b_RRC_LogPro{n_RRC_R4_ChaNr}:=FALSE;
        !
        ! Event log message  
        r_RRC_EvLogMsg st_RRC_EvLogMsgHeader,"Actual confiugration: "+stCurMaJob;
        RETURN ;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

ENDMODULE