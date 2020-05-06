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


`ifndef SKY130_FD_SC_HS__DLXBN_FUNCTIONAL_PP_V
`define SKY130_FD_SC_HS__DLXBN_FUNCTIONAL_PP_V

/**
 * dlxbn: Delay latch, inverted enable, complementary outputs.
 *
 * Verilog simulation functional model.
 */

`timescale 1ns / 1ps
`default_nettype none

// Import sub cells.
`include "../u_dl_p_pg/sky130_fd_sc_hs__u_dl_p_pg.v"

`celldefine
module sky130_fd_sc_hs__dlxbn (
    VPWR  ,
    VGND  ,
    Q     ,
    Q_N   ,
    D     ,
    GATE_N
);

    // Module ports
    input  VPWR  ;
    input  VGND  ;
    output Q     ;
    output Q_N   ;
    input  D     ;
    input  GATE_N;

    // Local signals
    wire GATE          ;
    wire buf_Q         ;
    wire GATE_N_delayed;
    wire D_delayed     ;

    //                         Delay       Name        Output  Other arguments
    not                                    not0       (GATE  , GATE_N             );
    sky130_fd_sc_hs__u_dl_p_pg `UNIT_DELAY u_dl_p_pg0 (buf_Q , D, GATE, VPWR, VGND);
    buf                                    buf0       (Q     , buf_Q              );
    not                                    not1       (Q_N   , buf_Q              );

endmodule
`endcelldefine

`default_nettype wire
`endif  // SKY130_FD_SC_HS__DLXBN_FUNCTIONAL_PP_V