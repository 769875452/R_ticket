defmodule Main do
  @moduledoc false


  def main do
    excludeNums=[]
    allNums=setNumToAll([],excludeNums,1)
    checkNumsLength=2;
#    checkNums=(getStartNums allNums,checkNumsLength,[],1)
    startNewLoop(allNums,checkNumsLength)
#    result=mainLoop(checkNums,[],allNums)
#    IO.puts "result-------------------"
#    for nums<-result do
#        iOPUTLIST nums
#    end
#    IO.puts "result++++++++++"
#    result
  end

    def startNewLoop(checkNums,allNums,tlNums) when tlNums==[] do
      false
    end

  def startNewLoop(allNums,checkNumsLength,tlNums) do
      mainLoop (getStartNums (tl tlNums),checkNumsLength,[],1),[],allNums,(hd tlNums)
      startNewLoop allNums,checkNumsLength,(tl tlNums)
  end

  def startNewLoop(allNums,checkNumsLength) do

#    spawn(
#        fn ->
         mainLoop (getStartNums (tl allNums),checkNumsLength,[],1),[],allNums,(hd allNums)
#         end
#     )
#     receive do
#       {^pid,result}->
#       for nums<-result do
#               iOPUTLIST nums
#       end
#     end
     startNewLoop allNums,checkNumsLength,(tl allNums)
  end




  def mainLoop(checkNums,result,allNums,staticNum) do
     result=result ++ [checkNums++[staticNum]]
     iOPUTLIST (checkNums++[staticNum])
#     IO.puts length result
     nextNums=getNextNums(checkNums,allNums,true)
     result=
     if (nextNums)!=false do
       mainLoop(nextNums,(result),allNums,staticNum)
       else
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


















  def getStartNums(tlAllNums,checkNumsLength,nums,nowLength) when tlAllNums==[] do
    nums
  end

  def getStartNums(tlAllNums,checkNumsLength,nums,nowLength) when nowLength>checkNumsLength do
    nums
  end

  def getStartNums(allNums,checkNumsLength,nums,nowLength) do
    getStartNums (tl allNums),checkNumsLength,[(hd allNums)]++nums,nowLength+1
  end













  def setNumToAll(allNums,excludeNums,now) when now >5 do
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
    IO.puts "-----------------------------"
  end

end