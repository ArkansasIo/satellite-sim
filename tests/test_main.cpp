#include "satellite/cpu.hpp"
#include "satellite/assembler.hpp"
#include <cassert>
#include <iostream>
int main(){
 sat::Assembler a; auto p=a.assemble("LOAD R0, 7\nLOAD R1, 3\nADD R0, R1\nHALT\n",sat::CpuWidth::W8);
 sat::Cpu c(sat::CpuWidth::W8); c.load_program(p); c.run();
 assert(c.reg(0)==10);
 sat::Cpu c18(sat::CpuWidth::W18); c18.load_program({0x1000|255,0xF000}); c18.run(); assert(c18.reg(0)==255);
 std::cout<<"All satellite simulator tests passed.\n";
}
