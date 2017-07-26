defmodule Main do
  @moduledoc false

  @checkNumsLength 6
  @result []

  def main(option,client) do
    allNums=setNumToAll([],option["excludeNums"],1)
    if(is_nil(option["allNumsArray"]))do
    startNewLoop(allNums,option,client)
    else
    loopByArray(option["allNumsArray"],option,client,[],0)
    end

  end

def main do
    excludeNums=[]
    allNums=setNumToAll([],excludeNums,1)
  end


  def startNewLoop(_,tlNums,_,_,_) when tlNums==[] do
    false
  end

  def startNewLoop(_,tlNums,_,_,maxLength) when (length tlNums) <= maxLength do
    false
  end

  def startNewLoop(allNums,tlNums,option,client,maxLength) do

    spawn(
        fn ->
            mainLoop (getStartNums (tl tlNums),[],1, option["checkNumsLength"] ),[],allNums,(hd tlNums),option,client,0
         end
     )
     startNewLoop allNums,(tl tlNums),option,client,maxLength
  end
  def startNewLoop(allNums,option,client) do
    spawn(
        fn ->
         mainLoop (getStartNums (tl allNums),[],1, option["checkNumsLength"] ),[],allNums,(hd allNums),option,client,0
         end
     )
     startNewLoop allNums,(tl allNums),option,client,option["checkNumsLength"]
  end


  def checkLoop(checkNums,option) do
      ContinumCheck.continumCheck(checkNums,option["continumCheckValue"]) &&
      OddLength.checkIsOddOverLength(checkNums,option["oddNumbresCheckValue"]) &&
      EvenLength.checkIsEvenOverLength(checkNums,option["evenNumbresCheckValue"]) &&
      CheckLastNum.checkLastNum(checkNums,2,option["laskNumberCheckNums2"]) &&
      CheckLastNum.checkLastNum(checkNums,3,option["laskNumberCheckNums3"]) &&
      CheckParagraphNumsCount.checkParagraphNumsCount(checkNums,0,option["paragraphCount0start"],option["paragraphCount0end"]) &&
      CheckParagraphNumsCount.checkParagraphNumsCount(checkNums,1,option["paragraphCount1start"],option["paragraphCount1end"]) &&
      CheckParagraphNumsCount.checkParagraphNumsCount(checkNums,2,option["paragraphCount2start"],option["paragraphCount2end"]) &&
      CheckParagraphNumsCount.checkParagraphNumsCount(checkNums,3,option["paragraphCount3start"],option["paragraphCount3end"]) &&
      SumCheck.sumCheck(checkNums,option["min"],option["max"]) &&
      CheckInclude.checkInclude(checkNums,option["includeNums"],option["includeLength"],option["isAtLeast"])
  end

    def loopByArray(allNumsArr,_,client,result,_) when allNumsArr==[] do
        {status, jsonResult} = JSON.encode(result)
         client |> Socket.Web.send! ({ :text, jsonResult })
  end

  def loopByArray(allNumsArr,option,client,result,resultLength) do
    result=
    if(checkLoop((hd allNumsArr),option)) do
        result ++ [hd allNumsArr]
        else
        result
    end

    resultLength=
    if(resultLength == 3000) do
        {status, jsonResult} = JSON.encode(result)
         client |> Socket.Web.send! ({ :text, jsonResult })
        0
        else
        resultLength+1
    end
    result=
    if(resultLength == 0) do
        []
        else
        result
    end
    loopByArray((tl allNumsArr),option,client,result,resultLength)

  end

  def mainLoop(checkNums,result,allNums,staticNum,option,client,resultLength) do
    tempNums=checkNums++[staticNum]
#     iOPUTLIST (checkNums++[staticNum])
    result=
    if(checkLoop(tempNums,option)) do
        result ++ [tempNums]
        else
        result
    end

    resultLength=
    if(resultLength == 3000) do
        {status, jsonResult} = JSON.encode(result)
         client |> Socket.Web.send! ({ :text, jsonResult })
        0
        else
        resultLength+1
    end

    result=
    if(resultLength == 0) do
        []
        else
        result
    end
     nextNums=getNextNums(checkNums,allNums,true)
     result=
     if (nextNums)!=false do
       mainLoop nextNums,(result),allNums,staticNum,option,client,resultLength
       else
#        iOPUTLIST @result
        {status, jsonResult} = JSON.encode(result)
         client |> Socket.Web.send! ({ :text, jsonResult })

       result
     end
     result
  end








  def getNextNums(checkNums,_,_) when checkNums==[] do
    false
  end

  def getNextNums(checkNums,allNums,isMainLoop) do
    firstNum=hd checkNums;
    checkNums=tl checkNums;
    nextNum=getNextNum(firstNum,allNums)
    checkNums=
    if (nextNum) !=false do
      [nextNum]++checkNums
    else
      getNextNumsAndAddFirst checkNums,allNums
    end
    if checkNums != false do
      checkNums
      else
      false
    end
  end

  def getNextNumsAndAddFirst(checkNums,allNums) do
     nextNums=getNextNums checkNums,allNums,false
     if nextNums != false do
        firstNum=getNextNum (hd nextNums),allNums
        if firstNum !=false do
          [firstNum] ++ nextNums
          else
          getNextNumsAndAddFirst(nextNums,allNums)
        end
       else
       false
     end
  end









  def getNextNum(lastNum,tlNums) when lastNum != (hd tlNums) do
    getNextNum(lastNum,(tl tlNums))
  end


  def getNextNum(lastNum,tlNums) when (tlNums)==[] do
    false
  end

  def getNextNum(lastNum,tlNums) when (tl tlNums)==[] do
    false
  end

  def getNextNum(lastNum,tlNums) do
    hd (tl tlNums)
  end


















  def getStartNums(tlAllNums,nums,nowLength,_) when tlAllNums==[] do
    nums
  end

  def getStartNums(_,nums,nowLength,maxLength) when nowLength>maxLength do
    nums
  end

  def getStartNums(allNums,nums,nowLength,maxLength) do
    getStartNums (tl allNums),[(hd allNums)]++nums,nowLength+1,maxLength
  end













  def setNumToAll(allNums,_,now) when now >37 do
    allNums
  end

  def setNumToAll(allNums,excludeNums,now) when excludeNums == [] do
    setNumToAll (allNums ++ [now]),[],now+1
  end

  def setNumToAll(allNums,excludeNums,now) when now == (hd excludeNums) do
    setNumToAll allNums,(tl excludeNums),now+1
  end
  def setNumToAll(allNums,excludeNums,now) do
#  iOPUTLIST excludeNums;
    setNumToAll (allNums ++ [now]),excludeNums,now+1
  end

  def iOPUTLIST(list) do

  IO.write "["
    for value<-list do
      IO.write value
      IO.write ","
    end
    IO.write "]"
    IO.puts "-----------------------------"
  end

end
