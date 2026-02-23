## --*texinfo*--
## @deftypescript {Data File} {busdata}
## @brief Bus data for IEEE 18-bus system
##
## Each row corresponds to a bus with the following columns:
## 1. Bus ID
## 2. Bus Type (1=Slack, 2=PV, 3=PQ)
## 3. Voltage Magnitude (p.u.)
## 4. Voltage Angle (degrees)
## 5. Active Power Load (MW)
## 6. Reactive Power Load (MVAR)
## 7. Active Power Generation (MW)
## 8. Reactive Power Generation (MVAR)
## @end deftypescript
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