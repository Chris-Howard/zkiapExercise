// https://hackmd.io/@gubsheep/S1Hz96Yqo#IsNegative
/*
IsNegative
NOTE: Signals are residues modulo p (the Babyjubjub prime), and there is no natural notion of “negative” numbers mod p. However, it is pretty clear that that modular arithmetic works analogously to integer arithmetic when we treat p-1 as -1. So we define a convention: “Negative” is by convention considered to be any residue in (p/2, p-1], and nonnegative is anything in [0, p/2)

Parameters: none
Input signal(s): in
Output signal(s): out
Specification: If in is negative according to our convention, out should be 1. Otherwise, out should be 0. You are free to use the CompConstant circuit, which takes a constant parameter ct, outputs 1 if in (a binary array) is strictly greater than ct when interpreted as an integer, and 0 otherwise.

*/

pragma circom 2.1.2;

include "circomlib/circuits/compconstant.circom";

template IsNegative() {
    signal input in;
    signal output out;

    // r = 21888242871839275222246405745257275088548364400416034343698204186575808495617
    // r/2(向下取整):
    // 10944121435919637611123202872628637544274182200208017171849102093287904247808
    var half_of_r = 10944121435919637611123202872628637544274182200208017171849102093287904247808;
    // r is 254bits
    component in_Num2Bits=Num2Bits(254);
    in_Num2Bits.in<==in;
    component comp = CompConstant(half_of_r);
    for(var i=0;i<254;i++){
        comp.in[i]<==in_Num2Bits.out[i];
    }

    out<==comp.out;
    
}

component main = IsNegative();

/* INPUT = {
    "in": "5"
} */
