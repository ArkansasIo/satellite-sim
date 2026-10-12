#include "satellite/memory.hpp"
#include <stdexcept>
sat::MemoryDevice::MemoryDevice(MemoryTechnology t,std::size_t words):technology_(t),data_(words,0){}
void sat::MemoryDevice::reset(){std::fill(data_.begin(),data_.end(),0);}
sat::Word sat::MemoryDevice::read(std::size_t a)const{if(a>=data_.size())throw std::out_of_range("memory read");return data_[a];}
void sat::MemoryDevice::write(std::size_t a,Word v){if(a>=data_.size())throw std::out_of_range("memory write");data_[a]=v;}
void sat::MemoryDevice::patch(std::size_t a,const std::vector<Word>&v){if(a+v.size()>data_.size())throw std::out_of_range("memory patch");std::copy(v.begin(),v.end(),data_.begin()+a);}
