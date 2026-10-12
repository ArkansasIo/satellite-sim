#include "satellite/memory.hpp"
#include <cassert>
int main(){sat::MemoryDevice m(sat::MemoryTechnology::MagneticCore,16);m.write(3,42);assert(m.read(3)==42);m.patch(4,{1,2,3});assert(m.read(6)==3);}
