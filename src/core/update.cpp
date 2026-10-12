#include "satellite/update.hpp"
bool sat::UpdateManager::validate(const UpdatePackage&p)const{return !p.package_id.empty()&&!p.spacecraft_id.empty()&&!p.to_version.empty();}
void sat::UpdateManager::stage(UpdatePackage p){if(validate(p))packages_.push_back(std::move(p));}
bool sat::UpdateManager::commit(const std::string&id){for(auto&p:packages_)if(p.package_id==id){for(auto&patch:p.patches){if(!patch.version.empty()&&patch.checksum==0)return false;}return true;}return false;}
