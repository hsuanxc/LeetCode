.data
arr_1: .word 0, 3
arrSize_1: .word 2
arr_2: .word 9, 8, 7, 6, 7, 8, 6, 2, 1, 0
arrSize_2: .word 10
arr_3: .word 1, 2, 3, 5, 10, 55, 48, 33, 15, 2
arrSize_3: .word 10
arr_4: .word 1, 2, 100, 200, 150, 180, 75, 48, 15, 2
arrSize_4: .word 10
str1:  .string "\nThe answer is true\n\n"
str2:  .string "\nThe answer is false\n\n"
str3:  .string " "

.text
# s1 is a pointer point to arr
# s2 is arrSize
# s3 = arr[i]
# s4 = arr[i+1]
# s5 = 2
# s6 = 1
# t0 is temp value
# t1 is int i
# t2 int status
# t3 is the answer

main:
    addi s5, x0, 2            #Load the constant s5 = 2
    # array 1
    la s1, arr_1              # Load the address to s1
    lw s2, arrSize_1          # Load the array size to s2
    addi s2, s2, -1           # --arrSize
    jal ra, print_number
    la s1, arr_1              # Load the address to s1
    lw s2, arrSize_1          # Load the array size to s2
    addi s2, s2, -1           # --arrSize
    addi t1, x0, 0            # int i = 0
    jal ra validMountainArray 
    # array 2
    la s1, arr_2              # Load the address to s1
    lw s2, arrSize_2          # Load the array size to s2
    addi s2, s2, -1           # --arrSize
    jal ra, print_number
    la s1, arr_2              # Load the address to s1
    lw s2, arrSize_2          # Load the array size to s2
    addi s2, s2, -1           # --arrSize
    addi t1, x0, 0            # int i = 0
    jal ra validMountainArray 
    # array 3
    la s1, arr_3              # Load the address to s1
    lw s2, arrSize_3          # Load the array size to s2
    addi s2, s2, -1           # --arrSize
    jal ra, print_number
    la s1, arr_3              # Load the address to s1
    lw s2, arrSize_3          # Load the array size to s2
    addi s2, s2, -1           # --arrSize
    addi t1, x0, 0            # int i = 0
    jal ra validMountainArray 
    # array 4
    la s1, arr_4              # Load the address to s1
    lw s2, arrSize_4          # Load the array size to s2
    addi s2, s2, -1           # --arrSize
    jal ra, print_number
    la s1, arr_4              # Load the address to s1
    lw s2, arrSize_4          # Load the array size to s2
    addi s2, s2, -1           # --arrSize
    addi t1, x0, 0            # int i = 0
    jal ra validMountainArray 
    # exit
    j exit

print_number:
    lw t0, 0(s1)        # load word arr[0] to temp
    addi s1, s1, 4      # arr++
    addi a0, t0, 0      # a0 = temp, output to console
    li, a7, 1           # Call system call, and print int
    ecall
    la a0, str3         # load string
    li a7, 4            # Call system call, and print string
    ecall    
    addi s2, s2, -1     # arrSize--;
    bge s2, s6, print_number # while(arrSize >= 1)
    ret

validMountainArray:
    addi t2, x0, 0            # int status = 0
    addi t3, x0, 1            # int ans = 1
    blt s2, s5, false         # if(arrSize < 2) break;
    lb s3, 0(s1)              # s3 = arr[i]
    lb s4, 4(s1)              # s4 = arr[i+1]
    blt t1, s2, loop          # while loop
    ret
loop:
    beq t1, s2, judge            # if(i >= arrSize) judge();
    beq s3, s4, false            # if(arr[i] == arr[i+1]) false();
    blt s3, s4, increase         # if(arr[i] < arr[i+1]) increase();
    blt s4, s3, decrease         # if(arr[i] > arr[i+1]) decrease();

increase:
    addi t1, t1, 1            # i++;
    addi s1, s1, 4            # s1 = &arr;
    lb s3, 0(s1)              # s3 = arr[i];
    lb s4, 4(s1)              # s4 = arr[i+1];
    addi t2, x0, 1
    j loop
decrease:
    addi t1, t1, 1            # i++;
    addi s1, s1, 4            # s1 = &arr;
    lb s3, 0(s1)              # s3 = arr[i];
    lb s4, 4(s1)              # s4 = arr[i+1];
    addi t0, x0, 0            # temp = 0;
    beq t2, t0, false         # if (stauts == 0) false();
    j loop

false:
    la a0, str2     # load "false" string
    li a7, 4        # Call system call, and print string
    ecall
    addi t1, s2, 0  # set i = arrSize
    ret
judge:
    la a0, str1     # because didn't return false, load "true" string
    li a7, 4        # Call system call, and print string
    ecall
    ret

exit:
    li a7, 10          # Exit the program
    ecall