function [ data ] = apply_scaling( data )
%apply_scaling Summary of this function goes here
%   Detailed explanation goes here

%k=0.547619047619048; %scaling factor : 1px equivalent to k microns?
k=ask_scaling_factor();

for i=1:numel(data)
    data{i}.Area=data{i}.Area*k^2;
    data{i}.MajorAxisLength=data{i}.MajorAxisLength*k;
    data{i}.MinorAxisLength=data{i}.MinorAxisLength*k;
    data{i}.EquivDiameter=data{i}.EquivDiameter*k;
    data{i}.Perimeter=data{i}.Perimeter*k;
end
