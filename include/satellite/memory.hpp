#pragma once
#include "satellite/types.hpp"
#include <cstdint>
#include <string>
#include <vector>
namespace sat {
enum class MemoryTechnology { MagneticCore, SRAM, EEPROM, Flash, NVRAM };
struct MemoryRegion { std::string name; MemoryTechnology technology; std::uint64_t origin; std::uint64_t words; bool writable; bool persistent; };
class MemoryDevice {
public:
 MemoryDevice(MemoryTechnology technology,std::size_t words);
 void reset();
 Word read(std::size_t address) const;
 void write(std::size_t address,Word value);
 void patch(std::size_t address,const std::vector<Word>& values);
 std::size_t size() const{return data_.size();}
 MemoryTechnology technology() const{return technology_;}
private:
 MemoryTechnology technology_; std::vector<Word> data_;
};
}
