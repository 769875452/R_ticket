defmodule CheckParagraphNumsCount do
  @moduledoc false

 def checkIsInRange(num,startNum,endNum) do
    num>=startNum && num <=endNum
  end

  def nextCheckInRange(_,endNum,_,tlNums,count) when (hd tlNums)>endNum  do
    true
  end

  def nextCheckInRange(_,_,_,tlNums,_) when tlNums==[]  do
    true
  end

  def nextCheckInRange(_,_,maxCount,_,count) when count >=maxCount do
    false
  end

    def nextCheckInRange(startNum,endNum,maxCount,tlNums,count) do
    count=
        if checkIsInRange (hd tlNums),startNum,endNum do
            count+1
        else
            count
        end
        nextCheckInRange startNum,endNum,maxCount,(tl tlNums),count;
    end

  def checkParagraphNumsCount(nums,start,maxCount) do
	startNum=start*10+1;
    endNum=(start+1)*10;
    nextCheckInRange startNum,endNum,maxCount,nums,0
  end
end