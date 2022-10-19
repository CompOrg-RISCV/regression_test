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
 	Immediate (r-type) ALU operations
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
 	Immediate (r-type immediate) ALU operations
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
 */
// If a branch test fails, it should branch to BRANCHE_FAIL indicating the
// need to debug your branch circuitry
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
 	Store (s-type)  operations
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
 	Load (l-type)  operations
 */
LOAD_TEST:
// if you have branches working at this point, use a branch to valid the load operation and
// upon a failed load, branch to LOAD_FAIL to indicate a failed load operation which will
// need to be debugged
// 
// Use the data that was stored in memory from the store instruction test sequence to test 
// the load operations
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


