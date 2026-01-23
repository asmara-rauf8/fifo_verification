////////////////////////////////////////////////////////////////////////////////
//
// Filename : fifo_env.sv
// Author : Asmara Rauf
// Creation Date : 07/18/2024
//
// No portions of this material may be reproduced in any form without
// the written permission of CoMira solutions Inc.
//
// All information contained in this document is CoMira solutions
// private, proprietary and trade secret.
//
// Description
// ===========
// This module contains fifo environment extended from uvm_env base component.
//
// ///////////////////////////////////////////////////////////////////////////////


class fifo_env extends uvm_env;
  
  //factory registration 
  `uvm_component_utils(fifo_env)

  //constructor
  function new(string name="fifo_env",uvm_component parent);
    super.new(name,parent);
  endfunction

  //declarations
  fifo_agent  agent;
  fifo_scb    scb;

  // build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    agent = fifo_agent :: type_id :: create("agent",this);
    scb   = fifo_scb   :: type_id :: create("scb",this);
  endfunction

  //connect phase
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);   
    agent.mon.wr_monitor_analysis_port.connect(scb.wr_monitor_export);
    agent.mon.rd_monitor_analysis_port.connect(scb.rd_monitor_export);
  endfunction

endclass
