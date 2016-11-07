%This script contains all external parameters for the precipitation model
%and explains their significance and is usually called by
%'precip_seasonal.m'.

%The units are given in brackets behind the parameter definition.

%All parameter estimates need to be treated with caution as their exact
%values might be very uncertain.

%base-level precipitation is the pricipitaion background level that always
%falls with our without seasonal cycle. This is  not important when looking
%at changes, but might be important when looking at amplitudes directly.
precip_base  = 10; %Units: [mm day^-1] 10

%Standard deviation of precipitation. This is an estimate of the width of
%the precipitation function over the seasonal cycle. A constant width is an
%approximation.
sig          = 5; %5 %Units: [deg]

%Shape of the precipitation distribution that is used to calculate annual
%mean precipitation fields. The input parameters are: x: latitude, m:
%location of the itcz, s: standard deviation.
shape = @(x,m,s) exp(-(x-m).^2/2/s^2); %Gaussian
%shape = @(x,m,s) exp(-abs(x-m)/s); %Exponential
%shape = @(x,m,s) 1./(1+(x-m).^2/s^2); %Cauchy-Lorentzian
%shape = @(x,m,s) exp(-(x-m).^2./2.*(1./s.^2+m.^2./10^2/(s/2)^2)); %Gaussian with variable variance

S0 = 400; %400

%This is the sensitivity of the precipitation amplitude to insolation at or
%around the maximum location. It is an estimate based on Merlis etal.
%(2013).
ins_sens     = 0.075; %Units: [m^2 mm W^-1 day^-1] 0.075

%This is the sensitivity of cross-equatorial atmospheric heat transport to
%the difference in area-weighted hemispheric average of insolation. It
%relates the differential solar input to the heat transported across the
%equator by the Hadley cells.
flx_sens     = 1.00*1/10; %1/10 %Units: No units.

%This is the sensitivity of the location of maximum precipitation to
%cross-equatorial atmospheric heat transport, e.g. Donohoe etal. (2013).
itcz_sens    = 3e-15; %Units: [deg W^-1] 3e-15

%This is the seasonal lag between the seasonal cycle of precipitation and
%the seasonal cycle of insolation. This is mostly accounting for seasonal
%heat storage in the surfac oceans.
seas_lag     = 60; %Units: [days] 60

%This is the cross-equatorial ocean heat transport today as estimated by
%e.g. Marshall etal. (2013).
ocean_ht     = 0.15e15; %0.15e15; %Units: [W]

%This is the timing of Heinrich events as estimate from e.g. Hemming
%(2004).
%hevents     = [12, 17, 24, 31, 38, 45, 60]; %Units: [kya]
%hevents     = 0*[12, 17, 24, 31, 38, 45, 60]; %Units: [kya]

%This variable 'eq_toggle' is used to switch between insolation at the
%equator and insolation at the ITCZ location for calculating the
%precipitation amplitude. If 'eq_toggle = 1', equatorial insolation is
%used.
eq_toggle   = 1;
        