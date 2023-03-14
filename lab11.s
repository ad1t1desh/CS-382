.text
.global _start


_start:
    // each iteration recieve one character
    // increment byte until reach '\n'
    mov x9, #0      // initialize sum
    mov x19, #10    // 10 to be multiplied
    //mov x22, #1


// x0 fd: file descriptor = 0
// x1 buf: address where string is stored
// x2 nbyte: number of bytes of string

// ssize_t read(int fd, void* buf, size_t nbyte);
read:
    mov     x0, #0      /* status := 0 */
    ldr     x20, =input
    mov     x1, x20 
    mov     x2, #1      // read one byte at a time
    mov     x8, #63     /* read is syscall #1 */
    svc     #0          /* invoke syscall */

loop:
    ldur x1, [x20]      // load string
    cmp x1, '\n'        // compare end of string
    b.eq squared

convertString:
    sub x1, x1, #48      // ' ' - 48
    mul x9, x9, x19     // int*10
    add x9, x9, x1      // sum = sum + int
    b read

squared:
    mul x9, x9, x9      // x^2
    //b initializeNumOfDigits
mov x10, #0
add x14, xzr, x9

// x0 fd: file descriptor = 1
// x1 buf: address where string is stored
// x2 nbyte: number of bytes of string

//initializeNumOfDigits:
  //mov x10, #0             // initialize counter
    //mov x14, x9             // initialize num of digits
numOfDigits:
    cmp x14, #0             // num/10 > 0
    b.eq init
    udiv x14, x14, x19      // num = num / 10
    add x10, x10, #1        // increment counter
    b numOfDigits
init: 
sub x23, x10, #1 
add x26, xzr, x10 


//initializeExponent:
 //   add x22, xzr, #1          // initialize exponent
 //   add x23, xzr, #1          // initialize counter
  //  sub x10, x10, #1     // numofdigits-1     
exponent:      
    cmp x23, #0        // i <= numofdigits-1
    b.le convertInt
    mul x22, x22, x19   // exp = exp * 10
    sub x23, x23, #1    // increment counter
    b exponent

//initializeConvert:
    //add x26,xzr, x22
convertInt:
mov x25, x9
    cmp x26, #0
    b.eq exit
    udiv x25, x9, x22      // integer division x^2 / 10^#digits-1
    add x25, x25, #48      // add 48

    // system call write 
    adr x1, output
    stur x25, [x1]
    mov     x0, #1      /* status := 1 */
    mov     x2, #1      // read one byte at a time
    mov     x8, #64     /* read is syscall #1 */
    svc     #0          /* invoke syscall */
    
    sub x25, x25, #48
    mul x24, x25, x22      // *10^#digits-1
    sub x9, x9, x24       // x^2 - x24
    sub x26, x26, #1
    mov x22, #1
    mov x23, x26
    b exponent

exit:
    // ldr x0, =output
    // mov x1, x22
    // bl printf
    mov     x0, #0      /* status := 0 */
    mov     w8, #93     /* exit is syscall #1 */
    svc     #0          /* invoke syscall */

.data
input: .space 8
.bss
output: .space 64
.end
