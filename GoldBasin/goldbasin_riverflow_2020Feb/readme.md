---
title: goldbasin_riverflow_2020Feb
description: simulation of a hypothetical landslide at goldbasin site with river near toe. Non-flat river leads to river flow.
---
# Overview

A simulation of a hypothetical landslide at goldbasin site with a river (water) near the toe. Developed by Yuankun Xu and David George. 

### Relevant/unique parameters for this simulation

* the variable river surface elevation from input file: eta_init_landslide_less1meter.tt3
* the initial porosity is set in setinit.py to `m0 = 0.62`
* the critical porosity is set in setrun.py to `digdata.m_crit = 0.625 `
  (this leads to a mildly contractive, relatively mobile flow)
* the manning coefficient for the fluid phase is: `geodata.coeffmanning = 0.060 `


# Preprocessing

### Required DEM files:

* File description (required input DEMs)

1. topodomain_w_riverbed.tt3 
    * A large topography file that includes both riverbed and landslide slip surface 
    * Landslide volume of this example is 2.1x10^6 m^3

2.  eta_init_landslide_less1meter.tt3
    * DEM of the landslide upper surface, lowered from Xu's surface for edges.
    * Landslide body is defined as (2) minus (1)

3. m0_init_landslide_0.62.tt3
    * DEM of the landslide body for m0 = 0.62.

4.  m0_init_river_200cm_clipped.tt2
    * DEM of river for m0 = 0.

* Place required topography softlinks locally:
```
python setinit.py
```
* Modify `setinit.py` based on the location of DEMs on your path
or you can modify `setrun.py` to point directly to DEMs. 

Note: this setinit.py creates some modified DEMs for the river and landslide surface

# Running/producing output

From your application directory:
```
make .output
```
Or, if you prefer, run in the background with `nohup` and `nice` (which prevents terminating the run if you log off or quit your terminal), and redirect screen output into `run.log` to keep a record of the run:
```
nohup nice make .output > run.log &
```

# Plotting with matlab

* Execute matlab in inside the `_output` directory:
```
matlab> pwd
/path/goldbasin_example/_output
```
* Add the m-files in the parent directory of `_output`:
```
matlab> addpath ../
```
* Results can be plotted with `plotclaw2.m`, and answer yes to use `setplot2.m`:
```
matlab> plotclaw2
plotclaw2  plots 2d results from clawpack or amrclaw
Execute setplot2 (default = no)? yes
```
You can then advance through each frame or output time. The interactive menu provides some options:
```
Hit <return> for next plot, or type k, r, rr, j, i, q, or ? 
```
enter `?` for explanation. Note, if you enter `k`, matlab enters a debug mode and no longer accepts `return` but instead type `dbcont` to continue plotting.   
* Modify the local .m-files to your liking. For example, choose the perspective in `afterframe.m`:

```
% overhead/map view with labeling
mapview_label_gca;

% oblique (3D) perspective (uncomment the following):
%obliqueview_gca;

```
or, you can modify the axis properties in `obliqueview_gca.m`.

* Choose the variable in the solution vector q used for the color-scale in the plots in `setplot2.m:` 
```
mq =1;                       % which component of q to plot
```
would color the flow based on the flow depth. If you set
```
mq = 4;						% which component of q to plot
```
the plots would use a colormap for the solid-volume fraction instead of the depth. 

* The colormaps are specified in `setprob.m`:

```
if mq==6
    flow_colormap = z_velocity;
elseif mq==5
    flow_colormap =zDigPressure;
elseif mq == 1
    flow_colormap = z_depth;
elseif mq==4
    flow_colormap = z_m;
elseif mq==2
    flow_colormap = z_velocity2;
else
    flow_colormap = z_eta;
end
```
You can modify the `flow_colormaps` chosen or defined in `setprob.m` to your liking. Note that the colormaps are used for a discrete or 'binned' scalebar, which is issued in `afterframe.m`:
```
hcbar = colorbar_discrete(flow_colormap,hsurf.Parent);

ylabel(hcbar,'flow depth (m)')
```

# Plotting with python

Plotting with python can be done by issuing 
```
make .plots
```
which executes setplot.py. 

Note: setplot.py is not currently adapted for this application, but can be modified to your needs. Developing setplot.py for this application as an example is planned in the future.