.text 
.global _start
.extern printf 

_start: 
ldr x4, = g
ldr x4, [x4]
ldr x0, = String
ldr x1, = f
ldr x1, [x1]
ldr x2, = i
ldr x2, [x2]
sub x3, x2, #4
cbnz x3, else 
add x1, x4, #12
b Exit

else : 
sub x1, x4, #24 
b Exit



Exit: 
bl printf
mov x0, #0
mov w8, #93
svc #0

.data
//variables 
i: .dword 0 
f: .dword 0 
g: .dword 0
String:
.ascii "String %d\n"



.end
