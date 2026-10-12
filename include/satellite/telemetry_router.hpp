#pragma once
#include "satellite/types.hpp"
#include <unordered_map>
#include <vector>
namespace sat {
struct SatelliteTelemetry {std::string satellite_id; Telemetry packet;};
class TelemetryRouter {
public:
 void ingest(std::string id,Telemetry t){latest_[id].push_back({t});}
 const std::vector<Telemetry>& latest(const std::string&id)const{return latest_.at(id);}
private:
 std::unordered_map<std::string,std::vector<Telemetry>> latest_;
};
}