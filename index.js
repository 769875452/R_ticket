var checkNumsLength=0;
var allNums=[];
var test=new Rticket.ticket();
var validNumsArr=[];

handleCheckStart=()=>{
    allNums=[];
    checkNumsLength=$("input[name='checkNumers']:checked").val() || 5;

    for(let i=1;i<37;i++){
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

    let allNumsLength=allNums.length;
    let numsArr=[];
    for(let i=0;i<checkNumsLength;i++){
        numsArr[i]=allNums[i];
    }
    while(true){
        let isValid=checkBySelect(numsArr);
        if(isValid) {
            validNumsArr.push(numsArr.concat([]))
        }
        numsArr=handleAddNumByIndex(numsArr,(checkNumsLength-1))
        if(!numsArr || validNumsArr.length>=1000){
            break;
        }
    }
}

checkBySelect=(numsArr)=>{
    test.setNumsArr(numsArr)

    let isValid=true;
    //ÆæÊýÅÅ³ý
    if(isValid && $("input[name='oddNumbres']:checked").val()){
        isValid=test.checkOddNumbers(parseInt($("input[name='oddNumbres']:checked").val()));
    }
    //Å¼Êý
    if(isValid && $("input[name='evenNumbres']:checked").val()){
        isValid=test.checkEvenNumbers(parseInt($("input[name='evenNumbres']:checked").val()));
    }
    //Á¬ºÅÉ¾³ý
    if(isValid &&  $("input[name='checkNumbers']:checked").val()){
        let valueArr=$("input[name='checkNumbers']:checked").val().split("-");
        isValid=test.checkIsAnyContinuum(parseInt(valueArr[0]),parseInt(valueArr[1]))

    }



    //Î²ÊýÉ¸Ñ¡
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


    //·Ö¶ÎÉ¸Ñ¡
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
    return isValid;
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