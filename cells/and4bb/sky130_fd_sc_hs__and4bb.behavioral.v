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


`ifndef SKY130_FD_SC_HS__AND4BB_BEHAVIORAL_V
`define SKY130_FD_SC_HS__AND4BB_BEHAVIORAL_V

/**
 * and4bb: 4-input AND, first two inputs inverted.
 *
 * Verilog simulation functional model.
 */

`timescale 1ns / 1ps
`default_nettype none

// Import sub cells.
`include "../u_vpwr_vgnd/sky130_fd_sc_hs__u_vpwr_vgnd.v"

`celldefine
module sky130_fd_sc_hs__and4bb (
    X   ,
    A_N ,
    B_N ,
    C   ,
    D   ,
    VPWR,
    VGND
);

    // Module ports
    output X   ;
    input  A_N ;
    input  B_N ;
    input  C   ;
    input  D   ;
    input  VPWR;
    input  VGND;

    // Local signals
    wire	D nor0_out          ;
    wire   and0_out_X        ;
    wire   u_vpwr_vgnd0_out_X;

    //                           Name          Output              Other arguments
    nor                          nor0         (nor0_out          , A_N, B_N              );
    and                          and0         (and0_out_X        , nor0_out, C, D        );
    sky130_fd_sc_hs__u_vpwr_vgnd u_vpwr_vgnd0 (u_vpwr_vgnd0_out_X, and0_out_X, VPWR, VGND);
    buf                          buf0         (X                 , u_vpwr_vgnd0_out_X    );

endmodule
`endcelldefine

`default_nettype wire
`endif  // SKY130_FD_SC_HS__AND4BB_BEHAVIORAL_V