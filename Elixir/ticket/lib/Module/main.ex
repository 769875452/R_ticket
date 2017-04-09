defmodule Main do
  @moduledoc false
  def getNextNum(num,waitNums,index) when (elem waitNums,index)>num do
    num
  end

  def getNextNum(num,waitNums,index) when index>=(tuple_size waitNums) do
    false
  end

  def getNextNum(num,waitNums,index) do
    getNextNum(num,waitNums,index+1)
  end




  def getStartNum(allLength,waitNums) do
    generateNum(0,{},allLength,waitNums)
  end

  def generateNum(index,nums,allLength,waitNums) when index<allLength do
    nums=Tuple.append nums,(elem waitNums,index)

    generateNum(index+1,nums,allLength,waitNums)
  end

  def printTuple(tuple) do
      IO.write "{ "
    for value <- Tuple.to_list(tuple) do
      IO.write "#{value},"
    end
    IO.write "}\n"
  end

  def generateNum(_,nums,_,_) do
  printTuple nums
    nums
  end

#  def nextNumsBySubIndex(nums,index) do
#    if index==0 do
#      false
#    end
#    (elem nums,index-1)=getNextNum (elem nums,index-1),nums,0
#    resetNumsByPrevIndex nums,index+1;
#  end
#
#  def resetNumsByPrevIndex(nums,index)do
#    if index<tuple_size nums do
#      (elem nums,index)=getNextNum (elem nums,index-1),nums,0
#      if !elem nums,index do
#        nextNumsBySubIndex(nums,index-2);
#      else
#        resetNumsByPrevIndex(nums,index+1)
#      end
#    end
#    nums
#  end

end