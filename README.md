# STE_JU2003_R_files
Date: 2017/11/23 
Release: IOP9-R2  
No. of receptors: 44 
***
## Experiment info
### Met
Station name: PWIDS15  
Location: 
Wind direction: 168 degree  
Wind speed: 6.13 m/s at 30 m
### Release
Site name: Park  
Location: (634686,3926036,0)  
Strength: 2.0 g/s, continuous  
### Receptors
Name:SF6 samplers  
No. Easting Northing height  
1. 054 634617,3926150,0,  
2. 064 634602,3926283,0,  
3. 065 634695,3926282,0,  
4. 074 634622,3926383,0,  
5. 084 634623,3926495,0,  
6. 086 634781,3926490,0,  
7. 094 634603,3926632,0,  
***
## CFD airflow info
Turbulence model: realizableKE
Solver: simpleFoam
Building model: center blocks (2,2)
### Location mapping 
> (UTM E, UTM N) -> CFD location (x,y):  
> (634614.498,3925939.808) -> (1900,1400)  
### Computational domain:
(4096,4096,1024)  
### Mesh info
Total No.: 900w+, unstructured  
Min size: (1, 1, 0.5)  
made by Star-CCM+
### B.C.
Wind direction: 168 degree  
Wind profile: power law, alpha = 0.25  
Ground: nutkWallFunction  
### Other settings
Sc_t = 0.7  
Discretization: 2nd order limitedLinear
### adjoint info
sourceProperties made by sourcePropertiesMaker.R  
***
## STE info
### Potential source region
1000*750 2d, 2m interval
Run by sampleDictMaker.R  
