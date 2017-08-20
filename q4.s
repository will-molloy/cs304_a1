.text
.globl main

main:
	li $a0, 4
	li $a1, 4096
	li $a2, 5
	j compute
	
compute: # a0: x, a1: y, a2: n
	# load args
	add $t0, $0, $a0	# $t0 -> x
	add $t1, $0, $a1 	# $t1 -> y
	add $t2, $0, $a2 	# $t2 -> n
	
	# check x,y are in valid range: 0<x<10, 0<n<7
	addi $t3, $0, 9
	addi $t4, $0, 6
	addi $t5, $0, 1
	
	# if (x < 10 && x > 0 && n < 7 && n > 0), we can continue
	# using OR (demorgan): (x >= 10 || x <= 0 || n >= 7 || n <= 0)
	# this way $t6 can be checked to see if any condition failed
	slt $t6, $t3, $t0 		# x >= 10 -> 10 <= x -> 9 < x
	bne $t6, $0, invalidArg

	slt $t6 $t0, $t5		# x <= 0 -> x < 1
	bne $t6, $0, invalidArg

	slt $t6, $t4, $t2		# n >= 7 -> 7 <= n -> 6 < n
	bne $t6, $0, invalidArg

	slt $t6 $t2, $t5		# n <= 0 -> n < 1
	bne $t6, $0, invalidArg

	# args are valid, compute z = 1 + pow(3*x, 4) + (y / pow(2, n))
	addi $t3, $0, 1 	# $t3 = z = 1 (for now)
	addi $t4, $0, 3		# for 3*x
	addi $t5, $0, 3		# exponent in (3x)^4, -1 for loop counter
	addi $t6, $0, 2		# for 2^n
	
	# compute (3x)^4
	mult $t0, $t4		# $t0: 3*x, 
	mflo $t0			# max (27) fits in LSB
	add $t7, $0, $t0 	# save 3*x
pow: 
	addi $t5, $t5, -1
	mult $t0, $t7
	mflo $t0			# max (531441) fits in LSB
	bne $t5, $0, pow	
	
	# compute y / 2^n
	addi $t2, $t2, -1 	# so we can use shift left (e.g. don't shift if n=1)
	sll $t2, $t6, $t2 	# $t2: 2^n
	
	div $t1, $t2		# $t1: y/2^n
	mflo $t1
	
	# add results to z
	add $t3, $t3, $t0 # + (3x)^4
	add $t3, $t3, $t1 # + (y/2^n)
	
	# return z
	add $v0, $0, $t3
	jr $ra

invalidArg:
	addi $v0, $0, 0
	jr $ra
	