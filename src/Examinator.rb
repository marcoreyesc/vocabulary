# encoding: utf-8
require './Word.rb'
require './FileLoader.rb'
require './Selector.rb'
require './Evaluator.rb'

class Examinator 

	def initialize file_loader, nativeLenguage
		@file_loader = file_loader
		@loaded_words = @file_loader.load nativeLenguage
		puts "temos lectura de archivo de #{@loaded_words.size} registros"
		@selector = Selector.new(@loaded_words)
	end 

	def get_response (word)
		print "#{word.local_name}:"
		response = gets.chomp
	end 

	def do_exam
		response = nil
		begin
			word = @selector.getNextWord
			if word.rate < 5 then
				attemps = 0
				begin 
					response = get_response word
					is_right =false
					if response != "_out" then
						is_right = Evaluator.eval_response word, response
						if is_right == false then 
							word.rate -=1
						else
							word.rate +=1
						end 
						attemps +=1
					end
				end while response != "_out" && attemps < 3 and is_right == false
				if is_right == false and !response.eql? ("_out") then 
					puts "las posibles respuestas eran #{word.foreign_name}"
				end
			end
		end while response != "_out" && @selector.hasNext
		saveExam
	end 

	def saveExam
		@file_loader.writeActualitation @loaded_words
	end

	def showResults
		@loaded_words.each{|pal|
			puts "Word: #{pal.local_name} rate:#{pal.rate}"
		}
	end
end 
