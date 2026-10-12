#pragma once
#include "satellite/subsystem.hpp"
namespace sat {
class AntennaSubsystem final: public Subsystem {
public: AntennaSubsystem():Subsystem("antenna"){}
 void reset() override{locked_=false;}
 void tick(double) override{telemetry_.push_back({101,locked_?1:0,100});}
 void lock(bool v){locked_=v;}
 bool locked()const{return locked_;}
private: bool locked_{false};
};
}