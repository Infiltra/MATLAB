clc;
clear all;
close all;
%declare the radius
R = 2;
%specify azimuth and elevation
az = -90:10:90;
el = -90:10:90;
%to 3d grid
[az_grid, el_grid] = meshgrid(az, el);
%specify north and south poles
poles = [0 0;-90 90];
ndir = [az_grid(:) el_grid(:)]';
%total number of elements
N = size(ndir, 2);
%to cartesian coordinates
[x, y, z] = sph2cart(deg2rad(ndir(1, :)), deg2rad(ndir(2, :)), R*ones(1, N));
array = phased.ConformalArray('ElementPosition', [x;y;z], 'ElementNormal', ndir)';
POS = getElementPosition(array);
viewArray(array)
%development of array manifold
theta = deg2rad(az);
phi = deg2rad(el);
%wavenumber matrix
f = 60*19^9;c = 3*10^8;
lambda = c./f;
% for p1 = 1:length(theta)
k = (-(2*pi)/lambda).*[sin(theta).*cos(phi);sin(theta).*sin(phi);cos(theta)];
vee = [];
for p1 = 1:sqrt(N)
    pos1(:, p1) = POS(:, p1);
end
v = exp(-j*k'*pos1);
%need to recuesively get for all N^2 elements.
    
