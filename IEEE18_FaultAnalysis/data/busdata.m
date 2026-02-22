% IEEE 18-bus system data
% Columns: [bus_number, bus_type, voltage_magnitude, voltage_angle, load_P, load_Q, gen_P, gen_Q]
%{
- BusType: 1 = Slack, 2 = PV, 3 = PQ
- Vmag = Voltage magnitude (p.u.)
- Vang = Voltage angle (degrees)
- Pg/Qg = Generation (MW/MVAR)
- Pl/Ql = Load (MW/MVAR)
%}

bus_data = [
  1  1  1.06  0    0   0   0   0;
  2  2  1.00  0    40  0   20  10;
  3  3  1.00  0    0   0   45  15;
  4  3  1.00  0    0   0   40  20;
  5  3  1.00  0    0   0   60  25;
  6  2  1.00  0    30  0   25  15;
  7  3  1.00  0    0   0   35  10;
  8  3  1.00  0    0   0   20  10;
  9  3  1.00  0    0   0   15  5;
  10 3  1.00  0    0   0   10  5;
  11 3  1.00  0    0   0   25  10;
  12 3  1.00  0    0   0   30  15;
  13 2  1.00  0    35  0   20  10;
  14 3  1.00  0    0   0   15  5;
  15 3  1.00  0    0   0   20  10;
  16 3  1.00  0    0   0   25  10;
  17 3  1.00  0    0   0   30  15;
  18 3  1.00  0    0   0   20  10;
];