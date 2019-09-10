%both transitter and receiver have hemi-spherical array structures
%no BF
clc;
clear all;
close all;
%frequency and other variables
f = 60*10^9;c = 3*10^8;
lambda = c/f;

%delcare the radius
R = 0.5*lambda;
%specify azimuth and elevation
az_tx = linspace(0, 180, 4);
el_tx = linspace(-80, 80, 4);
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
%viewArray(array_tx)
%scatter3(x_tx, y_tx, z_tx);hold on;

%rx
%specify azimuth and elevation
az_rx = linspace(-180, 0, 4);
el_rx = linspace(-80, 80, 4);
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
%figure, viewArray(array_rx)
%figure, scatter3(x_rx, y_rx, z_rx);hold on;

%frequency and other variables
f = 60*10^9;c = 3*10^8;
lambda = c/f;
%wavenuber
w = (2*pi)/lambda;
%generate random bits
M = 4;
lut = pskmod([0:M-1], M);
m_all = log2(M) + log2(sqrt(N_tx));
N_total = 1*10^6;
%scatters
L = max(N_tx, N_rx);
[theta_t, phi_t, r_t] = cart2sph(x_tx, y_tx, z_tx);
k_tx = (-(2*pi)/lambda).*[sin(theta_t).*cos(phi_t);sin(theta_t).*sin(phi_t);cos(theta_t)];
v_t1 = exp(-j*k_tx'*pos_tx);
vt = v_t1.';
%receiver operations
[theta_r, phi_r, r_r] = cart2sph(x_rx, y_rx, z_rx);
k_rx = (-(2*pi)/lambda).*[sin(theta_r).*cos(phi_r);sin(theta_r).*sin(phi_r);cos(theta_r)];
v_r1 = exp(-j*k_rx'*pos_rx);
vr = v_r1.';
alpha_l = (sqrt(0.5))*(randn(L, 1) + 1i*randn(L, 1));
%simplified channel matrix
z = alpha_l.';
%channel
H = vr*diag(z)*vt';
F1 = diagbfweights(H);
F1 = F1(1:vt,:);
pattern(array_tx,f,-90:90,-90:90,'Type','efield','ElementWeights',F1','PropagationSpeed',c);
F2 = diagbfweights(H);
F2 = F1(1:vr,:);
figure();
pattern(array_rx,f,-90:90,-90:90,'Type','efield','ElementWeights',F2','PropagationSpeed',c);