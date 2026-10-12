#pragma once
#include "satellite/subsystem.hpp"
namespace sat {
class ThermalSubsystem final: public Subsystem {
public: ThermalSubsystem():Subsystem("thermal"){}
 void reset() override{temperature_=20;}
 void tick(double dt) override{temperature_+=heat_*dt; temperature_+=(20-temperature_)*0.01*dt; telemetry_.push_back({102,static_cast<long long>(temperature_*100),100});}
 void set_heat(double h){heat_=h;}
 double temperature()const{return temperature_;}
private: double temperature_{20},heat_{0};
};
}