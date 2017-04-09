defmodule CheckLastNum do
  @moduledoc false

  def checkIsLastNum(num,checkNum)do
    (rem num,10)==checkNum
  end

    def checkNumsIsOverflowCheckNum(nums,sameLength,index,checkNums,checkNumsIndex,count) when count >= sameLength do
      false
    end

    def checkNumsIsOverflowCheckNum(nums,sameLength,index,checkNums,checkNumsIndex,count) when index >= (tuple_size nums) do
        checkNumsIsOverflowCheckNum(nums,sameLength,0,checkNums,checkNumsIndex+1,0)
    end

    def checkNumsIsOverflowCheckNum(nums,sameLength,index,checkNums,checkNumsIndex,count) when checkNumsIndex >= (tuple_size checkNums) do
        true;
    end

  def checkNumsIsOverflowCheckNum(nums,sameLength,index,checkNums,checkNumsIndex,count)do
     if checkIsLastNum (elem nums,index),(elem checkNums,checkNumsIndex)do
       checkNumsIsOverflowCheckNum(nums,sameLength,index+1,checkNums,checkNumsIndex,count+1)
     else
       checkNumsIsOverflowCheckNum(nums,sameLength,index+1,checkNums,checkNumsIndex,count)
     end
  end


  def checkLastNum(nums,sameLength,checkNums) do
        checkNumsIsOverflowCheckNum(nums,sameLength,0,checkNums,0,0);
  end
end