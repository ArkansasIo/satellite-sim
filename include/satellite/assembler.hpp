#pragma once
#include "satellite/types.hpp"
#include <string>
#include <vector>
namespace sat {
class Assembler {
public:
 std::vector<Word> assemble(const std::string& source, CpuWidth width) const;
private:
 Word encode(const std::vector<std::string>& t, CpuWidth width) const;
};
}