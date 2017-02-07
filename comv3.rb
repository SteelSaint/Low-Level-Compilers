$norw = 11      #number of reserved words
$txmax = 100   #length of identifier table
$nmax = 14      #max number of digits in number
$al = 10          #length of identifiers

$a = []
$chars = []
$rword = []
$table = []

$ch
$sym 
$id 
$num 
$linlen 
$kk 
$line 
$errorFlag 
$linelen

class TableValue
    attr_accessor :_error, :_getch, :_getsym, :_position, :_enter, :_constdeclaration, :_vardeclaration, :_block, :_statement, :_expression, :_term, :_factor, :_condition, :_main
    public def initialize(name, kind)
        $name = name
        $kind = kind
    end
end
public def _error(num)
    $errorFlag = errorFlag
    errorFlag = num
    num = 0
    case
    when num == 1
        print 'Use = instead of :='
    when num ==2
        print '= must be followed by a number.'
    when num ==3
        print 'Identifier must be followed by ='
    when num ==4
        print 'Const, Var, Procedure must be followed by an identifier.'
    when num ==5
        print 'Semicolon or comma missing'
    when num == 6
        print 'Incorrect symbol after procedure declaration.'
    when num == 7
        print 'Statement expected.'
    when num == 8
        print 'Incorrect symbol after statment part in block.'
    when num == 9
        print 'Period expected.'
    when num == 10
        print 'Semicolon between statements is missing.'
    when num == 11
        print 'Undeclard identifier'
    when num == 12
        print 'Assignment to a constant or procedure is not allowed.'
    when num == 13
        print 'Assignment operator := expected.'
    when num == 14
        print 'call must be followed by an identifier'
    when num == 15
        print 'Call of a constant or a variable is meaningless.'
    when num == 16
        print 'Then expected'
    when num == 17
        print 'Semicolon or end expected.'
    when num == 18
        print 'DO expected'
    when num == 19
        print 'Incorrect symbol following statement'
    when num == 20
        print 'Relational operator expected.'
    when num == 21
        print 'Expression must not contain a procedure identifier'
    when num == 22
        print 'Right parenthesis missing'
    when num == 23
        print 'The preceding factor cannot be followed by this symbol.'
    when num == 24
        print 'An expression cannot begin with this symbol.'
    when num ==25
        print 'Constant or Number is expected.'
    when num == 26
        print 'This number is too large.'
        else
    end
end
    
public def _getch(whichChar,ch,linelen,line)
    $whichChar = whichChar
    $ch =ch
    $linelen = linelen
    $line = line
    if whichChar == linelen         #if at end of line
        whichChar = 0
        line = infile.readline     #get next line
        linelen = len(line)
        sys.stdout.write(line)
    end
    if linelen != 0
        ch = line[whichChar]
        whichChar += 1
    return ch
    end
end
        
public def _getsym(charcnt,ch,al,a,norw,rword,sym,nmax,id)
    $charcnt = charcnt
    $ch = ch
    $al = al
    $a = a
    $norw = norw
    $rword = rword
    $sym = sym
    $nmax = nmax
    $id = id
    while ch == " " or ch == "\n" or ch == "\r"
        _getch($whichChar,$ch,$linelen,$line)
    a = []
    if ch.string.match(/^[[:alpha:]]+$/)
        k = 0
        while TRUE
            a.append(ch)
            _getch($whichChar,$ch,$linelen,$line)
            if not ch.match(/^[[:alnum:]]+$/)
            end
        id = a
        flag = 0
        for i in range(0..norw)
            if rword[i] == id
                sym = rword[i]
                flag = 1
            end
        end
        end 
        if  flag == 0    #sym is not a reserved word
            sym = 'ident'
        end
            
    elsif ch.match(/^[[:alnum:]]+$/)
        k=0
        num=0
        sym = 'number'
        while TRUE
            a.append(ch)
            k += 1
            _getch($whichChar,$ch,$linelen,$line)
            if not ch.match(/^[[:alnum:]]+$/)
            end
        if k>nmax
            _error(30)
        else
            id = a
        end
        end  
    elsif ch == ':'
        _getch($whichChar,$ch,$linelen,$line)
        if ch == '='
            sym = 'becomes'
            _getch($whichChar,$ch,$linelen,$line)
        else
            sym = 'colon'
        end
    elsif ch == '>'
        _getch($whichChar,$ch,$linelen,$line)
        if ch == '='
            sym = 'geq'
            _getch($whichChar,$ch,$linelen,$line)
        else
            sym = 'gtr'
        end
    
    elsif ch == '<'
        _getch($whichChar,$ch,$linelen,$line)
        if ch == '='
            sym = 'leq'
            _getch($whichChar,$ch,$linelen,$line)
        elsif ch == '>'
            sym = 'neq'
            _getch($whichChar,$ch,$linelen,$line)
        else
            sym = 'lss'
        end
    else
        sym = $ssym[ch]
        _getch($whichChar,$ch,$linelen,$line)
    end
    end
