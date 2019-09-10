clc;
clear all;
close all;
%get the frequency data
f = [500 1000 1500];%if three elements are given here then three equn are needed and three plots are obtained
%get the toolbox function into here
p = phased.CustomMicrophoneElement('PolarPatternFrequencies', f);
%convert angles to db
p.PolarPattern = mag2db([0.5+0.5*cosd(p.PolarPatternAngles);0.6+0.4*cosd(p.PolarPatternAngles);...
    0.7+0.3*cosd(p.PolarPatternAngles)]);%MATLAB always accept increasing values
pattern(p, f, [-180:180], 0, 'CoordinateSystem', 'polar', 'Type','powerdb', 'Normalize', true);
%construct the array
array = phased.ULA('NumElements',4, 'ElementSpacing', 0.5, 'Element', p);
figure();
pattern(array, f, [-180:180], 0, 'CoordinateSystem', 'polar', 'Type','powerdb', 'Normalize', true, ...
    'PropagationSpeed', 340.0);