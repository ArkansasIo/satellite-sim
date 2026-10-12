#pragma once
#include "satellite/types.hpp"
namespace sat {
struct CpuConfig {CpuWidth width{CpuWidth::W18}; std::size_t memory_words{256};};
struct SpacecraftConfig {std::string id{"SC-001"}; CpuConfig cpu{}; double power_capacity{100};};
struct FleetConfig {std::vector<SpacecraftConfig> spacecraft;};
}