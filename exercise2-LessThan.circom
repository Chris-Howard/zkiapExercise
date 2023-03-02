// https://hackmd.io/@gubsheep/S1Hz96Yqo#LessThan

pragma circom 2.1.2;


// 之前写的，借过来用用
template Num2Bits(nBits) {
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

template LessThan() {
    signal input in[2];
    signal output out; 
    // if(in[0]<in[1]){
    //     out<==1;
    // }else{
    //     out<==0;
    // }
    // 如何知道比较in[0]与in[1]的大小
    // 做差比较?做商比较??做商比较得分正负，考虑做差比较
    // 因为最高252次方-1，因此差值必小于2^252次方
    // 如果为正，不影响最高位，如果为负，最高位由0变1
    // 这要求in必须是BigInt而不能是double!!!!!!!!!!!!!!
    component comp = Num2Bits(253); 
    comp.in<==(1<<252)+in[0]-in[1];
    // 如果最高位为1，in[0]>=in[1],out为0
    // 如果最高位为0,in[0]<in[1],out为1
    out<==1-comp.b[252];

}

template LessThan_k(k){
    signal input in[2];
    signal output out; 
    assert(k<=252);
    component comp = Num2Bits(k+1); 
    comp.in<==((1<<k)+in[0]-in[1]);
    out<==1-comp.b[k];

}

// 带个k更具通用性
template LessEqThan(k) {
    signal input in[2];
    signal output out; 
    // 如何区分=和>?
    // 因为in[0]和in[1]是整数,如果in[0]+1<in[1],则in[0]<=in[1]
    component comp = LessThan_k(k);
    comp.in[0]<==in[0];
    comp.in[1]<==in[1];
    comp.out==>out;

}

template GreaterThan(k) {
    signal input in[2];
    signal output out;  
    component comp = LessEqThan(k);
    comp.in[0]<==in[0];
    comp.in[1]<==in[1];
    1-comp.out==>out;
}

template GreaterEqThan(k){
    signal input in[2];
    signal output out;  
    component comp = LessThan_k(k);
    comp.in[0]<==in[0];
    comp.in[1]<==in[1];
    1-comp.out==>out;
}



// 所有in均只能是整数
component main = LessThan();

/* INPUT = {
    "in": ["2","5"]
} */
