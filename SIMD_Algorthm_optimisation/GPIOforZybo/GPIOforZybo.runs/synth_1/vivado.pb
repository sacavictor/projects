
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
create_project: 2

00:00:112

00:00:122	
543.6372	
238.891Z17-268h px� 
>
Refreshing IP repositories
234*coregenZ19-234h px� 
G
"No user IP repositories specified
1154*coregenZ19-1704h px� 
j
"Loaded Vivado IP repository '%s'.
1332*coregen2!
C:/Xilinx/Vivado/2024.1/data/ipZ19-2313h px� 
�
�One or more IPs have been locked in the design '%s'. Please run report_ip_status for more details and recommendations on how to fix this issue.
List of locked IPs:
%s
766*rsb2
design_1.bd2"
 design_1_processing_system7_0_0
Z41-1661h px� 
�
Command: %s
1870*	planAhead2�
�read_checkpoint -auto_incremental -incremental C:/Users/User/Documents/SSC/ProiectSSC/GPIOforZybo/GPIOforZybo.srcs/utils_1/imports/synth_1/design_1_wrapper.dcpZ12-2866h px� 
�
;Read reference checkpoint from %s for incremental synthesis3154*	planAhead2r
pC:/Users/User/Documents/SSC/ProiectSSC/GPIOforZybo/GPIOforZybo.srcs/utils_1/imports/synth_1/design_1_wrapper.dcpZ12-5825h px� 
T
-Please ensure there are no constraint changes3725*	planAheadZ12-7989h px� 
k
Command: %s
53*	vivadotcl2:
8synth_design -top design_1_wrapper -part xc7z020clg400-1Z4-113h px� 
:
Starting synth_design
149*	vivadotclZ4-321h px� 
z
@Attempting to get a license for feature '%s' and/or device '%s'
308*common2
	Synthesis2	
xc7z020Z17-347h px� 
j
0Got license for feature '%s' and/or device '%s'
310*common2
	Synthesis2	
xc7z020Z17-349h px� 
D
Loading part %s157*device2
xc7z020clg400-1Z21-403h px� 
Z
$Part: %s does not have CEAM library.966*device2
xc7z020clg400-1Z21-9227h px� 

