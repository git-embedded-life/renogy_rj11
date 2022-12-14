EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L Device:R R1
U 1 1 6328A659
P 3075 2875
F 0 "R1" V 2868 2875 50  0000 C CNN
F 1 "R" V 2959 2875 50  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P10.16mm_Horizontal" V 3005 2875 50  0001 C CNN
F 3 "~" H 3075 2875 50  0001 C CNN
	1    3075 2875
	0    1    1    0   
$EndComp
$Comp
L Device:R R3
U 1 1 6328B481
P 3925 2275
F 0 "R3" H 3995 2321 50  0000 L CNN
F 1 "R" H 3995 2230 50  0000 L CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P10.16mm_Horizontal" V 3855 2275 50  0001 C CNN
F 3 "~" H 3925 2275 50  0001 C CNN
	1    3925 2275
	1    0    0    -1  
$EndComp
$Comp
L Device:R R4
U 1 1 6328BE61
P 4725 2275
F 0 "R4" H 4795 2321 50  0000 L CNN
F 1 "R" H 4795 2230 50  0000 L CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P10.16mm_Horizontal" V 4655 2275 50  0001 C CNN
F 3 "~" H 4725 2275 50  0001 C CNN
	1    4725 2275
	1    0    0    -1  
$EndComp
$Comp
L Device:R R2
U 1 1 6328C359
P 3075 3175
F 0 "R2" V 2868 3175 50  0000 C CNN
F 1 "R" V 2959 3175 50  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P10.16mm_Horizontal" V 3005 3175 50  0001 C CNN
F 3 "~" H 3075 3175 50  0001 C CNN
	1    3075 3175
	0    1    1    0   
$EndComp
$Comp
L power:+3V3 #PWR03
U 1 1 6328D9B1
P 4325 1625
F 0 "#PWR03" H 4325 1475 50  0001 C CNN
F 1 "+3V3" H 4340 1798 50  0000 C CNN
F 2 "" H 4325 1625 50  0001 C CNN
F 3 "" H 4325 1625 50  0001 C CNN
	1    4325 1625
	1    0    0    -1  
$EndComp
$Comp
L Connector:6P6C J1
U 1 1 6328E7EB
P 2150 3075
F 0 "J1" H 2207 3642 50  0000 C CNN
F 1 "6P6C" H 2207 3551 50  0000 C CNN
F 2 "Connector_RJ:RJ12_Amphenol_54601" V 2150 3100 50  0001 C CNN
F 3 "~" V 2150 3100 50  0001 C CNN
	1    2150 3075
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR01
U 1 1 63290CA8
P 2675 3625
F 0 "#PWR01" H 2675 3375 50  0001 C CNN
F 1 "GND" H 2680 3452 50  0000 C CNN
F 2 "" H 2675 3625 50  0001 C CNN
F 3 "" H 2675 3625 50  0001 C CNN
	1    2675 3625
	1    0    0    -1  
$EndComp
Wire Wire Line
	2550 2775 2675 2775
Wire Wire Line
	2675 2775 2675 3275
Wire Wire Line
	2550 3275 2675 3275
Connection ~ 2675 3275
Wire Wire Line
	2675 3275 2675 3625
NoConn ~ 2550 2975
NoConn ~ 2550 3075
Wire Wire Line
	2550 3175 2925 3175
Wire Wire Line
	2550 2875 2925 2875
Wire Wire Line
	3225 2875 3625 2875
Wire Wire Line
	3225 3175 4425 3175
$Comp
L power:GND #PWR04
U 1 1 6329AB4E
P 4725 3600
F 0 "#PWR04" H 4725 3350 50  0001 C CNN
F 1 "GND" H 4730 3427 50  0000 C CNN
F 2 "" H 4725 3600 50  0001 C CNN
F 3 "" H 4725 3600 50  0001 C CNN
	1    4725 3600
	1    0    0    -1  
$EndComp
Wire Wire Line
	4725 3375 4725 3600
$Comp
L power:GND #PWR02
U 1 1 6329BE2A
P 3925 3600
F 0 "#PWR02" H 3925 3350 50  0001 C CNN
F 1 "GND" H 3930 3427 50  0000 C CNN
F 2 "" H 3925 3600 50  0001 C CNN
F 3 "" H 3925 3600 50  0001 C CNN
	1    3925 3600
	1    0    0    -1  
$EndComp
Wire Wire Line
	3925 3075 3925 3600
Wire Wire Line
	3925 2425 3925 2500
Wire Wire Line
	4725 2975 4725 2625
$Comp
L power:+3V3 #PWR05
U 1 1 632A3050
P 6750 2000
F 0 "#PWR05" H 6750 1850 50  0001 C CNN
F 1 "+3V3" H 6765 2173 50  0000 C CNN
F 2 "" H 6750 2000 50  0001 C CNN
F 3 "" H 6750 2000 50  0001 C CNN
	1    6750 2000
	1    0    0    -1  
$EndComp
Wire Wire Line
	6750 2000 6750 2150
Wire Wire Line
	6750 2150 7025 2150
$Comp
L power:GND #PWR06
U 1 1 632A5553
P 6925 4100
F 0 "#PWR06" H 6925 3850 50  0001 C CNN
F 1 "GND" H 6930 3927 50  0000 C CNN
F 2 "" H 6925 4100 50  0001 C CNN
F 3 "" H 6925 4100 50  0001 C CNN
	1    6925 4100
	1    0    0    -1  
$EndComp
$Comp
L Connector_Generic:Conn_02x20_Odd_Even J2
U 1 1 632A6EAD
P 7225 3050
F 0 "J2" H 7275 4167 50  0000 C CNN
F 1 "Conn_02x20_Odd_Even" H 7275 4076 50  0000 C CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_2x20_P2.54mm_Vertical" H 7225 3050 50  0001 C CNN
F 3 "~" H 7225 3050 50  0001 C CNN
	1    7225 3050
	1    0    0    -1  
