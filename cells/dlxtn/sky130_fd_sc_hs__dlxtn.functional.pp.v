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


`ifndef SKY130_FD_SC_HS__DLXTN_FUNCTIONAL_PP_V
`define SKY130_FD_SC_HS__DLXTN_FUNCTIONAL_PP_V

/**
 * dlxtn: Delay latch, inverted enable, single output.
 *
 * Verilog simulation functional model.
 */

`timescale 1ns / 1ps
`default_nettype none

// Import sub cells.
`include "../u_dl_p_pg/sky130_fd_sc_hs__u_dl_p_pg.v"

`celldefine
module sky130_fd_sc_hs__dlxtn (
    VPWR  ,
    VGND  ,
    Q     ,
    D     ,
    GATE_N
);

    // Module ports
    input  VPWR  ;
    input  VGND  ;
    output Q     ;
    input  D     ;
    input  GATE_N;

    // Local signals
    wire	gate buf_Q         ;
    wire	gate GATE_N_delayed;
    wire	gate D_delayed     ;
    wire      GATE          ;

    //                         Name        Output  Other arguments
    not                        not0       (GATE  , GATE_N             );
    sky130_fd_sc_hs__u_dl_p_pg u_dl_p_pg0 (buf_Q , D, GATE, VPWR, VGND);
    buf                        buf0       (Q     , buf_Q              );

endmodule
`endcelldefine

`default_nettype wire
`endif  // SKY130_FD_SC_HS__DLXTN_FUNCTIONAL_PP_V