/*
 * Copyright 2020 The SkyWater PDK Authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * SPDX-License-Identifier: Apache-2.0
*/


`ifndef SKY130_FD_SC_HS__DLRTP_BEHAVIORAL_PP_V
`define SKY130_FD_SC_HS__DLRTP_BEHAVIORAL_PP_V

/**
 * dlrtp: Delay latch, inverted reset, non-inverted enable,
 *        single output.
 *
 * Verilog simulation functional model.
 */

`timescale 1ns / 1ps
`default_nettype none

// Import sub cells.
`include "../u_dl_p_r_no_pg/sky130_fd_sc_hs__u_dl_p_r_no_pg.v"

`celldefine
module sky130_fd_sc_hs__dlrtp (
    VPWR   ,
    VGND   ,
    Q      ,
    RESET_B,
    D      ,
    GATE
);

    // Module ports
    input  VPWR   ;
    input  VGND   ;
    output Q      ;
    input  RESET_B;
    input  D      ;
    input  GATE   ;

    // Local signals
    wire RESET          ;
    reg  notifier       ;
    wire D_delayed      ;
    wire GATE_delayed   ;
    wire RESET_delayed  ;
    wire RESET_B_delayed;
    wire buf_Q          ;
    wire awake          ;
    wire cond0          ;
    wire cond1          ;

    //                              Name             Output  Other arguments
    not                             not0            (RESET , RESET_B_delayed                                     );
    sky130_fd_sc_hs__u_dl_p_r_no_pg u_dl_p_r_no_pg0 (buf_Q , D_delayed, GATE_delayed, RESET, notifier, VPWR, VGND);
    assign awake = ( VPWR === 1'b1 );
    assign cond0 = ( awake && ( RESET_B_delayed === 1'b1 ) );
    assign cond1 = ( awake && ( RESET_B === 1'b1 ) );
    buf                             buf0            (Q     , buf_Q                                               );

endmodule
`endcelldefine

`default_nettype wire
`endif  // SKY130_FD_SC_HS__DLRTP_BEHAVIORAL_PP_V