////////////////////////////////////////////////////////////////////////////////
//
// Filename : fifo_directed_test.sv
// Author : Asmara Rauf
// Creation Date : 07/24/2024
//
// Description
// ===========
// This module contains test case for the verification of fifo output data, extended from uvm_test base component.
//
// ///////////////////////////////////////////////////////////////////////////////


// case 4: directed write enable and read enable with reset
class fifo_directed_test extends uvm_test;

  `uvm_component_utils(fifo_directed_test)

  // constructor
  function new(string name="fifo_directed_test",uvm_component parent);
    super.new(name,parent);
  endfunction

  // declarations
  fifo_env        env;
  fifo_seq_read   r_seq;
  fifo_seq_write  w_seq;
  fifo_seq_reset  rst_seq;

  // build phase
  function void build_phase(uvm_phase phase);
    env = fifo_env :: type_id :: create("env",this);
  endfunction

  // run phase
  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    phase.raise_objection(this);
    rst_seq = new();
    rst_seq.start(env.agent.sqr);
    repeat(109) begin
      w_seq = new();
      w_seq.start(env.agent.sqr);
    end
    
    rst_seq = new();
    rst_seq.start(env.agent.sqr);
     
    repeat(100) begin
      r_seq = new();
      r_seq.start(env.agent.sqr);
    end 

    repeat(102) begin
      w_seq = new();
      w_seq.start(env.agent.sqr);
    end
    
    r_seq = new();
    r_seq.start(env.agent.sqr);
      
    repeat(50) begin
      r_seq = new();
      r_seq.start(env.agent.sqr);
    end

    rst_seq = new();
    rst_seq.start(env.agent.sqr);

    repeat(5) begin
      r_seq = new();
      r_seq.start(env.agent.sqr);
    end

    phase.drop_objection(this);
endtask

endclass
