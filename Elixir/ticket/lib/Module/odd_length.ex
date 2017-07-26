defmodule OddLength do
@moduledoc false
  ##检测是否为奇数
  def checkIsOdd(num) do
    (rem num,2) == 1;
  end


  def checkIsOddOverLengthByIndex(_,maxLength,count) when count>=maxLength do
     false
  end

  def checkIsOddOverLengthByIndex(tlNums,_,_) when tlNums==[] do
    true
  end

  def checkIsOddOverLengthByIndex(tlNums,maxLength,count) do
  count=
       if checkIsOdd (hd tlNums) do
        count+1
       else
       count
       end
        checkIsOddOverLengthByIndex (tl tlNums),maxLength,count
  end


  def checkIsOddOverLength(_,maxLength) when maxLength == nil do
        true
  end

  def checkIsOddOverLength(nums,maxLength) do
    checkIsOddOverLengthByIndex nums,maxLength,0;
  end
end