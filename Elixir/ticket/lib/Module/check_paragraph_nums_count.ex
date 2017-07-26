defmodule CheckParagraphNumsCount do
  @moduledoc false

 def checkIsInRange(num,startNum,endNum) do
    num>=startNum && num <=endNum
  end

  def nextCheckInRange(_,_,_,maxCount,_,count) when count >maxCount do
    false
  end

#  def nextCheckInRange(_,endNum,_,tlNums,_) when (hd tlNums)>endNum  do
#    true
#  end


  def nextCheckInRange(_,_,minCount,_,tlNums,count) when (tlNums==[] and is_nil(minCount))  do
    true
  end
  def nextCheckInRange(_,_,minCount,_,tlNums,count) when tlNums==[]  do
    if count>=minCount do
      true
      else
      false
    end
  end


    def nextCheckInRange(startNum,endNum,minCount,maxCount,tlNums,count) do
    count=
        if checkIsInRange (hd tlNums),startNum,endNum do
            count+1
        else
            count
        end
        nextCheckInRange startNum,endNum,minCount,maxCount,(tl tlNums),count;
    end


  def checkParagraphNumsCount(_,_,minCount,maxCount) when (is_nil(minCount) and is_nil(maxCount==nil)) do
    true
  end
  def checkParagraphNumsCount(nums,start,minCount,maxCount) do
	startNum=start*10+1;
    endNum=(start+1)*10;
    nextCheckInRange startNum,endNum,minCount,maxCount,nums,0
  end
end
