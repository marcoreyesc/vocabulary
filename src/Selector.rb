

class Selector
	
	def initialize (words)
		@words = words
		@currentWordIndex = nil
	end  

	def getNextWord () 
		if @currentWordIndex == nil then 
			@currentWordIndex=0
		else 
			@currentWordIndex+=1
		end 
		@words[@currentWordIndex]
	end 

	def hasNext
		if @currentWordIndex + 1 < @words.size then
			return true
		end 
		return false
	end 	
end