#pragma once
#include "satellite/subsystem.hpp"
namespace sat {
class RadioSubsystem final: public Subsystem {
public: RadioSubsystem():Subsystem("radio"){}
 void reset() override{carrier_=true;}
 void tick(double) override{telemetry_.push_back({104,carrier_?1:0,100});}
 void set_carrier(bool v){carrier_=v;}
private: bool carrier_{true};
};
}