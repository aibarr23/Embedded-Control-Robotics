-- Hell world program
-- commands used in terminal
-- compile the file: ghdl -a hello.vhdl
-- run file: ghdl -e hello_world
-- launch: ghdl -r hello_world

use std.textio.all; -- Imports that standard textio package.

-- Defines a design entitty, without any ports.
entity hello_world is
end hello_world;

architecture behavior of hello_world is
begin
  process
    variable l : line;
  begin
    write (l, string'("Hello world!"));
    writeline (output, l);
    wait;
  end process;
end behavior;
