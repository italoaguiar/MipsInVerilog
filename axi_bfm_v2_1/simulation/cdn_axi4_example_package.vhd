-- (c) Copyright 2011 - 2012 Xilinx, Inc. All rights reserved.
-- 
-- This file contains confidential and proprietary information
-- of Xilinx, Inc. and is protected under U.S. and
-- international copyright and other intellectual property
-- laws.
-- 
-- DISCLAIMER
-- This disclaimer is not a license and does not grant any
-- rights to the materials distributed herewith. Except as
-- otherwise provided in a valid license issued to you by
-- Xilinx, and to the maximum extent permitted by applicable
-- law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
-- WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
-- AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
-- BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
-- INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
-- (2) Xilinx shall not be liable (whether in contract or tort,
-- including negligence, or under any other theory of
-- liability) for any loss or damage of any kind or nature
-- related to, arising under or in connection with these
-- materials, including for any direct, or any indirect,
-- special, incidental, or consequential loss or damage
-- (including loss of data, profits, goodwill, or any type of
-- loss or damage suffered as a result of any action brought
-- by a third party) even if such damage or loss was
-- reasonably foreseeable or Xilinx had been advised of the
-- possibility of the same.
-- 
-- CRITICAL APPLICATIONS
-- Xilinx products are not designed or intended to be fail-
-- safe, or for use in any application requiring fail-safe
-- performance, such as life-support or safety devices or
-- systems, Class III medical devices, nuclear facilities,
-- applications related to the deployment of airbags, or any
-- other applications that could lead to death, personal
-- injury, or severe property or environmental damage
-- (individually and collectively, "Critical
-- Applications"). Customer assumes the sole risk and
-- liability of any use of Xilinx products in Critical
-- Applications, subject only to applicable laws and
-- regulations governing limitations on product liability.
-- 
-- THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
-- PART OF THIS FILE AT ALL TIMES.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--library verilog;
--use verilog.vl_types.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;
use ieee.std_logic_textio.all;

library std;
use std.textio.all;

library work;
use work.all;


package cdn_axi4_example_tb_testbench is

    constant    C_M_AXI_NAME          : string  := "MASTER_0";
    constant    C_M_AXI_DATA_WIDTH    : integer := 32;
    constant    C_M_AXI_ADDR_WIDTH    : integer := 32;
    constant    C_M_AXI_ID_WIDTH      : integer := 4;
    constant    C_M_AXI_AWUSER_WIDTH  : integer := 1;
    constant    C_M_AXI_ARUSER_WIDTH  : integer := 1;
    constant    C_M_AXI_RUSER_WIDTH   : integer := 1;
    constant    C_M_AXI_WUSER_WIDTH   : integer := 1;
    constant    C_M_AXI_BUSER_WIDTH   : integer := 1;
    constant    C_INTERCONNECT_M_AXI_READ_ISSUING     : integer := 8;
    constant    C_INTERCONNECT_M_AXI_WRITE_ISSUING    : integer := 8;
    constant    C_M_AXI_EXCLUSIVE_ACCESS_SUPPORTED    : integer := 0;
    constant    C_S_AXI_NAME                          : string  := "SLAVE_0";
    constant    C_S_AXI_DATA_WIDTH                      : integer := 32;
    constant    C_S_AXI_ADDR_WIDTH                      : integer := 32;
    constant    C_S_AXI_ID_WIDTH: integer := 4;
    constant    C_S_AXI_AWUSER_WIDTH: integer := 1;
    constant    C_S_AXI_ARUSER_WIDTH: integer := 1;
    constant    C_S_AXI_RUSER_WIDTH: integer := 1;
    constant    C_S_AXI_WUSER_WIDTH: integer := 1;
    constant    C_S_AXI_BUSER_WIDTH: integer := 1;
    constant    C_INTERCONNECT_S_AXI_READ_ACCEPTANCE: integer := 8;
    constant    C_INTERCONNECT_S_AXI_WRITE_ACCEPTANCE: integer := 8;
    constant    C_S_AXI_MEMORY_MODEL_MODE: integer := 0;
    constant    C_S_AXI_EXCLUSIVE_ACCESS_SUPPORTED: integer := 1;
    constant    C_S_AXI_SLAVE_MEM_SIZE    : integer := 4096;
    constant    C_BASEADDR      : integer := 0;
    constant    C_HIGHADDR      : integer := 0;
    constant    MAX_BURST_LENGTH   : integer := 255;
    constant    WUSER_BUS_WIDTH    : integer := 1;
    constant    RESP_BUS_WIDTH                        : integer := 2;
    constant    CLK_PER             : time    :=  20 ns;

    -- Internal Signals for Master and Slave  
    signal S_AXI_ACLK     :  std_logic := '0';
    signal S_AXI_ARESETN  :  std_logic := '0';                        
    signal M_AXI_ACLK     :  std_logic := '0';
    signal M_AXI_ARESETN  :  std_logic := '0';         
    signal M_AXI_AWID     :  std_logic_vector(C_M_AXI_ID_WIDTH-1 downto 0)	   ;
    signal M_AXI_AWADDR   :  std_logic_vector(C_M_AXI_ADDR_WIDTH-1 downto 0)   ;
    signal M_AXI_AWLEN    :  std_logic_vector(7 downto 0)	                     ;
    signal M_AXI_AWSIZE   :  std_logic_vector(2 downto 0)	                     ;
    signal M_AXI_AWBURST  :  std_logic_vector(1 downto 0)	                     ;
    signal M_AXI_AWLOCK   :  std_logic   	                                     ;
    signal M_AXI_AWCACHE  :  std_logic_vector(3 downto 0)	                     ;
    signal M_AXI_AWPROT   :  std_logic_vector(2 downto 0)	                     ;
    signal M_AXI_AWREGION :  std_logic_vector(3 downto 0)	                     ;
    signal M_AXI_AWQOS    :  std_logic_vector(3 downto 0) 	                    ; 
    signal M_AXI_AWUSER   :  std_logic_vector(C_M_AXI_AWUSER_WIDTH-1 downto 0)  ; 
    signal M_AXI_AWVALID  :  std_logic			                                    ; 
    signal M_AXI_AWREADY  :  std_logic				                                  ; 
    signal M_AXI_WDATA    :  std_logic_vector(C_M_AXI_DATA_WIDTH-1 downto 0)    ; 
    signal M_AXI_WSTRB    :  std_logic_vector(3 downto 0)                       ; 
    signal M_AXI_WLAST    :  std_logic 		                                     ;  
    signal M_AXI_WUSER    :  std_logic_vector(C_M_AXI_WUSER_WIDTH-1 downto 0)   ; 
    signal M_AXI_WVALID   :  std_logic	                                         ;
    signal M_AXI_WREADY   :  std_logic	                                         ;
    signal M_AXI_BID      :  std_logic_vector(C_M_AXI_ID_WIDTH-1 downto 0)      ; 
    signal M_AXI_BRESP    :  std_logic_vector(1 downto 0)	                     ;  
    signal M_AXI_BVALID   :  std_logic	                                         ;
    signal M_AXI_BUSER    :  std_logic_vector(C_M_AXI_BUSER_WIDTH-1 downto 0)   ; 
    signal M_AXI_BREADY   :  std_logic				                                   ;
    signal M_AXI_ARID     :  std_logic_vector(C_M_AXI_ID_WIDTH-1 downto 0)	     ;
    signal M_AXI_ARADDR   :  std_logic_vector(C_M_AXI_ADDR_WIDTH-1 downto 0)    ; 
    signal M_AXI_ARLEN    :  std_logic_vector(7 downto 0)	                     ;  
    signal M_AXI_ARSIZE   :  std_logic_vector(2 downto 0)	                     ;  
    signal M_AXI_ARBURST  :  std_logic_vector(1 downto 0)	                     ; 
    signal M_AXI_ARLOCK   :  std_logic	                                       ;
    signal M_AXI_ARCACHE  :  std_logic_vector(3 downto 0)	                     ;
    signal M_AXI_ARPROT   :  std_logic_vector(2 downto 0)	                     ;
    signal M_AXI_ARREGION :  std_logic_vector(3 downto 0)	                     ;
    signal M_AXI_ARQOS    :  std_logic_vector(3 downto 0) 	                   ;
    signal M_AXI_ARUSER   :  std_logic_vector(C_M_AXI_ARUSER_WIDTH-1 downto 0) ;
    signal M_AXI_ARVALID  :  std_logic	                                       ;
    signal M_AXI_ARREADY  :  std_logic                                         ;
    signal M_AXI_RID      :  std_logic_vector(C_M_AXI_ID_WIDTH-1 downto 0)     ;
    signal M_AXI_RDATA    :  std_logic_vector(C_M_AXI_DATA_WIDTH-1 downto 0)   := (others=>'0') ;
    signal M_AXI_RRESP    :  std_logic_vector(1 downto 0)	                     ;
    signal M_AXI_RLAST    :  std_logic		                                     ;
    signal M_AXI_RUSER    :  std_logic_vector(C_M_AXI_RUSER_WIDTH-1 downto 0)  ;
    signal M_AXI_RVALID   :  std_logic                                         ;
    signal M_AXI_RREADY   :  std_logic		                                     ;
    signal  MTESTCACHETYPE      :  std_logic;
    signal  MTESTPROTECTIONTYPE :  std_logic;
    signal  MTESTREGION         :  std_logic;
    signal  MTESTQOS            :  std_logic;
    signal  MTESTAWUSER         :  std_logic;
    signal  MTESTARUSER         :  std_logic;
    signal  MTESTBUSER          :  std_logic;
    signal  V_WUSER             :  std_logic_vector (255 downto 0) := (others=>'0');
    signal  WRITE_DONE          :  std_logic; 
    signal  READ_DONE           :  std_logic; 
    signal  MTESTID             : std_logic_vector(3 downto 0)                        ; 
    signal  STESTID             : std_logic_vector(3 downto 0)                        ; 
    signal  MTESTADDR           : std_logic_vector(C_M_AXI_ADDR_WIDTH-1 downto 0)     ; 
    signal  MTESTBURSTLENGTH    : std_logic_vector(((C_M_AXI_DATA_WIDTH/8)*(MAX_BURST_LENGTH+1))-1  downto 0)  := (others=>'0'); 
    signal  BURST_SIZE_4_BYTES  : std_logic_vector(3 downto 0)                        ; 
    signal  BURST_TYPE          : std_logic_vector(1 downto 0)                        ; 
    signal  LOCK_TYPE           : std_logic                                    ;
    signal  FOURBIT             : std_logic                                    ;
    signal  THREEBIT            : std_logic                                    ;
    signal  RD_DATA             : std_logic_vector ((C_S_AXI_DATA_WIDTH*(MAX_BURST_LENGTH+1))-1 downto 0)    := (others=>'0')         ;
    signal  WRITE_TASK          : std_logic                                    ;
    signal  READ_TASK           : std_logic                                    ;
    signal  WRITE_BURST_CONCURRENT :     std_logic                              ;
    signal  WRITE_BURST_CONCURRENT_DONE :std_logic                        ;
    signal  MTESTDATASIZE       : std_logic_vector (10 downto 0)               := (others=>'0');
    signal  RESPONSE            : std_logic_vector (RESP_BUS_WIDTH-1 downto 0) := (others=>'0');
    signal  VRESPONSE           : std_logic_vector (511 downto 0)              := (others=>'0');
    signal  CHECK_RESPONSE      : std_logic_vector (RESP_BUS_WIDTH-1 downto 0) := (others=>'0');
    signal  V_RUSER             : std_logic_vector ((C_M_AXI_RUSER_WIDTH*(MAX_BURST_LENGTH+1))-1 downto 0)    := (others=>'0')          ;
    
    signal  S_V_WUSER           : std_logic_vector((C_S_AXI_WUSER_WIDTH*(MAX_BURST_LENGTH+1))-1 downto 0)   ;
    signal  STESTDATASIZE       : std_logic                        ;
    signal  WR_DATA             : std_logic_vector((C_S_AXI_DATA_WIDTH*(MAX_BURST_LENGTH+1))-1 downto 0) := (others=>'0') ;
    signal  WRITE_ID_TAG        : std_logic_vector(3 downto 0)            ;
    signal  READ_ID_TAG         : std_logic_vector(3 downto 0)            ;
    signal  ERROR_VRESPONSE     : std_logic_vector((RESP_BUS_WIDTH*(MAX_BURST_LENGTH+1))-1 downto 0);
    signal  RESP_DATA           : std_logic_vector((C_S_AXI_DATA_WIDTH*(MAX_BURST_LENGTH+1))-1 downto 0) := (others=>'0');
    signal  WRITE_BURST_RES     : std_logic ;
    signal  READ_BURST_RES      : std_logic ;
    signal  WRITE_BURST_RESP_CTRL      : std_logic ;
    signal  WRITE_BURST_RESP_CTRL_DONE : std_logic                        ;
    signal  READ_BURST_RESP_CTRL      : std_logic ;
    signal  READ_BURST_RESP_CTRL_DONE : std_logic                        ;
    signal  RESPONSE_TYPE              : std_logic_vector(1 downto 0)            ;
    signal  SET_READ_BURST_DATA_TRANSFER_GAP : std_logic ;
    signal  SET_READ_BURST_DATA_TRANSFER_GAP_DONE : std_logic ;
    signal  SET_WRITE_RESPONSE_GAP : std_logic ;
    signal  READ_DATA_TRANSFER_COMPLETE : std_logic ;
    signal  SET_READ_RESPONSE_GAP :  std_logic ;
    signal  GAP_DATA              :  std_logic_vector(7 downto 0) := (others=>'0');
    signal  WRITE_BURST_RES_DONE: std_logic ;
    signal  READ_BURST_RES_DONE : std_logic  ;
    signal  STESTBUSER          : std_logic                            ;
    signal  S_V_RUSER           : std_logic_vector((C_S_AXI_RUSER_WIDTH*(MAX_BURST_LENGTH+1))-1 downto 0)       ;
    signal  PENDING_TRANSACTIONS_COUNT : std_logic_vector(3 downto 0)  ;
    signal  TEST_DATA                     : std_logic_vector((C_S_AXI_DATA_WIDTH*(MAX_BURST_LENGTH+1))-1 downto 0) := (others=>'0');
    signal  WRITE_DATA_TRANSFER_COMPLETE  : std_logic                          ; 
    signal  WRITE_BURST_DATA_TRANSFER_GAP : std_logic                          ; 
    signal  WRITE_BURST_DATA_TRANSFER_GAP_DONE : std_logic                          ; 
    signal  M_GAP_DATA                      : std_logic_vector(7 downto 0)    := "00000000" ;
    signal  LEN                             : integer ;
    signal  J                               : integer ;
    signal REPORT_STATUS                     : std_logic    ;
    signal REPORT_STATUS_DONE                : std_logic    ;
    signal NUMBER_OF_EXPECTED_ERRORS_WARNINGS_AND_PENDING : std_logic;
    signal S_REPORT_STATUS                     : std_logic    := '0' ;
    signal S_REPORT_STATUS_DONE                : std_logic    ;
    signal S_NUMBER_OF_EXPECTED_ERRORS_WARNINGS_AND_PENDING : std_logic;
    
    signal   M_NO_OF_EXPECTED_ERRORS_WARNINGS_AND_PENDING : std_logic := '0';
    signal   S_NO_OF_EXPECTED_ERRORS_WARNINGS_AND_PENDING : std_logic := '0';


   PROCEDURE COMPARE_WUSER (signal v_wuser   : in std_logic_vector((WUSER_BUS_WIDTH*(MAX_BURST_LENGTH+1))-1 downto 0);
                            signal s_v_wuser : in std_logic_vector((WUSER_BUS_WIDTH*(MAX_BURST_LENGTH+1))-1 downto 0);
                            variable AWLEN   : IN integer);
   PROCEDURE COMPARE_RUSER (signal V_RUSER   : in std_logic_vector((WUSER_BUS_WIDTH*(MAX_BURST_LENGTH+1))-1 downto 0);
                            signal S_V_RUSER : in std_logic_vector((WUSER_BUS_WIDTH*(MAX_BURST_LENGTH+1))-1 downto 0);
                            variable ARLEN   : IN integer);
   PROCEDURE CHECK_RESPONSE_OKAY(variable check_resp : IN std_logic_vector (RESP_BUS_WIDTH-1 downto 0));
   PROCEDURE CHECK_RESPONSE_VECTOR_OKAY (signal VRESPONSE : IN std_logic_vector ((RESP_BUS_WIDTH*(MAX_BURST_LENGTH+1))-1 downto 0);
                                         signal LEN      : IN integer);
   PROCEDURE STOP_SIMULATION;
   PROCEDURE PRINT_DATA ( signal SLAVE_FINISHED : IN std_logic_vector (3 downto 0));
   PROCEDURE COMPARE_DATA (signal WR_DATA : IN std_logic_vector ((C_M_AXI_DATA_WIDTH*(MAX_BURST_LENGTH+1))-1 downto 0);
                           signal RD_DATA : IN std_logic_vector ((C_M_AXI_DATA_WIDTH*(MAX_BURST_LENGTH+1))-1 downto 0);
                           variable ARSIZE  : IN integer;
                           variable ARLEN   : IN integer);
   PROCEDURE  REPORT_MASTER_STATUS (signal NO_OF_EXPECTED_ERRORS_WARNINGS_AND_PENDING : IN std_logic;
                                    variable test                                     : IN integer) ;

   PROCEDURE  REPORT_SLAVE_STATUS (signal NO_OF_EXPECTED_ERRORS_WARNINGS_AND_PENDING : IN std_logic;
                                   variable test                                     : IN integer) ;

component cdn_axi4_master_bfm_wrap is
    generic(
        C_M_AXI_NAME    : string  := "MASTER_0";
        C_M_AXI_DATA_WIDTH: integer := 32;
        C_M_AXI_ADDR_WIDTH: integer := 32;
        C_M_AXI_ID_WIDTH: integer := 4;
        C_M_AXI_AWUSER_WIDTH: integer := 1;
        C_M_AXI_ARUSER_WIDTH: integer := 1;
        C_M_AXI_RUSER_WIDTH: integer := 1;
        C_M_AXI_WUSER_WIDTH: integer := 1;
        C_M_AXI_BUSER_WIDTH: integer := 1;
        C_INTERCONNECT_M_AXI_READ_ISSUING: integer := 8;
        C_INTERCONNECT_M_AXI_WRITE_ISSUING: integer := 8;
        C_M_AXI_EXCLUSIVE_ACCESS_SUPPORTED: integer := 0
        );
    port(
        M_AXI_ACLK     : in     std_logic ;
        M_AXI_ARESETN  : in     std_logic ;
        M_AXI_AWID     : out    std_logic_vector(C_M_AXI_ID_WIDTH-1 downto 0)	     ;  -- Master Write address ID. 
        M_AXI_AWADDR   : out    std_logic_vector(C_M_AXI_ADDR_WIDTH-1 downto 0)    ;  -- Master Write address. 
        M_AXI_AWLEN    : out    std_logic_vector(7 downto 0)	                     ;  -- Master Burst length.
        M_AXI_AWSIZE   : out    std_logic_vector(2 downto 0)	                     ;  -- Master Burst size.
        M_AXI_AWBURST  : out    std_logic_vector(1 downto 0)	                     ; -- Master Burst type.
        M_AXI_AWLOCK   : out    std_logic   	                                     ;  -- Master Lock type.
        M_AXI_AWCACHE  : out    std_logic_vector(3 downto 0)	                     ; -- Master Cache type.
        M_AXI_AWPROT   : out    std_logic_vector(2 downto 0)	                     ;  -- Master Protection type.
        M_AXI_AWREGION : out    std_logic_vector(3 downto 0)	                     ;-- Master Region signals.
        M_AXI_AWQOS    : out    std_logic_vector(3 downto 0) 	                     ;   -- Master QoS signals.
        M_AXI_AWUSER   : out    std_logic_vector(C_M_AXI_AWUSER_WIDTH-1 downto 0)  ;  -- Master User defined signals.
        M_AXI_AWVALID  : out    std_logic			                                     ; -- Master Write address valid.
        M_AXI_AWREADY  : in     std_logic				                                   ; -- Slave Write address ready.
        M_AXI_WDATA    : out    std_logic_vector(C_M_AXI_DATA_WIDTH-1 downto 0)    ;   -- Master Write data.
        M_AXI_WSTRB    : out    std_logic_vector(3 downto 0)                       ;   -- Master Write strobes.
        M_AXI_WLAST    : out    std_logic 		                                     ;   -- Master Write last.
        M_AXI_WUSER    : out    std_logic_vector(C_M_AXI_WUSER_WIDTH-1 downto 0)   ;   -- Master Write User defined signals.
        M_AXI_WVALID   : out		std_logic	                                         ;  -- Master Write valid.
        M_AXI_WREADY   : in			std_logic	                                         ;  -- Slave Write ready.
        M_AXI_BID      : in     std_logic_vector(C_M_AXI_ID_WIDTH-1 downto 0)      ;     -- Slave Response ID.
        M_AXI_BRESP    : in     std_logic_vector(1 downto 0)	                     ;   -- Slave Write response.
        M_AXI_BVALID   : in		  std_logic	                                         ;  -- Slave Write response valid. 
        M_AXI_BUSER    : in     std_logic_vector(C_M_AXI_BUSER_WIDTH-1 downto 0)   ;   -- Slave Write user defined signals.
        M_AXI_BREADY   : out    std_logic				                                   ;  -- Master Response ready.
        M_AXI_ARID     : out    std_logic_vector(C_M_AXI_ID_WIDTH-1 downto 0)	     ;    -- Master Read address ID.
        M_AXI_ARADDR   : out    std_logic_vector(C_M_AXI_ADDR_WIDTH-1 downto 0)    ;  -- Master Read address.
        M_AXI_ARLEN    : out    std_logic_vector(7 downto 0)	                     ;   -- Master Burst length.
        M_AXI_ARSIZE   : out    std_logic_vector(2 downto 0)	                     ;  -- Master Burst size.
        M_AXI_ARBURST  : out    std_logic_vector(1 downto 0)	                     ; -- Master Burst type.
        M_AXI_ARLOCK   : out    std_logic	                                         ;  -- Master Lock typ
        M_AXI_ARCACHE  : out    std_logic_vector(3 downto 0)	                     ; -- Master Cache type.
        M_AXI_ARPROT   : out    std_logic_vector(2 downto 0)	                     ;  -- Master Protection type.
        M_AXI_ARREGION : out    std_logic_vector(3 downto 0)	                     ;-- Master Region signals.
        M_AXI_ARQOS    : out    std_logic_vector(3 downto 0) 	                     ;   -- Master QoS signals.
        M_AXI_ARUSER   : out    std_logic_vector(C_M_AXI_ARUSER_WIDTH-1 downto 0)  ;  -- Master User defined signals.
        M_AXI_ARVALID  : out		std_logic	                                         ; -- Master Read address valid.
        M_AXI_ARREADY  : in		  std_logic                                          ; -- Slave Read address ready.
        M_AXI_RID      : in     std_logic_vector(C_M_AXI_ID_WIDTH-1 downto 0)      ;     -- Slave Read ID tag. 
        M_AXI_RDATA    : in     std_logic_vector(C_M_AXI_DATA_WIDTH-1 downto 0)    ;   -- Slave Read data.
        M_AXI_RRESP    : in     std_logic_vector(1 downto 0)	                     ;   -- Slave Read response.
        M_AXI_RLAST    : in	    std_logic		                                       ;   -- Slave Read last.
        M_AXI_RUSER    : in     std_logic_vector(C_M_AXI_RUSER_WIDTH-1 downto 0)   ;   -- Slave Read user defined signals.
        M_AXI_RVALID   : in			std_logic                                          ;  -- Slave Read valid.
        M_AXI_RREADY   : out		std_logic		                                       ;  -- Master Read ready.
        MTESTCACHETYPE      : in  std_logic;
        MTESTPROTECTIONTYPE : in  std_logic;
        MTESTREGION         : in  std_logic;
        MTESTQOS            : in  std_logic;
        MTESTAWUSER         : in  std_logic;
        MTESTARUSER         : in  std_logic;
        MTESTBUSER          : out  std_logic;
        V_WUSER             : in  std_logic_vector (255 downto 0);
        WRITE_DONE          : out  std_logic; 
        READ_DONE           : out  std_logic; 
        MTESTID             : in std_logic_vector(3 downto 0)                        ; 
        STESTID             : in std_logic_vector(3 downto 0)                        ; 
        MTESTADDR           : in std_logic_vector(C_M_AXI_ADDR_WIDTH-1 downto 0)     ; 
        MTESTBURSTLENGTH    : in std_logic_vector(((C_M_AXI_DATA_WIDTH/8)*(MAX_BURST_LENGTH+1))-1 downto 0)                        ; 
        BURST_SIZE_4_BYTES  : in std_logic_vector(3 downto 0)                        ; 
        BURST_TYPE          : in std_logic_vector(1 downto 0)                        ; 
        LOCK_TYPE           : in std_logic                                    ;
        FOURBIT             : in std_logic                                    ;
        THREEBIT            : in std_logic                                    ;
        RD_DATA             : out std_logic_vector ((C_S_AXI_DATA_WIDTH*(MAX_BURST_LENGTH+1))-1 downto 0)             ;
        WRITE_TASK          : in std_logic                                    ;
        READ_TASK           : in std_logic                                    ;
        WRITE_BURST_CONCURRENT : in std_logic                                    ;
        WRITE_BURST_CONCURRENT_DONE : out std_logic                                    ;
        MTESTDATASIZE       : in std_logic_vector (10 downto 0)                       ;
        RESPONSE            : out std_logic_vector (RESP_BUS_WIDTH-1 downto 0) ;
        VRESPONSE           : out std_logic_vector (511 downto 0)              ;
        V_RUSER             : out std_logic_vector ((C_M_AXI_RUSER_WIDTH*(MAX_BURST_LENGTH+1))-1 downto 0)               ;        
        TEST_DATA           : in std_logic_vector((C_S_AXI_DATA_WIDTH*(MAX_BURST_LENGTH+1))-1 downto 0)               ;
        WRITE_DATA_TRANSFER_COMPLETE  : out std_logic                          ; 
        WRITE_BURST_DATA_TRANSFER_GAP : in  std_logic                          ; 
        WRITE_BURST_DATA_TRANSFER_GAP_DONE  : out  std_logic                          ; 
        GAP_DATA                      : in  std_logic_vector(7 downto 0)              ;
        REPORT_STATUS                     : in  std_logic    ;
        REPORT_STATUS_DONE                : out std_logic    ;
        NUMBER_OF_EXPECTED_ERRORS_WARNINGS_AND_PENDING : out std_logic

    );
    end component;
    
component cdn_axi4_slave_bfm_wrap is
    generic(
        C_S_AXI_NAME    : string  := "SLAVE_0";
        C_S_AXI_DATA_WIDTH: integer := 32;
        C_S_AXI_ADDR_WIDTH: integer := 32;
        C_S_AXI_ID_WIDTH: integer := 4;
        C_S_AXI_AWUSER_WIDTH: integer := 1;
        C_S_AXI_ARUSER_WIDTH: integer := 1;
        C_S_AXI_RUSER_WIDTH: integer := 1;
        C_S_AXI_WUSER_WIDTH: integer := 1;
        C_S_AXI_BUSER_WIDTH: integer := 1;
        C_INTERCONNECT_S_AXI_READ_ACCEPTANCE: integer := 8;
        C_INTERCONNECT_S_AXI_WRITE_ACCEPTANCE: integer := 8;
        C_S_AXI_MEMORY_MODEL_MODE: integer := 0;
        C_S_AXI_EXCLUSIVE_ACCESS_SUPPORTED: integer := 1;
        C_BASEADDR      : integer := 0;
        C_HIGHADDR      : integer := 0;
        C_S_AXI_SLAVE_MEM_SIZE    : integer := 4096
    );
    port(
        S_AXI_ACLK      : in     std_logic                                              ;
        S_AXI_ARESETN   : in     std_logic                                              ;
        S_AXI_AWID      : in     std_logic_vector(C_S_AXI_ID_WIDTH-1 downto 0)	        ;-- Master Write address ID. 
        S_AXI_AWADDR    : in     std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0)        ;-- Master Write address. 
        S_AXI_AWLEN     : in     std_logic_vector(7 downto 0)	                          ;-- Master Burst length.
        S_AXI_AWSIZE    : in     std_logic_vector(2 downto 0)	                          ;-- Master Burst size.
        S_AXI_AWBURST   : in     std_logic_vector(1 downto 0)	                          ;-- Master Burst type.
        S_AXI_AWLOCK    : in     std_logic      	                                      ;-- Master Lock type.
        S_AXI_AWCACHE   : in     std_logic_vector(3 downto 0)	                          ;-- Master Cache type.
        S_AXI_AWPROT    : in     std_logic_vector(2 downto 0)	                          ;-- Master Protection type.
        S_AXI_AWREGION  : in     std_logic_vector(3 downto 0)	                          ;-- Master Region signals.
        S_AXI_AWQOS     : in     std_logic_vector(3 downto 0) 	                        ;-- Master QoS signals.
        S_AXI_AWUSER    : in     std_logic_vector(C_S_AXI_AWUSER_WIDTH-1 downto 0)      ;-- Master User defined signals.
        S_AXI_AWVALID   : in     std_logic        			                                ;-- Master Write address valid.
        S_AXI_AWREADY   : out    std_logic      				                                ;-- Slave Write address ready.
        S_AXI_WDATA     : in     std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0)        ;-- Master Write data.
        S_AXI_WSTRB     : in     std_logic_vector(3 downto 0)                           ;-- Master Write strobes.
        S_AXI_WLAST     : in     std_logic        			                                ;-- Master Write last.
        S_AXI_WUSER     : in     std_logic_vector(C_S_AXI_WUSER_WIDTH-1 downto 0)       ;-- Master Write User defined signals.
        S_AXI_WVALID    : in     std_logic        			                                ;-- Master Write valid.
        S_AXI_WREADY    : out    std_logic       				                                ;-- Slave Write ready.
        S_AXI_BID       : out    std_logic_vector (C_S_AXI_ID_WIDTH-1 downto 0)	      ;-- Slave Response ID.
        S_AXI_BRESP     : out    std_logic_vector (1 downto 0)	                        ;-- Slave Write response.
        S_AXI_BVALID    : out    std_logic       				                                ;-- Slave Write response valid. 
        S_AXI_BUSER     : out    std_logic_vector (C_S_AXI_BUSER_WIDTH-1 downto 0)      ;-- Slave Write user defined signals.
        S_AXI_BREADY    : in     std_logic        			                                ;-- Master Response ready.
        S_AXI_ARID      : in     std_logic_vector(C_S_AXI_ID_WIDTH-1 downto 0)	        ;-- Master Read address ID.
        S_AXI_ARADDR    : in     std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0)        ;-- Master Read address.
        S_AXI_ARLEN     : in     std_logic_vector(7 downto 0)	                          ;-- Master Burst length.
        S_AXI_ARSIZE    : in     std_logic_vector(2 downto 0)	                          ;-- Master Burst size.
        S_AXI_ARBURST   : in     std_logic_vector(1 downto 0)	                          ;-- Master Burst type.
        S_AXI_ARLOCK    : in     std_logic       	                                      ;-- Master Lock type.
        S_AXI_ARCACHE   : in     std_logic_vector(3 downto 0)	                          ;-- Master Cache type.
        S_AXI_ARPROT    : in     std_logic_vector(2 downto 0)	                          ;-- Master Protection type.
        S_AXI_ARREGION  : in     std_logic_vector(3 downto 0)	                          ;-- Master Region signals.
        S_AXI_ARQOS     : in     std_logic_vector(3 downto 0) 	                        ;-- Master QoS signals.
        S_AXI_ARUSER    : in     std_logic_vector(C_S_AXI_ARUSER_WIDTH-1 downto 0)      ;-- Master User defined signals.
        S_AXI_ARVALID   : in     std_logic        			                                ;-- Master Read address valid.
        S_AXI_ARREADY   : out    std_logic       				                                ;-- Slave Read address ready.
        S_AXI_RID       : out    std_logic_vector (C_S_AXI_ID_WIDTH-1 downto 0)	        ;-- Slave Read ID tag. 
        S_AXI_RDATA     : out    std_logic_vector (C_S_AXI_DATA_WIDTH-1 downto 0)       ;-- Slave Read data.
        S_AXI_RRESP     : out    std_logic_vector (1 downto 0)	                        ;-- Slave Read response.
        S_AXI_RLAST     : out    std_logic       				                                ;-- Slave Read last.
        S_AXI_RUSER     : out    std_logic_vector (C_S_AXI_RUSER_WIDTH-1 downto 0)      ;-- Slave Read user defined signals.
        S_AXI_RVALID    : out    std_logic       				                                ;-- Slave Read valid.
        S_AXI_RREADY    : in     std_logic       		  		                              ;-- Master Read ready.
        S_V_WUSER           : out std_logic_vector((C_S_AXI_WUSER_WIDTH*(MAX_BURST_LENGTH+1))-1 downto 0)   ;
        STESTDATASIZE       : out std_logic                        ;
        WR_DATA             : out std_logic_vector((C_S_AXI_DATA_WIDTH*(MAX_BURST_LENGTH+1))-1 downto 0)  ;
        WRITE_ID_TAG        : in std_logic_vector(3 downto 0)            ;
        READ_ID_TAG         : in std_logic_vector(3 downto 0)            ;
        ERROR_VRESPONSE     : in std_logic_vector((RESP_BUS_WIDTH*(MAX_BURST_LENGTH+1))-1 downto 0);
        RESP_DATA           : in std_logic_vector((C_S_AXI_DATA_WIDTH*(MAX_BURST_LENGTH+1))-1 downto 0) ;
        WRITE_BURST_RES     : in std_logic ;
        READ_BURST_RES      : in std_logic ;
        WRITE_BURST_RESP_CTRL      :  in std_logic ;
        WRITE_BURST_RESP_CTRL_DONE :  out std_logic                        ;
        READ_BURST_RESP_CTRL      :  in std_logic ;
        READ_BURST_RESP_CTRL_DONE :  out std_logic                        ;
        RESPONSE_TYPE              : in std_logic_vector(1 downto 0)            ;
        SET_READ_BURST_DATA_TRANSFER_GAP : in std_logic ;
        SET_READ_BURST_DATA_TRANSFER_GAP_DONE : out std_logic ;
        SET_WRITE_RESPONSE_GAP : in std_logic ;
        SET_READ_RESPONSE_GAP : in std_logic ;
        GAP_DATA              : in std_logic_vector(7 downto 0) ;
        READ_DATA_TRANSFER_COMPLETE : out std_logic  ;
        WRITE_BURST_RES_DONE: out std_logic ;
        READ_BURST_RES_DONE : out std_logic  ;
        STESTBUSER          : in std_logic ;
        PENDING_TRANSACTIONS_COUNT : out std_logic_vector(3 downto 0)  ;
        S_V_RUSER           : in std_logic_vector((C_S_AXI_RUSER_WIDTH*(MAX_BURST_LENGTH+1))-1 downto 0) ;
        REPORT_STATUS                       : in  std_logic    ;
        REPORT_STATUS_DONE                  : out std_logic    ;
        NUMBER_OF_EXPECTED_ERRORS_WARNINGS_AND_PENDING : out std_logic
    );
