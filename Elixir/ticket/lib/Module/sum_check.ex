defmodule SumCheck do
  @moduledoc false
  def getSumStep(nums,sum,index) when index>=(tuple_size nums) do
    sum
  end
  def getSumStep(nums,sum,index)do
    getSumStep nums,sum+(elem nums,index),index+1
  end
  def getSum(nums) do
    getSumStep nums,0,0
  end


  def sumCheck(nums,max) do
    (getSum nums) > max
  end
end