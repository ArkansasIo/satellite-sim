#pragma once
#include "satellite/patch.hpp"
#include <string>
namespace sat {
struct UpdatePackage { std::string package_id; std::string spacecraft_id; std::string from_version; std::string to_version; std::vector<Patch> patches; };
class UpdateManager {
public:
 bool validate(const UpdatePackage&) const;
 void stage(UpdatePackage);
 bool commit(const std::string& package_id);
private: std::vector<UpdatePackage> packages_;
};
}
