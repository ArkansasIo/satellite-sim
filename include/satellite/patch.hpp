#pragma once
#include "satellite/types.hpp"
#include <string>
#include <vector>
namespace sat {
enum class PatchKind { Software, Configuration, TelemetryTable, BootImage, Calibration };
struct Patch {
 std::string id;
 std::string target;
 PatchKind kind;
 std::uint64_t base_address{};
 std::vector<Word> words;
 std::uint32_t checksum{};
 std::string version;
};
class PatchManager {
public:
 bool verify(const Patch&) const;
 void stage(Patch);
 bool apply(const std::string& id);
 const std::vector<Patch>& staged() const{return staged_;}
private: std::vector<Patch> staged_;
};
}
