#Ruby based Pascal compiler
#!/usr/bin/env ruby
#gem install os

$errorFlag = errorFlag
$whichChar = whichChar 
$ch = ch 	
$linelen = linelen 
$line = line
$charcnt = charcnt
$ch = ch
$al = al
$norw = norw
$rword = rword
$sym = sym
$nmax = nmax
$id = id
$table = table

class TableValue
	def initialize(name, kind)
		@name = name 
		@kind = kind
	end
end

	def Error(num)
	errorFlag = 1
#puts - Maybe?
	if num == 1 
        	puts "Use = instead of :="
    	elsif num ==2 
        	puts "= must be followed by a number."
    	elsif num ==3 
        	puts "Identifier must be followed by ="
    	elsif num ==4 
        	puts "Const, Var, Procedure must be followed by an identifier."
    	elsif num ==5 
        	puts "Semicolon or comman missing"
    	elsif num == 6 
        	puts "Incorrect symbol after procedure declaration."
    	elsif num == 7  
        	puts "Statement expected."
    	elsif num == 8
        	puts "Incorrect symbol after statment part in block."
    	elsif num == 9
        	puts "Period expected."
    	elsif num == 10 
        	puts "Semicolon between statements is missing."
    	elsif num == 11  
        	puts "Undeclard identifier"
    	elsif num == 12
        	puts "Assignment to a constant or procedure is not allowed."
    	elsif num == 13
        	puts "Assignment operator := expected."
    	elsif num == 14 
        	puts "call must be followed by an identifier"
    	elsif num == 15  
        	puts "Call of a constant or a variable is meaningless."
    	elsif num == 16
        	puts "Then expected"
    	elsif num == 17
        	puts "Semicolon or end expected. "
    	elsif num == 18 
        	puts "DO expected"
    	elsif num == 19  
        	puts "Incorrect symbol following statement"
    	elsif num == 20
        	puts "Relational operator expected."
    	elsif num == 21
        	puts "Expression must not contain a procedure identifier"
    	elsif num == 22 
        	puts "Right parenthesis missing"
    	elsif num == 23  
        	puts "The preceding factor cannot be followed by this symbol."
    	elsif num == 24
        	puts "An expression cannot begin with this symbol."
    	elsif num ==25
        	puts "Constant or Number is expected."
    	elsif num == 26 
        	puts "This number is too large."
    	end
	end

	def Getch
	

		if whichChar == linelen #if at end of line
			whichChar = 0
			line = infile.readline #get next line/remains of python
			linelen = len(line)
			sys.stdout.write(line) #remains of python
		end
		if linelen != 0
			ch = line[whichChar]
			whichChar += 1
		return ch
		end
	end
	
	def Getsym
		while ch == "" or ch == "\n" or ch == "\r"
			Getch
			a = []
			end
				if ch.isalpha
				k = 0
				end
					while
					a.append(ch) #remains of python
					Getch
					end
						if not ch.isalnum #remains of python
						break
						end 
		id = "".join(a) #remains of python
		flag = 0
		end
		for i in range(0,norw)
			if  rword[i] == id
				sym = rword[i]
				flag = 1
			end
			if flag == 0 #sym is not a reserved word
			sym = "ident"
			end
		end

		if ch.isdigit #remains of python
			k = 0
			num = 0
			sym = "number"
		end
		while
			a.append(ch) #remains of python
			k += 1
			Getch
				if not ch.isdigit #remains of python
				break
				end
					if k>nmax
					Error(30)
					end
			id = "".join(a) #remains of python
			end
		if ch == ":"
		Getch
		end
		if ch == "="
			sym = "becomes"
			Getch
		else
			sym = "colon"
		end
		if ch == ">"
			Getch
		end
		if ch == "="
			sym = "geq"
			Getch
		else
			sym = "gtr"
		end
		if ch == "<"
			Getch
		end
		if ch == "="
			sym = "leq"
			Getch
		if ch == ">"
			sym = "neq"
			Getch
		else
			sym = "lss"
			Getch
		end
		else
			sym = ssym[ch]
			Getch
		end
	end
# Position Function
	def Position
		table[0] TableValue(k, "TEST")
		i = tx
		while table[i].name != k
			i -= i
		return i
		end
	end
# Enter Procedure
	def Enter
	tx[0] += 1
		while (len(table) > tx[0])
		table.pop[]
		x = TableValue
		table.append(x)
		end
	end
# Const Declaration
	def Constdeclaration
	
		if sym == "ident"
			temp = id
			Getsym
			if sym == "eql"
				Getsym
				if sym == "number"
					id = temp
					Enter
					Getsym
				else
					Error(2)
				end
			else
				Error(3)
			end
		else
			Error(4)
		end
	end
