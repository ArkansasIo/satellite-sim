#pragma once
#include "satellite/cpu.hpp"
#include "satellite/radio_link.hpp"
namespace sat {
class Spacecraft {
public:
 Spacecraft(CpuWidth width, RadioLink& link):cpu_(width),link_(link){}
 void tick(double now);
 void install_demo_program();
 double power()const{return power_;}
 bool antenna()const{return antenna_;}
 Cpu& cpu(){return cpu_;}
private:
 Cpu cpu_; RadioLink& link_; double power_{100}; bool antenna_{true}; std::uint32_t telemetry_seq_{};
 void command(const Command&);
};
}