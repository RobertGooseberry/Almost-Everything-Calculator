	.text
	.globl main

main:			
	la $a0, msg_commands 	
	li $v0, 4 		
	syscall			
	
	li $v0, 5 		
	syscall			

	beqz $v0, exit		
	sub $v0, $v0, 1

	beqz $v0, oper_add
	sub $v0, $v0, 1
	
	beqz $v0, oper_sub
	sub $v0, $v0, 1
	
	beqz $v0, oper_multiply
	sub $v0, $v0, 1
	
	beqz $v0, oper_divide
	sub $v0, $v0, 1
	
	beqz $v0, oper_average
	sub $v0, $v0, 1
	
	beqz $v0, oper_f_to_c
	sub $v0, $v0, 1
	
	beqz $v0, oper_c_to_f
	sub $v0, $v0, 1
	
	beqz $v0, oper_feet_to_m
	sub $v0, $v0, 1
	
	beqz $v0, oper_m_to_feet
	j main	

oper_add:
	la $a0, add_txt			#Loads add_txt into argument register
	li $v0, 4 				#System call code to print a string.
	syscall					#Prints add_txt
	
	li $v0, 5 				# System call code that reads the integer.
	syscall					# Reads the integer that the user had inputted.
	
	bnez $v0, add_increment 		# If integer does not equal 0
	beqz $v0, add_results			# If integer equals 0
	
	add_increment:
		add $t0, $t0, 1			# Add increment counter by 1
		add $t1, $t1, $v0		# Adds curretn integer to sum value.
		
		j oper_add			# Loops back to oper_add
	
	add_results:				# Prints result
		move $a0, $t0			# Moves number from $t0 to argument register.
		li $v0, 1			# System call to print integer
		syscall				# Prints the number of integers that were inputted.

		la $a0, num_entered_txt		# Loads num_entered_txt into argument register.
		li $v0, 4			# System call code to print a string.
		syscall				# Prints num_entered_mess.
		
		la $a0, sum_txt			# Loads sum_txt into the argument register.
		li $v0, 4			# System call code to print a string.
		syscall				# Print sum_mess.
	
		move $a0, $t1			# Moves the sum value from $t1 into the argument register.
		li $v0, 1			# System call code to print an integer.
		syscall				# Prints the sum.

		la $a0, nl 			# Loads nl into the argument register.
		li $v0, 4			# System call code to print a string.
		syscall				# Print nl.
		
		mul $t0, $zero, $t0		#Resets number of integers to 0
		mul $t1, $zero, $t1		#Resets total sum of all integers to 0

		j main				# Return to main.
oper_sub:
	bnez $t2, Sub_function			# Checks if first loop
	la $a0, Sub_msg				# Loads selected function notification
	li $v0, 4 				# Calls system print
	syscall					# System prints
	
	Sub_function:
		la $a0, Sub_msg1		# Loads Sub_msg1 to argument
		li $v0, 4 			# Calls system print
		syscall				# System prints

		li $v0, 5			# Reads integer entered	
		syscall				# System reads input
		
		beqz $v0, Sub_exit		# If 0 is entered jumped to Sub_exit
		
	Sub_iter_chk:		
		bnez $t0, Sub_op_loop		# Check if first iteration
		mul $t1, $v0, 1			# Multiplies First number by 1 and stores in $t1
		add $t0, $t0, 1			# Adds 1 to iteration counter to Skip Sub_iter_chk on second loop.
		add $t2, $t2, 1
		j oper_sub			# Loops back to oper_sub
		
	Sub_op_loop:	
		sub $t1,$t1,$v0			# Subtraction calculation
		add $t2, $t2, 1			# Adds 1 to iteration counter
		
		la $a0, Sub_curr_diff		# Loads last calculation result
		li $v0, 4			# Calls system print
		syscall				# System prints
		
		move $a0, $t1			# Moves $t1 to argument
		li $v0, 1			# Calls system print
		syscall				# System prints
		
		j oper_sub			# Loops back to oper_sub
	Sub_exit:	
		la $a0, Sub_exit_msg		# Loads msg to print
		li $v0, 4			# Calls system print
		syscall				# System prints
		
		la $a0, Sub_nums_entered	# Loads Sub_nums_entered
		li $v0, 4			# Calls system print
		syscall				# System Prints
		
		move $a0, $t2			# Moves $t2 to argument
		li $v0, 1			# Calls System Print
		syscall 			# System Prints
		
		la $a0, Sub_result 		# Loads Sub_result
		li $v0, 4			# Calls system print 
		syscall				# System Prints
		
		move $a0,$t1			# Moves $t1 final calculation to argument
		li $v0, 1			# Calls system print
		syscall				# System Prints
		
		mul $t0, $zero, $t0		# Resets operation
		mul $t1, $zero, $t1		# Resets operation
		mul $t2, $zero, $t2		# Resets operation
		
	j main	
