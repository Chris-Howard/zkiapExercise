// https://hackmd.io/@gubsheep/S1Hz96Yqo#IsZero
/**
 * IsZero
 * Parameters: none
 * Input signal(s): in
 * Output signal(s): out
 * Specification: If in is zero, out should be 1. If in is nonzero, out should be 0. This one is a little tricky!
 */
pragma circom 2.1.2;

template IsZero () {
    signal input in;
    signal output out;

    //out <-- (in!=0)?0:1;


    // 约束:
    // 如果in是0，out是1；
    // 如果in不是0，out是0；
    // in和out的约束关系应该是什么
    // 如果in是0，in+out===1;也可以看成in*in+out===1;
    // 如果in不是0,1/in*in+out ===1;
    // var in_inv = (in!=0)?1/in:0;
    // signal in_inv <--(in!=0)?1/in:0;
    //in*in_inv+out ===1;
    // out*(out-1)===0;
    signal in_inv;
    in_inv<-- (in==0)?0:1/in;
    out <==1-in*in_inv;
    in*out===0;
    out*(out-1)===0;
    //in*(in_inv*in-1)===0;
}

component main  = IsZero();

/* INPUT = {
    "in": "4"
} */
