#include "satellite/spacecraft.hpp"
#include "satellite/ground_station.hpp"
#include <iostream>
int main(){
 sat::RadioLink link({1.0,0.0,true});
 sat::Spacecraft craft(sat::CpuWidth::W18,link);
 sat::GroundStation ground(link);
 craft.install_demo_program();
 ground.send(1);
 for(int i=0;i<5;++i){double t=i*1.0;craft.tick(t);ground.tick(t);}
 std::cout<<"Satellite Sim running; telemetry packets="<<ground.telemetry().size()<<"\n";
 return 0;
}
