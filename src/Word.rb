
class Word

	attr_accessor :local_name, :foreign_name, :rate

   def initialize(local_name="spanish", foreign_name=["english"], rate=0)
      @local_name=local_name
      @foreign_name=foreign_name
      @rate=rate
   end
end

#palabra = Word.new "mesa" ,"inglés", "0"
#puts palabra.rate
#puts palabra.foreign_name
