handle = File.open("load.txt","r")
handle.lines.each do |line|
	begin
  		puts line + "\n"
  	rescue
  	end
end