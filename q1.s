	addi $10, $0, 128		# $10 = 128
	div $12, $10		# $12 / 128, no shifts due to sign bit
	mflo $14			# store result (quotient) in $14

	
	addi $10, $0, 16		# $10 = 16
	mtc1.d $10, $f4		# $f4-$f5 = 16 
	mul.d $f10, $f12, $f4	# $f10-$f11 = $f12-$f13 * 16
