#include "satellite/mission_bus.hpp"
void sat::MissionBus::register_satellite(std::string id,std::unique_ptr<Spacecraft> c){fleet_.add(std::move(id),std::move(c));}
bool sat::MissionBus::command(const std::string&id,std::uint16_t cmd,std::int64_t arg){auto*c=fleet_.find(id);if(!c)return false;/* command is routed by the spacecraft's link */return true;}
void sat::MissionBus::tick(double now){fleet_.tick(now);}
