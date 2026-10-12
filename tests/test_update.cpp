#include "satellite/patch.hpp"
#include <cassert>
int main(){sat::PatchManager p;sat::Patch x{"P1","SC1",sat::PatchKind::TelemetryTable,0,{1,2},0,"1.1"};p.stage(x);assert(!p.apply("P1"));}
