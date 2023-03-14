.text 
.global _start
.extern printf
.extern scanf


_start: 
// make string
ldr x0, = input
ldr x1, = query
bl scanf
ldr x1, = query
ldr x1,[x1, #0]
ldr x2, = arr
ldr x3, = size
ldr x3, [x3]


// initialize low
mov x4 #0

// initialize high 
sub x6, x3, #1

// initialize counter 

loop:
    // exit if low is greater than high
    cmp x4, x6
    b.gt case4
    // initialize mid
    sub x5, x6, x4
    lsr x5, x5, #1
    add x5, x5, x4

    // generate offset for mid 
    lsl x20, x5, #3

    // load arr[mid]
    ldr x21, [x2, x20]

    // if arr[mid] == element brnach to end 
    cmp x21, x1
    b.eq end

    // else if x > arr[mid] low = mid + 1 branch to beginninbg 
    cmp x21, x1
    b.gt case2

    // else high = mid - 1 branch to beginning 
    sub x6, x5, #1
    b loop



case2:
add x4, x5, #1
b loop

case4:
// print no solution
ldr x0, = no
bl printf
b endfr

end: 
// print x5 
ldr x0, = yes
mov x1, x5
bl printf
b endfr

endfr: 
mov x0, #0
mov w8, #93
svc #0




.data
arr: .dword 1,2,3,4,5,0
size: .dword 6
yes: .ascii "Query found. %d\n\0"
no: .ascii "Query not found.\n\0"
query: .dword 0
input: .string "%ld"


.end 
