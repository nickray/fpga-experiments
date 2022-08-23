#include <stdio.h>
#include <stdlib.h>
#include "Vthruwire.h"
#include "verilated.h"

int main(int argc, char **argv) {
	Verilated::commandArgs(argc, argv);
	Vthruwire *tb = new Vthruwire;

	for(int i=0; i!=20; i++) {
		tb->i_sw = i&1;
		tb->eval();

		printf("i = %2d, ", i);
		printf("sw = %2d, ", tb->i_sw);
		printf("led = %2d\n", tb->o_led);
	}
}
