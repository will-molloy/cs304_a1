func: 	# $a0: base of X, $a1: base of Y
		# $a2: i, $a3: j, $a4: num_rows (cannot access with $a4!)
		
	# first: get X[i][j] 
	# assuming row major, 0 based and X,Y same dimensions:
	# offset = (i*num_cols + j)*8 (bytes), need num_cols
		
	# num_cols = total_size / num_rows
	# compute size of the arrays (treat as 1D)
	add $t0, $0, $a0 	# $t0: pointer to X
	addi $t1, $0, 0		# counter for total_size
		
countArray:
	lwc1 $f4, 0($t0)	# load current X element (a double)
	cvt.s.d $f4, $f2	# convert to single (for int cvt)
	mfc1 $t0, $f2		# convert to int (for check)
	bne	$t0, $0, endCount # check if at end of array
	addi $t1, $t1, 1 	# total_size++
	addi $t0, $t0, 8	# iterate to next double
	j countArray
	
endCount:
	# now compute num_cols
	lw $t0, 40($sp) # $t0: num_rows (5th arg) (no longer points to X)
	div $t1, $t0	# total_size/num_rows
	mflo $t0		# $t0: num_cols
	
	# compute offset
	mult $t0, $a2 		# $t0: *= i
	mflo $t0			# overflow? i can't be big, memory would exceed
	add $t0, $t0, $a3  	# $t0: += j
	sll $t0, $t0, 3		# $t0: *= 8, now the offset
	
	# access X[i][j], offset += base
	add $t1, $t0, $a0	# $t1 points to X[i][j]
	lwc1 $f2, 0($t0)	# load, $f2 = X[i][j]
	
	# compute: 1 - X[i][j]/8
	addi $t1, $0, 8		# for ../8
	mtc1.d $t1, $f4
	div.d $f2, $f2, $f4	# $f2 = X[i][j]/8
	
	addi $t1, $0, 1		# for 1 - ..
	mtc1.d $t1, $f4
	sub.d $f2, $f4, $f2	# $f2 = 1 - (X[i][j]/8)
	
	# store result in Y[i][j]
	add $t2, $t0, $a1	# $t2 points to Y[i][j]
	swc1 $f2, 0($t2)	# Y[i][j] = $f2 = 1 - (X[i][j]/8)
	
	jr $ra