defmodule SumCheck do
  @moduledoc false
  def getSumStep(tlNums,sum) when tlNums==[] do
    sum
  end
  def getSumStep(tlNums,sum)do
    getSumStep (tl tlNums),sum+(hd tlNums)
  end
  def getSum(nums) do
    getSumStep nums,0
  end

  def sumCheck(nums,min,max) when max ==nil do
     ((getSum nums) > min)
  end

  def sumCheck(nums,min,max) when min == nil do
    ((getSum nums) < max)
  end

  def sumCheck(nums,min,max) do
    ((getSum nums) < max) and ((getSum nums) > min)
  end
end