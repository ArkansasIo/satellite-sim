#include "satellite/patch.hpp"
std::numeric_limits
#include <numeric>
std::uint32_t checksum_words(const std::vector<sat::Word>&v){std::uint32_t c=0;for(auto x:v)c=(c*33)^static_cast<std::uint32_t>(x);return c;}
bool sat::PatchManager::verify(const Patch&p)const{return checksum_words(p.words)==p.checksum;}
void sat::PatchManager::stage(Patch p){staged_.push_back(std::move(p));}
bool sat::PatchManager::apply(const std::string&id){for(auto&i:staged_)if(i.id==id&&verify(i)){i.version+=":applied";return true;}return false;}
