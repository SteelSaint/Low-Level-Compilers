

class COMPLIER
	def Initialize
		@TRUE = 1
		@FALSE = 0
		@NORW = 11
		@TXMAX = 100
		@NMAX = 14
		@AL = 20
		@AMAX = 2047
	end

public OBJECTS
		
			@Constant
			@Variable
			@Procedure
			@None
		end

		public SYMBOL
		
			@BEGINSYM
			@CALLSYM
			@CONSTSYM
			@DOSYM
			@ENDSYM
			@IFSYM
			@ODDSYM
			@PROCSYM
			@THENSYM
			@VARSYM
			@WHILESYM
			@NUL
			@IDENT
			@NUMBER
			@PLUS
			@MINUS
			@TIMES
			@SLASH
			@EQL
			@NEQ
			@LSS
			@LEQ
			@GTR
			@GEQ
			@LPAREN
			@RPAREN
			@COMMA
			@SEMICOLON
			@COLON
			@PERIOD
			@BECOMES
		$end

		public SYMBOL[]=
		
			@SYMBOL.BEGINSYM
			@SYMBOL.CALLSYM
			@SYMBOL.CONSTSYM
			@SYMBOL.DOSYM
			@SYMBOL.ENDSYM
			@SYMBOL.IFSYM
			@SYMBOL.ODDSYM
			@SYMBOL.PROCSYM
			@SYMBOL.THENSYM
			@SYMBOL.VARSYM
			@SYMBOL.WHILESYM
		$end

		public class Table_struct
		
			public String = name
			public OBJECTS = kind
		$end

		public String Word[]
		
			"BEGIN"
			"CALL"
			"CONST"
			"DO"
			"END"
			"IF"
			"ODD"
			"PROCEDURE"
			"THEN"
			"VAR"
			"WHILE"
		$end

		public Char_Word[][]
			'B' 'E' 'G' 'I' 'N'
			'C' 'A' 'L' 'L'
			'C' 'O' 'N' 'S' 'T'
			'D' 'O'
			'E' 'N' 'D'
			'I' 'F'
			'O' 'D' 'D'
			'P' 'R' 'O' 'C' 'E' 'D' 'U' 'R' 'E'
			'T' 'H' 'E' 'N'
			'V' 'A' 'R'
			'W' 'H' 'I' 'L' 'E'
		end

		Scanner input
		Table_struct [TXMAX]
		SYMBOL sym
		Ch
		Id[] = new.Id [AL]
		A[] = new.A [80]
		String Temp_id, Str_line
		Id_length CC LL KK Num

		public String ErrMsg[] =
			"Use = instead of :=" #1
			"= must be followed by a number" #2 
			"Identifier must be followed by =" #3 
			"Const, Var, Procedure must be followed by an identifier" #4
			"Semicolon or comma missing" #5
			"Incorrect symbol after procedure declaration" #6
			"Statement expected" #7
			"Incorrect symbol after statement part in block" #8
			"Period expected" #9
			"Semicolon between statements is missing" #10
			"Undeclared identifier" #11
			"Assignment to constant or procedure is not allowed" #12
			"Assignment operator := expected" #13
			"Call must be followed by an identifier" #14
			"Call of a constant or a variable is meaningless" #15
			"Then expected" #16
			"Semicolon or end expected" #17
			"Do expected" #18
			"Incorrect symbol following statement" #19
			"Relational operator expected" #20 
			"Procedure cannot return a value" #21
			"Right parenthesis or relational operator expected" #22
			"Number is too large" #23
			"Identifier expected" #24
			"An expression cannot begin with this symbol" #25
		 $end

		public Error(ErrorNumber)
		
		System.out.println(ErrMsg[ErrorNumber - 1])
		System.exit(-1)
		$end

		public GetChar()
		
		if (CC == LL)
		
			if (input.hasNext())
			
				LL = 0
				CC = 0

				Str_line = input.nextLine()
				Line[] = Str_line.toCharArray()
				System.out.println(str_line)
				LL = Str_line.length()

				if (LL > 0)
					if (Line[LL-1] == 13) then LL -= 1 
					if (Line[LL-1] == 10) then LL -= 1
					if (Line[LL-1] == 13) then LL -= 1
					if (Line[LL-1] == 10) then LL -= 1
					Ch = Line[CC.next]
				end
				else
					Ch = ' '
			end
		end
		else
			Ch = Line[CC.next]
		while (Ch == '\t')
			Ch = Line[CC.next]
		end
