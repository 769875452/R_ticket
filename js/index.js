var checkNumsLength=0;
var allNums=[];
var test=new Rticket.ticket();
var validNumsArr=[];
var allNumsLength=1;
var isContinue=false;

websocket = new WebSocket("ws://127.0.0.1:8082/");
websocket.onopen = function(evt) {
    console.log("websocket success")
};
websocket.onclose = function(evt) {
    console.log("websocket fail")
};
websocket.onmessage = function(evt) {
    if(evt.data=="endOne"){
        console.log("完成一个")
        getdata()
    }else{
        validNumsArr.push(JSON.parse(evt.data));
    }
    // getdata()
};
websocket.onerror = function(evt) {
    console.log("websocket error",evt.data);
};
handleCheckStart=()=>{
    // allNums=[];
    // checkNumsLength=$("input[name='checkNumers']:checked").val() || 5;
    // for(let i=1;i<38;i++){
    //     allNums.push(i);
    // }
    let excludeNums=[]
    $('input[name="notInNums"]:checked').each(function(){
        excludeNums.push(parseInt($(this).val()));
    });
    $("input[name='notInNums_1']:checked").each(function(){
        let notInNumsValue=$(this).val().split("-");
        let notIncludeNum=notInNumsValue[1];
        for(let i=0;i<4;i++){
            let thisNum=(i*10)+parseInt(notIncludeNum);
            excludeNums.filter((num)=>{
                return num!=(thisNum)
            })
            excludeNums.push(thisNum);
        }
    });
    let option={};
    option.excludeNums=excludeNums;
    console.log(excludeNums)


    //连续数
    console.log($("input[name='checkNumbers']:checked").val())
    if($("input[name='checkNumbers']:checked").val()){
        let valueArr=$("input[name='checkNumbers']:checked").val().split("-");
        option.continumCheckValue=parseInt(valueArr[0])
        console.log(option)
    }

    //奇数偶数
    if($("input[name='oddNumbres']:checked").val()){
        option.oddNumbresCheckValue=parseInt($("input[name='oddNumbres']:checked").val())
    }
    if($("input[name='evenNumbres']:checked").val()){
        option.evenNumbresCheckValue=parseInt($("input[name='evenNumbres']:checked").val())
    }

    //尾数排除
    let checkNumsMap={};
    $('.notInNums:checked').each(function(){
        let notInNumsValue=$(this).val().split("-");
        let sameLength=notInNumsValue[0];
        if(parseInt(sameLength)===1){
            return true
        }
        if(!checkNumsMap[sameLength]){
            checkNumsMap[sameLength]=[]
        }
        let checkNums=notInNumsValue[1];
        checkNumsMap[sameLength].push(parseInt(checkNums));
    })
    for(let sameLength in checkNumsMap){
        option["laskNumberCheckNums"+sameLength]=checkNumsMap[sameLength];
    }

    $(".check-paragraph:checked").each(function(){
        let paragraphValue=$(this).val().split("-");
        let startValue=parseInt(paragraphValue[0]);
        let paragraphLength=parseInt(paragraphValue[1]);
        option["paragraphCount"+startValue]=paragraphLength
    })

    // 最小值最大值
    option.min=parseInt($("#largerThan").val())
    option.max=parseInt($("#smallerThan").val())






    websocket.send(JSON.stringify(option))
    // $("input[name='notInNums_1']:checked").each(function(){
    //     let notInNumsValue=$(this).val().split("-");
    //     let notIncludeNum=notInNumsValue[1];
    //     let allNumsLength=allNums.length;
    //     for(let i=0;i<allNumsLength;i++){
    //         if(allNums[i]%10==notIncludeNum){
    //             allNums.splice(i,1);
    //             break;
    //         }
    //     }
    // });
    //
    // let numsArr=[];
    // for(let i=0;i<checkNumsLength;i++){
    //     numsArr[i]=allNums[i];
    // }
    //
    // allNumsLength=1;
    // for(let i=0;i<checkNumsLength;i++){
    //     allNumsLength=allNumsLength*(allNums.length-i)/(i+1);
    // }
    // $(".filter-result-have").html(allNumsLength)
    // $(".filter-result-length").html(0);
    // mainLoop(numsArr);
}



function mainLoop(numsArr){
    allNumsLength--;
    if(!numsArr ||!isContinue){
    }else{
        $(".filter-result-length").html(validNumsArr.length);
        $(".filter-result-have").html(allNumsLength)
        $("#numsLength").html(validNumsArr.length);
        pageobj.setalldatacount(validNumsArr.length);
        if(validNumsArr.length>=(pageobj.pagenum-1)*pageobj.perpage && validNumsArr.length<(pageobj.pagenum)*pageobj.perpage){
            getdata();
        }
        window.setTimeout(function(){
            numsArr=getNestNumAndCheck(numsArr)
        },0)
    }
}
function getNestNumAndCheck(numsArr){
    let isValid=checkBySelect(numsArr);
    if(isValid) {
        validNumsArr.push(numsArr.concat([]))
    }
    numsArr=handleAddNumByIndex(numsArr,(checkNumsLength-1));
    mainLoop(numsArr);
}

checkBySelect=(numsArr)=>{
    test.setNumsArr(numsArr)
    let isValid=true;
    if(isValid && $("input[name='mustHave']:checked").val()){
        let checkNumsArr=$("#inputSelectNumber").val().split(",");
        isValid=test.checkIsHave(checkNumsArr);
    }

    //�����ų�
    if(isValid && $("input[name='oddNumbres']:checked").val()){
        isValid=test.checkOddNumbers(parseInt($("input[name='oddNumbres']:checked").val()));
    }
    //ż���ų�
    if(isValid && $("input[name='evenNumbres']:checked").val()){
        isValid=test.checkEvenNumbers(parseInt($("input[name='evenNumbres']:checked").val()));
    }

    //β��ɸѡ
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
        isValid=test.checkSumNumbers($("#largerThan").val())
    }
    if(isValid && $("#smallerThan").val()){
        isValid=!test.checkSumNumbers($("#smallerThan").val()-1)
    }


    //�ֶ�ɸѡ
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
    if(isValid && $("input[name='simpleNums']:checked").val()){
        let checkNumsArr=$("#inputSelectNumber").val().split(",");
        isValid=test.checkParagraph([{paragraphLength:parseInt($("input[name='simpleNums']:checked").val()),paragraphNums:checkNumsArr,isInclude:true}])
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