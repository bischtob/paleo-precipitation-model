function [kya, days, lat, del_precip_amp_ann, del_precip_shape_ann, insol] = precip_change(kya)
%precip_model takes a time vector specified in kya 
%and calculates the seasonal cycle of precipitation at every point
%specified in 'kya' by calling 'precip_seasonal.m'.

display(['Calculating seasonal cycle of precipitation from ', num2str(min(kya), '%d'), 'kya BP to ',num2str(max(kya), '%d'), 'kya BP.']);
display('This takes a few minutes. So go and grab a coffee.')

%Calculate the reference precipitation shape and amplitude at kya = 0.
[days, ~, precip_s_shape_ref]  = precip_seasonal_shape(0); %calc seasonal cycles
[~, ~, precip_s_amp_ref]       = precip_seasonal_amp(0); %calc seasonal cycles

for k=1:length(kya)
    [~, ~, precip_s_shape] = precip_seasonal_shape(kya(k)); %calc seasonal cycles
    [days, lat, precip_s_amp] = precip_seasonal_amp(kya(k)); %calc seasonal cycles

    del_precip_amp(k,:,:)   = (precip_s_amp - precip_s_amp_ref).*precip_s_shape_ref; 
    del_precip_shape(k,:,:) = (precip_s_shape - precip_s_shape_ref).*precip_s_amp_ref; %store seasonal cycle of precip. for kya 'k'.
end

%Calculate the annual mean change in precipitation shape and amplitude
del_precip_shape_ann        = squeeze(sum(del_precip_shape,3)/length(days));
del_precip_amp_ann          = squeeze(sum(del_precip_amp,3)/length(days));