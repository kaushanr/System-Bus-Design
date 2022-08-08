# System Bus Design
EN5102 - Digital System Design - Group Project
<br>
## Bus Architecture

<img
  src="https://github.com/kaushanr/System-Bus-Design/blob/b635b9a3d2be1b8cbe0ab97bc9e9fe662c2a2057/docs/images/Bus_Design_Final.bmp"
  alt="Overview"
  title="Optional title"
  style="display: inline-block; margin: 0 auto; max-width: 20px">


This is our version of a system bus architecture, custom built with a selection of custom protocols.<br>
The design has been inspired by the design and functionality of the AMBA Spec 2.0, AHB/APB buses. Hence it consists of a blend of characteristics native to those bus arcitectures, albeit with significant performance and functionality limitations. <br>

<strong>A more detailed report on the performance is available [here](https://github.com/kaushanr/System-Bus-Design/blob/92e26f4ede344538dfdde3f7720f13ace26bae47/System%20Bus%20Design.pdf).</strong>

### Address Mapping
<p align="center">
  <img src="https://github.com/kaushanr/System-Bus-Design/blob/6d6dda05f802caa90e11a7e7d23120b032e018dd/docs/images/Address%20Mapping.png">
</p><br>

## Master, Slave Module Design
### I/O Definitions
<p align="center">
  <img src="https://github.com/kaushanr/System-Bus-Design/blob/6d6dda05f802caa90e11a7e7d23120b032e018dd/docs/images/master%20pinout.png" width="325"/> <img src="https://github.com/kaushanr/System-Bus-Design/blob/a4548d15422fd3aa55d8b20683ddb22fd5287b69/docs/images/slave%20split%20pinout.png" width="325"/> <img src= "https://github.com/kaushanr/System-Bus-Design/blob/a4548d15422fd3aa55d8b20683ddb22fd5287b69/docs/images/slave%20pinout.png" width="325"/>
</p><br>

### State Transitions
<p align="center">
  <figure>
  <img src="https://github.com/kaushanr/System-Bus-Design/blob/8de9dacfc2ff533b489f6c1f14d064f9e0f7da78/docs/images/Master.bmp" width="569"/>
  <figcaption align = "center"><b>Fig.1 - 4K Mountains Wallpaper</b></figcaption>
  </figure>
  <figure>
  <img src="https://github.com/kaushanr/System-Bus-Design/blob/8de9dacfc2ff533b489f6c1f14d064f9e0f7da78/docs/images/Slave_Split.bmp" width="439"/>
  </figure>
</p><br>

## Top Level Integration 
### Write, Split, Read Operation
