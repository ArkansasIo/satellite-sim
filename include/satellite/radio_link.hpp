#pragma once
#include "satellite/types.hpp"
#include <queue>
namespace sat {
struct Packet { double deliver_at{}; bool uplink{}; Command command{}; Telemetry telemetry{}; };
class RadioLink {
public:
 explicit RadioLink(LinkConfig c={}):cfg_(c){}
 void send_command(double now, Command c);
 void send_telemetry(double now, Telemetry t);
 void advance(double now);
 bool receive_command(Command&);
 bool receive_telemetry(Telemetry&);
 const LinkConfig& config()const{return cfg_;}
private:
 LinkConfig cfg_; std::queue<Packet> pending_, commands_, telemetry_;
};
}