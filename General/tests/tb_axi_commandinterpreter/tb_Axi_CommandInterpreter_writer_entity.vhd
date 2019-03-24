library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
use work.csv_utilitypkg.all;
use work.tb_axi_commandinterpreter_writer_pgk.all;
use work.type_conversions_pgk.all;

entity tb_Axi_CommandInterpreter_writer is 
generic (
FileName : string := ".\tb_Axi_CommandInterpreter.csv"
);
port (
clk : in std_logic ;
data : in tb_Axi_CommandInterpreter_writer_rec 
);
end entity;

architecture Behavioral of tb_Axi_CommandInterpreter_writer is 

constant  NUM_COL : integer := 7;
signal data_int : t_integer_array(NUM_COL downto 0)  := (others=>0)  ;
begin

csv_w : entity  work.csv_write_file 
    generic map (
         FileName => FileName,
         HeaderLines=> "rxData;rxDataValid;rxDataLast;rxDataReady;txData;txDataValid;txDataLast;txDataReady",
         NUM_COL =>   NUM_COL ) 
    port map(
         clk => clk, 
         Rows => data_int
    );


slv_to_integer(data.rxData, data_int(0) );
sl_to_integer(data.rxDataValid, data_int(1) );
sl_to_integer(data.rxDataLast, data_int(2) );
sl_to_integer(data.rxDataReady, data_int(3) );
slv_to_integer(data.txData, data_int(4) );
sl_to_integer(data.txDataValid, data_int(5) );
sl_to_integer(data.txDataLast, data_int(6) );
sl_to_integer(data.txDataReady, data_int(7) );
end Behavioral;

