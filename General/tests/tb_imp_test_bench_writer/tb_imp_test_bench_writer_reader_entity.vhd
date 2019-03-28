library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
use work.csv_utilitypkg.all;
use work.tb_imp_test_bench_writer_reader_pgk.all;
use work.type_conversions_pgk.all;

entity tb_imp_test_bench_writer_reader is 
generic (
FileName : string := ".\tb_imp_tesp_bench_writer.csv"
);
port (
clk : in std_logic ;
data : out tb_imp_test_bench_writer_reader_rec 
);
end entity;

architecture Behavioral of tb_imp_test_bench_writer_reader is 

constant  NUM_COL : integer := 12;
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

integer_to_sl(csv_r_data(0), data.txDataReady );
integer_to_sl(csv_r_data(1), data.valid );
integer_to_slv(csv_r_data(2), data.data_in_0 );
integer_to_slv(csv_r_data(3), data.data_in_1 );
integer_to_slv(csv_r_data(4), data.data_in_2 );
integer_to_slv(csv_r_data(5), data.data_in_3 );
integer_to_slv(csv_r_data(6), data.data_in_4 );
integer_to_slv(csv_r_data(7), data.data_in_5 );
integer_to_slv(csv_r_data(8), data.data_in_6 );
integer_to_slv(csv_r_data(9), data.data_in_7 );
integer_to_slv(csv_r_data(10), data.data_in_8 );
integer_to_slv(csv_r_data(11), data.data_in_9 );
integer_to_slv(csv_r_data(12), data.data_in_10 );
end Behavioral;

