library IEEE;
  use IEEE.std_logic_1164.all;
  use IEEE.numeric_std.all;
  use work.UtilityPkg.all;

entity impl_test_read_write is 
  generic ( 
    WIDTH: integer := 8
  );
  port ( 
    clk: in std_logic;
    
    
    rxData      : in  slv(31 downto 0);
    rxDataValid : in  sl;
    rxDataLast  : in  sl;
    rxDataReady : out sl;
    
    
    tXData      : out  slv(31 downto 0);
    txDataValid : out sl;
    txDataLast  : out  sl;
    txDataReady : in sl
    
  );
end entity;

architecture rtl of impl_test_read_write is
  constant COLNum : integer := 10;
  signal i_data :  Word32Array(COLNum downto 0) := (others => (others => '0'));
  signal i_valid      : sl := '0';
begin
  
  u_reader : entity work.Imp_test_bench_reader 
    generic map (
      COLNum => COLNum
    ) port map (
      Clk       => clk,
      -- Incoming data
      rxData      =>   rxData, 
      rxDataValid =>   rxDataValid, 
      rxDataLast  =>   rxDataLast,  
      rxDataReady =>   rxDataReady, 
      data_out    => i_data,
      valid => i_valid
    );

  u_writer : entity work.Imp_test_bench_writer 
    generic map (
      COLNum => COLNum
    ) port map (
      Clk      => clk,
      -- Incoming data
      tXData      =>  tXData ,  
      txDataValid =>  txDataValid, 
      txDataLast  =>  txDataLast  ,
      txDataReady =>  txDataReady ,
      data_in    => i_data,
      Valid      => i_valid
    );
  
end architecture;
