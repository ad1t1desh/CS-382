.text 
.global _start
.extern printf
.equ ELEM, 10

_start: 
.global max_func


max_func: 
mov x2, #ELEM
ldr x1, = arr    
bl findmax 
mov x1, x0
ldr x0, = String
bl printf

max_end:
mov x0, #0
mov w8, #93
svc #0


.func findmax
findmax: 
sub sp, sp, #16
str x30, [sp, 8]
str x3, [sp, 0]
//check if n == 1
subs xzr, x2, #1
b.ne rec
ldr x0, [x1]
// terminate function
b Exit

rec:
sub x2, x2, #1// n - 1
lsl x3, x2, #3// (n-1) * 8
add x3, x1, x3// A[n-1]
ldr x3, [x3]                
bl findmax                 
subs xzr, x3, x0           
b.ge setmax                 
b Exit 

setmax:
// put max in x0 (same as mov)
add x0, x3, xzr             
//.endfunc

Exit:
ldr x30, [sp, 8]
ldr x3, [sp, 0] 
add sp, sp, #16        
br x30             

.endfunc 

.data
String: 
.ascii "String %d\n"
arr:  
.dword 1,2,3,4,5,10,6,7,8,9

.end

