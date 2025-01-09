// global starts acts as an int main() in c/c++ prototype
.global _start

//kinda like the function in c/C++
//label
_start:
	//moves/copy data to and from registers
	//put 42 into register 0
	//# for immediate value
	mov r0, #42  	//return 42;
	//do a system call to exit the program
	//to do a syscall i need to put the syscall number in a specific register r7
	mov r7, #1

	//now i want interupt my program and run this syscall that i set up
	//software interupt
	swi 0
