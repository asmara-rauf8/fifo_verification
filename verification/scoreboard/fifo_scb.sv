////////////////////////////////////////////////////////////////////////////////
//
// Filename : fifo_scb.sv
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
// This module contains fifo scoreboard extended from uvm_scb base component.
//
// ///////////////////////////////////////////////////////////////////////////////

`uvm_analysis_imp_decl(_rd_monitor)
`uvm_analysis_imp_decl(_wr_monitor)

class fifo_scb extends uvm_scoreboard;

  //factory registration
  `uvm_component_utils(fifo_scb)

  //constructor
  function new(string name="fifo_scb",uvm_component parent);
    super.new(name,parent);
  endfunction

  //declarations
  uvm_analysis_imp_rd_monitor #(fifo_tx, fifo_scb) rd_monitor_export;
  uvm_analysis_imp_wr_monitor #(fifo_tx, fifo_scb) wr_monitor_export;

  logic [DATA_WIDTH-1:0] ref_queue [$];
  logic [DATA_WIDTH-1:0] queue_out;    
  int   total_monitored;
  int   pass;
  int   fail;
  int   empty_f = 0;
  int   empty_p = 0;
  int   full_f  = 0;
  int   full_p  = 0;


  //build phase
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    rd_monitor_export = new("rd_monitor_export", this);
    wr_monitor_export = new("wr_monitor_export", this);
    total_monitored   = 0;
    pass              = 0;
    fail              = 0;
  endfunction 
  
  // analysis port write function : for read transaction
  virtual function void write_rd_monitor(fifo_tx  item_rd);
    total_monitored++;    	
    if (item_rd.rd_en && ~item_rd.reset) begin 
      if (ref_queue.size() > 0) begin
        queue_out = ref_queue.pop_front();
        if ( queue_out != item_rd.rd_data) begin
          $display("Test Case Failed!"); 
          $display("Read  enable   = %0d", item_rd.rd_en);    
          $display("Expected output = %d, Actual output = %d", queue_out, item_rd.rd_data);
          fail++;
        end
        else begin
          $display("Test Case Passed!");
          $display("Read  enable   = %0d", item_rd.rd_en);    
          $display("Expected output = %d, Actual output = %d", queue_out, item_rd.rd_data);
          pass++;
        end                          
      end  
    end  
   
    if(item_rd.reset) begin
      ref_queue.delete();
    end   
  
    if(item_rd.fifo_empty == 1) begin
      if(ref_queue.size() == 0) begin
        $display("Empty Test Case Passed!");
        empty_p++;
      end 
      else begin
        $display("Empty Test Case Failed! empty signal =  %0d, queue =  %0d",item_rd.fifo_empty, ref_queue.size() );
       	empty_f++;  
      end
   end 
   prints();   
  endfunction
 
  // analysis port write function : for write transaction
  virtual function void write_wr_monitor(fifo_tx  item_wr);
    total_monitored++;
    if (item_wr.wr_en && ~item_wr.reset && ref_queue.size() < FIFO_SIZE) begin
      ref_queue.push_back(item_wr.wr_data);
    end 
    
    if(item_wr.reset) begin
      ref_queue.delete();
    end 

    if(item_wr.fifo_full == 1) begin
      if(ref_queue.size() >= FIFO_SIZE) begin
        $display("Full Test Case Passed!");
        full_p++;
      end 
      else begin
        $display("Full Test Case Failed!");
        full_f++;  
      end
      prints();
   end
  endfunction
  
  function prints();
    $display("==========================");
    $display("TOTAL rd_data Check PASS  = %0d", pass);
    $display("TOTAL rd_data Check FAIL  = %0d", fail);
    $display("TOTAL Empty Check PASS    = %0d", empty_p);
    $display("TOTAL Empty Check FAIL    = %0d", empty_f);
    $display("TOTAL Full Check PASS     = %0d", full_p);
    $display("TOTAL Full Check FAIL     = %0d", full_f);
    $display("TOTAL MONITORED = %0d", total_monitored);
    $display("==========================");
  endfunction
endclass
