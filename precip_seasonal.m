function [day, lat, precip, sloc] = precip_seasonal(kya)
%precip_seasonal_model takes a point in time (specified in kya)
%and calculates a time-latitude plot of precipitation for the
%orbital configuration at the time specified in kya.

%Get toolboxes for this script. We are using the insolation toolbox by
%Ian Eisenman and Peter Huybers.
addpath ../insolation;

%Get external parameters from 'parameters.m'
parameters;

%Determine characteristic function for Heinrich events. This vector has entries of 1
%at times of Heinrich events and zeros otherwise. This can be used to
%switch the ocean circulation of during Heinrich events and is used further
%down in this script.
heinrich     = (kya == hevents(1)) + (kya == hevents(2)) + (kya == hevents(3)) ...
             + (kya == hevents(4)) + (kya == hevents(5)) + (kya == hevents(6)) ...
             + (kya == hevents(7));

%Define time and space vectors for seasonal cycle. Use 2d grid for fast 
%execution of 'daily_insolation.m' (no loops necessary).
day          = 1:5:365; %days of the year in pentats
lat          = -90:90; %latitude vector
[dayg, latg] = meshgrid(day, lat); %day-lat grids

%Calculate the difference of integrated insolation between the
%hemispheres and the location of the ITCZ for every day of the year.
snh          = insolation_lat_int(kya, latg, dayg-seas_lag, [0 90]); %area-weighted average insolation in northern hemisphere
ssh          = insolation_lat_int(kya, latg, dayg-seas_lag, [-90 0]);%area-weighted average insolation in southern hemisphere
ds           = flx_sens*(snh - ssh) + ocean_ht*(1-heinrich); %
lat_itcz     = repmat(itcz_sens * ds, [length(lat) 1]);

%Calculate the precipitation amplitude via insolation at the ITCZ location
%or via insolation at the equator. Execution is much slower if insolation
%at ITCZ location is used.
if eq_toggle
    sloc      = daily_insolation(kya, 0, dayg); %equatorial insolation.
else
    for k =1:length(day)
        sloc(:,k) = daily_insolation(kya, itcz_sens * ds(k), dayg(:,k)); %insolation at ITCZ location
    end
end

%Calculate the precipitation amplitude and shape of precipitation at every
%point in space and time for this orbital configuration
precip_amp   = ins_sens * sloc;
precip_gauss = exp(-(latg-lat_itcz).^2/2/sig^2);

%The total seasonal precipitation is the product of amplitude and shape
%plus base-level precipitation (not necessary when looking at changes).
precip       = precip_base + precip_amp .* precip_gauss;