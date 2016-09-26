class Evaluator
	def self.eval_response(word, response)
		word.foreign_name.include? response
	end 
end