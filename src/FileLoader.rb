# encoding: utf-8
require './Word.rb'
require 'fileutils'

class FileLoader

	attr_reader :words
	
	def initialize file_path 
		@words = []
		@file_path = file_path
	end

	def load nativeLenguage
		Encoding.default_external = Encoding.list[1]
		File.open(@file_path, "r") { |f|  
			f.each_line do |line|
				if !line.start_with? "#" then
					split_line = line.split("=")
					word = Word.new
					if nativeLenguage.eql? "spanish" then
						word.local_name = split_line[0].strip
						word.foreign_name = split_line[1].split(",").collect{|x| x.strip}
					else
						word.local_name = split_line[1].split(",").collect{|x| x.strip}[0]
						word.foreign_name = split_line[0].strip
					end	
					word.rate = split_line[2].to_i
					
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
			if nativeLenguage? "spanish" then
				line = "#{pal.local_name}=#{pal.foreign_name.join(",")}=#{pal.rate} "
			else
				line = "#{pal.foreign_name.join(",")}=#{pal.local_name}=#{pal.rate} "
			end
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
