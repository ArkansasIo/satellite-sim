#pragma once
#include "satellite/fleet.hpp"
#include <unordered_map>
namespace sat {
class MissionBus {
public:
 void register_satellite(std::string id,std::unique_ptr<Spacecraft> craft);
 bool command(const std::string& id, std::uint16_t command, std::int64_t argument=0);
 void tick(double now);
 std::vector<std::string> satellites() const{return fleet_.ids();}
 Spacecraft* spacecraft(const std::string&id){return fleet_.find(id);}
private: Fleet fleet_;
};
}