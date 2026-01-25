////////////////////////////////////////////////////////////////////////////////
//
// Filename : top.sv
// Author : Asmara Rauf
// Creation Date : 07/18/2024
//
// Description
// ===========
// This module is the top testbench module used for the verification of a generic fifo. 
//
// ///////////////////////////////////////////////////////////////////////////////
module top;

  // import packages
  import uvm_pkg::*;
  import fifo_pkg::*;

  // create interface
  fifo_intf #(DATA_WIDTH, FIFO_SIZE) pif();


  //dut instantiation
  fifo #(
    .FIFO_SIZE  (FIFO_SIZE ), 
    .DATA_WIDTH (DATA_WIDTH)
  )  
  DUT (
    .clk        (pif.clk       ),
    .reset      (pif.reset     ),
    .rd_en      (pif.rd_en     ),
    .wr_en      (pif.wr_en     ),
    .wr_data    (pif.wr_data   ),
    .rd_data    (pif.rd_data   ),
    .fifo_empty (pif.fifo_empty),
    .fifo_full  (pif.fifo_full )
  );

  // set interface in config db
  initial begin
    uvm_config_db #(virtual fifo_intf #(DATA_WIDTH, FIFO_SIZE))::set(uvm_root::get(),"","vif",pif);
  end

  // run test
  initial begin
    run_test();
  end
 
  // clock generation 
  initial begin
    pif.clk             <= 1'b0;
    pif.reset           <= 1'b1;
    forever #10 pif.clk <= ~pif.clk;
  end 


endmodule
