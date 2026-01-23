////////////////////////////////////////////////////////////////////////////////
//
// Filename : fifo_intf.sv
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
// This module contains interface through which driver communicates wuth dut and dut communicates with monitor.
//
// ///////////////////////////////////////////////////////////////////////////////

interface fifo_intf #(DATA_WIDTH, FIFO_SIZE);
	
  logic                   clk;
  logic                   reset;
  logic                   rd_en;
  logic                   wr_en;
  logic  [DATA_WIDTH-1:0] wr_data;
  logic  [DATA_WIDTH-1:0] rd_data;
  logic                   fifo_empty;
  logic                   fifo_full;
  
endinterface
