defmodule Main do
  @moduledoc false

  def main do
    excludeNums=[]
    allNums=setNumToAll([],excludeNums,1)
    checkNumsLength=7;
    checkNums=(getStartNums allNums,checkNumsLength,[],1)
    result=mainLoop(checkNums,[],allNums)
    IO.puts "result-------------------"
    for nums<-result do
        iOPUTLIST nums
    end
    result
  end

  def mainLoop(checkNums,result,allNums) do

     iOPUTLIST checkNums
     result=result ++ [checkNums]

     nextNums=getNextNums(checkNums,allNums,true)
     if (nextNums)!=false do
       result=mainLoop(nextNums,(result),allNums)
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


















  def getStartNums(tlAllNums,checkNumsLength,nums,nowLength) when tlAllNums==[] do
    nums
  end

  def getStartNums(tlAllNums,checkNumsLength,nums,nowLength) when nowLength>checkNumsLength do
    nums
  end

  def getStartNums(allNums,checkNumsLength,nums,nowLength) do
    getStartNums (tl allNums),checkNumsLength,[(hd allNums)]++nums,nowLength+1
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
    setNumToAll (allNums ++ [now]),excludeNums,now+1
  end

  def iOPUTLIST(list) do
  IO.write "["
    for value<-list do
      IO.write value
      IO.write ","
    end
    IO.write "]"
    IO.puts "------------"
  end

end