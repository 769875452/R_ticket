defmodule EventLength do
  @moduledoc false
  ##检测是否为偶数
  def checkIsEven(num) do
    (rem num,2) ==0;
  end

  def checkIsEvenOverLengthByIndex(numbers,length,count,index) when index>=(tuple_size numbers)do
    IO.puts '结束了且应该没超出'
  end

  def checkIsEvenOverLengthByIndex(numbers,length,count,index) when count>=length do
       IO.puts '超出了'
  end

  def checkIsEvenOverLengthByIndex(numbers,length,count,index) do
       if checkIsEven(elem(numbers,index)) do
        checkIsEvenOverLengthByIndex(numbers,length,count+1,index+1)
       else
        checkIsEvenOverLengthByIndex(numbers,length,count,index+1)
       end
  end





  def checkIsEvenOverLength(numbers,length) do
    count=0;
    checkIsEvenOverLengthByIndex(numbers,length,count,0);
  end
end