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


`ifndef SKY130_FD_SC_HS__CLKDLYINV3SD3_FUNCTIONAL_PP_V
`define SKY130_FD_SC_HS__CLKDLYINV3SD3_FUNCTIONAL_PP_V

/**
 * clkdlyinv3sd3: Clock Delay Inverter 3-stage 0.50um length inner
 *                stage gate.
 *
 * Verilog simulation functional model.
 */

`timescale 1ns / 1ps
`default_nettype none

// Import sub cells.
`include "../u_vpwr_vgnd/sky130_fd_sc_hs__u_vpwr_vgnd.v"

`celldefine
module sky130_fd_sc_hs__clkdlyinv3sd3 (
    Y   ,
    A   ,
    VPWR,
    VGND
);

    // Module ports
    output Y   ;
    input  A   ;
    input  VPWR;
    input  VGND;

    // Local signals
    wire   not0_out_Y        ;
    wire   u_vpwr_vgnd0_out_Y;

    //                           Name          Output              Other arguments
    not                          not0         (not0_out_Y        , A                     );
    sky130_fd_sc_hs__u_vpwr_vgnd u_vpwr_vgnd0 (u_vpwr_vgnd0_out_Y, not0_out_Y, VPWR, VGND);
    buf                          buf0         (Y                 , u_vpwr_vgnd0_out_Y    );

endmodule
`endcelldefine

`default_nettype wire
`endif  // SKY130_FD_SC_HS__CLKDLYINV3SD3_FUNCTIONAL_PP_V