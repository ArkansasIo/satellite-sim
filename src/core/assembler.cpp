#include "satellite/assembler.hpp"
#include <sstream>
#include <unordered_map>
#include <algorithm>
#include <cctype>
namespace sat {
static std::string up(std::string s){for(char&c:s)c=static_cast<char>(std::toupper(static_cast<unsigned char>(c)));return s;}
static unsigned regno(const std::string&s){return static_cast<unsigned>(std::stoul(s.substr(1)));}
std::vector<Word> Assembler::assemble(const std::string& src,CpuWidth w) const{
 std::vector<std::string> lines; std::unordered_map<std::string,Word> labels; std::stringstream ss(src); std::string line; Word pc=0;
 while(std::getline(ss,line)){auto p=line.find(';');if(p!=std::string::npos)line.resize(p);for(char&c:line)if(c==','||c=='['||c==']')c=' ';std::stringstream ls(line);std::string tok; if(!(ls>>tok))continue; if(tok.back()==':'){tok.pop_back();labels[up(tok)]=pc; if(!(ls>>tok))continue;} lines.push_back(line);++pc;}
 std::vector<Word> out; for(auto&l:lines){std::stringstream ls(l);std::string op;ls>>op;op=up(op);if(op.back()==':')continue;std::vector<std::string> t{op};std::string x;while(ls>>x)t.push_back(x);out.push_back(encode(t,w));} return out;
}
Word Assembler::encode(const std::vector<std::string>&t,CpuWidth) const{
 auto imm=[&](const std::string&s)->Word{int base=10;size_t z=0;if(s.rfind("0x",0)==0||s.rfind("0X",0)==0)base=16;return std::stoull(s,&z,base);};
 if(t[0]=="NOP")return 0x0000;if(t[0]=="HALT")return 0xF000;
 if(t[0]=="LOAD"&&t.size()>=3)return 0x1000|(regno(t[1])<<8)|imm(t[2]);
 if(t[0]=="ADD"&&t.size()>=3)return 0x2000|(regno(t[1])<<8)|(regno(t[2])<<4);
 if(t[0]=="SUB"&&t.size()>=3)return 0x3000|(regno(t[1])<<8)|(regno(t[2])<<4);
 if(t[0]=="AND"&&t.size()>=3)return 0x4000|(regno(t[1])<<8)|(regno(t[2])<<4);
 if(t[0]=="OR"&&t.size()>=3)return 0x5000|(regno(t[1])<<8)|(regno(t[2])<<4);
 if(t[0]=="XOR"&&t.size()>=3)return 0x6000|(regno(t[1])<<8)|(regno(t[2])<<4);
 if(t[0]=="JMP"&&t.size()>=2)return 0x7000|imm(t[1]);
 if(t[0]=="JNZ"&&t.size()>=3)return 0x8000|(regno(t[1])<<8)|imm(t[2]);
 if(t[0]=="IN"&&t.size()>=3)return 0x9000|(regno(t[1])<<8)|imm(t[2]);
 if(t[0]=="OUT"&&t.size()>=3)return 0xA000|(regno(t[1])<<8)|imm(t[2]);
 throw std::runtime_error("assembler: unknown instruction");
}
}