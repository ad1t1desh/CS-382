.text 
.global _start
.extern printf


_start: 
//.global distance


//.func distance

//load in 
ldr x2, = P // load the point address
ldr x20, [x2] //x1 in x20 
add x3, x2, #8 
ldr x3, [x3] //y1 in x3

ldr x4, = C
ldr x21, [x4] //x2 in x21
add x5, x4, #8
ldr x5, [x5] //y2 in x5


ldr x6, = p3
ldr x6, [x6] // loads the radius 

//find the two differences
sub x7, x20, x21
sub x8, x5, x3
mul x7, x7, x7
mul x8, x8, x8
add x9, x7, x8
mul x6, x6, x6 
subs xzr, x6, x9 
b.gt exit1
ldr x0, = no 
bl printf
b endfr







exit1: 
ldr x0, = yes
bl printf
b endfr

endfr:
mov x0, #0
mov w8, #93
svc #0


//.endfunc
.data
P: .quad 0, 0
C: .quad 1, 2
p3: .quad 2
yes: .ascii "P is inside the circle.\n\0"
no: .ascii "P is outside the circle.\n\0"
 
.end
