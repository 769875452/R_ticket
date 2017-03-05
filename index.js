var checkNumsLength=0;
var allNums=[];
handleCheckStart=()=>{
    allNums=[];
    checkNumsLength=$("input[name='checkNumers']:checked").val();

    checkNumsLength=2;
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
    console.log("select nums:",allNums)
    console.log("select numsLength:",checkNumsLength);

    let allNumsLength=allNums.length;
    let numsArr=[];
    for(let i=0;i<checkNumsLength;i++){
        numsArr[i]=allNums[i];
    }
    var test=new Rticket.ticket(numsArr)
    while(true){
        test.setNumsArr(numsArr)
        let isValid=true;
        //if($("input[name='checkNumers']:checked").val()){
        //    isValid=test.checkIsContinuum();
        //}
        if($("input[name='oddRadio']:checked").val() && isValid){
            isValid=test.checkOddNumbers(parseInt($("input[name='oddNumbres']:checked").val()));

        }
        if($("input[name='evenRadio']:checked").val()  && isValid){
            isValid=test.checkEvenNumbers(parseInt($("input[name='evenNumbres']:checked").val()));
        }
        if(isValid){
            $('input[name="notInGroup"]:checked').each(function(){

                let sameLength=parseInt($(this).val());
                let checkNumsArr=[];
                $('input[name="notInNums_'+sameLength+'"]:checked').each(function(){
                    checkNumsArr.push(parseInt($(this).val()))
                })
                isValid=test.checkLastNumber(sameLength,checkNumsArr)
                if(!isValid){
                    return false;
                }
            })
        }

        if(isValid) {
            console.log(numsArr)
        }
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