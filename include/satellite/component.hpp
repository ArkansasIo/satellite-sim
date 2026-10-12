#pragma once
#include <string>
namespace sat {
class Component {
public:
 virtual ~Component()=default;
 virtual const char* name() const=0;
 virtual void reset()=0;
 virtual void tick(double dt)=0;
 bool enabled() const{return enabled_;}
 void set_enabled(bool v){enabled_=v;}
protected: bool enabled_{true};
};
}