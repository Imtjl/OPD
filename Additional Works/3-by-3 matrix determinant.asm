ORG 0x10
  LD X2Y2
  ST X
  LD X3Y3
  ST Y
  CALL MULT   ; X2Y2 * X3Y3
  LD R
  ST TMP
  LD X2Y3
  ST X
  LD X3Y2
  ST Y
  CALL MULT   ; X2Y3 * X3Y2
  LD TMP
  SUB R
  ST X
  LD X1Y1
  ST Y
  CALL MULT   ; X1Y1 * (X2Y2 * X3Y3 - X2Y3 * X3Y2)
  LD R
  ST REZ

  LD X2Y1
  ST X
  LD X3Y3
  ST Y
  CALL MULT   ; X2Y1 * X3Y3
  LD R
  ST TMP
  LD X2Y3
  ST X
  LD X3Y1
  ST Y
  CALL MULT   ; X2Y3 * X3Y1
  LD TMP
  SUB R
  ST X
  LD X1Y2
  ST Y
  CALL MULT   ; X1Y2 * (X2Y1 * X3Y3 - X2Y3 * X3Y1)
  LD REZ
  SUB R
  ST REZ   ; X1Y1 * (X2Y2 * X3Y3 - X2Y3 * X3Y2) - X1Y2 * (X2Y1 * X3Y3 - X2Y3 * X3Y1)

  LD X2Y1
  ST X
  LD X3Y2
  ST Y
  CALL MULT   ; X2Y1 * X3Y2
  LD R
  ST TMP
  LD X2Y2
  ST X
  LD X3Y1
  ST Y
  CALL MULT   ; X2Y2 * X3Y1
  LD TMP
  SUB R
  ST Y
  LD X1Y3
  ST X
  CALL MULT   ; X1Y3 * (X2Y1 * X3Y2 - X2Y2 * X3Y1)
  LD REZ
  ADD R
  ST REZ   ; X1Y1 * (X2Y2 * X3Y3 - X2Y3 * X3Y2) - X1Y2 * (X2Y1 * X3Y3 - X2Y3 * X3Y1) + X1Y3 * (X2Y1 * X3Y2 - X2Y2 * X3Y1)
  HLT
X1Y1: WORD 1
X1Y2: WORD 3
X1Y3: WORD 5
X2Y1: WORD 1
X2Y2: WORD 3
X2Y3: WORD 6
X3Y1: WORD 9
X3Y2: WORD 8
X3Y3: WORD 5
REZ: WORD ?

X: WORD ?
Y: WORD ?
R: WORD ?
MULT:
  CLA
  ST R   ; R = 0
  LD Y
  PUSH   
  CLA
  ADD X
LOOOP:   ; WHILE (X != 0) {
  BEQ DONE 
  CLC
  ROR   ; C = X & 1; X = X >> 1
  SWAP
  BCS ADDUP
  JUMP SKIP   ; IF (C == 1) {
ADDUP:
  PUSH
  ADD R
  ST R   ; R = Y + R
  POP   ; }
SKIP:
  ASL   ; Y = Y << 1
  SWAP
  JUMP LOOOP   ; }
DONE:
  POP
  RET
TMP: WORD ?
END