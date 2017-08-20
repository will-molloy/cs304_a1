.data
input_string: .asciiz "Shervin was in the garden in the morning.\n"

.text
.globl main

main:
	la $a0, input_string # load input
	j countNumIn

countNumIn:	# a0 base of the array
	# initialise
	add $t0, $0, $a0	# save $a0 in $t0
	addi $t1, $0, 0		# count of 'in'
	addi $t2, $0, 0		# check of 'i' (i.e. 1 if prev was 'i')
	lbu $t3, 0($t0)		# load first element of array
	addi $t4, $0, 'i'	# to check for 'i'
	addi $t5 $0, 'n'	# to check for 'n'
	
loop:
	beq $t3, $0, outLoop	# if current element is null, goto outLoop
	beq $t3, $t4, incrementCheck # if curr element is 'i', set check = 1
	beq $t3, $t5, checkPrevWasI # if curr element is 'n', see if check == 1
	addi $t2, $0, 0		# default (curr isn't null, i or n): check = 0
	
loadNext:
	addi $t0, $t0, 1	# iterate array address
	lbu $t3, 0($t0)		# load next array element 
	j loop
	
checkPrevWasI:
	beq $t2, 1, incrementCount	# curr is 'n', if prev was 'i' count++
	addi $t2, $0, 0		# check = 0
	j loadNext
	
incrementCheck:
	addi $t2, $t2, 1	# check = 1 (i.e. current char is 'i')
	j loadNext
	
incrementCount:
	addi $t1, $t1, 1	# count++
	addi $t2, $0, 0		# check = 0
	j loadNext
	
outLoop:
	add $v0, $0, $t1 	# return count, result in $v0
	jr $ra
	

