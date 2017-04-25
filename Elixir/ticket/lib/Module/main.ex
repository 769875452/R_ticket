defmodule Main do
  @moduledoc false

  @checkNumsLength 4
  @result []


  def main(option,client) do
    allNums=setNumToAll([],[],1)
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
      mainLoop (getStartNums (tl tlNums),[],1),[],allNums,(hd tlNums),option,client
      startNewLoop allNums,(tl tlNums),option,client
  end

  def startNewLoop(allNums,option,client) do

#    spawn(
#        fn ->
         mainLoop (getStartNums (tl allNums),[],1),[],allNums,(hd allNums),option,client
#         end
#     )
#     receive do
#       {^pid,result}->
#       for nums<-result do
#               iOPUTLIST nums
#       end
#     end
     startNewLoop allNums,(tl allNums),option,client
  end




  def mainLoop(checkNums,result,allNums,staticNum,option,client) do
     result=result ++ [checkNums++[staticNum]]
     iOPUTLIST (checkNums++[staticNum])

    {status, jsonResult} = JSON.encode(checkNums++[staticNum])
     client |> Socket.Web.send! ({ :text, jsonResult })
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













  def setNumToAll(allNums,excludeNums,now) when now >10 do
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