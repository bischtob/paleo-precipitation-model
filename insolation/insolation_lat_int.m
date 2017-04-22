function [ S ] = insolation_lat_int(kya, lat, day, range, time_type, So)
%Computes the meridionally 
%averaged insolation over the range of latitudes 'range' for solar longitude 
%L_s (or day of year if time_type=1) for times t (kyr before present).
%
%See daily_insolation.m for details on how the insolation is calculated.

%Use days of the year as time type in 'daily_insolation.m' if nothing else
%is specified.
if nargin < 5
    time_type = 1;
end
if nargin < 6
    So = 1365;
end

%Parameters for the planet
R           = PARS('radius');
alb         = PARS('albedo');
tau         = PARS('tau');
deg         = pi/180;

%Get insolation from Eisenman & Hyubers script.
Slat        = (1-alb*exp(-tau))*daily_insolation(kya, lat, day, time_type, So);
Slat_cos    = Slat.*cos(lat*deg);

%Calculate the area-weighted average insolation over the latitude range
%specified in 'range'.
lat_rg      = squeeze(lat(:,1));
mask        = repmat((lat_rg >= min(range)).*(lat_rg <= max(range)), [1 size(day,2)]);
S           = 2*pi*R^2*trapz(deg*lat(:,1), Slat_cos.*mask);

end

