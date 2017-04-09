defmodule ContinumCheck do
  @moduledoc false

    def isContinum(index,nums) do
      ((elem nums,index+1)-(elem nums,index))==1
    end

    def nextContinum(index,count,nums,continumLength) when count >continumLength do
        false
    end

    def nextContinum(index,count,nums,continumLength) when (index+1)>=(tuple_size nums) do
      true
    end
  def nextContinum(index,count,nums,continumLength) do
    if isContinum index,nums do
      nextContinum(index+1,count+1,nums,continumLength)
    else
      nextContinum(index+1,1,nums,continumLength)
    end
  end




  def continumCheck(nums,continumLength) do
    nextContinum(0,1,nums,continumLength);
  end

end