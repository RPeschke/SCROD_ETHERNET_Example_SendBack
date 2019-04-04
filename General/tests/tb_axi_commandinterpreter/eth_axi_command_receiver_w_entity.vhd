library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
use work.utilitypkg.all;
use work.eth_axi_command_receiver_w_pgk.all;
use work.type_conversions_pgk.all;

entity eth_axi_command_receiver_w is 
port (
clk : in std_logic ;
data_in : in eth_axi_command_receiver_w_rec ;
valid_in : in std_logic ;
txData : out std_logic_vector(31 downto 0) ;
txDataValid : out std_logic ;
txDataLast : out std_logic ;
txDataReady : in std_logic 
);
end entity;

architecture Behavioral of eth_axi_command_receiver_w is 
signal pack_counter : integer := 0;
constant  NUM_COL : integer := 9;
signal ethernet_writer_data : Word32Array(NUM_COL - 1 downto 0)  := (others =>  (others=>'0'))  ;
begin


  u_writer : entity work.Imp_test_bench_writer 
    generic map (
      COLNum => NUM_COL
    ) port map (
    Clk       => clk,
    -- Incoming data
    tXData      => txData,
    txDataValid => txDataValid,
    txDataLast  => txDataLast,
    txDataReady => txDataReady,
    data_in    => ethernet_writer_data,
    valid =>  valid_in
  );
  process(clk) is 
    
  begin
    if rising_edge(clk) then
      if valid_in = '1' then 
        pack_counter <= pack_counter +1;
      end if ;

    end if;

  end process;
  
  integer_to_slv(pack_counter, ethernet_writer_data(0));
  
  ethernet_writer_data(1) <= data_in.rxData;
sl_to_slv(data_in.rxDataLast, ethernet_writer_data(2) );
sl_to_slv(data_in.rxDataReady, ethernet_writer_data(3) );
sl_to_slv(data_in.rxDataValid, ethernet_writer_data(4) );
slv_to_slv(data_in.txData, ethernet_writer_data(5) );
sl_to_slv(data_in.txDataLast, ethernet_writer_data(6) );
sl_to_slv(data_in.txDataReady, ethernet_writer_data(7) );
sl_to_slv(data_in.txDataValid, ethernet_writer_data(8) );
end Behavioral;