oper_multiply:
	bnez $t0, Mul_function			# Checks if first loop
	la $a0, Mul_msg				# Loads selected function notification
	li $v0, 4 				# Calls system print
	syscall					# System Prints
	
	Mul_function:
		la $a0, Mul_op_msg		# Loads msg to print
		li $v0, 4			# Calls system print
		syscall				# Prints loaded msg
		
		li $v0, 5			# Reads int
		syscall				# Integer Input
		
		bnez $v0, Mul_iter_chk		# Branches to Mul_iter_chk if not equal to zero.
		la $a0, Mul_Term_msg		# Loads message Mul_Term_msg
		li $v0, 4			# Prepares to print
		syscall				# System prints Terminate_msg
		j Mul_exit			# Jumps to Mul_exit
	Mul_iter_chk:		
		bnez $t0, Mul_op_loop		# Check if first iteration
		add $t1, $t1, 1			# Adds 1 to $t1 so interger doesn't get multiplied by 0
		add $t0, $t0 1			# Adds 1 to iteration counter to stop adding 1 to $t1
		
	Mul_op_loop:	
		add $t2, $t2, 1			# Amount of Integers inputted counter
		mul  $t1, $t1, $v0		# Multiply integer entered by user
		la $a0, Mul_curr_prod		# Loads last calculation result
		li $v0, 4			# Loads msg to print
		syscall				# Prints msg
		move $a0, $t1			# Loads Current product
		li $v0, 1			# Sends integer to be printed
		syscall				# Prints Current product
		j oper_multiply			# Loop
	Mul_exit: 	
		la $a0, Mul_exit_msg		# Loads msg to print
		li $v0, 4			# Calls system print
		syscall				# System prints
		
		la $a0, Mul_counter		# Loads msg to print
		li $v0, 4			# Calls system print
		syscall				# System prints
		
		move $a0, $t2			# Moves iteration counter to argument
		li $v0, 1			# Sends to be printed
		syscall				# System print
		
		la $a0, Mul_Product_msg 	# Loads msg to print
		li $v0, 4			# Calls system print
		syscall				# System prints
		
		move $a0, $t1			# Moves product to argument
		li $v0, 1			# Calls system print		
		syscall				# System Prints
		
		mul $t0, $zero, $t0		# Resets back to first iteration
		mul $t1, $zero, $t1		# Resets product
		mul $t2, $zero, $t2		# Resets Counter
	j main
