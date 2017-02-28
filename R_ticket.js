

!
    function(window){
        Rticket={"version":"1.0",authon:"darkness,lqq"};
        window.Rticket=Rticket;
    }(window),
	function(Rticket){
		Rticket.ticket=function(arrNums){
			//传入一个数值oddLength
			//当数组内的奇数的数量大于该数值时，返回false
			//否则返回true
			this.numsArr=arrNums;
			this.setNumsArr=function(numsArr){
				this.numsArr=numsArr;
			}
			this.checkOddNumbers=function(oddLength){
				
			}
			//传入一个数值evenLength
			//当数组内的偶数的数量大于该数值时，返回false
			//否则返回true
			this.checkEvenNumbers=function(evenLength){
				
			}
			//传入一个最大值maxNums
			//当数组总和大于maxNums时，返回false
			//否则返回true
			this.checkSumNumbers=function(maxNums){
				
			}
			//传入一个连续的数值continuumLength
			//当该数组最后几位数为连续的数且，连续的数量大于等于continuumLength，返回false
			//否则返回true
			this.checkIsContinuum=function(continuumLength){
				
			}
			
			//传入一个段落对象
			//段落对象有3个属性 检查的个数(paragraphLength)，检查的数字数组(paragraphNums),排除还是包含(isSame:boolean)
			//isSame为在数组里是出现或非出现
			//paragraphLength为段落长度，
			//当出现或非出现的个数大于等于段落长度时返回false
			//否则返回true
			//整体数组之间的关系为&&（有一个为false，则直接返回false）
			this.checkParagraph=function(paragraphArr){
				
			}
		}
		
	}(Rticket)