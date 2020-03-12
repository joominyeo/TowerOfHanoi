//
// cyclicHanoi.s
//
// Cyclic Tower of Hanoi game
//
// return the number of steps in x2, x16 and x17 as placeholder registers

        eor     x2, x2, x2
        eor 	x11, x11, x11 //placeholder for switching A,B,C
        eor 	x12, x12, x12
        addi 	x12, x12, #1 //regulates if next movecw is from A
        eor 	x13, x13, z13 //regulates if next movecw is from B
        eor 	x14, x14, x14 //regulates if next movecw is from C
        eor 	x16, x16, x16
        eor 	x17, x17, x17

// x19, x20, x21 are stack pointers for stacks A, B, C
// stacks A, B, C grow upwards

        addi    x19, xzr, #0        // x19 = 0x0000
        addi    x20, xzr, #0x80     // x20 = 0x0080
        addi    x21, xzr, #0x100    // x21 = 0x0100

// place a very large disk of size 255 at the bottom of each stack

        addi    x15, xzr, #0xff     // size of very large disk
        stur    x15, [x19, #0]
        stur    x15, [x20, #0]
        stur    x15, [x21, #0]

// place disks n..1 on stack A

        addi    x4, xzr, #10        // n = 10
        add     x15, xzr, x4
loop:   addi    x19, x19, #8
        stur    x15, [x19, #0]
        subi    x15, x15, #1
        cbnz    x15, loop

        bl      chanoi
        stop

chanoi:	add 	x15, xzr, x4
		


movecw:	subi 	sp, sp, #64
		stur 	fp, [sp, #0]
		addi 	fp, sp, #56
		stur 	lr, [fp, #-48]
		stur 	x15, [fp, #0]
		stur 	x12, [fp, #-8]
		stur 	x13, [fp, #-16]
		stur 	x14, [fp, #-24]

		subi 	xzr, x15, #1
		b.le 	decide
		subi 	x15, x15, #1

		bl 		moveccw
		addi 	x15, xzr, #1
		bl 		movecw
		ldur 	x15, [fp, #0]
		subi 	x15, x15, #1
		add 	x11, x12, xzr
		add 	x12, x13, xzr
		add 	x13, x14, xzr
		add 	x14, x11, xzr
		bl 		moveccw
		

decide:	cbnz 	x12, moveAB
		cbnz 	x13, moveBC
		cbnz 	x14, moveCA

moveAB:	ldur 	x16, [x19, #0]
		ldur 	x17, [x20, #0]
		subi 	x31, x16, x17
		b.hi 	error
		addi 	x20, x20, #8
		stur 	x16, [x20, #0]
		stur	x31, [x19, #0]
		subi	x19, x19, #8
		addi 	x2, x2, #1
		b 		donecw
		
moveBC:	ldur 	x16, [x20, #0]
		ldur 	x17, [x21, #0]
		subi 	x31, x16, x17
		b.hi 	error
		addi 	x21, x21, #8
		stur 	x16, [x21, #0]
		stur	x31, [x20, #0]
		subi	x20, x20, #8
		addi 	x2, x2, #1
		b 		donecw

moveCA:	ldur 	x16, [x21, #0]
		ldur 	x17, [x19, #0]
		subi 	x31, x16, x17
		b.hi 	error
		addi 	x19, x19, #8
		stur 	x16, [x19, #0]
		stur	x31, [x21, #0]
		subi	x21, x21, #8
		addi 	x2, x2, #1
		b 		donecw

donecw: ldur 	lr, [fp, #-48]
		ldur 	x12 [fp, #-8]
		ldur 	x13 [fp, #-16]
		ldur 	x14 [fp, #-24]
		ldur 	fp, [fp, #-56]
		addi 	sp, sp, #64
		br 		lr



moveccw:subi 	sp, sp, #64
		stur 	fp, [sp, #0]
		addi 	fp, sp, #56
		stur 	lr, [fp, #-48]
		stur 	x15, [fp, #0]
		stur 	x12, [fp, #-8]
		stur 	x13, [fp, #-16]
		stur 	x14, [fp, #-24]


		subi	x15, x15, #1
		bl 		moveccw

		addi 	x15, xzr, #1
		bl 		movecw

		add 	x11, x12, xzr
		add 	x12, x13, xzr
		add 	x13, x14, xzr
		add 	x14, x11, xzr
		ldur 	x15, [fp, #0]
		subi 	x15, x15, #1
		bl 		movecw

		add 	x11, x12, xzr
		add 	x12, x13, xzr
		add 	x13, x14, xzr
		add 	x14, x11, xzr
		addi 	x15, xzr, #1
		bl 		movecw

		add 	x11, x12, xzr
		add 	x12, x13, xzr
		add 	x13, x14, xzr
		add 	x14, x11, xzr
		ldur 	x15, [fp, #0]
		subi 	x15, x15, #1
		bl 		moveccw
		b 		doneccw

doneccw: ldur 	lr, [fp, #-48]
		ldur 	x12 [fp, #-8]
		ldur 	x13 [fp, #-16]
		ldur 	x14 [fp, #-24]
		ldur 	fp, [fp, #-56]
		addi 	sp, sp, #64
		br 		lr

		

////////////////////////////////////
//
// Your code
//
////////////////////////////////////


// moving one item from one stack to the next
// call each as needed (thinking like branch with link)


	

error:  subi    x2, xzr, #1         // return -1 if error
        br      lr