public GetSym()
		
			#@I, @J, @K

			while (Ch == ' ' || Ch == '\r' || Ch == '\n')
				GetChar()

			if (Ch >= 'A' && Ch <= 'Z')
			
				K = 0
				X = 0

				for ( X < AL )
					X.next
					A[X]  = '\0'
					Id[X] = '\0'
				end
			end
				do
				
					if (K < AL)
						A[K.next] = Ch
					if (CC == LL)
					
						GetChar()
						break
					end
					else
						GetChar()
				end 
				while ((Ch >= 'A' && Ch <= 'Z') || (Ch >= '0' && Ch <= '9'))

				Id = A

				I = 0
				J = NORW - 1;

				if (K == 1)
					Id_length = 1
				else
					Id_length = K--

				do
				
					K = I + J
					K = K / 2
					
					Temp_id = String.copyValueOf(Id, 0, Id_length)

					if (Id[0] <= Char_Word[K][0])
					
						if (Temp_id.compareTo(Word[K]) <= 0)
							J = K - 1
					end
					if (Id[0] >= Char_Word[K][0])
					
						if (Temp_id.compareTo(Word[K]) >= 0)
							I = K + 1
					end
				end 
				while (I <= J)

				if (I - 1 > J)
					Sym = Wsym[K]
				else
					Sym = SYMBOL.IDENT
			end
			else if (Ch >= '0' && Ch <= '9')
			
				K = 0;
				Num = 0;
				Sym = SYMBOL.NUMBER;

				do
				
					if (K >= NMAX)
						Error(23);

					Num = 10 * Num + (Ch - '0')
					K.next

					GetChar()
				end 
			while (Ch >= '0' && Ch <= '9')
			end
			else if (Ch == ':')
			
				GetChar()

				if (Ch == '=')
				
					Sym = SYMBOL.BECOMES
					GetChar()
				end
				else
					Sym = SYMBOL.COLON
			end
			else if (Ch == '>')
				GetChar()

				if (Ch == '=')
					Sym = SYMBOL.GEQ
					GetChar()
				end
				else
					sym = SYMBOL.GTR
			end
			else if (Ch == '<')
				GetChar()

				if (Ch == '=')
					Sym = SYMBOL.LEQ
					GetChar()
				end
				else if (Ch == '>')
					Sym = SYMBOL.NEQ
					GetChar()
				end
				else
					Sym = SYMBOL.LSS
			end
			else
				if (Ch == '+')
					Sym = SYMBOL.PLUS
				else if (Ch == '-')
					Sym = SYMBOL.MINUS
				else if (Ch == '*')
					Sym = SYMBOL.TIMES
				else if (Ch == '/')
					Sym = SYMBOL.SLASH
				else if (Ch == '(')
					Sym = SYMBOL.LPAREN
				else if (Ch == ')')
					Sym = SYMBOL.RPAREN
				else if (Ch == '=')
					Sym = SYMBOL.EQL
				else if (Ch == '.')
					Sym = SYMBOL.PERIOD
				else if (Ch == ',')
					Sym = SYMBOL.COMMA
				else if (Ch == ';')
					Sym = SYMBOL.SEMICOLON

				GetChar()
			end
		end

		public Enter(OBJECTS K, Tx)
		
			Tx.next
			Table[Tx].Name = String.ValueOf(Id)
			Table[Tx].Kind = K

			return Tx
		end

		public Position(Id[], Tx)
			I = Tx

			Table[0].Name = String.ValueOf(Id)

			while (!Table[I].Name.Equals(String.ValueOf(Id)))
				I--

			return I
		end

		public Block(Tx)
			if (Sym == SYMBOL.CONSTSYM)
				GetSym()
				Tx = ConstDeclaration(Tx)
				while (Sym == SYMBOL.COMMA)
					GetSym()
					Tx = ConstDeclaration(Tx)
				end
				if (Sym == SYMBOL.SEMICOLON)
					GetSym()
				else
					Error(5)
			end # End if (CONSTSYM)

			if (Sym == SYMBOL.VARSYM)
				GetSym()
				Tx = VarDeclaration(Tx)
				while (Sym == SYMBOL.COMMA)
					GetSym()
					Tx = VarDeclaration(Tx)
				end

				if (Sym == SYMBOL.SEMICOLON)
					GetSym()
				else
					Error(5)
			end #END if (VARSYM)

			while (Sym == SYMBOL.PROCSYM)
				GetSym()

				if (Sym == SYMBOL.IDENT)
					Tx = Enter(OBJECTS.Procedure, Tx)
					GetSym()
				end
				else
					Error(6)

				if (Sym == SYMBOL.SEMICOLON)
					GetSym()
				else
					Error(5)

				Block(Tx)

				if (Sym == SYMBOL.SEMICOLON)
					GetSym()
				else
					Error(5)
			end

			Statement(Tx)
		end

		public Factor(Tx)
			I

			if (Sym == SYMBOL.IDENT)
				if ((I = Position(Id, Tx)) == FALSE)
					Error(11)
				GetSym()
			end
			else if (Sym == SYMBOL.NUMBER)
				GetSym()
			else if (Sym == SYMBOL.LPAREN)
				GetSym()
				Expression(Tx)
				if (Sym == SYMBOL.RPAREN)
					GetSym()
				else
					Error(22)
			end
			else
				Error(25)
		end

		public Term(Tx)
			Factor(Tx)

			while (Sym == SYMBOL.TIMES || Sym == SYMBOL.SLASH)
				GetSym()
				Factor(Tx)
			end
		end

		public Expression(Tx)
			if (Sym == SYMBOL.PLUS || Sym == SYMBOL.MINUS)
				GetSym()
				Term(Tx)
			end
			else
				Term(Tx)

			while (Sym == SYMBOL.PLUS || Sym == SYMBOL.MINUS)
				GetSym()
				Term(Tx)
			end
		end

		public Condition(Tx)
			if (Sym == SYMBOL.ODDSYM)
				GetSym()
				Expression(Tx)
			end
			else
				Expression(Tx)

				if ((Sym == SYMBOL.EQL) || (Sym == SYMBOL.GTR) || (Sym == SYMBOL.LSS) ||
				                (Sym == SYMBOL.NEQ) || (Sym == SYMBOL.LEQ) || (Sym == SYMBOL.GEQ))
					GetSym()
					Expression(Tx)
				end
				else
					Error(20)
			end
		end

		public ConstDeclaration(Tx)
			if (Sym == SYMBOL.IDENT)
				GetSym()
				if (Sym == SYMBOL.EQL)
					GetSym()
					if (Sym == SYMBOL.NUMBER)
						Tx = Enter(OBJECTS.Constant, Tx)
						GetSym()
					end
					else
						Error(2)
				end
				else
					Error(3)
			end
			else
				Error(4)

			return Tx
		end

		public VarDeclaration(Tx)
			if (Sym == SYMBOL.IDENT)
				Tx = Enter(OBJECTS.Variable, Tx)
				GetSym()
			end
			else
				Error(4)

			return Tx
		end

		public Statement(Tx)
			I
			Switch (Sym) #might need to still be switch
				case BEGINSYM:
					GetSym()
					Statement(Tx)					
					while (Sym == SYMBOL.SEMICOLON)
						GetSym()
						Statement(Tx)
					end
					if (Sym == SYMBOL.ENDSYM)
						GetSym()
					else
						Error(17)
					break

				case IDENT:
					if ((I = Position(Id, Tx)) == FALSE)
						Error(11)
					else
						if (Table[I].Kind != OBJECTS.Variable)
							Error(12)
					GetSym()
					if (Sym == SYMBOL.BECOMES)
						GetSym()
					else
						Error(13)
					Expression(Tx)
					break

				case IFSYM:
					GetSym()
					Condition(Tx)
					if (Sym == SYMBOL.THENSYM)
						GetSym()
					else
						Error(16)
					Statement(Tx)
					break

				case WHILESYM:
					GetSym()
					Condition(Tx)
					if (Sym == SYMBOL.DOSYM)
					
						GetSym()
						Statement(Tx)
					end
					else
						Error(18)
					break # WHILESYM 

				case CALLSYM:
					GetSym()
					if (Sym == SYMBOL.IDENT)
					
						if ((I = Position(Id, Tx)) == FALSE)
							Error(11)
						else
							if (Table[I].Kind != OBJECTS.Procedure)
								Error(15)
						GetSym()
					end
					else
						Error(14)
					break
			end
		end

		public Main(String[] Args)
		
			try
			
				Input = New.Scanner(System.in)
			end
			catch (Exception E)
			
				System.err.println("Error Getting Input")
				System.exit(1)
			end

			CC = LL
			LL = 0
			Ch = ' '
			KK = AL

			for (Q = 0, Q < TXMAX, Q.next)
				Table[Q] = new.Table_struct("", OBJECTS.None)
			end

			GetSym()

			Block(0)

			if (Sym != SYMBOL.PERIOD)
				Error(9)
			else
				System.out.println("\nSuccessful compilation!\n")

			Input.Close()
		end
end
