library IEEE;
  use IEEE.std_logic_1164.all;
  use IEEE.numeric_std.all;

  use work.UtilityPkg.all;
  use work.Eth1000BaseXPkg.all;
  use work.GigabitEthPkg.all;

entity ScrodEthernetExample_ethernet_2_axi is
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
end entity;

architecture rtl of ScrodEthernetExample_ethernet_2_axi is
  
  signal ethClk125       : sl;
  -- User Data interfaces
  signal  TxDataChannels :  DWORD;
  signal  TxDataValids   :  sl;
  signal  TxDataLasts    :  sl;
  signal  TxDataReadys   :  sl;
  signal  RxDataChannels :  DWORD;
  signal  RxDataValids   :  sl;
  signal  RxDataLasts    :  sl;
  signal  RxDataReadys   :  sl;
  
   constant COLNum : integer := 10;
   signal i_data :  Word32Array(COLNum -1 downto 0) := (others => (others => '0'));
   signal i_valid      : sl := '0';
   
   constant COLNum_out : integer := 10;
   signal i_data_out :  Word32Array(COLNum_out -1 downto 0) := (others => (others => '0'));
   
begin
  
  
  e2a : entity work.ethernet2axistream port map(
    -- Direct GT connections
    gtTxP        => gtTxP,
    gtTxN        => gtTxN,
    gtRxP        => gtRxP,
    gtRxN        => gtRxN,
    gtClkP       => gtClkP, 
    gtClkN       => gtClkN,
    
    -- Alternative clock input
    fabClkP      => fabClkP,
    fabClkN      => fabClkN,
    
    clockOut => ethClk125,
    -- SFP transceiver disable pin
    txDisable    => txDisable,
    -- axi stream output

    -- User Data interfaces
    TxDataChannels => TxDataChannels,
    TxDataValids   => TxDataValids,
    TxDataLasts    => TxDataLasts,
    TxDataReadys   => TxDataReadys,
    RxDataChannels => RxDataChannels,
    RxDataValids   => RxDataValids,
    RxDataLasts    => RxDataLasts,
    RxDataReadys   => RxDataReadys,

    EthernetIpAddr  => (3 => x"C0", 2 => x"A8", 1 => x"01", 0 => x"21"),
    udpPort        =>   x"07D1" 
    
  );
  
  
  u_reader : entity work.Imp_test_bench_reader 
    generic map (
      COLNum => COLNum 
    ) port map (
      Clk       => ethClk125,
      -- Incoming data
      rxData      => RxDataChannels,
      rxDataValid => RxDataValids,
      rxDataLast  => RxDataLasts,
      rxDataReady => RxDataReadys,
      data_out    => i_data,
      valid => i_valid
    );

  u_writer : entity work.Imp_test_bench_writer 
    generic map (
      COLNum => COLNum_out 
    ) port map (
      Clk      => ethClk125,
      -- Incoming data
      tXData      =>  TxDataChannels,
      txDataValid =>  TxDataValids,
      txDataLast  =>  TxDataLasts,
      txDataReady =>  TxDataReadys,
      data_in    => i_data_out,
      Valid      => i_valid
    );
end architecture;