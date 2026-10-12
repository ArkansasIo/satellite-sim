#pragma once
#include "satellite/subsystem.hpp"
namespace sat {
class PowerSubsystem final: public Subsystem {
public: PowerSubsystem():Subsystem("power"){}
 void reset() override{charge_=100; draw_=0;}
 void tick(double dt) override{if(enabled_) charge_=std::max(0.0,charge_-draw_*dt); telemetry_.push_back({100,static_cast<long long>(charge_),static_cast<std::uint8_t>(charge_)});}
 void set_draw(double watts){draw_=watts;}
 double charge()const{return charge_;}
private: double charge_{100},draw_{0};
};
}