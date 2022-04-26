# Bedmesh im Druckbereich

Hallo,

hier zeige ich euch, wie ihr ein Bedmesh im Druckbereich vor jedem Druck einrichtet.

Das original Repo ist von:
https://gist.github.com/ChipCE/95fdbd3c2f3a064397f9610f915f7d02

## <u> Was müsst ihr tun: </u>  
---

- Nehm auch den Bereich aus der marco.cfg und kopiert den in eure macro.cfg
- Fügt in euren "START_PRINT" gcode folgendes ein  
`"BED_MESH_PRINT_AREA AREA_START_X={params.AREA_START_X|float} AREA_START_Y={params.AREA_START_Y|float} AREA_END_X={params.AREA_END_X|float} AREA_END_Y={params.AREA_END_Y|float}"`
*(Am besten hinter dem Ztilt und einem Z-home)*
- Benutzt folgenden Start_Code in eurem Slicer:  
SUSI:  
`START_PRINT T_BED={first_layer_bed_temperature} T_EXTRUDER={first_layer_temperature} AREA_START_X={first_layer_print_min[0]} AREA_START_Y={first_layer_print_min[1]} AREA_END_X={first_layer_print_max[0]} AREA_END_Y={first_layer_print_max[1]}`  
    
    PRUSA:  
    `START_PRINT T_BED=[first_layer_bed_temperature] T_EXTRUDER=[first_layer_temperature] AREA_START_X={first_layer_print_min[0]} AREA_START_Y={first_layer_print_min[1]} AREA_END_X={first_layer_print_max[0]} AREA_END_Y={first_layer_print_max[1]}`  
---

Bei Fragen gerne im Discord https://discord.gg/zZYqTsP9 melden.  