end        
#--------------POSITION FUNCTION----------------------------
public def _position(tx, k)
    table
    table[0] = TableValue(k, 'TEST')
    i = tx
    while table[i].name != k
        i=i-1
    return i
    end
end
#---------------ENTER PROCEDURE-------------------------------
public def _enter(tx, k)
    id
    tx[0] += 1
    while len(table) > tx[0]
      table.pop()
    x = TableValue(id, k)
    table.append(x)
    end
end
#--------------CONST DECLARATION---------------------------
public def _constdeclaration(tx)
    $sym = sym
    $id = id
    if sym=='ident'
        temp = id
        _getsym($charcnt,$ch,$al,$a,$norw,$rword,$sym,$nmax,$id)
        if sym == 'eql'
            _getsym($charcnt,$ch,$al,$a,$norw,$rword,$sym,$nmax,$id)
            if sym == 'number'
                id = temp
                _enter(tx, 'const')
                _getsym($charcnt,$ch,$al,$a,$norw,$rword,$sym,$nmax,$id)
            else
                _error(2)
            end
        else
            _error(3)
        end
    else
        _error(4)
    end
end
#-------------VARIABLE DECLARATION-----------------------------------
public def _vardeclaration(tx)
    $sym = sym
    if sym == 'ident'
        _enter(tx, 'variable')
        _getsym($charcnt,$ch,$al,$a,$norw,$rword,$sym,$nmax,$id)
    else
        _error(4)
    end
end    
#-------------BLOCK------------------------------------------------
public def _block(tableindex)
    $tx = tx = [1]
    tx[0] = tableindex
    $sym = sym
    $id = id
    if sym == 'CONST'
        while TRUE               #makeshift do while in python
            _getsym($charcnt,$ch,$al,$a,$norw,$rword,$sym,$nmax,$id)
            _constdeclaration(tx)
            if sym != 'comma'
            end
        if sym != 'semicolon'
            _error(10)
            _getsym($charcnt,$ch,$al,$a,$norw,$rword,$sym,$nmax,$id)
        end
        end
    end
    if sym == 'VAR'
        while TRUE
            _getsym($charcnt,$ch,$al,$a,$norw,$rword,$sym,$nmax,$id)
            _vardeclaration(tx)
            if sym != 'comma'
            end
        if sym != 'semicolon'
            _error(10)
            _getsym($charcnt,$ch,$al,$a,$norw,$rword,$sym,$nmax,$id)
        end
        end
    end
    while sym == 'PROCEDURE'
        _getsym($charcnt,$ch,$al,$a,$norw,$rword,$sym,$nmax,$id)
        if sym == 'ident'
            _enter(tx, 'procedure')
            _getsym($charcnt,$ch,$al,$a,$norw,$rword,$sym,$nmax,$id)
        else
            _error(4)
        end
        if sym != 'semicolon'
            _error(10)
        _getsym($charcnt,$ch,$al,$a,$norw,$rword,$sym,$nmax,$id)
        _block(tx[0])
        end
        if sym != 'semicolon'
            _error(10)
            _getsym($charcnt,$ch,$al,$a,$norw,$rword,$sym,$nmax,$id)
        end
    end
    _statement(tx[0])
end
#--------------STATEMENT----------------------------------------
public def _statement(tx)
    $sym = sym
    $id = id
    if sym == 'ident'
        i = _position(tx, id)
        if i==0
            _error(11)
        elsif table[i].kind != 'variable'
            _error(12)
            _getsym($charcnt,$ch,$al,$a,$norw,$rword,$sym,$nmax,$id)
        end
        if sym != 'becomes'
            _error(13)
            _getsym($charcnt,$ch,$al,$a,$norw,$rword,$sym,$nmax,$id)
            _expression(tx)
        end
    elsif sym == 'CALL'
        _getsym($charcnt,$ch,$al,$a,$norw,$rword,$sym,$nmax,$id)
        if sym != 'ident'
            _error(14)
        end    
        i = _position(tx, id)
        if i==0
            _error(11)
        end
        if table[i].kind != 'procedure'
            _error(15)
            _getsym($charcnt,$ch,$al,$a,$norw,$rword,$sym,$nmax,$id)
        end
    elsif sym == 'IF'
        _getsym($charcnt,$ch,$al,$a,$norw,$rword,$sym,$nmax,$id)
        _condition(tx)
        if sym != 'THEN'
            _error(16)
            _getsym($charcnt,$ch,$al,$a,$norw,$rword,$sym,$nmax,$id)
            _statement(tx)
        end
    elsif sym == 'BEGIN'
        while TRUE
            _getsym($charcnt,$ch,$al,$a,$norw,$rword,$sym,$nmax,$id)
            _statement(tx)
            if sym != 'semicolon'
            end
            if sym != 'END'
            end
            _error(17)
            _getsym($charcnt,$ch,$al,$a,$norw,$rword,$sym,$nmax,$id)
            end
    else sym == 'WHILE'
        _getsym($charcnt,$ch,$al,$a,$norw,$rword,$sym,$nmax,$id)
        _condition(tx)
        if sym != 'DO'
            _error(18)
            _getsym($charcnt,$ch,$al,$a,$norw,$rword,$sym,$nmax,$id)
            _statement(tx)
        end
    end
    end

