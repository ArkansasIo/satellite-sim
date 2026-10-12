#include "satellite/spacecraft.hpp"
void sat::Spacecraft::install_demo_program(){cpu_.load_program({0x9100,0xA110,0xF000});}
void sat::Spacecraft::command(const Command&c){
 switch(c.id){
  case 1: link_.send_telemetry(0,{1,static_cast<long long>(power_),100});break;
  case 2: antenna_=c.argument!=0;break;
  case 3: power_=c.argument<0?0:(c.argument>100?100:c.argument);break;
  default: link_.send_telemetry(0,{0,-1,0});
 }
}
void sat::Spacecraft::tick(double now){
 link_.advance(now); Command c; while(link_.receive_command(c))command(c);
 cpu_.set_input(0,static_cast<Word>(power_)); cpu_.step();
 link_.send_telemetry(now,{static_cast<std::uint16_t>(10),static_cast<long long>(power_),antenna_?100:25});
 if(power_>0)power_-=0.01;
}
