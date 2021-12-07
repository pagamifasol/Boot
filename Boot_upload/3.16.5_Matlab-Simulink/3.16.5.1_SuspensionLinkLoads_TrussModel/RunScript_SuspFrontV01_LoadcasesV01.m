% Input file
    D = P094_SuspFront_LH_V01;
    def_scale = 10; %Scale deformation in the drawing
%% REMEMBER TO CHANGE USER FUNCTION IN CASE INVESTIGATING LH SUSPENSION 
% Replace loads (Optional)
    LoadcaseN = 5;

    TCP_Loadcases = [	-895	0       49703;  %1 Front Later Bump (LHS)
                        -895	0       30903;  %2 Front Later Bump (RHS)
                        -895	0       -6854;  %3 Rear Later Bump (LHS)
                        -895	0       14631;  %4 Rear Later Bump (RHS)
                        -11804	0       13463;  %5 Acceleration + Bump (LHS=RHS)
                        12648	0       23234;  %6 Brake + Bump (LHS=RHS)
                        -895	0       10043;  %7 Lateral+Bump (LHS)
                        -895	33440	31757;  %8 Lateral+Bump (RHS)
                        -895	0       29260;  %9 Vertical Bump (LHS=RHS)
                    ];

    D.Load(:,11) = TCP_Loadcases(LoadcaseN,:);
    
%     % Minimize contribution of Bypass damper ("Disable" it)
%     D.A(10) = 0.001;
    % Minimize contribution of Coilover damper ("Disable" it)
    D.A(6) = 0.001;
    
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
Coilover(:,LoadcaseN) = [R(:,9);R(:,10)]; % Coilover Upper Point
Bypass(:,LoadcaseN) = R(:,12);  % Bypass Upper Point
