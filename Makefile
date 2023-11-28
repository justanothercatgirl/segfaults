
.PHONY: rust c c++ python

all: asm c cpp fortran rust haskell shell python clean

asm:
	echo -e ".globl main \n main: \n mov $$$$0, %rax \n mov (%rax), %rax" | gcc -xassembler -
	-./a.out

c:
	echo "main;" | gcc -xc - -w
	-./a.out

cpp:
	echo "int main(){*(volatile int*)(-0);}" | gcc -xc++ -
	-./a.out

fortran:
	echo -e " real,pointer::p(:)=>null() \n P(1)=0. \n end" | gfortran-10 -xf95 -
	-./a.out

rust:
	echo "use std::ffi::*;fn main(){unsafe{let i = *(0 as *const c_char);print!(\"{i}\")};}" | rustc - -Awarnings
	-./rust_out

haskell:



shell:
	-kill -11 $$$$

python:
	-echo "import ctypes;ctypes.string_at(0)" | python3
	-echo "eval((lambda:0).__code__.replace(co_consts=()))" | python3
clean:
	rm -f a.out rust_out

