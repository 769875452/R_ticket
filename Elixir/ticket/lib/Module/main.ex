defmodule Main do
  @moduledoc false

  @checkNumsLength 6
  @result []


  def main(option,client) do
    allNums=setNumToAll([],option["excludeNums"],1)
    startNewLoop(allNums,option,client)
  end

  def main do
    excludeNums=[]
    allNums=setNumToAll([],excludeNums,1)
#    checkNums=(getStartNums allNums,@checkNumsLength,[],1)

#    startNewLoop(allNums)

#    result=mainLoop(checkNums,[],allNums)
#    IO.puts "result-------------------"
#    for nums<-result do
#        iOPUTLIST nums
#    end
#    IO.puts "result++++++++++"
#    result
  end


  def startNewLoop(allNums,tlNums,option,client) when tlNums==[] do
    false
  end

  def startNewLoop(allNums,tlNums,option,client) when (length tlNums) <= @checkNumsLength do
    false
  end

  def startNewLoop(allNums,tlNums,option,client) do

    spawn(
        fn ->
            mainLoop (getStartNums (tl tlNums),[],1),[],allNums,(hd tlNums),option,client
         end
     )
     startNewLoop allNums,(tl tlNums),option,client
  end

  def startNewLoop(allNums,option,client) do
    spawn(
        fn ->
         mainLoop (getStartNums (tl allNums),[],1),[],allNums,(hd allNums),option,client
         end
     )
     startNewLoop allNums,(tl allNums),option,client
  end


  def checkLoop(checkNums,option) do
      ContinumCheck.continumCheck(checkNums,option["continumCheckValue"]) &&
      OddLength.checkIsOddOverLength(checkNums,option["oddNumbresCheckValue"]) &&
      EvenLength.checkIsEvenOverLength(checkNums,option["evenNumbresCheckValue"]) &&
      CheckLastNum.checkLastNum(checkNums,2,option["laskNumberCheckNums2"]) &&
      CheckLastNum.checkLastNum(checkNums,3,option["laskNumberCheckNums3"]) &&
      CheckParagraphNumsCount.checkParagraphNumsCount(checkNums,0,option["paragraphCount0"]) &&
      CheckParagraphNumsCount.checkParagraphNumsCount(checkNums,1,option["paragraphCount1"]) &&
      CheckParagraphNumsCount.checkParagraphNumsCount(checkNums,2,option["paragraphCount2"]) &&
      CheckParagraphNumsCount.checkParagraphNumsCount(checkNums,3,option["paragraphCount3"]) &&
      SumCheck.sumCheck(checkNums,option["min"],option["max"]) &&
      CheckInclude.checkInclude(checkNums,option["includeNums"],option["includeLength"]) &&
      CheckInclude.isAtLeastOne(checkNums,option["includeNums"],option["isAtLeast"])
  end

  def mainLoop(checkNums,result,allNums,staticNum,option,client) do
    tempNums=checkNums++[staticNum]
     result=result ++ [tempNums]
#     iOPUTLIST (checkNums++[staticNum])
    if(checkLoop(tempNums,option)) do
        {status, jsonResult} = JSON.encode(tempNums)
         client |> Socket.Web.send! ({ :text, jsonResult })
       else
    end
#     IO.puts lengtsh result
     nextNums=getNextNums(checkNums,allNums,true)
     result=
     if (nextNums)!=false do
       mainLoop nextNums,(result),allNums,staticNum,option,client
       else
#        iOPUTLIST @result
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


















  def getStartNums(tlAllNums,nums,nowLength) when tlAllNums==[] do
    nums
  end

  def getStartNums(tlAllNums,nums,nowLength) when nowLength>@checkNumsLength do
    nums
  end

  def getStartNums(allNums,nums,nowLength) do
    getStartNums (tl allNums),[(hd allNums)]++nums,nowLength+1
  end













  def setNumToAll(allNums,excludeNums,now) when now >37 do
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
    IO.puts is_integer(now)
    IO.puts is_integer(hd excludeNums)
    IO.puts now ==(hd excludeNums)
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