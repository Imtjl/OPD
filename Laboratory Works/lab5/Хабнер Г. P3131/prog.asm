ORG                             0x0EE
ARR:            WORD            0x612
ADR:            WORD            0
FINISH:         WORD            0x00D
START:          CLA 
                LD              ARR
                ST              ADR
S1:             IN              0x19
                AND             #0x40
                BEQ             S1
                IN              0x18
                SWAB           
                ST              (ADR)
                SWAB
                AND             FINISH
                SUB             FINISH
                BEQ             EXIT
S2:             IN              0x19
                AND             #0x40
                BEQ             S2
                LD              (ADR)
                IN              0x18              
                ST              (ADR)+
                AND             FINISH
                SUB             FINISH
                BEQ             EXIT
                JUMP            S1
EXIT:           HLT


