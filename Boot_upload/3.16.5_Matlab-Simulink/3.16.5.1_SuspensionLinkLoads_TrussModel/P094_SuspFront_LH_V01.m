function D=P094_SuspFront_LH_V01
%  Definition of Data

%  Nodal Coordinates [mm]
Coord=[ -276.45  -250.19  330.70;    %1 UCA Front
          27.60  -250.19  309.44;    %2 UCA Rear
          25.72	 -750.54  304.47;    %3 UCA Outer
         -78.94	 -153.67   25.40;    %4 LCA Front
         301.14  -153.67   -1.23;    %5 LCA Rear
         -15.83	 -845.53  -25.68;    %6 LCA Outer
        -152.27	 -238.54  148.53;    %7 Tierod Inner
        -151.21	 -848.57  119.34;    %8 Tierod Outer
         183.40  -219.08  571.75;    %9 Coilover Upper
         111.90	 -505.12   32.98;    %10 Coilover Lower
         0.000   -934.31 -378.38;    %11 TCP
         190.24  -292.10  669.44;    %12 Bypass Upper
          84.32  -651.77   38.81;    %13 Bypass Lower
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