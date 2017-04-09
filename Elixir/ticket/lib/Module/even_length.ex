defmodule EvenLength do
  @moduledoc false
  ##检测是否为偶数
  def checkIsEven(num) do
    (rem num,2) ==0;
  end

  def checkIsEvenOverLengthByIndex(numbers,_,_,index) when index>=(tuple_size numbers)do
    true
  end

  def checkIsEvenOverLengthByIndex(_,length,count,_) when count>=length do
     false
  end

  def checkIsEvenOverLengthByIndex(numbers,length,count,index) do
       if (checkIsEven elem numbers,index) do
        checkIsEvenOverLengthByIndex numbers,length,count+1,index+1
       else
        checkIsEvenOverLengthByIndex numbers,length,count,index+1
       end
  end

  def checkIsEvenOverLength(numbers,length) do
    count=0;
    checkIsEvenOverLengthByIndex numbers,length,count,0;
  end
end