end component;

 
end;


package body cdn_axi4_example_tb_testbench is

PROCEDURE COMPARE_RUSER (signal V_RUSER   : in std_logic_vector((WUSER_BUS_WIDTH*(MAX_BURST_LENGTH+1))-1 downto 0);
                         signal S_V_RUSER : in std_logic_vector((WUSER_BUS_WIDTH*(MAX_BURST_LENGTH+1))-1 downto 0); 
                         variable ARLEN   : IN integer ) IS
       variable outline_user : line;
   BEGIN
      IF v_ruser(ARLEN downto 0) /= s_v_ruser(ARLEN downto 0)  THEN
          REPORT "TESTBENCH ERROR! RUSER data expected is not equal to actual. ";
          write(outline_user, string'("** v_ruser = "));
          write(outline_user, v_ruser);
          write(outline_user, string'("** s_v_ruser = "));
          write(outline_user, s_v_ruser);
          write(outline_user, string'("******** MISMATCH********* "));
          writeline(output,outline_user);
      END IF;
END PROCEDURE COMPARE_RUSER;

PROCEDURE COMPARE_WUSER (signal v_wuser   : in std_logic_vector((WUSER_BUS_WIDTH*(MAX_BURST_LENGTH+1))-1 downto 0);
                         signal s_v_wuser : in std_logic_vector((WUSER_BUS_WIDTH*(MAX_BURST_LENGTH+1))-1 downto 0);
                         variable AWLEN   : IN integer ) IS
       variable outline_user : line;
   BEGIN
      IF v_wuser(AWLEN downto 0) /= s_v_wuser(AWLEN downto 0)  THEN
          REPORT "TESTBENCH ERROR! WUSER data expected is not equal to actual. ";
          write(outline_user, string'("** v_wuser = "));
          write(outline_user, v_wuser);
          write(outline_user, string'("** s_v_wuser = "));
          write(outline_user, s_v_wuser);
          write(outline_user, string'("******** MISMATCH********* "));
          writeline(output,outline_user);
      ELSE 
          write(outline_user, string'(" WUSER comparision "));
          write(outline_user, string'("** PASS ** "));
          writeline(output,outline_user);
      END IF;
END PROCEDURE COMPARE_WUSER;


PROCEDURE CHECK_RESPONSE_OKAY(variable check_resp : IN std_logic_vector (RESP_BUS_WIDTH-1 downto 0)) IS
       variable outline1 : line;
   BEGIN

   IF response /= "00" THEN
        REPORT "Uacceptable values... Wrong Response";
        RETURN; -- Exit the procedure
   ELSE 
        write(outline1, string'("*****************************************"));
        write(outline1, string'("==========MASTER TO SLAVE RESPONSE VALUE :: OK "));
        write(outline1, response);
        write(outline1, string'(" :: PASS :: *****************************************"));
   END IF;
   writeline(output,outline1);

END PROCEDURE CHECK_RESPONSE_OKAY;

PROCEDURE COMPARE_DATA (signal wr_data : IN std_logic_vector ((C_M_AXI_DATA_WIDTH*(MAX_BURST_LENGTH+1))-1 downto 0);
                        signal rd_data : IN std_logic_vector ((C_M_AXI_DATA_WIDTH*(MAX_BURST_LENGTH+1))-1 downto 0) ;
                        variable ARSIZE  : IN integer ;
                        variable ARLEN   : IN integer ) IS
       variable outline2 : line;
       variable usb      : integer;
       variable size     : integer;
       variable length   : integer;
   BEGIN
   
   IF ARSIZE = 0 THEN
      size := 1;
   ELSIF ARSIZE = 1 THEN
     size := 2;
   ELSIF ARSIZE = 2 THEN
     size := 4;
   ELSIF ARSIZE = 3 THEN
     size := 8;
   ELSIF ARSIZE = 4 THEN
     size := 16;
   ELSIF ARSIZE = 5 THEN
     size := 32;
   ELSIF ARSIZE = 6 THEN
     size := 64;
   ELSIF ARSIZE = 7 THEN
     size := 128;
   END IF;

   length := ARLEN+1;

   usb := ((size*8)*length)-1; 
   write(outline2, string'("***********************  FUNCTION COMPARE DATA  ******************************"));
   writeline(output,outline2);
   write(outline2, string'("ARSIZE : "));
   write(outline2, ARSIZE);
   write(outline2, string'("     ARLENGTH :"));
   write(outline2, ARLEN);
   write(outline2, string'(" Comparing data width (SIZE*8)*LENGTH) :"));
   write(outline2, usb);
   writeline(output,outline2);
   writeline(output,outline2);
   
   IF wr_data(usb downto 0) /= rd_data(usb downto 0) THEN
        write(outline2, string'("******************************************************************************************"));
        writeline(output,outline2);
        write(outline2, string'("***********************   READ AND WRITE DATA MATCH :: FAIL (MIS MATCH RD AND WR DATA) ******************************"));
        writeline(output,outline2);
        write(outline2, string'("******************************************************************************************"));
        writeline(output,outline2);
        write(outline2, wr_data);
        write(outline2, string'(" ============="));
        write(outline2, rd_data);
        write(outline2, string'(" ============="));
        writeline(output,outline2);
        RETURN; -- Exit the procedure
   ELSE 
        write(outline2, string'("******************************************************************************************"));
        writeline(output,outline2);
        write(outline2, string'("***********************   READ AND WRITE DATA MATCH :: PASS  ******************************"));
        writeline(output,outline2);
        write(outline2, string'("******************************************************************************************"));
        writeline(output,outline2);
   END IF;

END PROCEDURE compare_data ;
 
PROCEDURE stop_simulation is
      begin
      wait for 100 ns;
      assert false report "simulation ended" severity failure;
end stop_simulation ;

PROCEDURE print_data ( signal SLAVE_FINISHED : IN std_logic_vector (3 downto 0)) IS
					 variable outline_tr : line;
   BEGIN
              write(outline_tr, string'("##============================================ ::"));
              write(outline_tr, string'("  EXAMPLE TEST  :: "));
              write(outline_tr, SLAVE_FINISHED);
              write(outline_tr, string'("  FINISHED WITH SLAVE ID :: "));
              write(outline_tr, SLAVE_FINISHED);
              write(outline_tr, string'("============================================ ::"));
              writeline(output,outline_tr);
	 END 
PROCEDURE print_data;

PROCEDURE CHECK_RESPONSE_VECTOR_OKAY(signal vresponse : IN std_logic_vector ((RESP_BUS_WIDTH*(MAX_BURST_LENGTH+1))-1 downto 0);
                                     signal  LEN      : IN integer  ) IS
       variable outliner : line;
       variable a : integer ;
       variable b : integer ;
BEGIN
         
         for j in 0 to LEN loop
              a := j*RESP_BUS_WIDTH+1;
              b := j*RESP_BUS_WIDTH;
             write(outliner, vresponse(a downto b));
             write(outliner, string'("***"));
             IF vresponse(a downto b) /= "00" THEN
                  REPORT "Uacceptable values... Wrong Response";
                  write(outliner, string'("************************ ::VRESPONSE FAIL ************************"));
                  write(outliner, vresponse(a downto b));
                  writeline(output,outliner);
                  RETURN; -- Exit the procedure
             ELSE 
                  write(outliner, string'("************************************"));
                  write(outliner, string'("****** MASTER TO SLAVE RESPONSE VALUE :: VRESPONSE ["));
                  write(outliner, a);
                  write(outliner, string'(":"));
                  write(outliner, b);
                  write(outliner, string'("] = "));
                  write(outliner, vresponse(a downto b));
                  write(outliner, string'("*******:: PASS ::*****************************"));
             END IF;
             writeline(output,outliner);
         end loop;

END PROCEDURE CHECK_RESPONSE_VECTOR_OKAY;
--------------------------------------------------------------------------
-- TEST BENCH LEVEL API: REPORT_MASTER_STATUS
--------------------------------------------------------------------------
-- Description:
-- REPORT_MASTER_STATUS(number_of_expected_errors_warnings_and_pending)
-- This task calls the masters report_status function which returns the 
-- total of the errors + warnings + pending counters. This return number 
-- is compared with the input 
-- number_of_expected_errors_warnings_and_pending
--------------------------------------------------------------------------
PROCEDURE REPORT_MASTER_STATUS (signal NO_OF_EXPECTED_ERRORS_WARNINGS_AND_PENDING : IN std_logic;
                                variable test                                     : IN integer ) IS 
       variable outline1 : line;
BEGIN
   If NO_OF_EXPECTED_ERRORS_WARNINGS_AND_PENDING /= NUMBER_OF_EXPECTED_ERRORS_WARNINGS_AND_PENDING THEN
        write(outline1, string'("---------------------------------------------------------------"));
        writeline(output,outline1);
        write(outline1, string'("EXAMPLE TEST "));
        write(outline1, test);
        write(outline1, string'("  : MASTER FAILED"));
        writeline(output,outline1);
        write(outline1, string'("---------------------------------------------------------------"));
        writeline(output,outline1);

        write(outline1, string'("---------------------------------------------------------------"));
        writeline(output,outline1);
        write(outline1, string'(" EXPECTED  : "));
        write(outline1, NO_OF_EXPECTED_ERRORS_WARNINGS_AND_PENDING);
        writeline(output,outline1);
        write(outline1, string'(" ACTUAL (MASTER) : "));
        write(outline1, NUMBER_OF_EXPECTED_ERRORS_WARNINGS_AND_PENDING);
        writeline(output,outline1);
        write(outline1, string'("---------------------------------------------------------------"));
        writeline(output,outline1);
   ELSE 
        write(outline1, string'("---------------------------------------------------------------"));
        writeline(output,outline1);
        write(outline1, string'("EXAMPLE TEST "));
        write(outline1, test);
        write(outline1, string'("  : MASTER PASSED"));
        writeline(output,outline1);
        write(outline1, string'("---------------------------------------------------------------"));
        writeline(output,outline1);

   END IF;

END PROCEDURE REPORT_MASTER_STATUS;

--------------------------------------------------------------------------
-- TEST BENCH LEVEL API: REPORT_SLAVE_STATUS
--------------------------------------------------------------------------
-- Description:
-- REPORT_SLAVE_STATUS(number_of_expected_errors_warnings_and_pending)
-- This task calls the slaves report_status function which returns the 
-- total of the errors + warnings + pending counters. This return number 
-- is compared with the input 
-- number_of_expected_errors_warnings_and_pending
--------------------------------------------------------------------------
PROCEDURE REPORT_SLAVE_STATUS (signal NO_OF_EXPECTED_ERRORS_WARNINGS_AND_PENDING : IN std_logic;
                                variable test                                     : IN integer ) IS 
       variable outline1 : line;
BEGIN
   If NO_OF_EXPECTED_ERRORS_WARNINGS_AND_PENDING /= S_NUMBER_OF_EXPECTED_ERRORS_WARNINGS_AND_PENDING THEN
        write(outline1, string'("---------------------------------------------------------------"));
        writeline(output,outline1);
        write(outline1, string'("EXAMPLE TEST "));
        write(outline1, test);
        write(outline1, string'("  : SLAVE FAILED"));
        writeline(output,outline1);
        write(outline1, string'("---------------------------------------------------------------"));
        writeline(output,outline1);

        write(outline1, string'("---------------------------------------------------------------"));
        writeline(output,outline1);
        write(outline1, string'(" EXPECTED  : "));
        write(outline1, NO_OF_EXPECTED_ERRORS_WARNINGS_AND_PENDING);
        writeline(output,outline1);
        write(outline1, string'(" ACTUAL (MASTER) : "));
        write(outline1, S_NUMBER_OF_EXPECTED_ERRORS_WARNINGS_AND_PENDING);
        writeline(output,outline1);
        write(outline1, string'("---------------------------------------------------------------"));
        writeline(output,outline1);
   ELSE 
        write(outline1, string'("---------------------------------------------------------------"));
        writeline(output,outline1);
        write(outline1, string'("EXAMPLE TEST "));
        write(outline1, test);
        write(outline1, string'("  : SLAVE PASSED"));
        writeline(output,outline1);
        write(outline1, string'("---------------------------------------------------------------"));
        writeline(output,outline1);

   END IF;

END PROCEDURE REPORT_SLAVE_STATUS;
--------------------------------------------------------------------------

end package body;
