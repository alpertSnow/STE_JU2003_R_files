# STE_JU2003_OF_files
Date: 2017/08/27  
Release: IOP9-R2  
No. of receptors: 7  
***
## Experiment info
### Met
Station name: M01, St. Anthony’s Hospital, N 10th and Dewey  
Location: (633954,3927040,45)  
Wind direction: 182.33 ± 11.62 degree  
Wind speed: 7.41 m/s  
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
Turbulence model: SKE
Solver: simpleFoam
Building model: center blocks (2,2)
### Location mapping 
> (UTM E, UTM N) -> CFD location (x,y):  
> (634614.498,3925939.808) -> (500,550)  
### Computational domain:
(1050,1350,200)  
### Mesh info
Total No.: 4067283, unstructured  
Min size: (2,2,2)  
snappyHexMesh: castellatedMesh T; snap T; addLayers F;
refinmentBox: min (200,0,0) max (850,900,50)  
### B.C.
Wind direction: 180 degree  
Wind profile: power law, alpha = 0.25  
Ground: nutkWallFunction  
### Other settings
Sc_t = 0.7  
Discretization: 1st order upwind  
### adjoint info
sourceProperties made by sourcePropertiesMaker.R  
***
## STE info
### Potential source region
    x <- seq(201,849,2)  
    y <- seq(1,899,2)  
    z <- seq(1,1,1)  
Run by sampleDictMaker.R  
