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


`ifndef SKY130_FD_SC_HS__CONB_BEHAVIORAL_PP_V
`define SKY130_FD_SC_HS__CONB_BEHAVIORAL_PP_V

/**
 * conb: Constant value, low, high outputs.
 *
 * Verilog simulation functional model.
 */

`timescale 1ns / 1ps
`default_nettype none

// Import sub cells.
`include "../u_vpwr_vgnd/sky130_fd_sc_hs__u_vpwr_vgnd.v"

`celldefine
module sky130_fd_sc_hs__conb (
    VPWR,
    VGND,
    HI  ,
    LO
);

    // Module ports
    input  VPWR;
    input  VGND;
    output HI  ;
    output LO  ;

    // Local signals
    wire pullup0_out_HI;

    //                           Name          Output          Other arguments
    pullup                       pullup0      (pullup0_out_HI);
    sky130_fd_sc_hs__u_vpwr_vgnd u_vpwr_vgnd0 (HI            , pullup0_out_HI, VPWR, VGND);
    pulldown                     pulldown0    (LO            );

endmodule
`endcelldefine

`default_nettype wire
`endif  // SKY130_FD_SC_HS__CONB_BEHAVIORAL_PP_V