#--------------EXPRESSION--------------------------------------
public def _expression(tx)
    $sym = sym
    if sym == 'plus' or sym == 'minus'
        _getsym($charcnt,$ch,$al,$a,$norw,$rword,$sym,$nmax,$id)
        _term(tx)
    else
        _term(tx)
    end 
    while sym == 'plus' or sym == 'minus'
        _getsym($charcnt,$ch,$al,$a,$norw,$rword,$sym,$nmax,$id)
        _term(tx)
    end
end 
#-------------TERM----------------------------------------------------
public def _term(tx)
    $sym = sym
    _factor(tx)
    while sym=='times' or sym=='slash'
        _getsym($charcnt,$ch,$al,$a,$norw,$rword,$sym,$nmax,$id)
        _factor(tx)
    end
end
#-------------FACTOR--------------------------------------------------
public def _factor(tx)
    $sym = sym
    if sym == 'ident'
        i = _position(tx, id)
        if i==0
            _error(11)
            _getsym($charcnt,$ch,$al,$a,$norw,$rword,$sym,$nmax,$id)
        end
    elsif sym == 'number'
        _getsym($charcnt,$ch,$al,$a,$norw,$rword,$sym,$nmax,$id)
    elsif sym == 'lparen'
        _getsym($charcnt,$ch,$al,$a,$norw,$rword,$sym,$nmax,$id)
        _expression(tx)
        if sym != 'rparen'
            _error(22)
        end
        _getsym($charcnt,$ch,$al,$a,$norw,$rword,$sym,$nmax,$id)
    else
#        print "sym here is: ", sym
      _error(24)
    end
end
#-----------CONDITION-------------------------------------------------
public def _condition(tx)
    $sym = sym
    if sym == 'ODD'
        _getsym($charcnt,$ch,$al,$a,$norw,$rword,$sym,$nmax,$id)
        _expression(tx)
    
    else
        _expression(tx)
        if not sym ['eql''neq''lss''leq''gtr''geq']
            _error(20)
        else
            _getsym($charcnt,$ch,$al,$a,$norw,$rword,$sym,$nmax,$id)
            _expression($tx)
        end
    end
end   
#-------------------MAIN PROGRAM------------------------------------------------------------#
public def _main()
    rword.match('BEGIN')
    rword.match('CALL')
    rword.match('CONST')
    rword.match('DO')
    rword.match('END')
    rword.match('IF')
    rword.match('ODD')
    rword.match('PROCEDURE')
    rword.match('THEN')
    rword.match('VAR')
    rword.match('WHILE')

    $ssym = {'+' => 'plus',
             '-' => 'minus',
             '*' => 'times',
             '/' => 'slash',
             '(' => 'lparen',
             ')' => 'rparen',
             '=' => 'eql',
             ',' => 'comma',
             '.' => 'period',
             '#' => 'neq',
             '<' => 'lss',
             '>' => 'gtr',
             '"' => 'leq',
             '@' => 'geq',
             ';' => 'semicolon',
             ':' => 'colon'}
              

    $charcnt = 0
    $whichChar = 0
    $linelen = 0
    $ch = ' '
    $kk = $al                
    $a = []
    $id= '     '
    $errorFlag = 0
    $table.append(0)    #making the first position in the symbol table empty
    $sym = ' '            

    infile =    sys.stdin       #path to input file
    outfile =  sys.stdout     #path to output file, will create if doesn't already exist

    _getsym($charcnt,$ch,$al,$a,$norw,$rword,$sym,$nmax,$id)           #get first symbol
    _block(0)             #call block initializing with a table index of zero

    if $sym != 'period'      #period expected after block is completed
        _error(9)
    end
   
    print 'Something'
    if $errorFlag == 0
        print 'Successful compilation!'
    end
end
puts 'Please enter code'
a,b = gets.chomp
Work = TableValue.new(a,b)
Work.initialize(a,b)
Work._main