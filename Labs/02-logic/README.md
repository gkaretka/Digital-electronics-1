# Digital-electronics-1

## Lab 2: Combinational logic

## Preparation tasks (done before the lab at home)

*Digital* or *Binary comparator* compares the digital signals A, B presented at input terminal and produce outputs depending upon the condition of those inputs. Complete the truth table for 2-bit *Identity comparator* (B equals A), and two *Magnitude comparators* (B is greater than A, B is less than A). Note that, such a digital device has four inputs and three outputs/functions.

| **Dec. equivalent** | **B[1:0]** | **A[1:0]** | **B is greater than A** | **B equals A** | **B is less than A** |
| :-: | :-: | :-: | :-: | :-: | :-: |
| 0 | 0 0 | 0 0 | 0 | 1 | 0 |
| 1 | 0 0 | 0 1 | 0 | 0 | 1 |
| 2 | 0 0 | 1 0 | 0 | 0 | 1 |
| 3 | 0 0 | 1 1 | 0 | 0 | 1 |
| 4 | 0 1 | 0 0 | 1 | 0 | 0 |
| 5 | 0 1 | 0 1 | 0 | 1 | 0 |
| 6 | 0 1 | 1 0 | 0 | 0 | 1 |
| 7 | 0 1 | 1 1 | 0 | 0 | 1 |
| 8 | 1 0 | 0 0 | 1 | 0 | 0 |
| 9 | 1 0 | 0 1 | 1 | 0 | 0 |
| 10 | 1 0 | 1 0 | 0 | 1 | 0 |
| 11 | 1 0 | 1 1 | 0 | 0 | 1 |
| 12 | 1 1 | 0 0 | 1 | 0 | 0 |
| 13 | 1 1 | 0 1 | 1 | 0 | 0 |
| 14 | 1 1 | 1 0 | 1 | 0 | 0 |
| 15 | 1 1 | 1 1 | 0 | 1 | 0 |

```verilog
eq_sop = (~b1 * ~b0 * ~a1 * ~a0) + (b1 * ~b0 * a1 * ~a0) + (~b1 * b0 * ~a1 * ~a0) + (b1 * b0 * a1 * a0);

blta_pos = (b1 + b0 + a1 + a0) * (b1 + ~b0 + a1 + a0) * (b1 + ~b0 + a1 + ~a0) * (~b1 + b0 + a1 + a0) * (~b1 + b0 + a1 + ~a0) * 
            (~b1 + b0 + ~a1 + a0) * (~b1 + ~b0 + a1 + a0) * (~b1 + ~b0 + a1 + ~a0) * (~b1 + ~b0 + ~a1 + a0) * (~b1 + ~b0 + ~a1 + ~a0);

bgta_pos = (b1 + b0 + a1 + a0) * (b1 + b0 + a1 + ~a0) * (b1 + ~b0 + ~a1 + a0) * (b1 + b0 + ~a1 + ~a0) * (b1 + ~b0 + a1 + ~a0) * 
            (b1 + ~b0 + a1 + ~a0) * (b1 + ~b0 + ~a1 + ~a0) * (~b1 + b0 + ~a1 + a0) * (~b1 + b0 + ~a1 + ~a0) * (~b1 + ~b0 + ~a1 + ~a0);
```

## K-map

| x  | 00 | 01 | 11 | 10 |
| 00 | x  | x  | x  | x  |
| 01 | x  | x  | x  | x  |
| 11 | x  | x  | x  | x  |
| 10 | x  | x  | x  | x  |