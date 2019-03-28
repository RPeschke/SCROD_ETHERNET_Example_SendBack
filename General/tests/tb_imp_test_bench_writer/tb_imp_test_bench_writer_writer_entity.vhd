library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
use work.csv_utilitypkg.all;
use work.tb_imp_test_bench_writer_writer_pgk.all;
use work.type_conversions_pgk.all;

entity tb_imp_test_bench_writer_writer is 
generic (
FileName : string := ".\tb_imp_tesp_bench_writer.csv"
);
port (
clk : in std_logic ;
data : in tb_imp_test_bench_writer_writer_rec 
);
end entity;

architecture Behavioral of tb_imp_test_bench_writer_writer is 

constant  NUM_COL : integer := 15;
signal data_int : t_integer_array(NUM_COL downto 0)  := (others=>0)  ;
begin

csv_w : entity  work.csv_write_file 
    generic map (
         FileName => FileName,
         HeaderLines=> "txData;txDataValid;txDataLast;txDataReady;valid;data_in_0;data_in_1;data_in_2;data_in_3;data_in_4;data_in_5;data_in_6;data_in_7;data_in_8;data_in_9;data_in_10",
         NUM_COL =>   NUM_COL ) 
    port map(
         clk => clk, 
         Rows => data_int
    );


slv_to_integer(data.txData, data_int(0) );
sl_to_integer(data.txDataValid, data_int(1) );
sl_to_integer(data.txDataLast, data_int(2) );
sl_to_integer(data.txDataReady, data_int(3) );
sl_to_integer(data.valid, data_int(4) );
slv_to_integer(data.data_in_0, data_int(5) );
slv_to_integer(data.data_in_1, data_int(6) );
slv_to_integer(data.data_in_2, data_int(7) );
slv_to_integer(data.data_in_3, data_int(8) );
slv_to_integer(data.data_in_4, data_int(9) );
slv_to_integer(data.data_in_5, data_int(10) );
slv_to_integer(data.data_in_6, data_int(11) );
slv_to_integer(data.data_in_7, data_int(12) );
slv_to_integer(data.data_in_8, data_int(13) );
slv_to_integer(data.data_in_9, data_int(14) );
slv_to_integer(data.data_in_10, data_int(15) );
end Behavioral;

