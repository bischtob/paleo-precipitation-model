%This script contains all external parameters for the precipitation model.
%The units are given in brackets behind the parameter definition.

%All parameter estimates need to be treated with caution as their exact
%values might be very uncertain.

%Base-level precipitation is the pricipitaion background level that always
%falls with our without seasonal cycle. This is  not important when looking
%at changes, but is important when looking at amplitudes directly.
precip_base  = 10; %Units: [mm day^-1]

%Standard deviation of precipitation. This is an estimate of the width of
%the precipitation function.
sig          = 5; %5 %Units: [deg]

%Shape of the precipitation distribution.
%The input parameters are: x: latitude, m:
%location of the itcz, s: standard deviation.
shape = @(x,m,s) exp(-(x-m).^2/2/s^2); 

%Zeroth-order coefficient in Taylor expansion of precipitation amplitude
%around location of itcz location
S0 = 400;

%This is the sensitivity of the precipitation amplitude to insolation at or
%around the maximum location. It is an estimate based on Merlis etal.
%(2013).
ins_sens     = 0.075; %Units: [m^2 mm W^-1 day^-1]

%This is the sensitivity of cross-equatorial atmospheric heat transport to
%the difference in area-weighted hemispheric average of insolation. It
%relates the differential solar input to the heat transported across the
%equator by the Hadley cells.
flx_sens     = 1.00/10; %Units: No units.

%This is the sensitivity of the location of maximum precipitation to
%cross-equatorial atmospheric heat transport, e.g. Donohoe etal. (2013).
itcz_sens    = 3e-15; %Units: [deg W^-1]

%This is the seasonal lag between the seasonal cycle of precipitation and
%the seasonal cycle of insolation.
seas_lag     = 60; %Units: [days]

%This is the cross-equatorial ocean heat transport today as estimated by
%e.g. Marshall etal. (2013).
%ocean_ht     = 0.15e15; %Units: [W]
ocean_ht = 0.0;

%This variable 'eq_toggle' is used to switch between insolation at the
%equator and insolation at the ITCZ location for calculating the
%precipitation amplitude. If 'eq_toggle = 1', equatorial insolation is
%used.
eq_toggle   = 0;
        