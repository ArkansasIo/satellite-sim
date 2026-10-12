#include "satellite/radio_link.hpp"
void sat::RadioLink::send_command(double now,Command c){if(cfg_.enabled)pending_.push({now+cfg_.one_way_seconds,true,c,{}});}
void sat::RadioLink::send_telemetry(double now,Telemetry t){if(cfg_.enabled)pending_.push({now+cfg_.one_way_seconds,false,{},t});}
void sat::RadioLink::advance(double now){while(!pending_.empty()&&pending_.front().deliver_at<=now){auto p=pending_.front();pending_.pop();if(p.uplink)commands_.push(p);else telemetry_.push(p);}}
bool sat::RadioLink::receive_command(Command&c){if(commands_.empty())return false;c=commands_.front().command;commands_.pop();return true;}
bool sat::RadioLink::receive_telemetry(Telemetry&t){if(telemetry_.empty())return false;t=telemetry_.front().telemetry;telemetry_.pop();return true;}
