clc;
clear all;
close all;
R = 2;                          % Radius (m)
az = -90:10:90;                 % Azimuth angles
el = -80:10:80;                 % Elevation angles (excluding poles)
[az_grid, el_grid] = meshgrid(az,el);
poles = [0 0; -90 90];          % Add south and north poles
nDir = [poles [az_grid(:) el_grid(:)]']; % Element normal directions
N = size(nDir,2);               % Number of elements
[x, y, z] = sph2cart(degtorad(nDir(1,:)), degtorad(nDir(2,:)),R*ones(1,N));
hemisphericalConformalArray = phased.ConformalArray(...
    'ElementPosition',[x; y; z],'ElementNormal',nDir);

viewArray(hemisphericalConformalArray,...
    'Title','Hemispherical Conformal Array');
view(90,0)