oper_divide:
	bnez $t0, Div_function			# Checks if first loop
	la $a0, Div_msg				# Loads selected function notification
	li $v0, 4 				# Calls system print
	syscall					# System Prints
	
	Div_function:
		la $a0, Div_op_msg		# Loads msg to print
		li $v0, 4			# Calls system print
		syscall				# Prints loaded msg
		
		li $v0, 5			# Reads int
		syscall				# Integer Input
		
		bnez $v0, Div_iter_chk		# Branches to Div_iter_chk if not equal to zero.
		la $a0, Div_Term_msg		# Loads message Div_Term_msg
		li $v0, 4			# Prepares to print
		syscall				# System prints Div_Terminate_msg
		j Div_exit			# Jumps to Mul_exit
		
	Div_iter_chk:		
		bnez $t0, Div_op_loop		# Check if first iteration
		mul $t1, $v0, 1			# Adds $v0 to $t1 so interger doesn't get divided by 0
		add $t0, $t0 1			# Adds 1 to iteration counter to stop first loop processes
		add $t2, $t2, 1			# Adds 1 to iteration counter		
		j oper_divide			# Jumps to oper_divide
		
	Div_op_loop:	
		add $t2, $t2, 1			# Amount of Integers inputted counter
		div  $t1, $t1, $v0		# Divide integer entered by user
		la $a0, Div_curr_quot		# Loads last calculation result
		li $v0, 4			# Loads msg to print
		syscall				# Prints msg
		move $a0, $t1			# Loads Current quotient
		li $v0, 1			# Sends integer to be printed
		syscall				# Prints Current quotient
		j oper_divide			# Loop
	Div_exit: 	
		la $a0, Div_exit_msg		# Loads msg to print
		li $v0, 4			# Calls system print
		syscall				# System prints
		
		la $a0, Div_counter		# Loads msg to print
		li $v0, 4			# Calls system print
		syscall				# System prints
		
		move $a0, $t2			# Moves iteration counter to argument
		li $v0, 1			# Sends to be printed
		syscall				# System print
		
		la $a0, Div_quotient_msg 	# Loads msg to print
		li $v0, 4			# Calls system print
		syscall				# System prints
		
		move $a0, $t1			# Moves product to argument
		li $v0, 1			# Calls system print		
		syscall				# System Prints
		
		mul $t0, $zero, $t0		# Resets back to first iteration
		mul $t1, $zero, $t1		# Resets product
		mul $t2, $zero, $t2		# Resets Counter
	j main	
oper_average:
	
	la $a0, average_intro	
	li $v0, 4 				
	syscall					

	li $v0, 5 				
	syscall					
	
	beqz $v0, average_end	
			
	beqz $t0, average_innit			#firstloop int
	average_innit_back:
	
	add $t0, $t0, 1			
	add $t1, $t1, $v0	
	
	bge $v0, $t2, average_min_skip		#mincheck
	move $t2, $v0
	
	average_min_skip:			
	
	ble $v0, $t3, average_max_skip		#maxcheck
	move $t3, $v0
	
	average_max_skip:	
	
	j oper_average
	
	average_innit:
		move $t2, $v0
		move $t3, $v0
	j average_innit_back
		
	average_end:
						
		la $a0, average_avgmsg		#avg formating
		li $v0, 4			
		syscall		
		
		div $t1, $t1, $t0		#div/print avg
		move $a0, $t1			
		li $v0, 1			
		syscall	
		
		la $a0, average_minmsg		#min formating
		li $v0, 4			
		syscall	
		
		move $a0, $t2			#move/print min
		li $v0, 1			
		syscall		
		
		la $a0, average_maxmsg		#max formating
		li $v0, 4			
		syscall	
		
		move $a0, $t3			#move/print max
		li $v0, 1			
		syscall				
		
		add $t0, $zero, $zero		#reset registers
		add $t1, $zero, $zero
		add $t2, $zero, $zero
		add $t3, $zero, $zero
		
		j main				
oper_f_to_c:
	la $a0, ftoc_msg			# Loads msg to print
	li $v0, 4 				# Calls system print
	syscall					# Prints loaded msg
		la $a0, ftoc_entry_msg		# Loads msg to print
		li $v0, 4			# Calls system print
		syscall				# Prints loaded msg
		
		li $v0, 5			# Reads int
		syscall				# Integer Input
		
		
		
	ftoc_equation:  
		add $t0, $zero, $v0		# Takes value from $v0 and puts into $t0
		sub $t0, $t0, 32		# -32 from $t0
		mul $t1, $t0, 5			# Multiplys $t0 by 5
		div $t1, $t1, 9			# Divides $t1 by 9
		
	ftoc_result:		
		move $a0, $v0			# Moves $v0 to Argument
		li $v0, 1			# Sends $v0 to system to be printed
		syscall				# Prints integer in $v0
		
		la $a0, ftoc_result_msg1	# Loads msg to print
		li $v0, 4			# Calls system print
		syscall				# Prints loaded msg
			
		move $a0, $t1			# Moves $t1 to Argument
		li $v0, 1			# Calls integer print function
		syscall				# System Prints integer
		
		la $a0, ftoc_result_msg2	# Loads msg to print
		li $v0, 4			# Calls system print
		syscall				# Prints loaded msg
		
	ftoc_reset:
		mul $t0, $zero, $t0		# Resets Values
		mul $t1, $zero, $t1		# Resets Values
	j main	
