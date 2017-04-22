function [day, lat, precip_shape] = precip_seasonal_shape(kya, So)
%precip_seasonal_model takes a point in time (specified in kya)
%and calculates a time-latitude plot of the precipitation shape for the
%orbital configuration at the time specified in kya.

%Get toolboxes for this script. We are using the insolation toolbox by
%Ian Eisenman and Peter Huybers.
addpath ./insolation/;

%Get external parameters from 'parameters.m'
parameters;

if nargin<2
    So=1365;
end

day_type = 1;
if length(kya)==3
    day_type = -1;
end

%Define time and space vectors for seasonal cycle. Use 2d grid for fast 
%execution of 'daily_insolation.m' (no loops necessary).
day          = 1:5:365; %days of the year in pentats
lat          = -90:90; %latitude vector
[dayg, latg] = meshgrid(day, lat); %day-lat grids

%Calculate the difference of integrated insolation between the
%hemispheres and the location of the ITCZ for every day of the year.
snh          = insolation_lat_int(kya, latg, dayg-seas_lag, [0 90], day_type, So); %area-weighted average insolation in northern hemisphere
ssh          = insolation_lat_int(kya, latg, dayg-seas_lag, [-90 0], day_type, So);%area-weighted average insolation in southern hemisphere
ds           = flx_sens*(snh - ssh); %ocean_ht;
lat_itcz     = repmat(itcz_sens * ds, [length(lat) 1]);

%Calculate the precipitation amplitude and shape of precipitation at every
%point in space and time for this orbital configuration
precip_shape = shape(latg, lat_itcz, sig);