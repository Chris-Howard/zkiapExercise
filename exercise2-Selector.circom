// https://hackmd.io/@gubsheep/S1Hz96Yqo#Selector
/**
 * 
 * Selector
 * Parameters: nChoices
 * Input signal(s): in[nChoices], index
 * Output: out
 * Specification: The output out should be equal to in[index]. If index is out of bounds (not in [0, nChoices)), out should be 0.
 * 
 */

pragma circom 2.1.2;

template Selector(nChoices) {
    signal input in[nChoices];
    signal input index;
    signal output out;
    out <--(index>=0&&index<nChoices)?in[index]:0;

    // 约束:
    // 如果index在[0,nChoices)内out===in[index]
    // 如果index不在[0,nChoices)内out===0;
    
    for(var i=0;i<nChoices;i++){
        out*(out-in[i])===0;
    }
    // 感觉上述约束还不够
    

}

component main  = Selector(4);

/* INPUT = {
    "in": ["0","1","2","3"],
    "index": "2"
} */
