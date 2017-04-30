defmodule CheckInclude do
  @moduledoc false


  def checkIsInclude(_,_,count,maxCount) when count>=maxCount do
    IO.puts "check is include false"
    false
  end

  def checkIsInclude(_,checkNums,_,_,atLeast) when checkNums == [] do
  if(!atLeast) do
    IO.puts "check is include ---false"
  end
    atLeast
  end

  def checkIsInclude(nums,checkNums,count,maxCount,atLeast) when (hd nums) > (hd checkNums) do
    checkIsInclude (tl nums),checkNums,count,maxCount,atLeast
  end

  def checkIsInclude(nums,checkNums,count,maxCount,atLeast) when (hd nums) < (hd checkNums) do
     checkIsInclude nums,(tl checkNums),count,maxCount,atLeast
  end

  def checkIsInclude(nums,checkNums,count,maxCount,atLeast) do
    checkIsInclude (tl nums),(tl checkNums),(count+1),maxCount,true
  end

  def checkInclude(_,checkNums,_,atLeast) when is_nil checkNums do
    true
  end


  def checkInclude(nums,checkNums,maxCount,atLeast) when is_nil(atLeast) do
    IO.puts "快四十了?"
    checkIsInclude(nums,checkNums,0,maxCount,true)
  end

  def checkInclude(nums,checkNums,maxCount,atLeast) when is_nil(maxCount) do
    checkIsInclude(nums,checkNums,0,999,false)
  end

  def checkInclude(nums,checkNums,maxCount,atLeast) do
    checkIsInclude(nums,checkNums,0,maxCount,false)
  end


end