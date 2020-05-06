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


`ifndef SKY130_FD_SC_HS__EINVN_BEHAVIORAL_V
`define SKY130_FD_SC_HS__EINVN_BEHAVIORAL_V

/**
 * einvn: Tri-state inverter, negative enable.
 *
 * Verilog simulation functional model.
 */

`timescale 1ns / 1ps
`default_nettype none

// Import sub cells.
`include "../u_vpwr_vgnd/sky130_fd_sc_hs__u_vpwr_vgnd.v"

`celldefine
module sky130_fd_sc_hs__einvn (
    A   ,
    TE_B,
    Z   ,
    VPWR,
    VGND
);

    // Module ports
    input  A   ;
    input  TE_B;
    output Z   ;
    input  VPWR;
    input  VGND;

    // Local signals
    wire u_vpwr_vgnd0_out_A  ;
    wire u_vpwr_vgnd1_out_teb;

    //                           Name          Output                Other arguments
    sky130_fd_sc_hs__u_vpwr_vgnd u_vpwr_vgnd0 (u_vpwr_vgnd0_out_A  , A, VPWR, VGND                           );
    sky130_fd_sc_hs__u_vpwr_vgnd u_vpwr_vgnd1 (u_vpwr_vgnd1_out_teb, TE_B, VPWR, VGND                        );
    notif0                       notif00      (Z                   , u_vpwr_vgnd0_out_A, u_vpwr_vgnd1_out_teb);

endmodule
`endcelldefine

`default_nettype wire
`endif  // SKY130_FD_SC_HS__EINVN_BEHAVIORAL_V