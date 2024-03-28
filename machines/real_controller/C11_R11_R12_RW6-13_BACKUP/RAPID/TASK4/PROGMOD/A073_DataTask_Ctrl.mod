MODULE A073_DataTask_Ctrl
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
    ! FUNCTION    :  Includ all Task Data's for Project
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
    ! Declaration :     bool
    !************************************************
    !
    TASK PERS bool b_A073_MyBool:=FALSE;

    !************************************************
    ! Declaration :     num
    !************************************************
    !
    TASK PERS num n_A073_MyNum:=0;

    !************************************************
    ! Declaration :     string
    !************************************************
    !
    TASK PERS string st_A073_MyString:="";

    !************************************************
    ! Declaration :     btnres
    !************************************************
    !
    TASK PERS btnres btr_A073_Answer:=1;

ENDMODULE