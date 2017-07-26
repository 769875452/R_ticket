defmodule EvenLength do
  @moduledoc false
  ##检测是否为偶数
  def checkIsEven(num) do
    (rem num,2) ==0;
  end

  def checkIsEvenOverLengthByIndex(_,maxLength,count) when count>=maxLength do
     false
  end

  def checkIsEvenOverLengthByIndex(tlNums,_,_) when  tlNums==[] do
    true
  end


  def checkIsEvenOverLengthByIndex(tlNums,maxLength,count) do
        count=
       if (checkIsEven hd tlNums) do
        count+1
       else
        count
       end
       checkIsEvenOverLengthByIndex (tl tlNums),maxLength,count
  end


  def checkIsEvenOverLength(_,maxLength) when maxLength == nil do
    true
  end

  def checkIsEvenOverLength(nums,maxLength) do
    checkIsEvenOverLengthByIndex nums,maxLength,0;
  end
end