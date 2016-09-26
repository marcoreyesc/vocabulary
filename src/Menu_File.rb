
# encoding: utf-8
require './FileLoader.rb'
require './Examinator.rb'

class Menu_File

	def initialize 
		@repository_path =File.expand_path('../repository', File.dirname(__FILE__))+"//" 
		@options = load_options
	end

	def load_options
		files = Dir.entries(@repository_path)

		files.delete(".")
		files.delete("..")
		files.delete_if {|x| !(x.end_with? ".txt")}
		return files.map{|x| x.gsub(".txt","")}
	end

	def evaluate_option option
		if option.eql? "_out" then 
			return false
		end 
		if option.to_i < 1 || option.to_i > @options.size  then 
			puts "La option seleccionada no es valida"
			return true
		end
		return false
	end 

	def show_menu
		
		selected_option = nil
		begin
			begin
				selected_option = nil	
				index = 1
				@options.each{ |x|
					puts "#{index}. #{x}"
					index+=1
				}
				selected_option= STDIN.gets.chomp
			end while evaluate_option selected_option 
			if !selected_option.eql? "_out" then
				final_option = selected_option.to_i 
				final_option -= 1
				file_loader = FileLoader.new(@repository_path+@options[final_option]+".txt")
				examinator = Examinator.new(file_loader,"english") 
				examinator.do_exam
			end 
		end while selected_option != "_out"

	end
end


menu = Menu_File.new
menu.show_menu
