#include "satellite/cpu.hpp"
#include <stdexcept>
namespace sat {
Word mask_for(CpuWidth w){ if(w==CpuWidth::W64) return ~Word{0}; return (Word{1}<<static_cast<int>(w))-1; }
std::string width_name(CpuWidth w){ switch(w){case CpuWidth::W8:return "8-bit";case CpuWidth::W18:return "18-bit";case CpuWidth::W32:return "32-bit";default:return "64-bit";} }
Cpu::Cpu(CpuWidth w):width_(w){reset();}
Word Cpu::mask(Word v) const{return v&mask_for(width_);}
void Cpu::reset(){pc_=0;halted_=false;r_.fill(0);mem_.fill(0);io_.fill(0);}
void Cpu::load_program(const std::vector<Word>& p){reset(); for(size_t i=0;i<p.size()&&i<mem_.size();++i) mem_[i]=mask(p[i]);}
void Cpu::set_input(uint16_t p,Word v){io_[p&255]=mask(v);}
Word Cpu::output(uint16_t p) const{return io_[p&255];}
Word Cpu::reg(size_t i) const{return r_.at(i);}
bool Cpu::step(){
 if(halted_) return false;
 const Word ins=mem_[pc_++]; const unsigned op=(ins>>12)&0xF, a=(ins>>8)&0xF, b=(ins>>4)&0xF; const Word imm=ins&0xFF;
 switch(op){
  case 0x0: break; // NOP
  case 0x1: r_[a]=mask(imm); break; // LDI
  case 0x2: r_[a]=mask(r_[a]+r_[b]); break;
  case 0x3: r_[a]=mask(r_[a]-r_[b]); break;
  case 0x4: r_[a]=mask(r_[a]&r_[b]); break;
  case 0x5: r_[a]=mask(r_[a]|r_[b]); break;
  case 0x6: r_[a]=mask(r_[a]^r_[b]); break;
  case 0x7: pc_=imm; break;
  case 0x8: if(r_[a]!=0) pc_=imm; break;
  case 0x9: r_[a]=io_[imm]; break;
  case 0xA: io_[imm]=r_[a]; break;
  case 0xF: halted_=true; break;
  default: throw std::runtime_error("invalid opcode");
 }
 return !halted_;
}
void Cpu::run(size_t n){for(size_t i=0;i<n&&!halted_;++i) step();}
}