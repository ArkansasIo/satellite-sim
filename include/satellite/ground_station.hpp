#pragma once
#include "satellite/radio_link.hpp"
#include <vector>
namespace sat {
class GroundStation {
public:
 explicit GroundStation(RadioLink& l):link_(l){}
 void send(std::uint16_t id,std::int64_t arg=0){link_.send_command(now_,{id,arg,++seq_});}
 void tick(double now){now_=now;link_.advance(now);Telemetry t;while(link_.receive_telemetry(t))telemetry_.push_back(t);}
 const std::vector<Telemetry>& telemetry()const{return telemetry_;}
private:
 RadioLink& link_;double now_{0};std::uint32_t seq_{0};std::vector<Telemetry> telemetry_;
};
}