defmodule ContinumCheck do
  @moduledoc false

    def isContinum(nums) do
      (hd nums)-(hd (tl nums))==1
    end

    def nextContinum(count,_,continumLength) when count >=continumLength do
        IO.puts "check continum false"
        false
    end

    def nextContinum(_,tlNums,_) when (tl tlNums)==[] do
      true
    end

  def nextContinum(count,tlNums,continumLength) do
    count=
    if (isContinum tlNums) do
        count+1
    else
        1
    end
    nextContinum(count,(tl tlNums),continumLength)
  end




  def continumCheck(_,continumLength) when continumLength == nil do
    true
  end

  def continumCheck(nums,continumLength) do
    nextContinum(1,nums,continumLength);
  end

end