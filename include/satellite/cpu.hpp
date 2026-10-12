#pragma once
#include "satellite/types.hpp"
#include <array>
#include <string>
#include <vector>
namespace sat {
class Cpu {
public:
 explicit Cpu(CpuWidth width);
 void reset();
 void load_program(const std::vector<std::uint64_t>& words);
 bool step();
 void run(std::size_t max_steps=1000);
 Word reg(std::size_t i) const;
 Word pc() const { return pc_; }
 bool halted() const { return halted_; }
 void set_input(std::uint16_t port, Word value);
 Word output(std::uint16_t port) const;
private:
 CpuWidth width_; Word pc_{0}; bool halted_{false};
 std::array<Word,16> r_{}; std::array<Word,256> mem_{}; std::array<Word,256> io_{};
 Word mask(Word v) const;
};
}