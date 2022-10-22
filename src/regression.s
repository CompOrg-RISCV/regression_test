/*
 * regression_.s
 *
 * Author:
 * Date:
 *
 */

 // Section .crt0 is always placed from address 0
	.section .crt0, "ax"

_start:
	.global _start

 /*
 	Immediate (i-type) ALU operations
    
    Suggested tests or unique features of ITYPE instructions
    - there are 6 immediate arithematic operations
        - addi
        - slti
        - sltiu
        - xori
        - andi
    - immediates are positive and negative
    - there are operations that use unsigned numbers
    - there are comparison operations that need to test the 3 options
         - less than
         - equal
         - greater than
    - there must be 3 nops between instructions in that this test will be
    used before data hazard detection and forwarding has been implemented
 */
 	addi x2, x0, 2				// load 2 into register x2
 	nop
 	nop
 	nop
 	addi x2, x2, (-1 & 0xfff)	// add -1 to x2
 	nop					// x2 = 2
 	nop
 	nop
 	slti x3, x2, 2				// compare 1 to 2, less than so x3 = 1
 	nop					// x2 = 1
 	nop
 	nop
 	slti x3, x2, 1				// compare 1 to 1, not less than, so x3 = 0
 	nop					// x3 = 1
 	nop
 	nop
 	nop
 	nop					// x3 = 0
 	nop
 	nop
 	nop
 	nop
  	halt
 	nop
 	nop
 	nop
 	nop
 /*
 	RTYPE ALU operations

    Suggested tests or unique features of RTYPE instructions
    - there are 10 rtype arithematic operations
        - add
        - sub
        - sll
        - slt
        - sltu
        - xor
        - srl
        - sra
        - or
        - and
    - two register operands that can either be positive and negative
    - there are operations that use unsigned numbers
    - there are comparison operations that need to test the 3 options
         - less than
         - equal
         - greater than
    - there must be 3 nops between instructions in that this test will be
    used before data hazard detection and forwarding has been implemented
    
    - recommend that before testing the operations, use addi opertion to load
    different test values in registers that will be used by the different
    RTYPE instruction tests
         - example, addi x1, x0, 1   // loads a 1 in register x1
                    addi x2, x0, -1  // loads a -1 (0xffffffff) into register x2
 */
    nop 
	nop
	nop
	nop
	nop
 	halt
 	nop
 	nop
 	nop
 	nop
 /*
 	Shift Immediate ALU operations
      
    Suggested tests or unique features of Shift Immediate instructions
    - there are 3 shift immediate operations  
        - slli
        - srli
        - srai
    - logical shifts do not maintain the sign of the operand (the number 
    of bits shifted are padded with 0s) while an arithematic shifts maintain 
    the sign (the number of bits shifted are padded with the sign bit value)
    - both negative and positive values must be tested for each operation
 */
	nop
	nop
	nop
	nop
 	halt
 	nop
 	nop
 	nop
 	nop
 /*
 	Data hazard detection and forwarding test sequences
    
    - Data forward removes the requirement of putting nops between each 
    instruction.  Starting at this test, there should not be a requirement
    to place nops between instructions
    - Data forwarding must be tested for each register operand, rs1 and rs1,
    for each instruction in the pipeline after the ID (Instruction Decode) stage,
    EX, MEM, and WB.  To test this combination, a minimum of 6 tests are required.
 */
 	addi x2, x0, 1				// load x2 register with 1
 	addi x3, x0, 2				// load x3 register with 2
 	addi x4, x0, 3				// load x4 register with 3
 	addi x5, x0, -1				// load x5 register with -1
	nop
	nop
	nop
	nop
  	halt
 	nop
 	nop
 	nop
 	nop
 /*
 	Branch (b-type) operations

    Suggested tests or unique features of BTYPE (branch) instructions
    - there are 6 BTYPE (branch) operations  
        - beq
        - bne
        - blt
        - bge
        - bltu
        - bgeu
    - there are operations that use unsigned values (bltu & bgeu)
    - both negative and positive operands should be tested
    - branches are comparison operations that need to test the 3 options
         - less than
         - equal
         - greater than
    - a test must ensure that the branch goes to the proper address
    - branch immediates are signed which indicates a branch should test
    both positive (forward) branches and negative (backword) branches
    - You can add new BRANCH labels for testing.  Highly recommended.
    - if a branch test fails, it should branch to the BRANCH_FAIL label to 
    help indicate which branch test fails

 */
	nop
	nop
	nop
	nop
	beq x0, x0, PASS
    nop
    nop
    nop
BRANCH_FAIL:
	nop
	nop
	nop
	nop
	halt		// Branch test has failed, time to debug
	nop
	nop
	nop
	nop
