var checkNumsLength=0;
var allNums=[];
handleCheckStart=()=>{
    allNums=[];
    checkNumsLength=$("input[name='checkNumers']:checked").val();

    checkNumsLength=6;
    var validNumsArr=[];
    for(let i=1;i<=36;i++){
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
        //奇数排除
        if($("input[name='oddNumbres']:checked").val() && isValid){
            isValid=test.checkOddNumbers(parseInt($("input[name='oddNumbres']:checked").val()));

        }
        //偶数
        if($("input[name='evenNumbres']:checked").val()  && isValid){
            isValid=test.checkEvenNumbers(parseInt($("input[name='evenNumbres']:checked").val()));
        }
        //尾数筛选
        if(isValid){
            let checkNumsMap={};
            $('.notInNums:checked').each(function(){
                let notInNumsValue=$(this).val().split("-");
                let sameLength=notInNumsValue[0];
                if(!checkNumsMap[sameLength]){
                    checkNumsMap[sameLength]=[]
                }
                let checkNums=notInNumsValue[1];
                checkNumsMap[sameLength].push(parseInt(checkNums));
            })
            for(let checkNum in checkNumsMap){
                isValid=test.checkLastNumber(checkNum,checkNumsMap[checkNum])
                if(!isValid){
                    break;
                }
            }
        }
        if(isValid && $("#largerThan").val()){
            isValid=!test.checkSumNumbers($("#largerThan").val())
        }
        if(isValid && $("#smallerThan").val()){
            isValid=test.checkSumNumbers($("#smallerThan").val()-1)
        }


        //分段筛选
        if(isValid){
            $(".check-paragraph:checked").each(function(){
                let paragraphValue=$(this).val().split("-");
                let startValue=parseInt(paragraphValue[0]);
                let paragraphLength=parseInt(paragraphValue[1]);
                isValid=test.checkContinuumParagraph(startValue,paragraphLength)
                if(!isValid){
                    return false;
                }
            })
        }

        if(isValid) {
            console.log(numsArr)
            //console.log(numsArr,isValid,$("#largerThan").val(),test.checkSumNumbers($("#largerThan").val()))
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