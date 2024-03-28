MODULE A083_Instructions
    !***********************************************************************************
    !
    ! ETH Zurich / NCCR Digital Fabrication
    ! HIB C51 / Stefano-Franscini-Platz 1
    ! CH-8093 Zurich
    !
    !***********************************************************************************
    !
    ! PROJECT     :  A083 Augmented-Timber
    !
    ! FUNCTION    :  Inclouds all project specific instructions
    !
    ! AUTHOR      :  Philippe Fleischmann
    !
    ! EMAIL       :  fleischmann@arch.ethz.ch
    !
    ! HISTORY     :  2022.01.20
    !
    ! Copyright   :  ETH Zürich (CH) 2022
    !
    !***********************************************************************************

    !************************************************
    ! Function    :     Gripper open
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2023.02.28
    !***************** ETH Zurich *******************
    !
    PROC r_A083_GripperOpen(\switch NoFeedback)
        !
        ! Read string value
        st_RRC_StringValue:=bm_RRC_RecBufferRob{n_RRC_ChaNr,n_RRC_ReadPtrRecBuf}.Data.St1;
        !
        ! Read float value
        n_RRC_FloatValue:=bm_RRC_RecBufferRob{n_RRC_ChaNr,n_RRC_ReadPtrRecBuf}.Data.V1;
        !
        ! Placehoder for your Code
        TPErase;
        TPWrite "Gripper Open";
        WaitTime\InPos,2.0;
        !
        IF NOT Present(NoFeedback) THEN
            !
            ! Feedback
            IF bm_RRC_RecBufferRob{n_RRC_ChaNr,n_RRC_ReadPtrRecBuf}.Data.F_Lev>0 THEN
                !
                ! Instruction done
                r_RRC_FDone;
                !
                ! Check additional feedback
                IF bm_RRC_RecBufferRob{n_RRC_ChaNr,n_RRC_ReadPtrRecBuf}.Data.F_Lev>1 THEN
                    !
                    ! Cenerate feedback
                    TEST bm_RRC_RecBufferRob{n_RRC_ChaNr,n_RRC_ReadPtrRecBuf}.Data.F_Lev
                    DEFAULT:
                        !
                        ! Not defined
                        !
                        ! Feedback not supported
                        r_RRC_FError;
                    ENDTEST
                ENDIF
                !
                ! Move message in send buffer
                r_RRC_MovMsgToSenBufRob n_RRC_ChaNr;
            ENDIF
        ENDIF
        RETURN ;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     Gripper close
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2023.02.28
    !***************** ETH Zurich *******************
    !
    PROC r_A083_GripperClose(\switch NoFeedback)
        !
        ! Read string value
        st_RRC_StringValue:=bm_RRC_RecBufferRob{n_RRC_ChaNr,n_RRC_ReadPtrRecBuf}.Data.St1;
        !
        ! Read float value
        n_RRC_FloatValue:=bm_RRC_RecBufferRob{n_RRC_ChaNr,n_RRC_ReadPtrRecBuf}.Data.V1;
        !
        ! Placehoder for your Code
        TPErase;
        TPWrite "Gripper Close";
        WaitTime 2.0;
        !
        IF NOT Present(NoFeedback) THEN
            !
            ! Feedback
            IF bm_RRC_RecBufferRob{n_RRC_ChaNr,n_RRC_ReadPtrRecBuf}.Data.F_Lev>0 THEN
                !
                ! Instruction done
                r_RRC_FDone;
                !
                ! Check additional feedback
                IF bm_RRC_RecBufferRob{n_RRC_ChaNr,n_RRC_ReadPtrRecBuf}.Data.F_Lev>1 THEN
                    !
                    ! Cenerate feedback
                    TEST bm_RRC_RecBufferRob{n_RRC_ChaNr,n_RRC_ReadPtrRecBuf}.Data.F_Lev
                    DEFAULT:
                        !
                        ! Not defined
                        !
                        ! Feedback not supported
                        r_RRC_FError;
                    ENDTEST
                ENDIF
                !
                ! Move message in send buffer
                r_RRC_MovMsgToSenBufRob n_RRC_ChaNr;
            ENDIF
        ENDIF
        RETURN ;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC

    !************************************************
    ! Function    :     RAPID Pick Demo fuer Aurelé
    ! Programmer  :     Philippe Fleischmann
    ! Date        :     2023.02.28
    !***************** ETH Zurich *******************
    !
    PROC r_A083_Rapid_Pick_Demo()
        !
        ! Move to home position
        MoveL p_A083_Home,v100,z100,t_A083_RefTip\WObj:=ob_A083_Wobj_Pick;
        !
        ! Move over pick
        MoveL Offs(p_A083_Pick,0,0,50),v50,fine,t_A083_RefTip\WObj:=ob_A083_Wobj_Pick;
        !
        ! Open gripper
        r_A083_GripperOpen\NoFeedback;
        !
        ! Move to pick pos
        MoveL p_A083_Pick,v10,fine,t_A083_RefTip\WObj:=ob_A083_Wobj_Pick;
        Stop;
        !
        ! Close gripper
        r_A083_GripperClose\NoFeedback;
        !
        ! Move up
        MoveL Offs(p_A083_Pick,0,0,50),v10,z50,t_A083_RefTip\WObj:=ob_A083_Wobj_Pick;
        !
        ! Back to home
        MoveL p_A083_Home,v100,fine,t_A083_RefTip\WObj:=ob_A083_Wobj_Pick;
        !
        ! Feedback
        IF bm_RRC_RecBufferRob{n_RRC_ChaNr,n_RRC_ReadPtrRecBuf}.Data.F_Lev>0 THEN
            !
            ! Instruction done
            r_RRC_FDone;
            !
            ! Check additional feedback
            IF bm_RRC_RecBufferRob{n_RRC_ChaNr,n_RRC_ReadPtrRecBuf}.Data.F_Lev>1 THEN
                !
                ! Cenerate feedback
                TEST bm_RRC_RecBufferRob{n_RRC_ChaNr,n_RRC_ReadPtrRecBuf}.Data.F_Lev
                DEFAULT:
                    !
                    ! Not defined
                    !
                    ! Feedback not supported
                    r_RRC_FError;
                ENDTEST
            ENDIF
            !
            ! Move message in send buffer
            r_RRC_MovMsgToSenBufRob n_RRC_ChaNr;
        ENDIF
        RETURN ;
    ERROR
        ! Placeholder for Error Code...
    ENDPROC
ENDMODULE