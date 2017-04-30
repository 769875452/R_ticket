defmodule CheckLastNum do
  @moduledoc false

  def checkIsLastNum(num,checkNum)do
    (rem num,10)==checkNum
  end

    def checkNumsIsOverflowCheckNum(nums,sameLength,checkNums,tlNums,tlCheckNums,count) when count >= sameLength do
      IO.puts "check last num false"
      false
    end

    def checkNumsIsOverflowCheckNum(nums,sameLength,checkNums,tlNums,tlCheckNums,count) when tlNums==[] do
        checkNumsIsOverflowCheckNum(nums,sameLength,checkNums,nums,(tl tlCheckNums),0)
    end

    def checkNumsIsOverflowCheckNum(nums,sameLength,checkNums,tlNums,tlCheckNums,count) when tlCheckNums==[] do
        true;
    end

  def checkNumsIsOverflowCheckNum(nums,sameLength,checkNums,tlNums,tlCheckNums,count)do
  count=
     if checkIsLastNum (hd tlNums),(hd tlCheckNums) do
        count+1
     else
        count
     end
     checkNumsIsOverflowCheckNum(nums,sameLength,checkNums,(tl tlNums),tlCheckNums,count)
  end

  def checkLastNum(_,_,checkNums) when (checkNums == nil) do
    true
  end


  def checkLastNum(nums,sameLength,checkNums) do
        checkNumsIsOverflowCheckNum(nums,sameLength,checkNums,nums,checkNums,0);
  end
end