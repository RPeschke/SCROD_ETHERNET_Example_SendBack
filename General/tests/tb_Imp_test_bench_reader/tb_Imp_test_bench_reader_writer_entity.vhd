library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
use work.csv_utilitypkg.all;
use work.tb_imp_test_bench_reader_writer_pgk.all;
use work.type_conversions_pgk.all;

entity tb_Imp_test_bench_reader_writer is 
generic (
FileName : string := ".\Imp_test_bench_reader.csv"
);
port (
clk : in std_logic ;
data : in tb_Imp_test_bench_reader_writer_rec 
);
end entity;

architecture Behavioral of tb_Imp_test_bench_reader_writer is 

constant  NUM_COL : integer := 15;
signal data_int : t_integer_array(NUM_COL downto 0)  := (others=>0)  ;
begin

csv_w : entity  work.csv_write_file 
    generic map (
         FileName => FileName,
         HeaderLines=> "rxData;rxDataValid;rxDataLast;rxDataReady;clk_out;data_out_0;data_out_1;data_out_2;data_out_3;data_out_4;data_out_5;data_out_6;data_out_7;data_out_8;data_out_9;data_out_10",
         NUM_COL =>   NUM_COL ) 
    port map(
         clk => clk, 
         Rows => data_int
    );


slv_to_integer(data.rxData, data_int(0) );
sl_to_integer(data.rxDataValid, data_int(1) );
sl_to_integer(data.rxDataLast, data_int(2) );
sl_to_integer(data.rxDataReady, data_int(3) );
sl_to_integer(data.clk_out, data_int(4) );
slv_to_integer(data.data_out_0, data_int(5) );
slv_to_integer(data.data_out_1, data_int(6) );
slv_to_integer(data.data_out_2, data_int(7) );
slv_to_integer(data.data_out_3, data_int(8) );
slv_to_integer(data.data_out_4, data_int(9) );
slv_to_integer(data.data_out_5, data_int(10) );
slv_to_integer(data.data_out_6, data_int(11) );
slv_to_integer(data.data_out_7, data_int(12) );
slv_to_integer(data.data_out_8, data_int(13) );
slv_to_integer(data.data_out_9, data_int(14) );
slv_to_integer(data.data_out_10, data_int(15) );
end Behavioral;

