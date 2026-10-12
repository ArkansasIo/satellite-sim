#pragma once
#include "satellite/subsystem.hpp"
namespace sat {
class AttitudeSubsystem final: public Subsystem {
public: AttitudeSubsystem():Subsystem("attitude"){}
 void reset() override{yaw_=pitch_=roll_=0;}
 void tick(double) override{telemetry_.push_back({103,static_cast<long long>(yaw_*100),100});}
 void set(double y,double p,double r){yaw_=y;pitch_=p;roll_=r;}
private: double yaw_{},pitch_{},roll_{};
};
}