VNo compile time benefit to using incremental synthesis; A full resynthesis will be run2353*designutilsZ20-5440h px� 
�
�Flow is switching to default flow due to incremental criteria not met. If you would like to alter this behaviour and have the flow terminate instead, please set the following parameter config_implementation {autoIncr.Synth.RejectBehavior Terminate}2229*designutilsZ20-4379h px� 
o
HMultithreading enabled for synth_design using a maximum of %s processes.4828*oasys2
2Z8-7079h px� 
a
?Launching helper process for spawning children vivado processes4827*oasysZ8-7078h px� 
N
#Helper process launched with PID %s4824*oasys2
18164Z8-7075h px� 
�
%s*synth2{
yStarting RTL Elaboration : Time (s): cpu = 00:00:07 ; elapsed = 00:00:07 . Memory (MB): peak = 1440.816 ; gain = 449.812
h px� 
�
synthesizing module '%s'%s4497*oasys2
design_1_wrapper2
 2s
oC:/Users/User/Documents/SSC/ProiectSSC/GPIOforZybo/GPIOforZybo.gen/sources_1/bd/design_1/hdl/design_1_wrapper.v2
138@Z8-6157h px� 
�
synthesizing module '%s'%s4497*oasys2

design_12
 2m
ic:/Users/User/Documents/SSC/ProiectSSC/GPIOforZybo/GPIOforZybo.gen/sources_1/bd/design_1/synth/design_1.v2
138@Z8-6157h px� 
�
synthesizing module '%s'%s4497*oasys2!
design_1_processing_system7_0_02
 2�
�C:/Users/User/Documents/SSC/ProiectSSC/GPIOforZybo/GPIOforZybo.runs/synth_1/.Xil/Vivado-8788-DESKTOP-DO77H1P/realtime/design_1_processing_system7_0_0_stub.v2
68@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2!
design_1_processing_system7_0_02
 2
02
12�
�C:/Users/User/Documents/SSC/ProiectSSC/GPIOforZybo/GPIOforZybo.runs/synth_1/.Xil/Vivado-8788-DESKTOP-DO77H1P/realtime/design_1_processing_system7_0_0_stub.v2
68@Z8-6155h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
TTC0_WAVE0_OUT2!
design_1_processing_system7_0_02
processing_system7_02m
ic:/Users/User/Documents/SSC/ProiectSSC/GPIOforZybo/GPIOforZybo.gen/sources_1/bd/design_1/synth/design_1.v2
818@Z8-7071h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
TTC0_WAVE1_OUT2!
design_1_processing_system7_0_02
processing_system7_02m
ic:/Users/User/Documents/SSC/ProiectSSC/GPIOforZybo/GPIOforZybo.gen/sources_1/bd/design_1/synth/design_1.v2
818@Z8-7071h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
TTC0_WAVE2_OUT2!
design_1_processing_system7_0_02
processing_system7_02m
ic:/Users/User/Documents/SSC/ProiectSSC/GPIOforZybo/GPIOforZybo.gen/sources_1/bd/design_1/synth/design_1.v2
818@Z8-7071h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
USB0_PORT_INDCTL2!
design_1_processing_system7_0_02
processing_system7_02m
ic:/Users/User/Documents/SSC/ProiectSSC/GPIOforZybo/GPIOforZybo.gen/sources_1/bd/design_1/synth/design_1.v2
818@Z8-7071h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
USB0_VBUS_PWRSELECT2!
design_1_processing_system7_0_02
processing_system7_02m
ic:/Users/User/Documents/SSC/ProiectSSC/GPIOforZybo/GPIOforZybo.gen/sources_1/bd/design_1/synth/design_1.v2
818@Z8-7071h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
M_AXI_GP0_ARVALID2!
design_1_processing_system7_0_02
processing_system7_02m
ic:/Users/User/Documents/SSC/ProiectSSC/GPIOforZybo/GPIOforZybo.gen/sources_1/bd/design_1/synth/design_1.v2
818@Z8-7071h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
M_AXI_GP0_AWVALID2!
design_1_processing_system7_0_02
processing_system7_02m
ic:/Users/User/Documents/SSC/ProiectSSC/GPIOforZybo/GPIOforZybo.gen/sources_1/bd/design_1/synth/design_1.v2
818@Z8-7071h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
M_AXI_GP0_BREADY2!
design_1_processing_system7_0_02
processing_system7_02m
ic:/Users/User/Documents/SSC/ProiectSSC/GPIOforZybo/GPIOforZybo.gen/sources_1/bd/design_1/synth/design_1.v2
818@Z8-7071h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
M_AXI_GP0_RREADY2!
design_1_processing_system7_0_02
processing_system7_02m
ic:/Users/User/Documents/SSC/ProiectSSC/GPIOforZybo/GPIOforZybo.gen/sources_1/bd/design_1/synth/design_1.v2
818@Z8-7071h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
M_AXI_GP0_WLAST2!
design_1_processing_system7_0_02
processing_system7_02m
ic:/Users/User/Documents/SSC/ProiectSSC/GPIOforZybo/GPIOforZybo.gen/sources_1/bd/design_1/synth/design_1.v2
818@Z8-7071h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
M_AXI_GP0_WVALID2!
design_1_processing_system7_0_02
processing_system7_02m
ic:/Users/User/Documents/SSC/ProiectSSC/GPIOforZybo/GPIOforZybo.gen/sources_1/bd/design_1/synth/design_1.v2
818@Z8-7071h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
M_AXI_GP0_ARID2!
design_1_processing_system7_0_02
processing_system7_02m
ic:/Users/User/Documents/SSC/ProiectSSC/GPIOforZybo/GPIOforZybo.gen/sources_1/bd/design_1/synth/design_1.v2
818@Z8-7071h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
M_AXI_GP0_AWID2!
design_1_processing_system7_0_02
processing_system7_02m
ic:/Users/User/Documents/SSC/ProiectSSC/GPIOforZybo/GPIOforZybo.gen/sources_1/bd/design_1/synth/design_1.v2
818@Z8-7071h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
M_AXI_GP0_WID2!
design_1_processing_system7_0_02
processing_system7_02m
ic:/Users/User/Documents/SSC/ProiectSSC/GPIOforZybo/GPIOforZybo.gen/sources_1/bd/design_1/synth/design_1.v2
818@Z8-7071h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
M_AXI_GP0_ARBURST2!
design_1_processing_system7_0_02
processing_system7_02m
ic:/Users/User/Documents/SSC/ProiectSSC/GPIOforZybo/GPIOforZybo.gen/sources_1/bd/design_1/synth/design_1.v2
818@Z8-7071h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
M_AXI_GP0_ARLOCK2!
design_1_processing_system7_0_02
processing_system7_02m
ic:/Users/User/Documents/SSC/ProiectSSC/GPIOforZybo/GPIOforZybo.gen/sources_1/bd/design_1/synth/design_1.v2
818@Z8-7071h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
M_AXI_GP0_ARSIZE2!
design_1_processing_system7_0_02
processing_system7_02m
ic:/Users/User/Documents/SSC/ProiectSSC/GPIOforZybo/GPIOforZybo.gen/sources_1/bd/design_1/synth/design_1.v2
818@Z8-7071h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
M_AXI_GP0_AWBURST2!
design_1_processing_system7_0_02
processing_system7_02m
ic:/Users/User/Documents/SSC/ProiectSSC/GPIOforZybo/GPIOforZybo.gen/sources_1/bd/design_1/synth/design_1.v2
818@Z8-7071h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
M_AXI_GP0_AWLOCK2!
design_1_processing_system7_0_02
processing_system7_02m
ic:/Users/User/Documents/SSC/ProiectSSC/GPIOforZybo/GPIOforZybo.gen/sources_1/bd/design_1/synth/design_1.v2
818@Z8-7071h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
M_AXI_GP0_AWSIZE2!
design_1_processing_system7_0_02
processing_system7_02m
ic:/Users/User/Documents/SSC/ProiectSSC/GPIOforZybo/GPIOforZybo.gen/sources_1/bd/design_1/synth/design_1.v2
818@Z8-7071h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
M_AXI_GP0_ARPROT2!
design_1_processing_system7_0_02
processing_system7_02m
ic:/Users/User/Documents/SSC/ProiectSSC/GPIOforZybo/GPIOforZybo.gen/sources_1/bd/design_1/synth/design_1.v2
818@Z8-7071h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
M_AXI_GP0_AWPROT2!
design_1_processing_system7_0_02
processing_system7_02m
ic:/Users/User/Documents/SSC/ProiectSSC/GPIOforZybo/GPIOforZybo.gen/sources_1/bd/design_1/synth/design_1.v2
818@Z8-7071h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
M_AXI_GP0_ARADDR2!
design_1_processing_system7_0_02
processing_system7_02m
ic:/Users/User/Documents/SSC/ProiectSSC/GPIOforZybo/GPIOforZybo.gen/sources_1/bd/design_1/synth/design_1.v2
818@Z8-7071h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
M_AXI_GP0_AWADDR2!
design_1_processing_system7_0_02
processing_system7_02m
ic:/Users/User/Documents/SSC/ProiectSSC/GPIOforZybo/GPIOforZybo.gen/sources_1/bd/design_1/synth/design_1.v2
818@Z8-7071h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
M_AXI_GP0_WDATA2!
design_1_processing_system7_0_02
processing_system7_02m
ic:/Users/User/Documents/SSC/ProiectSSC/GPIOforZybo/GPIOforZybo.gen/sources_1/bd/design_1/synth/design_1.v2
818@Z8-7071h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
M_AXI_GP0_ARCACHE2!
design_1_processing_system7_0_02
processing_system7_02m
ic:/Users/User/Documents/SSC/ProiectSSC/GPIOforZybo/GPIOforZybo.gen/sources_1/bd/design_1/synth/design_1.v2
818@Z8-7071h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
M_AXI_GP0_ARLEN2!
design_1_processing_system7_0_02
processing_system7_02m
ic:/Users/User/Documents/SSC/ProiectSSC/GPIOforZybo/GPIOforZybo.gen/sources_1/bd/design_1/synth/design_1.v2
818@Z8-7071h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
M_AXI_GP0_ARQOS2!
design_1_processing_system7_0_02
processing_system7_02m
ic:/Users/User/Documents/SSC/ProiectSSC/GPIOforZybo/GPIOforZybo.gen/sources_1/bd/design_1/synth/design_1.v2
818@Z8-7071h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
M_AXI_GP0_AWCACHE2!
design_1_processing_system7_0_02
processing_system7_02m
ic:/Users/User/Documents/SSC/ProiectSSC/GPIOforZybo/GPIOforZybo.gen/sources_1/bd/design_1/synth/design_1.v2
818@Z8-7071h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
M_AXI_GP0_AWLEN2!
design_1_processing_system7_0_02
processing_system7_02m
ic:/Users/User/Documents/SSC/ProiectSSC/GPIOforZybo/GPIOforZybo.gen/sources_1/bd/design_1/synth/design_1.v2
818@Z8-7071h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
M_AXI_GP0_AWQOS2!
design_1_processing_system7_0_02
processing_system7_02m
ic:/Users/User/Documents/SSC/ProiectSSC/GPIOforZybo/GPIOforZybo.gen/sources_1/bd/design_1/synth/design_1.v2
818@Z8-7071h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
M_AXI_GP0_WSTRB2!
design_1_processing_system7_0_02
processing_system7_02m
ic:/Users/User/Documents/SSC/ProiectSSC/GPIOforZybo/GPIOforZybo.gen/sources_1/bd/design_1/synth/design_1.v2
818@Z8-7071h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
FCLK_RESET0_N2!
design_1_processing_system7_0_02
processing_system7_02m
ic:/Users/User/Documents/SSC/ProiectSSC/GPIOforZybo/GPIOforZybo.gen/sources_1/bd/design_1/synth/design_1.v2
818@Z8-7071h px� 
�
Kinstance '%s' of module '%s' has %s connections declared, but only %s given4757*oasys2
processing_system7_02!
design_1_processing_system7_0_02
692
362m
ic:/Users/User/Documents/SSC/ProiectSSC/GPIOforZybo/GPIOforZybo.gen/sources_1/bd/design_1/synth/design_1.v2
818@Z8-7023h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2

design_12
 2
02
12m
ic:/Users/User/Documents/SSC/ProiectSSC/GPIOforZybo/GPIOforZybo.gen/sources_1/bd/design_1/synth/design_1.v2
138@Z8-6155h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
design_1_wrapper2
 2
02
12s
oC:/Users/User/Documents/SSC/ProiectSSC/GPIOforZybo/GPIOforZybo.gen/sources_1/bd/design_1/hdl/design_1_wrapper.v2
138@Z8-6155h px� 
�
%s*synth2{
yFinished RTL Elaboration : Time (s): cpu = 00:00:09 ; elapsed = 00:00:10 . Memory (MB): peak = 1549.199 ; gain = 558.195
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
;
%s
*synth2#
!Start Handling Custom Attributes
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Handling Custom Attributes : Time (s): cpu = 00:00:09 ; elapsed = 00:00:10 . Memory (MB): peak = 1549.199 ; gain = 558.195
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished RTL Optimization Phase 1 : Time (s): cpu = 00:00:09 ; elapsed = 00:00:10 . Memory (MB): peak = 1549.199 ; gain = 558.195
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
Netlist sorting complete. 2

00:00:002
00:00:00.0042

1549.1992
0.000Z17-268h px� 
K
)Preparing netlist for logic optimization
349*projectZ1-570h px� 
>

Processing XDC Constraints
244*projectZ1-262h px� 
=
Initializing timing engine
348*projectZ1-569h px� 
�
$Parsing XDC File [%s] for cell '%s'
848*designutils2�
�c:/Users/User/Documents/SSC/ProiectSSC/GPIOforZybo/GPIOforZybo.gen/sources_1/bd/design_1/ip/design_1_processing_system7_0_0/design_1_processing_system7_0_0/design_1_processing_system7_0_0_in_context.xdc2#
design_1_i/processing_system7_0	8Z20-848h px� 
�
-Finished Parsing XDC File [%s] for cell '%s'
847*designutils2�
�c:/Users/User/Documents/SSC/ProiectSSC/GPIOforZybo/GPIOforZybo.gen/sources_1/bd/design_1/ip/design_1_processing_system7_0_0/design_1_processing_system7_0_0/design_1_processing_system7_0_0_in_context.xdc2#
design_1_i/processing_system7_0	8Z20-847h px� 
�
Parsing XDC File [%s]
179*designutils2^
ZC:/Users/User/Documents/SSC/ProiectSSC/GPIOforZybo/GPIOforZybo.runs/synth_1/dont_touch.xdc8Z20-179h px� 
�
Finished Parsing XDC File [%s]
178*designutils2^
ZC:/Users/User/Documents/SSC/ProiectSSC/GPIOforZybo/GPIOforZybo.runs/synth_1/dont_touch.xdc8Z20-178h px� 
H
&Completed Processing XDC Constraints

245*projectZ1-263h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
Netlist sorting complete. 2

00:00:002

00:00:002

1555.0782
0.000Z17-268h px� 
l
!Unisim Transformation Summary:
%s111*project2'
%No Unisim elements were transformed.
Z1-111h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2"
 Constraint Validation Runtime : 2

00:00:002
00:00:00.0062

1555.0782
0.000Z17-268h px� 

VNo compile time benefit to using incremental synthesis; A full resynthesis will be run2353*designutilsZ20-5440h px� 
�
�Flow is switching to default flow due to incremental criteria not met. If you would like to alter this behaviour and have the flow terminate instead, please set the following parameter config_implementation {autoIncr.Synth.RejectBehavior Terminate}2229*designutilsZ20-4379h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
Finished Constraint Validation : Time (s): cpu = 00:00:20 ; elapsed = 00:00:20 . Memory (MB): peak = 1555.078 ; gain = 564.074
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
D
%s
*synth2,
*Start Loading Part and Timing Information
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
8
%s
*synth2 
Loading part: xc7z020clg400-1
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Loading Part and Timing Information : Time (s): cpu = 00:00:20 ; elapsed = 00:00:20 . Memory (MB): peak = 1555.078 ; gain = 564.074
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
H
%s
*synth20
.Start Applying 'set_property' XDC Constraints
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished applying 'set_property' XDC Constraints : Time (s): cpu = 00:00:20 ; elapsed = 00:00:21 . Memory (MB): peak = 1555.078 ; gain = 564.074
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished RTL Optimization Phase 2 : Time (s): cpu = 00:00:20 ; elapsed = 00:00:21 . Memory (MB): peak = 1555.078 ; gain = 564.074
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
:
%s
*synth2"
 Start RTL Component Statistics 
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
9
%s
*synth2!
Detailed RTL Component Info : 
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
=
%s
*synth2%
#Finished RTL Component Statistics 
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
6
%s
*synth2
Start Part Resource Summary
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
q
%s
*synth2Y
WPart Resources:
DSPs: 220 (col length:60)
BRAMs: 280 (col length: RAMB18 60 RAMB36 30)
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
9
%s
*synth2!
Finished Part Resource Summary
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
E
%s
*synth2-
+Start Cross Boundary and Area Optimization
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
H
&Parallel synthesis criteria is not met4829*oasysZ8-7080h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Cross Boundary and Area Optimization : Time (s): cpu = 00:00:23 ; elapsed = 00:00:23 . Memory (MB): peak = 1555.078 ; gain = 564.074
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
@
%s
*synth2(
&Start Applying XDC Timing Constraints
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Applying XDC Timing Constraints : Time (s): cpu = 00:00:31 ; elapsed = 00:00:32 . Memory (MB): peak = 1555.078 ; gain = 564.074
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
4
%s
*synth2
Start Timing Optimization
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2
}Finished Timing Optimization : Time (s): cpu = 00:00:31 ; elapsed = 00:00:32 . Memory (MB): peak = 1555.078 ; gain = 564.074
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
3
%s
*synth2
Start Technology Mapping
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2~
|Finished Technology Mapping : Time (s): cpu = 00:00:31 ; elapsed = 00:00:32 . Memory (MB): peak = 1555.078 ; gain = 564.074
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
-
%s
*synth2
Start IO Insertion
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
?
%s
*synth2'
%Start Flattening Before IO Insertion
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
B
%s
*synth2*
(Finished Flattening Before IO Insertion
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
6
%s
*synth2
Start Final Netlist Cleanup
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
9
%s
*synth2!
Finished Final Netlist Cleanup
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2x
vFinished IO Insertion : Time (s): cpu = 00:00:37 ; elapsed = 00:00:38 . Memory (MB): peak = 1555.078 ; gain = 564.074
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
=
%s
*synth2%
#Start Renaming Generated Instances
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Renaming Generated Instances : Time (s): cpu = 00:00:37 ; elapsed = 00:00:38 . Memory (MB): peak = 1555.078 ; gain = 564.074
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
:
%s
*synth2"
 Start Rebuilding User Hierarchy
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Rebuilding User Hierarchy : Time (s): cpu = 00:00:37 ; elapsed = 00:00:38 . Memory (MB): peak = 1555.078 ; gain = 564.074
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
9
%s
*synth2!
Start Renaming Generated Ports
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Renaming Generated Ports : Time (s): cpu = 00:00:38 ; elapsed = 00:00:38 . Memory (MB): peak = 1555.078 ; gain = 564.074
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
;
%s
*synth2#
!Start Handling Custom Attributes
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Handling Custom Attributes : Time (s): cpu = 00:00:38 ; elapsed = 00:00:38 . Memory (MB): peak = 1555.078 ; gain = 564.074
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
8
%s
*synth2 
Start Renaming Generated Nets
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Renaming Generated Nets : Time (s): cpu = 00:00:38 ; elapsed = 00:00:38 . Memory (MB): peak = 1555.078 ; gain = 564.074
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
9
%s
*synth2!
Start Writing Synthesis Report
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
/
%s
*synth2

Report BlackBoxes: 
h p
x
� 
O
%s
*synth27
5+------+--------------------------------+----------+
h p
x
� 
O
%s
*synth27
5|      |BlackBox name                   |Instances |
h p
x
� 
O
%s
*synth27
5+------+--------------------------------+----------+
h p
x
� 
O
%s
*synth27
5|1     |design_1_processing_system7_0_0 |         1|
h p
x
� 
O
%s
*synth27
5+------+--------------------------------+----------+
h p
x
� 
/
%s*synth2

Report Cell Usage: 
h px� 
I
%s*synth21
/+------+------------------------------+------+
h px� 
I
%s*synth21
/|      |Cell                          |Count |
h px� 
I
%s*synth21
/+------+------------------------------+------+
h px� 
I
%s*synth21
/|1     |design_1_processing_system7_0 |     1|
h px� 
I
%s*synth21
/+------+------------------------------+------+
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Writing Synthesis Report : Time (s): cpu = 00:00:38 ; elapsed = 00:00:38 . Memory (MB): peak = 1555.078 ; gain = 564.074
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
`
%s
*synth2H
FSynthesis finished with 0 errors, 0 critical warnings and 1 warnings.
h p
x
� 
�
%s
*synth2�
Synthesis Optimization Runtime : Time (s): cpu = 00:00:26 ; elapsed = 00:00:36 . Memory (MB): peak = 1555.078 ; gain = 558.195
h p
x
� 
�
%s
*synth2�
�Synthesis Optimization Complete : Time (s): cpu = 00:00:38 ; elapsed = 00:00:38 . Memory (MB): peak = 1555.078 ; gain = 564.074
h p
x
� 
B
 Translating synthesized netlist
350*projectZ1-571h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
Netlist sorting complete. 2

00:00:002
00:00:00.0052

1555.0782
0.000Z17-268h px� 
K
)Preparing netlist for logic optimization
349*projectZ1-570h px� 
Q
)Pushed %s inverter(s) to %s load pin(s).
98*opt2
02
0Z31-138h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
Netlist sorting complete. 2

00:00:002

00:00:002

1562.4142
0.000Z17-268h px� 
l
!Unisim Transformation Summary:
%s111*project2'
%No Unisim elements were transformed.
Z1-111h px� 
V
%Synth Design complete | Checksum: %s
562*	vivadotcl2

304b9a3aZ4-1430h px� 
C
Releasing license: %s
83*common2
	SynthesisZ17-83h px� 

G%s Infos, %s Warnings, %s Critical Warnings and %s Errors encountered.
28*	vivadotcl2
282
362
02
0Z4-41h px� 
L
%s completed successfully
29*	vivadotcl2
synth_designZ4-42h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
synth_design: 2

00:00:442

00:00:462

1566.4382

1001.477Z17-268h px� 
�
 The %s '%s' has been generated.
621*common2

checkpoint2b
`C:/Users/User/Documents/SSC/ProiectSSC/GPIOforZybo/GPIOforZybo.runs/synth_1/design_1_wrapper.dcpZ17-1381h px� 
�
Executing command : %s
56330*	planAhead2k
ireport_utilization -file design_1_wrapper_utilization_synth.rpt -pb design_1_wrapper_utilization_synth.pbZ12-24828h px� 
\
Exiting %s at %s...
206*common2
Vivado2
Sun Dec 29 18:34:40 2024Z17-206h px� 


End Record