oper_c_to_f:
	la $a0, ctof_msg			# Loads msg to print	
	li $v0, 4 				# Calls system print
	syscall					# Prints loaded msg
		la $a0, ctof_entry_msg		# Loads msg to print
		li $v0, 4			# Calls system print
		syscall				# Prints loaded msg
		
		li $v0, 5			# Reads int
		syscall				# Integer Input
		
	ctof_equation:  
		add $t0, $zero, $v0		# Value $v0 goes into $t0
		mul $t1, $t0, 9			# Multiply $t0 by 9
		div $t1, $t1, 5			# Divides $t1 by 5
		add $t1, $t1, 32		# add 32 from $t1
		
	ctof_result:		
		move $a0, $t0			# Moves $t0 to Argument
		li $v0, 1			# Sends $t0 to system to be printed
		syscall				# Prints integer in $t0
		
		la $a0, ctof_result_msg1	# Loads msg to print
		li $v0, 4			# Calls system print
		syscall				# Prints loaded msg
			
		move $a0, $t1			# Moves $t1 to Argument
		li $v0, 1			# Calls integer print function
		syscall				# System Prints integer
		
		la $a0, ctof_result_msg2	# Loads msg to print
		li $v0, 4			# Calls system print
		syscall				# Prints loaded msg
	ctof_reset:
		mul $t0, $zero, $t0		# Resets Values
		mul $t1, $zero, $t1		# Resets Values

	j main	
oper_feet_to_m:
	la $a0, ftom_entry_msg		# Loads msg to print
	li $v0, 4			# Calls system print
	syscall				# Prints loaded msg
		
	li $v0, 7			#Reads double
	syscall				#Double input
	s.d $f0, feet			#Store input in $f0, label feet
	
	ftom_equation:  
		l.d $f0, feet		#Load double $f0
		l.d $f2, meterDivide	#Load double $f2
		div.d $f2, $f0, $f2	#Divide $f0 by $f2 and store value in $f2
		s.d $f2, meters		#Store result in $f2, label meters.
		
	ftom_result:		
		l.d $f12, feet			#Moves feet to argument $f12
		li $v0, 3			#Sends feet to system to be printed
		syscall				#Prints double feet
		
		la $a0, ftom_result_msg1	# Loads msg to print
		li $v0, 4			# Calls system print
		syscall				# Prints loaded msg
			
		l.d $f12, meters		#Moves meters to argument $f12
		li $v0, 3			#Sends meters to system to be printed
		syscall				#Prints double meters
		
		la $a0, ftom_result_msg2	# Loads msg to print
		li $v0, 4			# Calls system print
		syscall				# Prints loaded msg
	
	ftom_reset:
		sub.d $f0, $f0, $f0		#Sets $f0 equal to 0
		sub.d $f2, $f2, $f2		#Sets $f2 equal to 0
	
	j main	
oper_m_to_feet:
	la $a0, mtof_entry_msg		# Loads msg to print
	li $v0, 4			# Calls system print
	syscall				# Prints loaded msg
		
	li $v0, 7			#Reads double
	syscall				#Double input
	s.d $f0, feet			#Store input in $f0, label feet
	
	mtof_equation:  
		l.d $f0, feet		#Load double $f0
		l.d $f2, meterMultiply	#Load double $f2
		mul.d $f2, $f0, $f2	#Multiply $f0 by $f2 and store value in $f2
		s.d $f2, meters		#Store result in $f2, label meters.
		
	mtof_result:		
		l.d $f12, feet			#Moves feet to argument $f12
		li $v0, 3			#Sends feet to system to be printed
		syscall				#Prints double feet
		
		la $a0, mtof_result_msg1	# Loads msg to print
		li $v0, 4			# Calls system print
		syscall				# Prints loaded msg
			
		l.d $f12, meters		#Moves meters to argument $f12
		li $v0, 3			#Sends meters to system to be printed
		syscall				#Prints double meters
		
		la $a0, mtof_result_msg2	# Loads msg to print
		li $v0, 4			# Calls system print
		syscall				# Prints loaded msg
	
	mtof_reset:
		sub.d $f0, $f0, $f0
		sub.d $f2, $f2, $f2
	
	j main	

