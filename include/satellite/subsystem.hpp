#pragma once
#include "satellite/component.hpp"
#include "satellite/types.hpp"
#include <vector>
namespace sat {
class Subsystem: public Component {
public:
 explicit Subsystem(std::string id):id_(std::move(id)){}
 const char* name() const override{return id_.c_str();}
 const std::vector<Telemetry>& telemetry() const{return telemetry_;}
protected:
 std::string id_; std::vector<Telemetry> telemetry_;
};
}