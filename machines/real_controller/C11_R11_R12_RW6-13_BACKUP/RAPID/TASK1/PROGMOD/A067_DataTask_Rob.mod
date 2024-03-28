MODULE A067_DataTask_Rob
    !***********************************************************************************
    !
    ! ETH Zurich / NCCR Digital Fabrication
    ! HIB C51 / Stefano-Franscini-Platz 1
    ! CH-8093 Zurich
    !
    !***********************************************************************************
    !
    ! PROJECT     :  A067 Integral Timber Joints
    !
    ! FUNCTION    :  Includ all Task Data's for Project
    !
    ! AUTHOR      :  Philippe Fleischmann
    !
    ! EMAIL       :  fleischmann@arch.ethz.ch
    !
    ! HISTORY     :  2019.12.04
    !
    ! Copyright   :  ETH Zurich (CH) 2019
    !
    !***********************************************************************************

    !************************************************
    ! Declaration :     bool
    !************************************************
    !
    TASK PERS bool b_A067_ClearPath:=FALSE;

    !************************************************
    ! Declaration :     num
    !************************************************
    !

    !************************************************
    ! Declaration :     string
    !************************************************
    !

    !************************************************
    ! Declaration :     tooldata
    !************************************************
    !
    TASK PERS tooldata t_A067_Tool:=[TRUE,[[0,0,0],[1,0,0,0]],[2.12,[0,0,45],[1,0,0,0],0,0,0]];
    TASK PERS tooldata t_A067_Tool_PG1500:=[TRUE,[[0,0,0],[1,0,0,0]],[12.4,[0,0,105],[1,0,0,0],0,0,0]];
    TASK PERS tooldata t_A067_Tool_PG1000:=[TRUE,[[0,0,0],[1,0,0,0]],[10.72,[0,0,105],[1,0,0,0],0,0,0]];
    TASK PERS tooldata t_A067_Tool_PG500:=[TRUE,[[0,0,0],[1,0,0,0]],[9.04,[0,0,110],[1,0,0,0],0,0,0]];
    TASK PERS tooldata t_A067_Tool_CL3:=[TRUE,[[0,0,0],[1,0,0,0]],[7.99,[0,0,73],[1,0,0,0],0,0,0]];
    TASK PERS tooldata t_A067_Tool_CL3M:=[TRUE,[[0,0,0],[1,0,0,0]],[7.99,[0,0,73],[1,0,0,0],0,0,0]];
    TASK PERS tooldata t_A067_Tool_SL1:=[TRUE,[[0,0,0],[1,0,0,0]],[6.75,[0,0,138],[1,0,0,0],0,0,0]];
    TASK PERS tooldata t_A067_Tool_SL1_G200:=[TRUE,[[0,0,0],[1,0,0,0]],[7.35,[0,0,138],[1,0,0,0],0,0,0]];

    !************************************************
    ! Declaration :     wobjdata
    !************************************************
    !
    TASK PERS wobjdata ob_A067_Wobjdata:=[FALSE,TRUE,"",[[0,0,0],[1,0,0,0]],[[0,0,0],[1,0,0,0]]];

    !************************************************
    ! Declaration :     jointtarget
    !************************************************
    !
    TASK PERS jointtarget jp_A067_Jointtarget:=[[0,0,0,0,0,0],[9E9,9E9,9E9,9E9,9E9,9E9]];

    !************************************************
    ! Declaration :     robtarget
    !************************************************
    !
    TASK PERS robtarget p_A067_Robtarget:=[[0,0,0],[1,0,0,0],[0,0,0,0],[9E9,9E9,9E9,9E9,9E9,9E9]];

    !************************************************
    ! Declaration :     speeddata
    !************************************************
    !
    TASK PERS speeddata v_A067_Speed:=[0,0,0,0];
    
    !************************************************
    ! Declaration :     loaddata
    !************************************************
    !
    TASK PERS loaddata ld_A067_ActLoad:=[8.74,[20,0,240],[1,0,0,0],0,0,0];
    
    !************************************************
    ! Declaration :     intnum
    !************************************************
    !
    TASK VAR intnum in_A067_IntStart:=0;
    TASK VAR intnum in_A067_IntEnd:=0;

    !************************************************
    ! Declaration :     errnum
    !************************************************
    !
    TASK VAR errnum er_A067_ClearPath := -1;    
ENDMODULE