function D=P094_SuspRear_LH_V01
%  Definition of Data

%  Nodal Coordinates [mm]

Coord=[ 3135.09  -317.50  325.82;    %1 UCA Front
        3705.20  -317.50  285.95;    %2 UCA Rear
        3512.83	 -796.33  265.95;    %3 UCA Outer
        3089.69	 -153.67   38.09;    %4 LCA Front
        3583.79  -153.67    3.54;    %5 LCA Rear
        3402.63	 -812.60  -38.21;    %6 LCA Outer
        3583.79	 -153.67    3.54;    %7 Tierod Inner
        3580.00	 -812.60  -50.61;    %8 Tierod Outer
        3444.98  -234.44  677.72;    %9 Coilover Upper
        3396.73	 -511.27   57.35;    %10 Coilover Lower
        3500.00  -934.31 -397.22;    %11 TCP
        3460.99  -308.02  837.77;    %12 Bypass Upper
        3406.96  -662.76   23.68;    %13 Bypass Lower
        ];

%  Connectivity
Con=[1 3;    %1 UCA front link
     2 3;    %2 UCA rear link
     4 6;    %3 LCA front link
     5 6;    %4 LCA rear link
     7 8;    %5 Tierod
     9 10;   %6 Coilover to Lower WB
     3 11;   %7 UCA to TCP
     6 11;   %8 LCA to TCP
     8 11;   %9 Tierod to TCP
     12 13;  %10 Bypass to Lower WB
     10 13;  %11 Bypass and coilover attachments to Lower WB
     % Connect all upright nodes between them
     3 6;
     3 8;
     6 8;
     % Connect all Lower Wishbone nodes between them (for Coilover)
     4 6
     4 5
     5 6
     6 10
     4 10
     5 10
     % Connect Lower WB points with Bypass attachment
     6 13
     4 13
     5 13
    ];

% Definition of Degree of freedom (free=0 &  fixed=1); for 2-D trusses the last column is equal to 1
Re=zeros(size(Coord)); %Default all free
Re(1,:)=[1 1 1];
Re(2,:)=[1 1 1];
Re(4,:)=[1 1 1];
Re(5,:)=[1 1 1];
Re(7,:)=[1 1 1];
Re(9,:)=[1 1 1];
Re(12,:)=[1 1 1];
% or:   Re=[0 0 0;0 0 0;0 0 0;0 0 0;0 0 0;0 0 0;1 1 1;1 1 1;1 1 1;1 1 1];

% Definition of Nodal loads 
Load=zeros(size(Coord));
Load(11,:) = [0 0 1000];
% Load([1:3,6],:)=1e3*[1 -10 -10;0 -10 -10;0.5 0 0;0.6 0 0];
% or:   Load=1e3*[1 -10 -10;0 -10 -10;0.5 0 0;0 0 0;0 0 0;0.6 0 0;0 0 0;0 0 0;0 0 0;0 0 0];

% Definition of Modulus of Elasticity [MPa]
E=ones(1,size(Con,1))*210e6; %Steel 210Gpa
% or:   E=[1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1]*1e7;

% Definition of Area [mm^2]
% A=[.4 .1 .1 .1 .1 3.4 3.4 3.4 3.4 .4 .4 1.3 1.3 .9 .9 .9 .9 1 1 1 1 3.4 3.4 3.4 3.4];
A = ones(1,size(Con,1))*1256; %40mm solid circle - 20x20x3.14 = 1256 mm^2

% Convert to structure array
D=struct('Coord',Coord','Con',Con','Re',Re','Load',Load','E',E','A',A');