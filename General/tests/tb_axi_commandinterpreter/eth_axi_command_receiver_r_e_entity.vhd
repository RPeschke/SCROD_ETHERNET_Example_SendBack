library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
use work.utilitypkg.all;
use work.eth_axi_command_receiver_r_e_pgk.all;
use work.type_conversions_pgk.all;

entity eth_axi_command_receiver_r is 
port (
rxData : in std_logic_vector(31 downto 0) ;
rxDataValid : in std_logic ;
rxDataLast : in std_logic ;
rxDataReady : out std_logic ;
clk : in std_logic ;
data_out : out eth_axi_command_receiver_r_e_rec ;
valid_out : out std_logic 
);
end entity;

architecture Behavioral of eth_axi_command_receiver_r is 

constant  NUM_COL : integer := 5;
signal eth_reader_data : Word32Array(NUM_COL-1 downto 0)  := (others =>  (others=>'0'))  ;
signal eth_reader_valid : std_logic  := '0'  ;
begin


  u_reader : entity work.Imp_test_bench_reader 
    generic map (
      COLNum => NUM_COL
    ) port map (
    Clk       => clk,
    -- Incoming data
    rxData      => rxData,
    rxDataValid => rxDataValid,
    rxDataLast  => rxDataLast,
    rxDataReady => rxDataReady,
    data_out    => eth_reader_data,
    valid =>  valid_out
  );



    
  data_out.rxData  <= eth_reader_data(1);
slv_to_sl(eth_reader_data(2), data_out.rxDataValid );
slv_to_sl(eth_reader_data(3), data_out.rxDataLast );
slv_to_sl(eth_reader_data(4), data_out.txDataReady );
end Behavioral;

