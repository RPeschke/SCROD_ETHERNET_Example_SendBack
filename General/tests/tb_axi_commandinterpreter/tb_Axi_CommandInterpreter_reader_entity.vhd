library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
use work.csv_utilitypkg.all;
use work.tb_axi_commandinterpreter_reader_pgk.all;
use work.type_conversions_pgk.all;

entity tb_Axi_CommandInterpreter_reader is 
generic (
FileName : string := ".\tb_Axi_CommandInterpreter.csv"
);
port (
clk : in std_logic ;
data : out tb_Axi_CommandInterpreter_reader_rec 
);
end entity;

architecture Behavioral of tb_Axi_CommandInterpreter_reader is 

constant  NUM_COL : integer := 3;
signal csv_r_data : t_integer_array(NUM_COL downto 0)  := (others=>0)  ;
begin


csv_r :entity  work.csv_read_file 
    generic map (
       FileName =>  FileName, 
       NUM_COL => NUM_COL,
       useExternalClk=>true,
       HeaderLines =>  2
       ) 
       port map(
       clk => clk,
       Rows => csv_r_data
       );

integer_to_slv(csv_r_data(0), data.rxData );
integer_to_sl(csv_r_data(1), data.rxDataValid );
integer_to_sl(csv_r_data(2), data.rxDataLast );
integer_to_sl(csv_r_data(3), data.txDataReady );
end Behavioral;

