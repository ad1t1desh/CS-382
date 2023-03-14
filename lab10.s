.text 
.global _start
.extern printf


_start: 
adr X0, fmt_str // Load address of the string

// load all values 
adr x1, a
ldr d1, [x1]

adr x2, b
ldr d2, [x2]

adr x3, n
ldr d3, [x3]

adr x4, c1
ldr d4, [x4]

adr x5, c2
ldr d5, [x5]

adr x6, c3
ldr d6, [x6]

adr x7, c4 
ldr d7, [x7]


// set value of iterator
mov x13, #0

// value to use for float registers
mov x14, #2
SCVTF D20, X14

// determine delta x
fsub d8, d2, d1
// divide d8 by n 
fdiv d8, d8, d3


// set first midpoint
fdiv d9, d8, d20
fadd d9, d9, d1

Loop: //repeat until counter = n 

cmp x13, #4
b.eq Print


//find value at midpoint 
// x^4 term 
fmul d10, d9, d9
fmul d10, d10, d9
fmul d10, d10, d9
fmul d10, d4, d10


// x^2 term 
fmul d11, d9, d9
fmul d11, d5, d11
fadd d10, d11, d10

// x term 
fmul d11, d9, d6
//fmul d11, d11, d6
fadd d10, d10, d11

// constant term 
fadd d10, d7, d10

// add to sum for this iteration
fmul d10, d10, d8
fadd d12, d12, d10

//increment counter 
add x13, x13, #1

//determine new midpoint
fadd d9, d8, d9

b Loop



Print: 
// load each into x1 
adr x0, fmt_str
fmov d3, d12
adr x1, a
ldur d0, [x1] 
adr x1, b
ldr d1, [x1]
adr x1, n
ldr d2, [x1]
bl printf
b end




end:
mov x0, #0
mov w8, #93
svc #0


.data
a: .double -1
b: .double 1
n: .double 4

c1: .double 8.32
c2: .double -6.53
c3: .double 9.34
c4: .double 12.32

fmt_str: .ascii "%lf %lf %lf %lf\n\0"

.bss
result: .skip 8



.end
