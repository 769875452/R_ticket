var checkNumsLength=0;
var allNums=[];
handleCheckStart=()=>{
    allNums=[];
    checkNumsLength=$("input[name='checkNumers']:checked").val();

    checkNumsLength=6;
    var validNumsArr=[];
    for(let i=1;i<=37;i++){
        allNums.push(i);
    }
    $('input[name="notInNums"]:checked').each(function(){
        let allNumsLength=allNums.length;
        for(let i=0;i<allNumsLength;i++){
            if(allNums[i]==$(this).val()){
                allNums.splice(i,1);
                break;
            }
        }
    });
    console.log("需要筛选的数:",allNums)
    console.log("需要筛选的数的长度:",checkNumsLength);

    let allNumsLength=allNums.length;
    let numsArr=[];
    for(let i=0;i<checkNumsLength;i++){
        numsArr[i]=allNums[i];
    }
    while(true){
        console.log(numsArr)
        numsArr=handleAddNumByIndex(numsArr,(checkNumsLength-1))
        if(!numsArr){
            break;
        }
    }
}

handleAddNumByIndex=(numsArr,index)=>{
    if(numsArr[index]!=allNums[allNums.length-1]){
        numsArr[index]=getNextNum(numsArr[index]);
        return numsArr
    }else{
        if(index!=0){
            return nextArr(numsArr,index);
        }else{
            return false;
        }
    }
}

nextArr=(numsArr,index)=>{
    if(index==0){
        return false;
    }
    numsArr[index-1]=getNextNum(numsArr[index-1])
    for(let i=index;i<checkNumsLength;i++){
        numsArr[i]=getNextNum(numsArr[i-1]);
        if(!numsArr[i]){
            return nextArr(numsArr,index-1)
        }
    }
    return numsArr;
}

getNextNum=(num)=>{
    for(let i of allNums){
        if(i>num){
            return i;
        }
    }
    return false;
}