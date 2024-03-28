MODULE iGPS_SC_Acc_Exp
    
    LOCAL CONST num num_targets := 20;
    LOCAL CONST speeddata robot_speed := v400;
    
    LOCAL CONST extjoint base_position := [9500, -7000, -4500, 0, 0, 0];
    
    LOCAL PERS robtarget targets{num_targets} :=
    [
    [[13500.5, 8999.68, 2198.88], [-0.000165685, 1, -0.000870238, -0.000298353], [0, 2, -3, 0], [9500, -7000, -4500, 0, 0, 0]],
    [[12893.7, 9351.19, 2052.2], [0.0140551, 0.973878, 0.20728, -0.0916479], [-1, 2, -3, 0], [9500, -7000, -4500, 0, 0, 0]],
    [[13534.2, 10299, 2582.83], [0.0391842, -0.918141, -0.376964, -0.115674], [-1, 2, -3, 0], [9500, -7000, -4500, 0, 0, 0]],
    [[12054, 10927.4, 2385.04], [0.0241932, -0.673381, -0.73843, -0.0263472], [-2, 2, -3, 0], [9500, -7000, -4500, 0, 0, 0]],
    [[10831.7, 10819.4, 2529.09], [0.0248897, 0.425629, 0.904468, -0.0125415], [-2, 2, -3, 0], [9500, -7000, -4500, 0, 0, 0]],
    [[9943.68, 10068.1, 2873.98], [0.0404398, -0.184986, -0.981845, -0.0111994], [-2, 2, -3, 0], [9500, -7000, -4500, 0, 0, 0]],
    [[11564.1, 9314.04, 2062.34], [0.128689, 0.186232, 0.973467, -0.0334372], [-2, 2, -3, 0], [9500, -7000, -4500, 0, 0, 0]],
    [[10731.7, 10619.4, 2429.09], [0.0248897, 0.425629, 0.904468, -0.0125415], [-2, 2, -3, 0], [9500, -7000, -4500, 0, 0, 0]],
    [[11564.1, 9314.06, 2062.34], [0.12858, 0.186208, 0.973489, -0.0333636], [-2, 2, -3, 0], [9500, -7000, -4500, 0, 0, 0]],
    [[12651.7, 8697.15, 1849.44], [0.0636364, -0.946795, 0.253615, 0.187644], [0, 2, -3, 0], [9500, -7000, -4500, 0, 0, 0]],
    [[13537, 7833.67, 2255.55], [0.0190537, -0.947452, 0.31602, 0.0458633], [0, 2, -3, 0], [9500, -7000, -4500, 0, 0, 0]],
    [[13401.5, 7131.31, 2766.12], [0.0129969, -0.89707, 0.441156, 0.021855], [0, 2, -3, 0], [9500, -7000, -4500, 0, 0, 0]],
    [[13001.5, 7031.31, 2666.12], [0.0129969, -0.89707, 0.441156, 0.021855], [0, 2, -3, 0], [9500, -7000, -4500, 0, 0, 0]],
    [[11772.6, 7396.28, 2168.66], [0.0348366, -0.657471, 0.752222, 0.026073], [1, 2, -3, 0], [9500, -7000, -4500, 0, 0, 0]],
    [[11073.8, 7908.14, 2132.16], [0.036482, -0.436085, 0.899051, 0.0143862], [1, 2, -3, 0], [9500, -7000, -4500, 0, 0, 0]],
    [[10049.9, 8478.28, 2630.76], [0.0811793, 0.168412, -0.982333, 0.00837412], [1, 2, -3, 0], [9500, -7000, -4500, 0, 0, 0]],
    [[9806.66, 8516.95, 2983.98], [0.06, -0.147157, 0.987278, 0.00523976], [1, 2, -3, 2], [9500, -7000, -4500, 0, 0, 0]],
    [[9977.73, 8332.64, 2487.07], [0.239475, 0.32595, -0.914497, 0.0101509], [1, 2, -3, 2], [9500, -7000, -4500, 0, 0, 0]],
    [[10982.5, 8349.65, 2021.3], [0.0371425, 0.323995, -0.945274, 0.010241], [1, 2, -3, 0], [9500, -7000, -4500, 0, 0, 0]],
    [[11184.7, 6735.15, 3140.64], [0.0971625, 0.599568, -0.792361, 0.0569385], [1, 1, -3, 2], [9500, -7000, -4500, 0, 0, 0]]
    ];
    
    LOCAL PERS robtarget targets_low_extended{num_targets} :=
    [
    [[13500.5, 8999.68, 698.88], [-0.000165685, 1, -0.000870238, -0.000298353], [0, 2, -3, 0], [9500, -7000, -3000, 0, 0, 0]],
    [[12893.7, 9351.19, 552.2], [0.0140551, 0.973878, 0.20728, -0.0916479], [-1, 2, -3, 0], [9500, -7000, -3000, 0, 0, 0]],
    [[13534.2, 10299, 1082.83], [0.0391842, -0.918141, -0.376964, -0.115674], [-1, 2, -3, 0], [9500, -7000, -3000, 0, 0, 0]],
    [[12054, 10927.4, 885.04], [0.0241932, -0.673381, -0.73843, -0.0263472], [-2, 2, -3, 0], [9500, -7000, -3000, 0, 0, 0]],
    [[10831.7, 10819.4, 1029.09], [0.0248897, 0.425629, 0.904468, -0.0125415], [-2, 2, -3, 0], [9500, -7000, -3000, 0, 0, 0]],
    [[9943.68, 10068.1, 1373.98], [0.0404398, -0.184986, -0.981845, -0.0111994], [-2, 2, -3, 0], [9500, -7000, -3000, 0, 0, 0]],
    [[11564.1, 9314.04, 562.34], [0.128689, 0.186232, 0.973467, -0.0334372], [-2, 2, -3, 0], [9500, -7000, -3000, 0, 0, 0]],
    [[10731.7, 10619.4, 929.09], [0.0248897, 0.425629, 0.904468, -0.0125415], [-2, 2, -3, 0], [9500, -7000, -3000, 0, 0, 0]],
    [[11564.1, 9314.06, 562.34], [0.12858, 0.186208, 0.973489, -0.0333636], [-2, 2, -3, 0], [9500, -7000, -3000, 0, 0, 0]],
    [[12651.7, 8697.15, 349.44], [0.0636364, -0.946795, 0.253615, 0.187644], [0, 2, -3, 0], [9500, -7000, -3000, 0, 0, 0]],
    [[13537, 7833.67, 755.55], [0.0190537, -0.947452, 0.31602, 0.0458633], [0, 2, -3, 0], [9500, -7000, -3000, 0, 0, 0]],
    [[13401.5, 7131.31, 1266.12], [0.0129969, -0.89707, 0.441156, 0.021855], [0, 2, -3, 0], [9500, -7000, -3000, 0, 0, 0]],
    [[13001.5, 7031.31, 1166.12], [0.0129969, -0.89707, 0.441156, 0.021855], [0, 2, -3, 0], [9500, -7000, -3000, 0, 0, 0]],
    [[11772.6, 7396.28, 668.66], [0.0348366, -0.657471, 0.752222, 0.026073], [1, 2, -3, 0], [9500, -7000, -3000, 0, 0, 0]],
    [[11073.8, 7908.14, 632.16], [0.036482, -0.436085, 0.899051, 0.0143862], [1, 2, -3, 0], [9500, -7000, -3000, 0, 0, 0]],
    [[10049.9, 8478.28, 1130.76], [0.0811793, 0.168412, -0.982333, 0.00837412], [1, 2, -3, 0], [9500, -7000, -3000, 0, 0, 0]],
    [[9806.66, 8516.95, 1483.98], [0.06, -0.147157, 0.987278, 0.00523976], [1, 2, -3, 2], [9500, -7000, -3000, 0, 0, 0]],
    [[9977.73, 8332.64, 987.07], [0.239475, 0.32595, -0.914497, 0.0101509], [1, 2, -3, 2], [9500, -7000, -3000, 0, 0, 0]],
    [[10982.5, 8349.65, 521.3], [0.0371425, 0.323995, -0.945274, 0.010241], [1, 2, -3, 0], [9500, -7000, -3000, 0, 0, 0]],
    [[11184.7, 6735.15, 1640.64], [0.0971625, 0.599568, -0.792361, 0.0569385], [1, 1, -3, 2], [9500, -7000, -3000, 0, 0, 0]]
    ];
    
    LOCAL PERS robtarget targets_inactive_mid_nominal{num_targets} :=
    [
    [[13501.8, 8999.44, 1697.94], [0.000459625, -0.999998, 0.00179723, 0.000913529], [0, 2, -3, 0], [9500, -7000, -4000, 0, 0, 0]],
    [[13116.7, 9161.99, 1748.36], [-8.87319E-05, 0.997475, 0.0708872, -0.00435851], [-1, 2, -3, 0], [9500, -7000, -4000, 0, 0, 0]],
    [[12719.7, 9378.09, 1923.74], [0.00105727, 0.965684, 0.259678, -0.00456877], [-1, 2, -3, 0], [9500, -7000, -4000, 0, 0, 0]],
    [[12385.8, 9343.42, 2099.29], [0.0156571, 0.91016, 0.412255, -0.0375312], [-1, 2, -3, 0], [9500, -7000, -4000, 0, 0, 0]],
    [[12212.8, 9878.04, 2213.94], [0.0732568, -0.729304, -0.674622, -0.0873695], [-1, 2, -3, 0], [9500, -7000, -4000, 0, 0, 0]],
    [[11830.1, 9711.8, 1945.18], [0.00610242, -0.53054, -0.847623, -0.00512838], [-2, 2, -3, 0], [9500, -7000, -4000, 0, 0, 0]],
    [[11757.9, 9306.11, 1944.98], [0.0604996, 0.278454, 0.958337, -0.0198436], [-2, 2, -3, 0], [9500, -7000, -4000, 0, 0, 0]],
    [[12104, 9066.01, 2015.22], [0.177071, 0.274306, 0.943329, -0.0594284], [-2, 2, -3, 0], [9500, -7000, -4000, 0, 0, 0]],
    [[12368.5, 9408.88, 2110.61], [0.0115907, 0.880987, 0.472449, -0.0228114], [-1, 2, -3, 0], [9500, -7000, -4000, 0, 0, 0]],
    [[12714.5, 8914.34, 2348.86], [0.013267, 0.990684, -0.0981421, 0.0934715], [0, 2, -3, 0], [9500, -7000, -4000, 0, 0, 0]],
    [[12744.1, 8555.75, 2439.02], [0.0607638, 0.934688, -0.30779, 0.167128], [0, 2, -3, 0], [9500, -7000, -4000, 0, 0, 0]],
    [[12749.1, 8349.03, 2180.61], [0.0741382, 0.962136, -0.239069, 0.107911], [0, 2, -3, 0], [9500, -7000, -4000, 0, 0, 0]],
    [[12598.8, 8233.29, 2200.61], [0.0892549, 0.932596, -0.333338, 0.105754], [0, 2, -3, 0], [9500, -7000, -4000, 0, 0, 0]],
    [[12338.3, 8363.72, 2116.8], [0.0226019, 0.665028, -0.744285, 0.0571587], [0, 2, -2, 0], [9500, -7000, -4000, 0, 0, 0]],
    [[12205.3, 8143.74, 2273.9], [0.231328, 0.530181, -0.717364, 0.38831], [0, 2, -2, 0], [9500, -7000, -4000, 0, 0, 0]],
    [[11922.7, 8536.26, 2063.49], [0.0864469, 0.751372, -0.654076, 0.0123183], [1, 1, -3, 0], [9500, -7000, -4000, 0, 0, 0]],
    [[11695, 8660.37, 1998.63], [-0.0912111, -0.631674, 0.763817, 0.0961894], [1, 1, -3, 0], [9500, -7000, -4000, 0, 0, 0]],
    [[11763.5, 8754.94, 2232.47], [-0.10802, -0.618821, 0.77224, 0.0950695], [1, 1, -3, 0], [9500, -7000, -4000, 0, 0, 0]],
    [[11538.2, 8518.12, 2447.96], [0.26788, 0.587305, -0.760325, -0.0722458], [1, 1, -3, 0], [9500, -7000, -4000, 0, 0, 0]],
    [[12384.1, 8763.15, 2269.76], [0.133887, 0.987201, -0.0866486, -0.000794353], [0, 1, -3, 0], [9500, -7000, -4000, 0, 0, 0]]
    ];
    
    LOCAL PROC ApplyBasePosition()
        FOR i FROM 1 TO num_targets DO
            targets{i}.extax := base_position;    
            !targets{i}.trans.x := targets{i}.trans.x + 4000;
        ENDFOR
    ENDPROC
    
    PROC SCAccExpCollectTargets()
        VAR robtarget meas_target;
        iGPSConnect "Robot12";  
        
        FOR i FROM 1 TO num_targets DO
            TPWrite "Press play for measuring target" + ValToStr(i);   
            Stop;
            iGPSGetRobTarget meas_target, "tool0", "wobj0";   
            targets{i} := meas_target;
        ENDFOR
        
        iGPSDisconnect;
    ENDPROC
    
    PROC SCAccExperiments()
        VAR iodev output_file; 
        VAR string folder_name;
        VAR string file_name;
        VAR robtarget meas_target;
        
        folder_name := "Home:/iGPS/";
        file_name := "sc_acc_experiment.txt";
        
        MakeDir folder_name;
        Open folder_name + file_name, output_file \Write;
        
        ApplyBasePosition;
        
        iGPSConnect "Robot12";   

        FOR i FROM 1 TO num_targets DO
            TPWrite "Processing target" + ValToStr(i);
            
            Write output_file, "1.0," + TargetToStr(targets{i});
            
            ! With calibration, without correction step
            iGPSMoveJ targets{i}, robot_speed, "tool0", \tool_load:=kDSCLoadData, "wobj0", FALSE; 
            iGPSGetRobTarget meas_target, "tool0", "wobj0";               
            Write output_file, "2.0," + TargetToStr(meas_target);
            
            ! With calibration, with correction step
            iGPSMoveJAndCorrect targets{i}, robot_speed, "tool0", \tool_load:=kDSCLoadData, "wobj0", FALSE;  
            iGPSGetRobTarget meas_target, "tool0", "wobj0";    
            Write output_file, "3.0," + TargetToStr(meas_target);
        
            WaitTime 2;
        ENDFOR
        
        iGPSDisconnect;
    ENDPROC
    
    LOCAL FUNC string TargetToStr(robtarget target)
        RETURN NumToStr(target.trans.x, 5) + ","
            + NumToStr(target.trans.y, 5) + ","
            + NumToStr(target.trans.z, 5) + ","
            + NumToStr(target.rot.q1, 6) + ","
            + NumToStr(target.rot.q2, 6) + ","
            + NumToStr(target.rot.q3, 6) + ","
            + NumToStr(target.rot.q4, 6);
    ENDFUNC
    
ENDMODULE