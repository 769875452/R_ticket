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


  def sumCheck(nums,max) do
    (getSum nums) > max
  end
end