# Variable Declaration
	def Vardeclaration
		
		if sym == "ident"
			Enter
			Getsym
		else
			Error(4)
			end
	end
# Block
	def Block
	tx = [1]
	tx[0] = TableIndex
	if sym == "CONST"
		while  #might need a do while loop here, needed in python
			Getsym
			Constdeclaration
			end
				if sym != "comma"
					break
					end
		if sym != "semicolon"
			Error(10)
			end
		while sym == "PROCEDURE"
			Getsym
			if sym == "ident"
				Enter
				Getsym
			else
				Error(4)
			end
		end
			if sym != "semicolon"
			Getsym
			Block(tx[0])
			end

		if sym != "semicolon"
		Getsym
		Statement
		end
	end
# Statement
	def Statement
		if sym == "ident"
			i = Position(tx, id)
		end
		if i == 0
			Error(11)
		elsif table[i].kind != "variable"
			Error(12)
			Getsym
		end
		if sym != "becomes"
			Error(13)
			Getsym
			Expression(tx)
		elsif sym == "CALL"
			Getsym
		end
		if sym != "ident"
			Error(14)
			i = Position(tx, id)
		end
		if i == 0
			Error(11)
		end
		if table[i].kind != "procedure"
			Error(15)
			Getsym
		end
		elsif sym == "IF"
			Getsym
			Condition(tx)
		end
			if sym != "THEN"
				Error(16)
				Getsym
				Statement(tx)
			end
	elsif sym == "BEGIN"
		while
			Getsym
			Statement(tx)
			if sym != "semicolon"
				#break
			end
				if sym != "END"
					Error(17)
					Getsym
				end	
		end
	elsif sym == "WHILE"
		Getsym
		Condition(tx)
			if sym != "DO"
			Error(18)
			end
		Getsym
		Statement(tx)
	elsif sym == "ELSE"
		Getsym
		Condition(tx)
			if sym != "THEN"
			Error(16)
			end
	else
		Getsym
		Statement(tx)
		end
	end
# EXPRESSION
	def Expression
			if sym == "plus" or sym == "minus"
			Getsym
			Term(tx)
		else
			Term(tx)
		end
		while sym == "plus" or sym == "minus"
			Getsym
			Term(tx)
		end
	end
# Term
	def Term
	Factor(tx)
		while sym == "times" or sym == "slash"
			Getsym
			Factor(tx)
		end
	end
# Factor
	def Factor
	
		if sym == "ident"
			i = Position(tx, id)
		end
		if i == 0
			Error(11)
			Getsym
		elsif sym == "number"
			Getsym
		elsif sym == "lparen"
			Getsym
			Expression(tx)
		end
		if sym != "rparen"
			Error(22)
			Getsym
		else
		#	print "sym here is: ", sym (da heck?)
		Error(24)
		end
	end
# Condition
		def Condition
	
		if sym == "ODD"
			Getsym
			Expression(tx)
		else
			Expression(tx)
		end
		if not (sym == ["eql""neq""lss""leq""gtr""geq"]) #seems to work 1/22/2016
			Error(20)
		else
			Getsym
			Expression(tx)
		end
	end
=begin
# Main Program
#Note: All of this is the python able way, need to figure out how ruby wants it
rword.append('BEGIN')
rword.append('CALL')
rword.append('CONST')
rword.append('DO')
rword.append('END')
rword.append('IF')
rword.append('ELSE')
rword.append('ODD')
rword.append('PROCEDURE')
rword.append('THEN')
rword.append('VAR')
rword.append('WHILE')

ssym = '+' or "plus"'-' or "minus"'*' or "times"'/' or "slash"'(' or "lparen"')' or "rparen"'=' or "eql"',' or "comma"'.' or "period"'#' or "neq"'<' or "lss"'>' or "gtr"'"' or "leq"'@' or "geq"';' or "semicolon"':' or "colon"


charcnt = 0
whichChar = 0
linelen = 0
ch = ' '
kk = al
a = []
id = ' '
errorFlag = 0
table.append(0) #making the first position in the symbol table empty
sym = ' '

File.open('testcase.txt', 'r') do |f1| #hopefully path to input file
	while line = f1.gets
		puts line
	end
end

File.open('success.txt','w') do |f2| #hopefully path to output file, will create if doesn't exist
f2.puts "f1.txt"
end

Getsym
Block(0)

if sym != "period"
	Error(9)
end
puts >> outfile
if errorFlag == 0
	puts "Successful compilation!"
=end

puts "Welcome to hell."
print "Input your code"

input = gets 
Tablevalue
end