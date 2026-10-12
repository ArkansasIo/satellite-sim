#pragma once
#include "satellite/spacecraft.hpp"
#include <memory>
#include <unordered_map>
namespace sat {
class Fleet {
public:
 void add(std::string id,std::unique_ptr<Spacecraft> craft);
 Spacecraft* find(const std::string& id);
 void tick(double now);
 std::vector<std::string> ids() const;
private: std::unordered_map<std::string,std::unique_ptr<Spacecraft>> crafts_;
};
}