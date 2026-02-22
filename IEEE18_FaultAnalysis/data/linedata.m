% IEEE 18-bus system line data
% Columns: [from_bus, to_bus, resistance, reactance, line_charging]
%{
Each row:
[FromBus, ToBus, R, X, B]
- R = Resistance (p.u.)
- X = Reactance (p.u.)
- B = Line charging susceptance (p.u.)
%}


line_data = [
  1 2  0.02  0.06  0.03;
  2 3  0.05  0.19  0.02;
  3 4  0.06  0.17  0.02;
  4 5  0.04  0.13  0.01;
  5 6  0.03  0.10  0.01;
  6 7  0.04  0.12  0.01;
  7 8  0.05  0.20  0.02;
  8 9  0.06  0.18  0.02;
  9 10 0.04  0.13  0.01;
  10 11 0.03  0.09  0.01;
  11 12 0.04  0.12  0.01;
  12 13 0.05  0.15  0.02;
  13 14 0.06  0.17  0.02;
  14 15 0.04  0.13  0.01;
  15 16 0.03  0.10  0.01;
  16 17 0.04  0.12  0.01;
  17 18 0.05  0.20  0.02;
];