exit:	
	la $a0,	exit_msg	
	li $v0, 4	
	syscall			
	
	li $v0, 10		
	syscall			

	.data
msg_commands: 			.asciiz 	"\nOperation Types, type number to select operation: (0-exit, 1-add, 2-subtract, 3-multiply, 4-divide, 5-average, 6-f->c, 7-c->f, 8-feet->meter, 9-meter->feet)"
add_msg: 			.asciiz 	"\nAdd"
	add_txt: 		.asciiz 	"Enter a number to add(0 to exit): "
	sum_txt: 		.asciiz 	"\nThe sum is: "
	num_entered_txt:	.asciiz 	" numbers were entered\n"
	nl: 			.asciiz 	"\n"
Sub_msg: 			.asciiz 	"\nSubtraction Function"
	Sub_nums_entered: 	.asciiz 	"\n\tAmount of numbers entered: "
	Sub_msg1: 		.asciiz 	"\n\tEnter a number to Subtract (Entering 0 exits): "
	Sub_result: 		.asciiz 	"\n\tThe difference is: "
	Sub_curr_diff:		.asciiz		"\tResult = "
	Sub_exit_msg:		.asciiz		"\nCalculation has been terminated.\n"
Mul_msg: 			.asciiz 	"\nMultiplication Function"
	Mul_op_msg: 		.asciiz		"\n\tEnter integers to be Muliplied. (Entering 0 will terminate calculation.) -> "
	Mul_Term_msg: 		.asciiz		"\nCalculation has been terminated.\n"
	Mul_exit_msg:		.asciiz		"\n\tCalculation Results are as follows:"
	Mul_counter:		.asciiz		"\n\t\t Amount of numbers input   = "
	Mul_Product_msg:	.asciiz		"\n\t\t Final product resulted in = " 
	Mul_curr_prod:		.asciiz		"\tResult = "
Div_msg: 			.asciiz 	"\nDivision Function"
	Div_op_msg: 		.asciiz		"\n\tEnter integers to be Divided. (Entering 0 will terminate calculation.) -> "
	Div_Term_msg: 		.asciiz		"\nCalculation has been terminated.\n"
	Div_exit_msg:		.asciiz		"\n\tCalculation Results are as follows:"
	Div_counter:		.asciiz		"\n\t\t Amount of numbers input   = "
	Div_quotient_msg:	.asciiz		"\n\t\t Final quotient resulted in = " 
	Div_curr_quot:		.asciiz		"\tResult = "
avg_msg: 			.asciiz 	"\navg"
	average_intro: 		.asciiz 	"Enter a number to average(0 to exit): "
	average_avgmsg: 	.asciiz 	"\nThe Average is: "
	average_minmsg: 	.asciiz 	"\nThe Minimum Value is: "
	average_maxmsg: 	.asciiz 	"\nThe Maximum Value is: "
ftoc_msg: 			.asciiz 	"\nftoc"
	ftoc_entry_msg:		.asciiz		"\nEnter a Temperature in Fahrenheit to convert to Celsius: "
	ftoc_result_msg1:	.asciiz		" Fahrenheit = "
	ftoc_result_msg2:	.asciiz		" Celsius."
ctof_msg: 			.asciiz 	"\nctof"
	ctof_entry_msg:		.asciiz		"\nEnter a Temperature in Celsius to convert to Fahrenheit: "
	ctof_result_msg1:	.asciiz		" Celsius = "
	ctof_result_msg2:	.asciiz		" Fahrenheit."
ftom_msg: 			.asciiz 	"\nftom"
	feet:			.double 0
	meters:			.double 0.0
	meterDivide:		.double 3.281
	ftom_entry_msg:		.asciiz		"Enter a measurement in Feet to convert to Meters: "
	ftom_result_msg1:	.asciiz		" Feet = "
	ftom_result_msg2:	.asciiz		" Meters."
mtof_msg: 			.asciiz 	"\nmtof"
	meterMultiply:		.double 3.281
	mtof_entry_msg:		.asciiz		"Enter a measurement in Meters to convert to Feet: "
	mtof_result_msg1:	.asciiz		" Meters = "
	mtof_result_msg2:	.asciiz		" Feet."
nbslh: 				.asciiz 	"\n"
exit_msg: 			.asciiz 	"\nProgram Exited\n"