function [par] = PARS(parstr, options);
% PARS  Parameters for plots and analyses.

  %%%%%%%%%%%%%           parse options         %%%%%%%%%%%%%%%%%%%%
  error(nargchk(1, 2, nargin))     
  if nargin ==1 | isempty(options)
    fopts      = [];
  else
    fopts      = fieldnames(options);
  end
  
  if strmatch('slide', fopts)
    slide = options.slide;
  else 
    slide = 0;
  end
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
        
  % plot parameters
  if (slide)
    % size of figures (in inches)
    figure_width      = 16;
    figure_height     = figure_width / 1.618;
    
    % line widths
    line_width        = 1.0;
    thin_line_width   = 0.5;
    axes_line_width   = 1.5;
    thick_line_width  = 2.0;

    % line color
    pos_line_color    = 'b';
    neg_line_color    = 'c';
    line_color        = 'b';
    
    % line styles
    line_style        = '-';
    thin_line_cstyle  = 'm-';
    thick_line_cstyle = 'r-';

    % tick length
    tick_length       = [0.01 0.01];
    
    % marker size
    marker_size       = 10;
    
    % font sizes
    font_size         = 10;
    clabel_size       = 10;
  else
    % size of figures (in inches)

    % Science (one column)
    %figure_width      = 2.3;
    %figure_height     = figure_width;
        
    % AMS journals
    figure_width      = 3.125;
    figure_height     = figure_width / 1.618;
    %figure_height     = figure_width;
    tick_length       = [0.0175 0.0175];
    
    % Other 
    %figure_width      = 3.1;
    %figure_height     = 1.5;
    
    % Small square 
    %figure_width      = 2.2;
    %figure_height     = figure_width;
    %tick_length       = [0.02 0.02];
    
    % supercriticality figure in SW06 (JAS)
    %figure_width      = 3;
    %figure_height     = figure_width;
    
    % line colors and styles	
    pos_line_color    = 'k';
    neg_line_color    = 'm';
    line_color        = 'k';
    line_style        = '-';
    thin_line_cstyle  = 'k:';
    thick_line_cstyle = 'k-';

    % Annual Reviews
    %figure_width       = 6.5;
    %figure_width      = 3.38;
    %figure_height     = figure_width/1.6;
    %pos_line_color    = 'm-';
    %neg_line_color    = 'm--';
    %line_color        = 'm';
    %thin_line_cstyle  = 'c';
    %thick_line_cstyle = 'r-';

    % line widths
    line_width        = 0.5;  % pt 
    thin_line_width   = 0.5; % PUP
    axes_line_width   = 1.0;
    thick_line_width  = 1.7;
    
    % marker size
    marker_size       = 4.5;
    
    % font sizes
    font_size         = 8;
    clabel_size       = 7;
  end
  
  % physical parameters
  radius 	          = 6.3710e6;     % in meters [for Earth]
  gravity 	          = 9.81;         % in m/s^2
  gas_constant	      = 287.04;       % gas constant dry air [J/kg/K] 
  kappa               = 2/7;
  cp                  = gas_constant/kappa; % specific heat at constant pressure 
  cp_v                = 1870;         % specific heat water vapor [J/kg/K]
  cl                  = 4190;         % heat capacity liquid water [J/kg/K]
  gas_constant_v      = 461.50;       % gas constant water vapor [J/kg/K]
  latent_heat_v       = 2.5e6;        % latent heat of evaporation [J/kg]
  omega               = 7.292e-5;     % angular velocity earth [rad/s]
  mean_sfc_press      = 1e5;          % mean surface pressure
  solar_constant      = 1360;
  tau                 = 0.22;
  albedo              = 0.38;
  del_sol             = 1.2;
  p_ref               = 1e5;
  stefan              = 5.67e-8; %in W/m^2/K^4
  

  gray                = [.5 .5 .5];   % RGB value for gray lines

  % for conversion of units
  secs_per_day        = 86400;        % length of Earth day [seconds]
  deg                 = pi/180;
  
  % for isentropic-coordinate plots
  sfc_cdf_isolines    = [.1 .5 .9];      % for plotting of median only
  pressure_surfaces  = [250 500 750 925]; %isobars to be plotted
  
  eval(['par = ', parstr, ';']);
  
  
