%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%--------------------------------------------------------------------------
%
% A MATLAB code for convert the pressure data in .BIN format from  
% Scripps Institution of Oceanography EM instruments to .SAC format.  
%
% 
% Written by Guilherme de Melo
% Scripps Institution of Oceanography
%
%
% v 1.0 April 2022 first version using getsio (sconstable@ucsd.edu) and 
%                   MKSAC (https://github.com/IPGP/sac-lib/) codes
%
% GITHUB: https://github.com/gwsmelo/convertSIO_BIN2SAC
%
%--------------------------------------------------------------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all; clc;

%%%%filename with complete data of the instrument
filename ='s3mendo_goldfish_s03.bin';

%%%%open the file%%%%
[stFile, ~] = getsio('header',filename,'off');

%%%%find the start and end time%%%%%
starttime = datevec(stFile.datastart + 1); 

%t%%total time of file in seconds%%%%%
timelength=5360786;

%%%%get the data with total time length######
[stFile,errmsg] = getsio('times',stFile,starttime,'time',timelength);

%%%%select the pressure channel in instrument#####
pressurechannel=stFile.data(5,:);

%%%%create variable with the start time updated
pressurechannelStartTime=stFile.dStart(1,:)

%%%%convert the data in MATLAB variable to .SAC format using MKSAC
mksac('s3mendo_goldfish_s03_test.sac',pressurechannel,pressurechannelStartTime,'DELTA',(1/62.5),'KSTNM','s3mendo','KCMPNM','SHZ');

%%s3mendo_goldfish_s03_test.sac -> output file in SAC format
%%%DELTA = time increment 
%%%KSTNM = station name
%%%KCMPNM = channel
