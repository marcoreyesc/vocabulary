# encoding: utf-8
require './Word.rb'
require 'fileutils'

class FileLoader

	attr_reader :words
	
	def initialize file_path 
		@words = []
		@file_path = file_path
	end

	def load
		Encoding.default_external = Encoding.list[1]
		File.open(@file_path, "r") { |f|  
			f.each_line do |line|
				if !line.start_with? "#" then
					split_line = line.split("=")
					word = Word.new
					split_line.each_index do |index|
						case index 
						when  0
							word.local_name = split_line[index].strip
						when 1
							word.foreign_name = split_line[index].split(",").collect{|x| x.strip}
						when 2
							word.rate = split_line[index].to_i
						end
					end
					
					@words << word
				end
			end
		}
		@words.sort_by! do |item| 
			item.rate
		end 
	end 

	def writeActualitation words 
		puts "salvando examen"
		File.rename(@file_path, @file_path+".bak")
		out_file = File.new @file_path, "w"
		words.each{|pal|
			line = "#{pal.local_name}=#{pal.foreign_name.join(",")}=#{pal.rate} "
			out_file.puts line
		}
		out_file.close
	end 	
end

#file_loader = FileLoader.new
#word = Word.new 
#words = [word]
#readed = file_loader.writeActualitation words 
#puts "lecttra: #{readed}"