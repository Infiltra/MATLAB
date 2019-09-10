clc
clear all;
close all;
%element declarations
N = 60;
f = 400e6;
%element spacing
theta = 360/N;
%get value in radians
thetarad = deg2rad(theta);
%choosing radius
arclength = 0.5*(physconst('LightSpeed')/f);
%radius
radius = arclength/thetarad;
%per element azimuth angle
ang = (0:N-1)*theta;
ang(ang >= 180) = ang(ang >= 180) - 360;
per = phased.ConformalArray;
%set positions
per.ElementPosition = [radius*cosd(ang);radius*sind(ang);zeros(1, N)];
figure();
viewArray(per);
figure();
pattern(per, 1e9, [-180:180], 0, 'PropagationSpeed', physconst('LightSpeed'), ...
    'CoordinateSystem', 'polar', 'Type', 'powerdb', 'Normalize', true);