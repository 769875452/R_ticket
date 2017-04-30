defmodule CheckInclude do
  @moduledoc false


  def checkIsInclude(_,_,count,maxCount) when count>=maxCount do
    IO.puts "check is include false"
    false
  end

  def checkIsInclude(_,checkNums,_,_) when checkNums == [] do
    true
  end

  def checkIsInclude(nums,checkNums,count,maxCount) when (hd nums) > (hd checkNums) do
    checkIsInclude (tl nums),checkNums,count,maxCount
  end

  def checkIsInclude(nums,checkNums,count,maxCount) when (hd nums) < (hd checkNums) do
     checkIsInclude nums,(tl checkNums),count,maxCount
  end

  def checkIsInclude(nums                   ,checkNums,count,maxCount) do
    checkIsInclude (tl nums),(tl checkNums),(count+1),maxCount
  end

  def checkInclude(_,checkNums,_) when is_nil checkNums do
    true
  end

  def checkInclude(nums,checkNums,maxCount) do
    checkIsInclude(nums,checkNums,0,maxCount)
  end
end