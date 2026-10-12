#pragma once
#include <cstdint>
#include <string>
namespace sat {
using Word = std::uint64_t;
enum class CpuWidth : std::uint8_t { W8=8, W18=18, W32=32, W64=64 };
struct Telemetry { std::uint16_t channel{}; std::int64_t value{}; std::uint8_t quality{100}; };
struct Command { std::uint16_t id{}; std::int64_t argument{}; std::uint32_t sequence{}; };
struct LinkConfig { double one_way_seconds{0}; double loss_probability{0}; bool enabled{true}; };
std::string width_name(CpuWidth);
Word mask_for(CpuWidth);
}