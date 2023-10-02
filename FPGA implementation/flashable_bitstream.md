# [Steps to create a bitstream that can be stored in the flash memory of the FPGA](https://www.youtube.com/watch?v=UO17LriY9RA&list=LL&index=3)

## Process to follow (after your design steps are complete and you are ready to program the FPGA)
* create a constraint file (named 'bitstream' {name can be anything}).
  - Right click on constraint file ```bitstream```.
  - Select ```Set as target constraint file```.
* Right click and select ```Set used in``` -> uncheck ```sysnthesis``` option and click ```OK```.
  -  complete ```Synthesis``` and open synthesized design.
  -  Once opened, select ```tools``` from the top bar of Vivado -> ```edit device properties```.
     * open ```Configuration``` tab
       - under SPI select ```bus width``` as ```4```.
     * under ```Configuration Modes```
       -  select ```Master SPI x4```.
     * click ```OK```.
     * Save changes.
     * Close synthesized design.
     * Now the constraint file will have been edited automatically.
* generate bitstream.
* Tools -> Generate Memory Configuration File.
  - Format -> BIN.
  - Memory Part -> Spansion S25FL127
  - Filename -> ```filename_bin```
  - Interface -> SPIx4
  - Check ```Load bitstream files``` box
     * Bitfile -> ```bitstream_file_generated``` present in Project Dir under runs-> impl_1-> bitstream_file.bit.
  - Click ```OK```.
* Now we program this file  
  - Switch evaluation board on.
  - Open ```Hardware Manager``` in vivado.
  - Open target and auto connect.
  - Righ click on FPGA present on evaluation board.
  - select add configuration memory device.
  - select flash part.
  - once device is added, right click on device.
  - Select ```Program Configuration Memory Device``` option.
  - Select configuration file (bin file) generated.
  - Leave all other options default.
  - Click ```OK```.
* Change configuration mode  FPGA evaluation board.
  - set it to boot from SPI flash.
  - close hardware manager in Vivado.
  - Switch of the board and switch it on.
  - The board should load it's configuration from memory. 
  
  
  
         
