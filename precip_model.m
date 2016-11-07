function [kya, days, lat, precip, insolation] = precip_model(kya)
%precip_model takes a time vector specified in kya 
%and calculates the seasonal cycle of precipitation at every point
%specified in 'kya' by calling 'precip_seasonal.m'.

display(['Calculating seasonal cycle of precipitation from ', num2str(min(kya), '%d'), 'kya BP to ',num2str(max(kya), '%d'), 'kya BP.']);
display('This takes a few minutes. So go and grab a coffee.')

for k=1:length(kya)
    [~, ~, precip_s_shape] = precip_seasonal_shape(kya(k)); %calc seasonal cycles
    [days, lat, precip_s_amp, sloc_s] = precip_seasonal_amp(kya(k)); %calc seasonal cycles

    precip(k,:,:) = precip_s_shape .* precip_s_amp; %store seasonal cycle of precip. for kya 'k'.
    insolation(k,:,:) = sloc_s; %store seasonal cycle of insol. for kya 'k'.
end