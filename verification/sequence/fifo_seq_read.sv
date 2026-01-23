////////////////////////////////////////////////////////////////////////////////
//
// Filename : fifo_seq_read.sv
// Author : Asmara Rauf
// Creation Date : 07/24/2024
//
// No portions of this material may be reproduced in any form without
// the written permission of CoMira solutions Inc.
//
// All information contained in this document is CoMira solutions
// private, proprietary and trade secret.
//
// Description
// ===========
// This module contains fifo read sequence for simulation extended from uvm_sequence base component.
//
// ///////////////////////////////////////////////////////////////////////////////


class fifo_seq_read extends uvm_sequence #(fifo_tx);

  // factory registration
  `uvm_object_utils(fifo_seq_read)

  // constructor
  function new(string name="fifo_seq_read");
    super.new(name);
  endfunction

  // declarations
  fifo_tx   tx;
  
  // main task of the sequence
  virtual task body();
    tx  = fifo_tx  :: type_id :: create("tx");
    start_item(tx);
    tx.set_read;
    finish_item(tx); 
  endtask

endclass


