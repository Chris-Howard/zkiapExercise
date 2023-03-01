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
