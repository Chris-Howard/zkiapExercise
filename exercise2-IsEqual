// https://hackmd.io/@gubsheep/S1Hz96Yqo#IsEqual

/**
 * 
 * IsEqual
 * Parameters: none
 * Input signal(s): in[2]
 * Output signal(s): out
 * Specification: If in[0] is equal to in[1], out should be 1. Otherwise, out should be 0.
 * 
 */

pragma circom 2.1.2;

template IsEqual() {
    signal input in[2];
    signal output out;
    out<--(in[0]!=in[1])?0:1;
    out*(out-1)===0;
    

}

component main = IsEqual();

/* INPUT = {
    "in": ["4","5"]
} */
