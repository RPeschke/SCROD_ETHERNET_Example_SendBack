----------------------------------------------------------------------------------
-- Company: 
-- Engineer:  
-- 
-- Create Date:    13:21:31 07/23/2015 
-- Design Name: 
-- Module Name:    scrodEthernetExample_Example_SendBack - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.NUMERIC_STD.ALL;
use work.UtilityPkg.all;
use work.Eth1000BaseXPkg.all;
use work.GigabitEthPkg.all;

library UNISIM;
use UNISIM.VComponents.all;

entity top_eth_axi_commandreceiver is
   generic (


      NUM_IP_G        : integer := 2;
      GATE_DELAY_G    : time := 1 ns
   );
   port ( 
      -- Direct GT connections
      gtTxP        : out sl;
      gtTxN        : out sl;
      gtRxP        :  in sl;
      gtRxN        :  in sl;
      gtClkP       :  in sl;
      gtClkN       :  in sl;
      -- Alternative clock input
		fabClkP      :  in sl;
		fabClkN      :  in sl;
      -- SFP transceiver disable pin
      txDisable    : out sl

   );
end top_eth_axi_commandreceiver;

architecture Behavioral of top_eth_axi_commandreceiver is



	signal led          : slv(15 downto 0);

   signal fabClk       : sl;
   signal ethClk62     : sl;
   signal ethClk125    : sl;

   signal userRst     : sl;

   signal ethRxLinkSync  : sl;
   signal ethAutoNegDone : sl;

	signal ethCoreMacAddr : MacAddrType := MAC_ADDR_DEFAULT_C;
   signal ethCoreIpAddr  : IpAddrType  := IP_ADDR_DEFAULT_C;
   signal ethCoreIpAddr1 : IpAddrType  := (3 => x"C0", 2 => x"A8", 1 => x"01", 0 => x"21");
   
   signal tpData      : slv(31 downto 0);
   signal tpDataValid : sl;
   signal tpDataLast  : sl;
   signal tpDataReady : sl;
   
   -- User Data interfaces
   signal userTxDataChannels : Word32Array(NUM_IP_G-1 downto 0);
   signal userTxDataValids   : slv(NUM_IP_G-1 downto 0);
   signal userTxDataLasts    : slv(NUM_IP_G-1 downto 0);
   signal userTxDataReadys   : slv(NUM_IP_G-1 downto 0);
   signal userRxDataChannels : Word32Array(NUM_IP_G-1 downto 0);
   signal userRxDataValids   : slv(NUM_IP_G-1 downto 0);
   signal userRxDataLasts    : slv(NUM_IP_G-1 downto 0);
   signal userRxDataReadys   : slv(NUM_IP_G-1 downto 0);

   -- Register control interfaces

   
   -- Test registers
   -- Default is to send 1000 counter words once per second.
   signal waitCyclesHigh : slv(15 downto 0) := x"0773";
   signal waitCyclesLow  : slv(15 downto 0) := x"5940";
   signal numWords       : slv(15 downto 0) := x"02E9";
   
   
   constant COLNum : integer := 10;
   signal i_data :  Word32Array(COLNum downto 0) := (others => (others => '0'));
   signal i_valid      : sl := '0';
   
begin



   U_IBUFGDS : IBUFGDS port map ( I => fabClkP, IB => fabClkN, O => fabClk);

   --------------------------------
   -- Gigabit Ethernet Interface --
   --------------------------------
   U_S6EthTop : entity work.S6EthTop
      generic map (
         NUM_IP_G     => 2
      )
      port map (
         -- Direct GT connections
         gtTxP           => gtTxP,
         gtTxN           => gtTxN,
         gtRxP           => gtRxP,
         gtRxN           => gtRxN,
         gtClkP          => gtClkP,
         gtClkN          => gtClkN,
         -- Alternative clock input from fabric
         fabClkIn        => fabClk,
         -- SFP transceiver disable pin
         txDisable       => txDisable,
         -- Clocks out from Ethernet core
         ethUsrClk62     => ethClk62,
         ethUsrClk125    => ethClk125,
         -- Status and diagnostics out
         ethSync         => ethRxLinkSync,
         ethReady        => ethAutoNegDone,
         led             => led,
         -- Core settings in 
         macAddr         => ethCoreMacAddr,
         ipAddrs         => (0 => ethCoreIpAddr, 1 => ethCoreIpAddr1),
         udpPorts        => (0 => x"07D0",       1 => x"07D1"), --x7D0 = 2000,
         -- User clock inputs
         userClk         => ethClk125,
         userRstIn       => '0',
         userRstOut      => userRst,
         -- User data interfaces
         userTxData      => userTxDataChannels,
         userTxDataValid => userTxDataValids,
         userTxDataLast  => userTxDataLasts,
         userTxDataReady => userTxDataReadys,
         userRxData      => userRxDataChannels,
         userRxDataValid => userRxDataValids,
         userRxDataLast  => userRxDataLasts,
         userRxDataReady => userRxDataReadys
      );

   U_TpGenTx : entity work.TpGenTx
      generic map (

         GATE_DELAY_G  => GATE_DELAY_G
      )
      port map (
         -- User clock and reset
         userClk         => ethClk125,
         userRst         => userRst,
         -- Configuration
         waitCycles      => waitCyclesHigh & waitCyclesLow,
         numWords        => x"0000" & numWords,
         -- Connection to user logic
         userTxData      => tpData,
         userTxDataValid => tpDataValid,
         userTxDataLast  => tpDataLast,
         userTxDataReady => tpDataReady
      );

   -- Channel 0 TX high speed test pattern
   --           RX unused
   userTxDataChannels(0) <= tpData;
   userTxDataValids(0)   <= tpDataValid;
   userTxDataLasts(0)    <= tpDataLast;
   tpDataReady           <= userTxDataReadys(0);
   -- Note that the Channel 0 RX channels are unused here
   --userRxDataChannels;
   --userRxDataValids;
   --userRxDataLasts;
   userRxDataReadys(0) <= '1';



u_eth_axi_command_receiver : entity work.eth_axi_command_receiver port map(
  clk => ethClk125,
  txData      => userTxDataChannels(1),
  txDataValid => userTxDataValids(1),
  txDataLast  => userTxDataLasts(1),
  txDataReady => userTxDataReadys(1),
  rxData      => userRxDataChannels(1),
  rxDataValid => userRxDataValids(1),
  rxDataLast  => userRxDataLasts(1),
  rxDataReady => userRxDataReadys(1)
  
);
         
end Behavioral;

