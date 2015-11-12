function [ data ] = apply_scaling( data )
%apply_scaling Summary of this function goes here
%   Detailed explanation goes here


for i=1:numel(data)
    data{i}.Area=data{i}.Area*0.5476^2;
    data{i}.MajorAxisLength=data{i}.MajorAxisLength*0.5476;
    data{i}.MinorAxisLength=data{i}.MinorAxisLength*0.5476;
    data{i}.EquivDiameter=data{i}.EquivDiameter*0.5476;
    data{i}.Perimeter=data{i}.Perimeter*0.5476;
end

