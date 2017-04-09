defmodule CheckParagraphNumsCount do
  @moduledoc false

 def checkIsInRange(num,startNum,endNum) do
    num>=startNum && num <=endNum
  end

  def nextCheckInRange(nums,_,endNum,_,index,count) when (elem nums,index)>endNum  do
    true
  end

  def nextCheckInRange(nums,_,_,_,index,_) when index>=(tuple_size nums)  do
    true
  end

  def nextCheckInRange(_,_,_,maxCount,_,count) when count >=maxCount do
    false
  end

    def nextCheckInRange(nums,startNum,endNum,maxCount,index,count) do
        if checkIsInRange (elem nums,index),startNum,endNum do
          nextCheckInRange nums,startNum,endNum,maxCount,index+1,count+1;
          else
          nextCheckInRange nums,startNum,endNum,maxCount,index+1,count;
        end
    end

  def checkParagraphNumsCount(nums,start,maxCount) do
	startNum=start*10+1;
    endNum=(start+1)*10;
    nextCheckInRange nums,startNum,endNum,maxCount,0,0
  end
end