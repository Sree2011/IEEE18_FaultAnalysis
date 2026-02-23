## --*texinfo*--
## @deftypescript {Data File} {gendata}
## @brief Generator data for IEEE 18-bus system
##
## Each row corresponds to a generator with the following columns:
## 1. Bus ID where generator is located
## 2. Generator Type (1=Slack, 2=PV)
## 3. Active Power Generation (MW)
## 4. Reactive Power Generation (MVAR)
## 5. Voltage Setpoint (p.u.)
## 6. Minimum Reactive Power Limit (MVAR)
## 7. Maximum Reactive Power Limit (MVAR)
## @end deftypescript
gen_data = [
  1 1 0 0 1.06 0 0;
  2 2 40 0 1.00 -20 50;
  5 2 30 0 1.00 -15 40;
  9 2 20 0 1.00 -10 30;
  13 2 25 0 1.00 -15 35;
];