PASS:
	nop
	nop
	nop
  	halt
 	nop
 	nop
 	nop
 	nop
 /*
 	jump instruction operations

    Suggested tests or unique features of Jump instructions
    - there are 2 jump operations  
        - jalr
        - jal
    - jump operations change the flow of a program without the need to 
    pass a conditional statement such as less than
    - a test must ensure that the jump goes to the proper address
    - jump immediates are signed which indicates a jump should test
    both positive (forward) jumps and negative (backword) jumps
    - jump instructions store the return address, pc + 4, in the rd,
    destination register, which must be tested/validated
    - You can add new JUMP labels for testing.  Highly recommended.
    - if a jump test fails, it should branch to the JUMP_FAIL label to 
    help indicate which jump test fails
 */
	nop
	nop
	nop
	nop
  	halt
    nop
    nop
    nop
    jal x0, JUMP_PASS
 	nop
JUMP_FAIL:
 	nop
 	nop
 	nop
    halt
    nop
    nop
JUMP_PASS:
    nop
    nop
 /*
 	Store (s-type)  operations

    Suggested tests or unique features of store instructions
    - there are 3 store operations  
        - sw
        - sh
        - sb
    - store immediates are signed which indicates a store should test
    both a positive and negative immediate
    - a byte can be placed into one of the four byte locations of a 
    data word indicating a minimum of 4 sb (store byte) tests
    - a half-word can be placed into two of the four half-word locations
    of a data word indicating a minimum of 2 sh (store half-word) tests
    - you  will be using the memory view of the debugger to validate 
    the store operations
 */
 	// Loading test data into registers for Store / Load tests
    lui x20, 0x210
    srli x20, x20, 12
    lui x30, 0x76543
    or x20, x20, x30                        // x20 = 76543210
    lui x21, 0xdef
    srli x21, x21, 12
    lui x30, 0x89abc
    or x21, x21, x30                        // x21 = 0x89abcdef

 	// Load register x10 with base DATA memory location
 	lui x10, (DATA & 0xfff)		            // Use linker to obtain lower 12-bits
 	srli x10, x10, 12				        // Move the lower 12-bits to locations 11..0
    lui x30, ((DATA & 0xfffff000) >> 12)    // Move the upper DATA address bits into upper 20-bits
 	or x10, x10, x30           	        // x10 = DATA address
 	// Load register x11 with base DATA_MINUs location
 	lui x11, (DATA_MINUS & 0xfff)		    // Use linker to obtain lower 12-bits
 	srli x11, x11, 12				        // Move the lower 12-bits to locations 11..0
    lui x30, ((DATA_MINUS & 0xfffff000) >> 12)    // Move the upper DATA address bits into upper 20-bits
 	or x11, x11, x30           	        // x11 = DATA_MINUS address
 	// start of Store Instruction test
	nop
	nop
	nop
	nop
  	halt
  	nop
  	beq x0, x0, LOAD_TEST
  	nop
  	nop
 /*
 	Data Memory Space for regression test
 	- There are 8 NOP locations which are available
 		to be overwritten for test
 	- Accessing the first data location by 0 offset of x10 => 0(x10)
 	- Accessing the 1st byte in data space is 1 offset of x10 => 1(x10)
 	- Accessing the 2nd half-word in data space is 2 offset of x10 => 2(x10)
 	- Accessing the 2nd word in data space is 4 offset of x10 => 4(x10)
 */
DATA:
 	nop
 	nop
 	nop
 	nop
 	nop
 	nop
 	nop
 	nop
 DATA_MINUS:
    nop
    nop
    nop
    nop

 /*
 	Load operations
    
    Suggested tests or unique features of load instructions
    - there are 5 load operations  
        - lw
        - lh
        - lhu
        - lb
        - lbu
    - load immediates are signed which indicates a load should test
    both a positive and negative immediate
    - a byte can be read from one of the four byte locations of a 
    data word indicating a minimum of 4 lb (load byte) tests
    - a minimum of two unsigned load byte (lbu) to test a byte with 
    bit 7 a 0 and a 1 to validate proper signed bit extension
    - a half-word can be placed into two of the four half-word locations
    of a data word indicating a minimum of 2 lh (load half-word) tests
    - a minimum of two unsigned load byte (lhu) to test a half-word with 
    bit 15 a 0 and a 1 to validate proper signed bit extension
    - You can use the test values in memory from the store testss for the load 
    memory tests
         - You can use the DATA and DATA_MINUS labels that were used for stores
    - if you have branches working at this point, use a branch to validate 
    the proper load operation and upon failure, branch to LOAD_FAIL label to
    indicate a failed load operation to debug
 */
LOAD_TEST:
	nop
	nop
	nop
	nop
  	halt
 	nop
 	nop
 	nop
 	nop
 LOAD_FAIL:							// Using branch statements, if load does not
 	nop								// return result expected, branch to LOAD_FAIL label
 	nop
 	nop
 	halt
 	nop
 	nop
 	nop
 	nop


