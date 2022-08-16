# System Bus Design

## Bus Architecture

<img
  src="https://github.com/kaushanr/System-Bus-Design/blob/b635b9a3d2be1b8cbe0ab97bc9e9fe662c2a2057/docs/images/Bus_Design_Final.bmp"
  alt="Overview"
  title="Optional title"
  style="display: inline-block; margin: 0 auto; max-width: 20px">


This is our version of a system bus architecture, custom built with a selection of custom protocols.<br>
The design has been inspired by the design and functionality of the AMBA Spec 2.0, AHB/APB buses. Hence it consists of a blend of characteristics native to those bus arcitectures, albeit with significant performance and functionality limitations. <br>

<strong>A more detailed report on the performance is available [here](https://github.com/kaushanr/System-Bus-Design/blob/d9bb30cc176aa504982230904be13e6e81fe69b5/docs/System%20Bus%20Design.pdf).</strong>

### Features & Limitations

| Features | Design Limitations |
| :---: | :---: |
| Priority requests | Data transfers limited to 32-bit WORD sized packets |
| Write / read transactions | No burst transfer capability |
| Split transactions | Split transactions only possible on READ operations|
| | Designed around a specfied static clock frequency|
  
### Address Mapping
<p align="center">
  <img src="https://github.com/kaushanr/System-Bus-Design/blob/6d6dda05f802caa90e11a7e7d23120b032e018dd/docs/images/Address%20Mapping.png">
</p><br>

## Arbiter Module Design

### I/O Definitions
<p align="center">
  <img src="https://github.com/kaushanr/System-Bus-Design/blob/e99b10418b60de18b7bc6e130391b9a7626ba97e/docs/images/Arbiter%20pinout.jpg" width="300">
</p><br>

### Arbitration

<p align="center">
  <img src="https://github.com/kaushanr/System-Bus-Design/blob/74de8b1b098fcf76b2f3bb61a2e224830a742ed3/docs/images/priority.jpg" width="340">
</p><br>

## Master, Slave Module Design
### I/O Definitions
<p align="center">
  <img src="https://github.com/kaushanr/System-Bus-Design/blob/6d6dda05f802caa90e11a7e7d23120b032e018dd/docs/images/master%20pinout.png" width="270"/> <img src="https://github.com/kaushanr/System-Bus-Design/blob/a4548d15422fd3aa55d8b20683ddb22fd5287b69/docs/images/slave%20split%20pinout.png" width="270"/> <img src= "https://github.com/kaushanr/System-Bus-Design/blob/a4548d15422fd3aa55d8b20683ddb22fd5287b69/docs/images/slave%20pinout.png" width="270"/>
</p><br>

### State Transitions
<p align="center">
  <img src="https://github.com/kaushanr/System-Bus-Design/blob/8de9dacfc2ff533b489f6c1f14d064f9e0f7da78/docs/images/Master.bmp" width="440"/>
  <img src="https://github.com/kaushanr/System-Bus-Design/blob/8de9dacfc2ff533b489f6c1f14d064f9e0f7da78/docs/images/Slave_Split.bmp" width="340"/>
</p>
<p align = "center">
  <strong>Master  |  Slave States</strong>
</p>

## Top Level Integration 
### Write, Split, Read Operation
<p align="center">
  <img src="https://github.com/kaushanr/System-Bus-Design/blob/a1241c528bb65c62d6deb7807635494e78d010a6/docs/images/master%201%20-%20write%20read-split%20write%20read.png" />
  <img src="https://github.com/kaushanr/System-Bus-Design/blob/a1241c528bb65c62d6deb7807635494e78d010a6/docs/images/slave%201%20-%20write%20read-split%20write%20read.png" />
</p><br>
The figures above show a brief glimpse of a SPLIT transaction taking place between Master 1 and Slave 1. Bus access is handed off to Master 2 and Slave 2 to perform a WRITE operation in the intermittent time duration. More details included in report. 

## Software
The entire codebase was written and synthesized in Xilinx ISE Design Suite 14.7. <br>
All waveform simulations were performed in the integrated ISim platform.

## References
ARM Developer Documentation : [AMBA Specification (Rev 2.0)](https://developer.arm.com/documentation/ihi0011/a/)
