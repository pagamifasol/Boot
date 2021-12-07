% Input file
    D = P094_SuspRear_RH_V01;
    def_scale = 1e4; %Scale deformation in the drawing

%% REMEMBER TO CHANGE USER FUNCTION IN CASE INVESTIGATING LH SUSPENSION 
    % Replace loads (Optional)
    LoadcaseN = 9;

    TCP_Loadcases = [	-969	0       26097;  %1 Front Later Bump (LHS)
                        -969    0        7297;  %2 Front Later Bump (RHS)
                        -969    0       51869;  %3 Rear Later Bump (LHS)
                        -969    0       73354;  %4 Rear Later Bump (RHS)
                        -12788  0       24537;  %5 Acceleration + Bump (LHS=RHS)
                        23488   0       14766;  %6 Brake + Bump (LHS=RHS)
                        -969    0       15743;  %7 Lateral+Bump (LHS)
                        -969    42560   37457;  %8 Lateral+Bump (RHS)
                        -969    0       37240;  %9 Vertical Bump (LHS=RHS)
                    ];

    D.Load(:,11) = TCP_Loadcases(LoadcaseN,:);

    % Minimize contribution of Bypass damper ("Disable" it)
    D.A(10) = 0.001;
%     % Minimize contribution of Coilover damper ("Disable" it)
%     D.A(6) = 0.001
    
% Run model
    [F,U,R]=ST(D);

% Check force sum to be zero
    FSum = sum(R,2) + sum(D.Load,2);
    disp('Forces equilibrium - should be near zero!')
    disp(FSum)

% Drawing
    figure
    TP(D,U,def_scale);

% Custom output for excel sheet
UCA(:,LoadcaseN) = [R(:,1); R(:,2)];
LCA(:,LoadcaseN) = [R(:,4); R(:,5)];
Tie(:,LoadcaseN) = [R(:,7);R(:,8)];  % 7 = Tierod Inner, 8 = Tierod Outer
Coilover(:,LoadcaseN) = [R(:,9);R(:,10)]; % 9 = Coilover Upper Point, 10= Coilover Lower Point
Bypass(:,LoadcaseN) = R(:,12);  % 12 = Bypass Upper Point
