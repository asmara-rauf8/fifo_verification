////////////////////////////////////////////////////////////////////////////////
//
// Filename : fifo_agent.sv
// Author : Asmara Rauf
// Creation Date : 07/18/2024
//
// Description
// ===========
// This module contains fifo agent extended from uvm_agent base component.
//
// ///////////////////////////////////////////////////////////////////////////////


class fifo_agent extends uvm_agent;

  //factory registration
  `uvm_component_utils (fifo_agent)

  //constructor
  function new (string name="fifo_agent",uvm_component parent);
    super.new (name,parent);
  endfunction

  //declarations
  fifo_driver  driver;
  uvm_sequencer #(fifo_tx) sqr;
  fifo_monitor  mon;

  //build phase
  function void build_phase(uvm_phase phase);
    sqr    = uvm_sequencer #(fifo_tx):: type_id :: create("sqr",this);
    driver = fifo_driver  :: type_id :: create("driver",this);
    mon    = fifo_monitor :: type_id :: create("mon",this);
  endfunction

  // connect phase
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_warning ("fifo_agent","Starting connect phase")
    driver.seq_item_port.connect(sqr.seq_item_export);
  endfunction

endclass
