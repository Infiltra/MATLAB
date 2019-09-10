%both transitter and receiver have hemi-spherical array structures
%no BF
clc;
clear all;
close all;
%delcare the radius
R = 0.1;
%specify azimuth and elevation
az_tx = linspace(0, 180, 2);
el_tx = linspace(-80, 80, 2);
%to 3d grid
[az_grid_tx, el_grid_tx] = meshgrid(az_tx, el_tx);
%specify north and south poles
poles = [0 0;-90 90];
ndir_tx = [az_grid_tx(:) el_grid_tx(:)]';
%total number of elements
N_tx = size(ndir_tx, 2);
%to cartesian coordinates
[x_tx, y_tx, z_tx] = sph2cart(deg2rad(ndir_tx(1, :)), deg2rad(ndir_tx(2, :)), R*ones(1, N_tx));
array_tx = phased.ConformalArray('ElementPosition', [x_tx;y_tx;z_tx], 'ElementNormal', ndir_tx);
pos_tx = getElementPosition(array_tx);
viewArray(array_tx)
%scatter3(x_tx, y_tx, z_tx);hold on;

%rx
%specify azimuth and elevation
az_rx = linspace(-180, 0, 2);
el_rx = linspace(-80, 80, 2);
%to 3d grid
[az_grid_rx, el_grid_rx] = meshgrid(az_rx, el_rx);
%specify north and south poles
poles = [0 0;-90 90];
ndir_rx = [az_grid_rx(:) el_grid_rx(:)]';
%total number of elements
N_rx = size(ndir_rx, 2);
%to cartesian coordinates
[x_rx, y_rx, z_rx] = sph2cart(deg2rad(ndir_rx(1, :)), deg2rad(ndir_rx(2, :)), R*ones(1, N_rx));
array_rx = phased.ConformalArray('ElementPosition', [x_rx;y_rx;z_rx], 'ElementNormal', ndir_rx);
pos_rx = getElementPosition(array_rx);
figure, viewArray(array_rx)
%figure, scatter3(x_rx, y_rx, z_rx);hold on;