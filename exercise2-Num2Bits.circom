pragma circom 2.1.2;

/**
*Num2Bits
*- Parameters: nBits
*- Input signal(s): in
*- Output signal(s): b[nBits]
* The output signals should be an array of bits of length nBits equivalent to the binary representation of in. b[0] is the least significant bit.
*/

template Num2Bits (nBits) {
    signal input in;
    signal output b[nBits];

    // 将in拆成bit存入b[i]中
    for(var i = 0;i<nBits;i++){
        b[i]<--(in>>i)&1;
    }

    // 约束
    // 1.b[i]只能为0或1
    // 2.b还原成10进制需与in相等
    var sum =0;
    var e = 1;
    
    for(var i = 0;i<nBits;i++){
        //b[i]只能为0或者1
        b[i]*(b[i]-1)===0;
        sum = sum + b[i]*e;
        e = 2*e;
    }
    // sum 必须与in相等
    sum === in;
    
}

//Q:在输入数字前难道还要自己先知道二进制是多少位!???
component main= Num2Bits(4);

/* INPUT = {
    "in": "11"
} */
