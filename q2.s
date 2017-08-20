	# initialisation
	add $t0, $0, $11		# $t0 current A element, initially base of A
	add $t1, $0, $12		# $t1 current B element, initially base of B 
	addi $t2, $0, 0		# initialise loop counter
	addi $t3, $0, 1000		# number of iterations 

Loop:	# copy current A element (little endian) to current B element (big endian)
	# Endianness only affects the storage of elements (byte order) and not the 
	# array order. This is where the difference will be taken care of.
	lbu $t4, 0($t1)		# load first byte from B
	sb $t4, 3($t0)		# first byte of B = last byte of A

	lbu $t4, 1($t1)		# load 2nd byte from B
	sb $t4, 2($t0)		# 2nd byte of B = 3rd byte of A
	
	lbu $t4, 2($t1)		# load 3rd byte from B
	sb $t4, 1($t0)		# 3rd byte of B = 2nd byte of A

	lbu $t4, 3($t1)		# load 4th (last) byte from B
	sb $t4, 0($t0)		# last byte of B = first byte of A

	# iterate to the next word (array elements) and increment loop counter
	addi $t0, $t0, 4		
	addi $t1, $t1, 4
	addi $t2, $t2, 1

	# check if finished
	slt $t6, $t2, $t3		# if($t2<$t3) {$t6 = 1} else {$t6 = 0}
	bne $t6, $0, Loop		# if($t6==1) {goto Loop} i.e. if($t2<$t3), repeat
