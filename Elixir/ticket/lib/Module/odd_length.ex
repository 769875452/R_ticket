defmodule OddLength do
@moduledoc false
  ##检测是否为奇数
  def checkIsOdd(num) do
    (rem num,2) == 1;
  end

  def checkIsOddOverLengthByIndex(numbers,length,count,index) when index>=(tuple_size numbers)do
    true
  end

  def checkIsOddOverLengthByIndex(numbers,length,count,index) when count>=length do
     false
  end

  def checkIsOddOverLengthByIndex(numbers,length,count,index) do
       if (checkIsOdd elem numbers,index) do
        checkIsOddOverLengthByIndex numbers,length,count+1,index+1
       else
        checkIsOddOverLengthByIndex numbers,length,count,index+1
       end
  end

  def checkIsOddOverLength(numbers,length) do
    count=0;
    checkIsOddOverLengthByIndex numbers,length,count,0;
  end
end