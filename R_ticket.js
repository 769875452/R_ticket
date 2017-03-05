

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
				var count=0;
				for (var i = 0; i < this.numsArr.length; i++) {
					if (this.numsArr[i]%2!=0) {
						count++;
					}
				}
				if (count>=oddLength) {
					return false;
				}
				return true;
			}
			//传入一个数值evenLength
			//当数组内的偶数的数量大于该数值时，返回false
			//否则返回true
			this.checkEvenNumbers=function(evenLength){
				var count=0;
				for (var i = 0; i < this.numsArr.length; i++) {
					if (this.numsArr[i]%2==0) {
						count++;
					}
				}
				if (count>=evenLength) {
					return false;
				}
				return true;
				
			}
			//传入一个最大值maxNums
			//当数组总和大于maxNums时，返回false
			//否则返回true
			this.checkSumNumbers=function(maxNums){
				var sum=0;
				for(var i=0;i<this.numsArr.length;i++){
					sum+=this.numsArr[i];
				}
				if(sum>maxNums){
					return false;
				}
				return true;
				
			}
			//传入一个连续的数值continuumLength
			//当该数组最后几位数为连续的数且，连续的数量大于等于continuumLength，返回false
			//否则返回true
			this.checkIsContinuum=function(continuumLength){
				var count=1;
				let numsArrLength=this.numsArr.length
				for(var i=1;i<numsArrLength;i++){
					if(this.numsArr[numsArrLength-i]-this.numsArr[numsArrLength-(i+1)]==1){
						count++;						
						if(count>=continuumLength){
							return false;
						}
					}else{
						break;
					}
				}
				return true;
			}
			
			//传入一个数组，数组内有如下格式的段落对象
		
			//段落对象有3个属性 检查的个数(paragraphLength)，检查的数字数组(paragraphNums),排除还是包含(isInclude:boolean)
			//isSame为在数组里是出现或非出现
			//paragraphLength为段落长度，
			//当出现或非出现的个数大于等于段落长度时返回false
			//否则返回true
			//整体数组之间的关系为&&（有一个为false，则直接返回false）
			
			
			this.checkParagraph=function(paragraphArr){
				for(let paragraph of paragraphArr){
					console.log(paragraph)
					var count=0;
					let numsArrLength=this.numsArr.length;
					let paragraphNumsLength=paragraph.paragraphNums.length;
					for(var i=0;i<numsArrLength;i++){
						let paragraphLen=paragraph.paragraphNums.length;
						for(var j=(paragraphLen-1);j>=0;j--){
							if(this.numsArr[i]==paragraph.paragraphNums[j]){
								count++;
								if(paragraph.isInclude){
									if(count>=paragraph.paragraphLength){
										return false;
									}
								}else{
									if(paragraphNumsLength-count>=paragraph.paragraphLength){
										return false;
									}
								}
								paragraph.paragraphNums.splice(j,1);
								break;
							}
						}
					}
				}
				return true;
			}
			this.checkLastNumber=function(sameLength,checkNumsArr){
				let numsArrLength=this.numsArr.length;
				let checkNumsArrLength=checkNumsArr.length;
				for(let j=0;j<checkNumsArrLength;j++){
					let thisCheckNumsLength=0;
					for(let i=0;i<numsArrLength;i++){
						if(this.numsArr[i]%10==checkNumsArr[j]){
							thisCheckNumsLength++;
							if(thisCheckNumsLength>=sameLength){
								return false;
							}
						}
					}
				}
				return true
			}



		}
		
	}(Rticket)