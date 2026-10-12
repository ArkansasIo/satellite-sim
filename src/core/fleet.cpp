#include "satellite/fleet.hpp"
void sat::Fleet::add(std::string id,std::unique_ptr<Spacecraft> c){crafts_[std::move(id)]=std::move(c);}
sat::Spacecraft* sat::Fleet::find(const std::string&id){auto i=crafts_.find(id);return i==crafts_.end()?nullptr:i->second.get();}
void sat::Fleet::tick(double now){for(auto&[id,c]:crafts_)c->tick(now);}
std::vector<std::string> sat::Fleet::ids()const{std::vector<std::string>v;for(auto&[id,_]:crafts_)v.push_back(id);return v;}
