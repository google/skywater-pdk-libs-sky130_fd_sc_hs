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


`ifndef SKY130_FD_SC_HS__O2BB2A_FUNCTIONAL_V
`define SKY130_FD_SC_HS__O2BB2A_FUNCTIONAL_V

/**
 * o2bb2a: 2-input NAND and 2-input OR into 2-input AND.
 *
 *         X = (!(A1 & A2) & (B1 | B2))
 *
 * Verilog simulation functional model.
 */

`timescale 1ns / 1ps
`default_nettype none

// Import sub cells.
`include "../u_vpwr_vgnd/sky130_fd_sc_hs__u_vpwr_vgnd.v"

`celldefine
module sky130_fd_sc_hs__o2bb2a (
    VPWR,
    VGND,
    X   ,
    A1_N,
    A2_N,
    B1  ,
    B2
);

    // Module ports
    input  VPWR;
    input  VGND;
    output X   ;
    input  A1_N;
    input  A2_N;
    input  B1  ;
    input  B2  ;

    // Local signals
    wire	B2 nand0_out         ;
    wire	B2 or0_out           ;
    wire    and0_out_X        ;
    wire    u_vpwr_vgnd0_out_X;

    //                           Name          Output              Other arguments
    nand                         nand0        (nand0_out         , A2_N, A1_N            );
    or                           or0          (or0_out           , B2, B1                );
    and                          and0         (and0_out_X        , nand0_out, or0_out    );
    sky130_fd_sc_hs__u_vpwr_vgnd u_vpwr_vgnd0 (u_vpwr_vgnd0_out_X, and0_out_X, VPWR, VGND);
    buf                          buf0         (X                 , u_vpwr_vgnd0_out_X    );

endmodule
`endcelldefine

`default_nettype wire
`endif  // SKY130_FD_SC_HS__O2BB2A_FUNCTIONAL_V