$EndComp
Wire Wire Line
	7025 2550 6925 2550
Wire Wire Line
	6925 2550 6925 3350
Wire Wire Line
	7025 3350 6925 3350
Connection ~ 6925 3350
Wire Wire Line
	6925 3350 6925 4050
Wire Wire Line
	7025 4050 6925 4050
Connection ~ 6925 4050
Wire Wire Line
	6925 4050 6925 4100
$Comp
L power:GND #PWR07
U 1 1 632ACE3B
P 7625 4100
F 0 "#PWR07" H 7625 3850 50  0001 C CNN
F 1 "GND" H 7630 3927 50  0000 C CNN
F 2 "" H 7625 4100 50  0001 C CNN
F 3 "" H 7625 4100 50  0001 C CNN
	1    7625 4100
	1    0    0    -1  
$EndComp
Wire Wire Line
	7525 3750 7625 3750
Wire Wire Line
	7625 3750 7625 4025
Wire Wire Line
	7525 3550 7625 3550
Wire Wire Line
	7625 3550 7625 3750
Connection ~ 7625 3750
Wire Wire Line
	7525 3050 7625 3050
Wire Wire Line
	7625 3050 7625 3550
Connection ~ 7625 3550
Wire Wire Line
	7525 2750 7625 2750
Wire Wire Line
	7625 2750 7625 3050
Connection ~ 7625 3050
Wire Wire Line
	7525 2350 7625 2350
Wire Wire Line
	7625 2350 7625 2750
Connection ~ 7625 2750
Wire Wire Line
	4325 1625 3925 1625
Wire Wire Line
	3925 1625 3925 2125
Wire Wire Line
	4325 1625 4725 1625
Wire Wire Line
	4725 1625 4725 2125
Connection ~ 4325 1625
Wire Wire Line
	3925 2500 6100 2500
Wire Wire Line
	6100 2500 6100 1550
Wire Wire Line
	6100 1550 8125 1550
Connection ~ 3925 2500
Wire Wire Line
	3925 2500 3925 2675
Wire Wire Line
	7525 2950 8125 2950
Wire Wire Line
	8125 1550 8125 2950
Wire Wire Line
	4725 2625 6225 2625
Wire Wire Line
	6225 2625 6225 1675
Wire Wire Line
	6225 1675 8000 1675
Wire Wire Line
	8000 1675 8000 2850
Wire Wire Line
	8000 2850 7525 2850
Connection ~ 4725 2625
Wire Wire Line
	4725 2625 4725 2425
NoConn ~ 7025 2250
NoConn ~ 7025 2350
NoConn ~ 7025 2450
NoConn ~ 7025 2650
NoConn ~ 7025 2750
NoConn ~ 7025 2850
NoConn ~ 7025 2950
NoConn ~ 7025 3050
NoConn ~ 7025 3150
NoConn ~ 7025 3250
NoConn ~ 7025 3450
NoConn ~ 7025 3550
NoConn ~ 7025 3650
NoConn ~ 7025 3750
NoConn ~ 7025 3850
NoConn ~ 7025 3950
NoConn ~ 7525 4050
NoConn ~ 7525 3950
NoConn ~ 7525 3850
NoConn ~ 7525 3650
NoConn ~ 7525 3450
NoConn ~ 7525 3350
NoConn ~ 7525 3250
NoConn ~ 7525 3150
NoConn ~ 7525 2650
NoConn ~ 7525 2550
NoConn ~ 7525 2450
NoConn ~ 7525 2250
NoConn ~ 7525 2150
$Comp
L power:PWR_FLAG #FLG0101
U 1 1 632C89A6
P 7625 4025
F 0 "#FLG0101" H 7625 4100 50  0001 C CNN
F 1 "PWR_FLAG" V 7625 4153 50  0000 L CNN
F 2 "" H 7625 4025 50  0001 C CNN
F 3 "~" H 7625 4025 50  0001 C CNN
	1    7625 4025
	0    1    1    0   
$EndComp
Connection ~ 7625 4025
Wire Wire Line
	7625 4025 7625 4100
$Comp
L power:PWR_FLAG #FLG0102
U 1 1 632CA795
P 4725 1625
F 0 "#FLG0102" H 4725 1700 50  0001 C CNN
F 1 "PWR_FLAG" V 4725 1753 50  0000 L CNN
F 2 "" H 4725 1625 50  0001 C CNN
F 3 "~" H 4725 1625 50  0001 C CNN
	1    4725 1625
	0    1    1    0   
$EndComp
Connection ~ 4725 1625
$Comp
L Device:Q_NPN_EBC Q1
U 1 1 632E15F2
P 3825 2875
F 0 "Q1" H 4016 2921 50  0000 L CNN
F 1 "Q_NPN_EBC" H 4016 2830 50  0000 L CNN
F 2 "Package_SIP:SIP3_11.6x8.5mm" H 4025 2975 50  0001 C CNN
F 3 "~" H 3825 2875 50  0001 C CNN
	1    3825 2875
	1    0    0    -1  
$EndComp
$Comp
L Device:Q_NPN_EBC Q2
U 1 1 632E3169
P 4625 3175
F 0 "Q2" H 4816 3221 50  0000 L CNN
F 1 "Q_NPN_EBC" H 4816 3130 50  0000 L CNN
F 2 "Package_SIP:SIP3_11.6x8.5mm" H 4825 3275 50  0001 C CNN
F 3 "~" H 4625 3175 50  0001 C CNN
	1    4625 3175
	1    0    0    -1  
$EndComp
$EndSCHEMATC
