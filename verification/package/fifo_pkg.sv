////////////////////////////////////////////////////////////////////////////////
//
// Filename : fifo_pkg.sv
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
// This module is a package file which contains all the required components for the verification of fifo, macros and uvm package.
//
// ///////////////////////////////////////////////////////////////////////////////

package fifo_pkg;
  import uvm_pkg::*;
  `include "uvm_macros.svh"
  `include "../parameter/parameter.sv"
  `include "../sequence_item/fifo_tx.sv"
  `include "../sequence/fifo_seq_read.sv"
  `include "../sequence/fifo_seq_write.sv"
  `include "../sequence/fifo_seq_reset.sv"
  `include "../sequence/fifo_seq_read_write.sv"
  `include "../driver/fifo_driver.sv"
  `include "../monitor/fifo_monitor.sv"
  `include "../agent/fifo_agent.sv"
  `include "../scoreboard/fifo_scb.sv"
  `include "../environment/fifo_env.sv"
  `include "../test/fifo_write_test.sv"
  `include "../test/fifo_read_test.sv"
  `include "../test/fifo_randomized_test.sv"
  `include "../test/fifo_directed_test.sv"
endpackage : fifo_pkg
