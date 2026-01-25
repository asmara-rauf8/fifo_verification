////////////////////////////////////////////////////////////////////////////////
//
// Filename : fifo_randomized_test.sv
// Author : Asmara Rauf
// Creation Date : 07/24/2024
//
// Description
// ===========
// This module contains test case for the verification of fifo output data, extended from uvm_test base component.
//
// ///////////////////////////////////////////////////////////////////////////////


// case 3: randomized write enable and read enable
class fifo_randomized_test extends uvm_test;

  `uvm_component_utils(fifo_randomized_test)

  // constructor
  function new(string name="fifo_randomized_test",uvm_component parent);
    super.new(name,parent);
  endfunction

  // declarations
  fifo_env             env;
  fifo_seq_read        r_seq;
  fifo_seq_write       w_seq;
  fifo_seq_reset       rst_seq;
  fifo_seq_read_write  rw_seq;
  

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
    repeat(5) begin
      repeat($urandom_range(1,10)) begin
     	w_seq = new();
        w_seq.start(env.agent.sqr);
      end
    
      repeat($urandom_range(1,10)) begin
        r_seq = new();
        r_seq.start(env.agent.sqr);
      end 

      repeat(4) begin
        rw_seq = new();
        rw_seq.start(env.agent.sqr);
      end
    
      repeat($urandom_range(1, 10)) begin
        r_seq = new();
        r_seq.start(env.agent.sqr);
      end

      repeat($urandom_range(1, 5)) begin
        w_seq = new();
        w_seq.start(env.agent.sqr);
      end

      repeat($urandom_range(1, 15)) begin
        rw_seq = new();
        rw_seq.start(env.agent.sqr);
      end
    
      repeat($urandom_range(1, 15)) begin
        r_seq = new();
        r_seq.start(env.agent.sqr);
      end

      repeat($urandom_range(1, 2)) begin
        rw_seq = new();
        rw_seq.start(env.agent.sqr);
      end

      repeat($urandom_range(1, 10)) begin
        r_seq = new();
        r_seq.start(env.agent.sqr);
      end
    end
    phase.drop_objection(this);
    
  endtask

endclass
