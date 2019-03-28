library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
use work.csv_utilitypkg.all;
use work.tb_imp_test_bench_reader_reader_pgk.all;
use work.type_conversions_pgk.all;

entity tb_Imp_test_bench_reader_reader is 
generic (
FileName : string := ".\Imp_test_bench_reader.csv"
);
port (
clk : in std_logic ;
data : out tb_Imp_test_bench_reader_reader_rec 
);
end entity;

architecture Behavioral of tb_Imp_test_bench_reader_reader is 

constant  NUM_COL : integer := 2;
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
end Behavioral;

