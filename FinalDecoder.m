%This is version 20, edited today on May 9th, 2014. It is the final version with all comments and everything! :D It was mainly programmed by my father in the decoding parts... but I programmed the printing messages part andthe part where you pull out the data.

%Clears all the variables and closes them
%Clears the screen
clear all; close all; clc
set(0,'defaultfigureWindowStyle','docked'); %This line makes it so that when you run the program, the default window style is 'docked'.

%START!!! :D

ParseNmeaFile=0; %set to 0 to load already-parsed file, set to 1 when creating a new MAT file.

PosAvgPdopLimit=1.5; %Fixes for computing the average are only considered when PDOP is below this value - Otherwise the it is too high.

if ParseNmeaFile
  Truncate=0;
  DecodeLines=-20000; %set negative to read the whole file, because the program will never reach a negative-numbered line!

  %NmeaFileName='C:\MelData\ALL_SCIENCE_FAIR_DATA\ScienceFairProject2013_2014\MATLAB_Code\SD_Data\LOG00007.TXT'; %(WAAS) Mom and Dad's Room Window - First time I enabled WAAS satellites and other message types.| Coordinates: 39.287704 -82.063244 291.303175
  %NmeaFileName='C:\MelData\ALL_SCIENCE_FAIR_DATA\ScienceFairProject2013_2014\MATLAB_Code\SD_Data\LOG00012.TXT'; %(WAAS) This data collection was logged infront of our porch. (Big Antenna) | Coordinates: 39.287683 -82.063429 292.144499
  %NmeaFileName='C:\MelData\ALL_SCIENCE_FAIR_DATA\ScienceFairProject2013_2014\MATLAB_Code\SD_Data\LOG00016.TXT'; %(WAAS) Back garden, open sky | Coordinates: 39.287713 -82.062908 289.380964
  %NmeaFileName='C:\MelData\ALL_SCIENCE_FAIR_DATA\ScienceFairProject2013_2014\MATLAB_Code\SD_Data\LOG00021.TXT'; %(WAAS) Stroud's Run State Park Woods (Drozek's Backyard)| Coordinates: 39.366620 -82.040040 303.493506
  %NmeaFileName='C:\MelData\ALL_SCIENCE_FAIR_DATA\ScienceFairProject2013_2014\MATLAB_Code\SD_Data\LOG00022.TXT'; %(WAAS) Closet with WAAS | Coordinates: 39.287642 -82.063294 296.806349
  %NmeaFileName='C:\MelData\ALL_SCIENCE_FAIR_DATA\ScienceFairProject2013_2014\MATLAB_Code\SD_Data\LOG00031.TXT'; %(WAAS) Laundry Room Closet | Coordinates: 39.287630 -82.063240 295.468388
  %NmeaFileName='C:\MelData\ALL_SCIENCE_FAIR_DATA\ScienceFairProject2013_2014\MATLAB_Code\SD_Data\LOG00039.TXT'; %(WAAS) In motion data collection - trip 2 Columbus | Coordinates: 40.097432 -83.002426 255.732726
  %NmeaFileName='C:\MelData\ALL_SCIENCE_FAIR_DATA\ScienceFairProject2013_2014\MATLAB_Code\SD_Data\LOG00131.TXT'; %(WAAS) Garage | Coordinates: 39.287710 -82.063213 295.577346 39.293317 -82.071417 295.183930
  %NmeaFileName='C:\MelData\ALL_SCIENCE_FAIR_DATA\ScienceFairProject2013_2014\MATLAB_Code\SD_Data\LOG00173.TXT'; %(WAAS) My Room | Coordinates: 39.287726 -82.063294 298.451589
  %NmeaFileName='C:\MelData\ALL_SCIENCE_FAIR_DATA\ScienceFairProject2013_2014\MATLAB_Code\SD_Data\LOG00186.TXT'; %(WAAS) TestOpenSky checking to see if the cable is damaged (2/12/14). If it is not damaged I'll use the file to compare against open sky without WAAS. | Coordinates: 39.287756 -82.062971 290.447708
  %NmeaFileName='C:\MelData\ALL_SCIENCE_FAIR_DATA\ScienceFairProject2013_2014\MATLAB_Code\SD_Data\LOG00218.TXT'; %(NoWAAS) TestedOpenSky again since the cable was not damaged, this time disabling WAAS satellites. | Coordinates: 39.287734 -82.062932 290.799012
  %NmeaFileName='C:\MelData\ALL_SCIENCE_FAIR_DATA\ScienceFairProject2013_2014\MATLAB_Code\SD_Data\LOG00295.TXT'; %(WAAS) Sol Restraunt Alleyway | Coordinates: 39.330305 -82.101474 231.949153
  %NmeaFileName='C:\MelData\ALL_SCIENCE_FAIR_DATA\ScienceFairProject2013_2014\MATLAB_Code\SD_Data\LOG00320.TXT'; %(WAAS) Dad's Office Window, Stocker Center | Coordinates: Coordinates: 39.325551 -82.106896 240.632740
  %NmeaFileName='C:\MelData\ALL_SCIENCE_FAIR_DATA\ScienceFairProject2013_2014\MATLAB_Code\SD_Data\LOG00321.TXT'; %(WAAS) Dad's Office, Stocker Center | Coordinates: 39.325627 -82.106852 231.118888
  %NmeaFileName='C:\MelData\ALL_SCIENCE_FAIR_DATA\ScienceFairProject2013_2014\MATLAB_Code\SD_Data\LOG00344.TXT'; %(WAAS) Redo Garage | Coordinates:
  
  [nmeaPath nmeaName nmeaExt]=fileparts(NmeaFileName);
  ProcessedFilename=[nmeaPath '\' nmeaName '.mat'];
else
  TruncateAfterLoad=1; %if truncate is enabled. The data is truncated to DatSelRange.

  %(WAAS) Mom and Dad's Room Window - First time I enabled WAAS satellites and other message types.| Coordinates: 39.287704 -82.063244 291.303175
  %ProcessedFilename='C:\MelData\ALL_SCIENCE_FAIR_DATA\ScienceFairProject2013_2014\MATLAB_Code\SD_Data\LOG00007.mat';
  %DatSelRange=100:30000; %Customized Data Range for this file.
  %NameOfFile='LOG00007';

  %(WAAS) This data collection was logged infront of our porch. (Big Antenna) | Coordinates: 39.287683 -82.063429 292.144499
  %ProcessedFilename='C:\MelData\ALL_SCIENCE_FAIR_DATA\ScienceFairProject2013_2014\MATLAB_Code\SD_Data\LOG00012.mat';
  %DatSelRange=600:21519; %Customized Data Range for this file.
  %NameOfFile='LOG00012';

  %(WAAS) Back garden, open sky | Coordinates: 39.287713 -82.062908 289.380964
  %ProcessedFilename='C:\MelData\ALL_SCIENCE_FAIR_DATA\ScienceFairProject2013_2014\MATLAB_Code\SD_Data\LOG00016.mat';
  %DatSelRange=1200:59000; %Customized Data Range for this file.
  %NameOfFile='LOG00016';

  %(WAAS) Stroud's Run State Park Woods (Drozek's Backyard)| Coordinates: 39.366620 -82.040040 303.493506
  %ProcessedFilename='C:\MelData\ALL_SCIENCE_FAIR_DATA\ScienceFairProject2013_2014\MATLAB_Code\SD_Data\LOG00021.mat';
  %DatSelRange=1200:78000; %Customized Data Range for this file.
  %NameOfFile='LOG00021';

  %(WAAS) Closet with WAAS | Coordinates: 39.287642 -82.063294 296.806349
  %ProcessedFilename='C:\MelData\ALL_SCIENCE_FAIR_DATA\ScienceFairProject2013_2014\MATLAB_Code\SD_Data\LOG00022.mat';
  %DatSelRange=600:59000; %Customized Data Range for this file.
  %NameOfFile='LOG00022';

  %(WAAS) Laundry Room Closet | Coordinates: 39.287630 -82.063240 295.468388
  %ProcessedFilename='C:\MelData\ALL_SCIENCE_FAIR_DATA\ScienceFairProject2013_2014\MATLAB_Code\SD_Data\LOG00031.mat';
  %DatSelRange=300:80000; %Customized Data Range for this file.
  %NameOfFile='LOG00031';

  %(WAAS) In motion data collection - trip 2 Columbus | Coordinates: 40.097432 -83.002426 255.732726
  %ProcessedFilename='C:\MelData\ALL_SCIENCE_FAIR_DATA\ScienceFairProject2013_2014\MATLAB_Code\SD_Data\LOG00039.mat';
  %This file does not a have a 'DatSelRange' because I cannot really have one - this was collected in motion. Also set Truncate to 0.
  %NameOfFile='LOG00039';

  %(WAAS) Garage | Coordinates: 39.287710 -82.063213 295.577346
  %ProcessedFilename='C:\MelData\ALL_SCIENCE_FAIR_DATA\ScienceFairProject2013_2014\MATLAB_Code\SD_Data\LOG00131.mat';
  %DatSelRange=4000:44800; %Customized Data Range for this file.
  %NameOfFile='LOG00131';

  %(WAAS) My Room | Coordinates: 39.287726 -82.063294 298.451589
  %ProcessedFilename='C:\MelData\ALL_SCIENCE_FAIR_DATA\ScienceFairProject2013_2014\MATLAB_Code\SD_Data\LOG00173.mat';
  %DatSelRange=1200:440908; %Customized Data Range for this file.
  %NameOfFile='LOG00173';

  %(With WAAS) TestOpenSky checking to see if the cable is damaged (2/12/14). If it is not damaged I'll use the file to compare against open sky without WAAS. | Coordinates: 39.287756 -82.062971 290.447708
  %ProcessedFilename='C:\MelData\ALL_SCIENCE_FAIR_DATA\ScienceFairProject2013_2014\MATLAB_Code\SD_Data\LOG00186.mat';
  %DatSelRange=120:74840; %Customized Data Range for this file.
  %NameOfFile='LOG00186';

  %(Without WAAS) TestedOpenSky again since the cable was not damaged, this time disabling WAAS satellites. | Coordinates: 39.287734 -82.062932 290.799012
  %ProcessedFilename='C:\MelData\ALL_SCIENCE_FAIR_DATA\ScienceFairProject2013_2014\MATLAB_Code\SD_Data\LOG00218.mat';
  %DatSelRange=600:81490; %Customized Data Range for this file.
  %NameOfFile='LOG00218';

  %(WAAS) Sol Restraunt Urban Canyon | Coordinates: 39.330305 -82.101474 231.949153
  %ProcessedFilename='C:\MelData\ALL_SCIENCE_FAIR_DATA\ScienceFairProject2013_2014\MATLAB_Code\SD_Data\LOG00295.mat';
  %DatSelRange=1200:73900; %Customized Data Range for this file.
  %NameOfFile='LOG00295';
  
  %(WAAS) Stocker Center Dad's Office Window | Coordinates: 39.325551 -82.106896 240.632740
  %ProcessedFilename='C:\MelData\ALL_SCIENCE_FAIR_DATA\ScienceFairProject2013_2014\MATLAB_Code\SD_Data\LOG00320.mat';
  %DatSelRange=300:73000; %Customized Data Range for this file.
  %NameOfFile='LOG00320';

  %(WAAS) Stocker Center Dad's Office | Coordinates: 39.325627 -82.106852 231.118888
  %ProcessedFilename='C:\MelData\ALL_SCIENCE_FAIR_DATA\ScienceFairProject2013_2014\MATLAB_Code\SD_Data\LOG00321.mat';
  %DatSelRange=300:47000; %Customized Data Range for this file.
  %NameOfFile='LOG00321';
  
  %WAAS) Test | Coordinates: -
  %ProcessedFilename='C:\MelData\ALL_SCIENCE_FAIR_DATA\ScienceFairProject2013_2014\MATLAB_Code\SD_Data\LOG00339.mat';
  %DatSelRange=300:47000; %Customized Data Range for this file.
  %NameOfFile='LOG00339';
  
  %WAAS) RedoGarage | Coordinates: 
  ProcessedFilename='C:\MelData\ALL_SCIENCE_FAIR_DATA\ScienceFairProject2013_2014\MATLAB_Code\SD_Data\LOG00344.mat';
  DatSelRange=300:80000; %Customized Data Range for this file.
  NameOfFile='LOG00344';
  
end
  
%START


%% Decode the NMEA file
if ParseNmeaFile

  handle=fopen(NmeaFileName); %Open file

  %Error Message:
  if handle<0
    error('could not open the file: %s',NmeaFileName);
  end

  %VARIABLES

  LineNumber=0; %This creates a variable which will act as a counter to count the number of lines in the file, and then tell when to stop it.
  number_GPGGA=0; %This creates a variable which will act as a counter to count the number of GPGGA messages in the file.
  number_GPVTG=0; %This creates a variable which will act as a counter to count the number of GPVTG messages in the file.
  number_GPGLL=0; %This creates a variable which will act as a counter to count the number of GPGLL messages in the file.
  number_GPGSA=0; %This creates a variable which will act as a counter to count the number of GPGSA messages in the file.
  number_GPGST=0; %This creates a variable which will act as a counter to count the number of GPGST messages in the file.
  number_GPGSV=0; %This creates a variable which will act as a counter to count the number of GPGSV messages in the file.
  number_GPRMC=0; %This creates a variable which will act as a counter to count the number of GPRMC messages in the file.
  number_GPZDA=0; %This creates a variable which will act as a counter to count the number of GPZDA messages in the file.

  counter=1; % "counter" counts $GPGGA messages

  SVDat.SV01.Cnr (nan)
  
  k=0;
  GgaGood=false;
  TimeHrs=0;
  TimeHrs_d1=0;
  TimeBiasHrs=0; % time bias in hours (used to keep time growing beyond 24 hour day)

  GllTimeHrs=0;
  GllTimeHrs_d1=0;
  GllTimeBiasHrs=0; % time bias in hours (used to keep time growing beyond 24 hour day)

  skipdecode=false;
  while 1

    line=fgetl(handle); %Read a line from the file

    if ~ischar(line) %Is the file valid? Yes, continue, no break.
      break;
    end;
    LineNumber=LineNumber+1; %This is the line where the variable I created earlier acts as a counter, and makes the variable value

    if LineNumber==DecodeLines; %This line says to stop when the number of lines read = 10.
      break;
    end;

    if NMEAChecksumPass(line) % don't decode unless checksum pass

      MsgType=textscan(line,'%s',1,'delimiter',','); % get the first delimited word %Decode Message Type

      %     if strcmpi(MsgType{1},'$GPZDA') %If a GPZDA message is found, then display the following different message.
      %
      %       DatT=textscan(line,'%s',4,'delimiter',','); %This line here makes a variable that perfroms a textscan to fish ou the first 10 comma-seperated parameters of a GPGGA message.
      %       Dat=DatT{1}; %This line here makes a variable that we can refer to so that we can individually pull out different parameters i.e. parameter 2 would be {2}.
      %
      %       if isempty(Dat{2})
      %         KeepDecoding=false;
      %       else
      %         number_GPZDA=number_GPZDA+1; %This is the line where the variable for GPZDA messages I created earlier acts as a counter, and makes the variable value
      %         KeepDecoding=true;
      %         ValidIndex=ValidIndex+1;
      %       end
      %
      %       %disp('I found a GPZDA message! :)');
      %
      %       %greater each time a new line is read.
      %
      %     end

      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
      %GPGGA = GPS Fix Data, DEFAUL OUTLET
      if strcmpi(MsgType{1},'$GPGGA') %If a GPGGA message is found, then display the following message.

        %$GPGGA,192428.00,3917.26034,N,08203.80563,W,1,07,1.19,00299,M,-033,M,,*55

        D=textscan(line,'%s',14,'delimiter',',');
        D=D{1};

        GgaGood=~isempty(D{2}) && ... % indicates that receiver has decoded UTC time
          ~isempty(D{3}) && ...
          ~isempty(D{4}) && ...
          ~isempty(D{5}) && ...
          ~isempty(D{6}) && ...
          ~isempty(D{7}) && ...
          ~isempty(D{8});

        if GgaGood
          k=k+1;

          % decode time in hours
          TimeHrs_d1=TimeHrs; % previous time epoch
          TimeHrs=str2double(D{2}(1:2));

          if TimeHrs_d1>TimeHrs % next-day offset
            TimeBiasHrs=TimeBiasHrs+24;
          end

          Dat.Time(k)=TimeBiasHrs+TimeHrs+(str2double(D{2}(3:4))/60)+(str2double(D{2}(5:length(D{2})))/3600);

          % decode latitude ddmm.mmmmm
          if strcmpi(D{4},'N')
            Dat.Lat(k)=str2double(D{3}(1:2))+((str2double(D{3}(3:length(D{3}))))/60); %        %This section over here decodes latitude (up and down)
          elseif strcmpi(D{4},'S')                                                                       %and north and south. Dat(4) decodes whether the position
            %is north or south, and Dat(3) is the exact latitude. Again,
            Dat.Lat(k)=-(str2double(D{3}(1:2))+((str2double(D{3}(3:length(D{3}))))/60)); %     %I use the MATLAB str2double function to take the raw data
          else                                                                                             %and store it as a decimal value in a cell.
            error('Latitude must be N or S. FileLine %d',LineNumber);
          end

          % decode Longitude. dddmm.mmmmm                                                                  %This section does the same thing as the one above, but
          if strcmpi(D{6},'E')                                                                           %instead it is for longitude, and east and west. Dat{5} is
            Dat.Lon(k)=  str2double(D{5}(1:3))+((str2double(D{5}(4:length(D{5}))))/60);  %    %for whether the position is east or west.
          elseif strcmpi(D{6},'W')                                                                       %the field for the exact longitude, and Dat{6} is the field
            Dat.Lon(k)=-(str2double(D{5}(1:3))+((str2double(D{5}(4:length(D{5}))))/60));  %    %for whether the position is east or west.
          else
            error('Latitude must be W or E. FileLine %d',LineNumber);
          end

          % decode quality indicator
          Dat.Qual(k)=str2double(D{7});

          % decode NumSat
          Dat.NumSat(k)=str2double(D{8});

          % decode HDOP
          Dat.Hdop(k)=str2double(D{9});

          % Antenna altitude in in meters
          Dat.AntHeightMeters(k)=str2double(D{10});
          if D{11}~='M'
            error('expected M')
          end

          % Geoidal separation in meters
          Dat.GeoidSepMeters(k)=str2double(D{12});
          if D{13}~='M'
            error('expected M')
          end

          % 13: Age of Differential GPS Data. Time in seconds since the last Type 1
          % or 9 Update

          % 14: Differential Reference Station ID (0000 to 1023)

          % initialize other variables that will be filled in subsequent
          % message types below
          % index 33: NMEA46, PRN133
          % index 34: NMEA48, PRN135
          % index 35: NMEA51, PRN138
          Dat.PRN_Az(:,k)=nan*ones(35,1);
          Dat.PRN_El(:,k)=nan*ones(35,1);
          Dat.PRN_Cnr(:,k)=nan*ones(35,1);

        end %endif GgaGood



        %disp('I found a GPGGA message! :)');
        number_GPGGA=number_GPGGA+1; %This is the line where the variable for GPGGA messages I created earlier acts as a counter, and makes the variable value

        counter=counter+1; % go to next index

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %GPGLL = Geographic Position - Lat + Lon
      elseif  strcmpi(MsgType{1},'$GPGLL') %If a GPGLL message is found, then display the following different message.
        %$GPGLL,3917.26334,N,08203.79345,W,024606.00,A,D*71

        D=textscan(line,'%s',8,'delimiter',',');
        D=D{1};

        GllGood=~isempty(D{2}) && ... % indicates that receiver has decoded UTC time
          ~isempty(D{3}) && ...
          ~isempty(D{4}) && ...
          ~isempty(D{5}) && ...
          ~isempty(D{6}) && ...
          ~isempty(D{7}) && ...
          ~isempty(D{8});
        if GgaGood && GllGood

          % decode latitude ddmm.mmmmm
          if strcmpi(D{3},'N')
            GllLat=str2double(D{2}(1:2))+((str2double(D{2}(3:length(D{2}))))/60); %        %This section over here decodes latitude (up and down)
          elseif strcmpi(D{3},'S')                                                                       %and north and south. Dat(4) decodes whether the position
            %is north or south, and Dat(3) is the exact latitude. Again,
            GllLat=-(str2double(D{2}(1:2))+((str2double(D{2}(3:length(D{2}))))/60)); %     %I use the MATLAB str2double function to take the raw data
          else                                                                                             %and store it as a decimal value in a cell.
            error('GLL Latitude must be N or S. FileLine %d',LineNumber);
          end

          if GllLat~=Dat.Lat(k)
            %1/6/14: made the following error into a warning because it is
            %posible to have missing GPGGAs. When this happens, the time
            %stamps are not the same.
            warning('GllLat not same as GgaLat. FileLine %d',LineNumber); %#ok<WNTAG>
            skipdecode=true;
            k=k-1; % force the current bin to be overwritten next time
          end

          %Dat.GllLat(k)=GllLat;

          if ~skipdecode
            % decode Longitude. dddmm.mmmmm                                                                  %This section does the same thing as the one above, but
            if strcmpi(D{5},'E')                                                                           %instead it is for longitude, and east and west. Dat{5} is
              GllLon=  str2double(D{4}(1:3))+((str2double(D{4}(4:length(D{4}))))/60);  %    %for whether the position is east or west.
            elseif strcmpi(D{5},'W')                                                                       %the field for the exact longitude, and Dat{6} is the field
              GllLon=-(str2double(D{4}(1:3))+((str2double(D{4}(4:length(D{4}))))/60));  %    %for whether the position is east or west.
            else
              error('GLL Latitude must be W or E. FileLine %d',LineNumber);
            end

            %if GllLon~=Dat.Lon(k)
            %  error('GllLon not same as GgaLat')
            %end

            if GllLon~=Dat.Lon(k)
              %1/6/14: made the following error into a warning because it is
              %posible to have missing GPGGAs. When this happens, the time
              %stamps are not the same.
              warning('GllLon not same as GgaLon. FileLine %d',LineNumber); %#ok<WNTAG>
              skipdecode=true;
              k=k-1; % force the current bin to be overwritten next time
            end

            %Dat.GllLon(k)=GllLon;

            if ~skipdecode

              % decode time in hours
              GllTimeHrs_d1=GllTimeHrs; % previous time epoch
              GllTimeHrs=str2double(D{6}(1:2));

              if GllTimeHrs_d1>GllTimeHrs % next-day offset
                GllTimeBiasHrs=GllTimeBiasHrs+24;
              end

              GllTime=GllTimeBiasHrs+GllTimeHrs+(str2double(D{6}(3:4))/60)+(str2double(D{6}(5:length(D{6})))/3600);

              if GllTime~=Dat.Time(k)
                %error('GLL Time is not the same as GGA Time!');
                warning('GLL Time is not the same as GGA Time. FileLine %d',LineNumber); %#ok<WNTAG>
              end

              Dat.GllStatus(k)=D{7};
              Mode=D{8};
              Dat.GllMode(k)=Mode(1);
            end % if ~skipdecode
          end % if ~skipdecode
        end


        %disp('I found a GPGLL message! :)');
        number_GPGLL=number_GPGLL+1; %This is the line where the variable for GPGLL messages I created earlier acts as a counter, and makes the variable value
        %greater each time a new line is read.

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %GPVTG = Track made good and ground speed, DEFAULT OUTLET
      elseif  ~skipdecode && strcmpi(MsgType{1},'$GPVTG') %If a GPVTG message is found, then display the following different message.

        %disp('I found a GPVTG message! :)');
        number_GPVTG=number_GPVTG+1; %This is the line where the variable for GPVTG messages I created earlier acts as a counter, and makes the variable value
        %greater each time a new line is read.

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % GPGSA = GPS DOP and active satellites
      elseif  ~skipdecode && strcmpi(MsgType{1},'$GPGSA') %If a GPGSA message is found, then display the following different message.
        %$GPGSA,A,3,22,25,01,14,32,18,31,11,,,,,2.00,1.27,1.54*0D

        D=textscan(line,'%s',18,'delimiter',',');
        D=D{1};

        GsaGood=~isempty(D{2}) && ... % indicates that receiver has decoded UTC time
          ~isempty(D{3}) && ...
          ~isempty(D{16}) && ...
          ~isempty(D{17}) && ...
          ~isempty(D{18});
        if GgaGood && GsaGood
          Dat.GsaMode(k)=D{2};

          Dat.GsaCurrMode(k)=D{3};
          % array of used SVs
          Dat.GsaUsedSvs(k,:)=zeros(1,12);
          for kk=1:12
            if ~isempty(D{kk+3})
              GsaPrn=str2double(D{kk+3});
              if GsaPrn>32 % correction for SBAS PRNs
                Dat.GsaUsedSvs(k,kk)=GsaPrn+87;
              else
                Dat.GsaUsedSvs(k,kk)=GsaPrn;
              end
            end
          end

          Dat.GsaPdop(k)=str2double(D{16});
          Dat.GsaHdop(k)=str2double(D{17});
          Dat.GsaVdop(k)=str2double(strtok(D{18},'*'));

          if Dat.GsaHdop(k) ~= Dat.Hdop(k)
            warning('Line %d, HDOP mismatch in GGA/GSA: %f %f',LineNumber, Dat.GsaHdop(k),Dat.Hdop(k)); %#ok<WNTAG>
          end

        end




        %disp('I found a GPGSA message! :)');
        number_GPGSA=number_GPGSA+1; %This is the line where the variable for GPGSA messages I created earlier acts as a counter, and makes the variable value
        %greater each time a new line is read.

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %GPGSV = GPS satellites in view
      elseif  ~skipdecode && strcmpi(MsgType{1},'$GPGSV') %If a GPGSV message is found, then display the following different message.

        %Dat=textscan(line,'%s',10,'delimiter',','); %This line here makes a variable that perfroms a textscan to fish ou the first 10 comma-seperated parameters of a GPGGA message.
        %Dat=DatT{1};

        if GgaGood
          D=textscan(line,'%s',20,'delimiter',',');
          D=D{1};

          if ~isempty(D{5}) && ~isempty(D{6}) && ~isempty(D{7}) && ~isempty(D{8})
            NMEA=str2double(D{5});
            if NMEA>=1 && NMEA<=32
              Dat.PRN_El(NMEA,k)=str2double(D{6});
              Dat.PRN_Az(NMEA,k)=str2double(D{7});
              Dat.PRN_Cnr(NMEA,k)=str2double(D{8});
            elseif NMEA==46
              Dat.PRN_El(33,k)=str2double(D{6});
              Dat.PRN_Az(33,k)=str2double(D{7});
              Dat.PRN_Cnr(33,k)=str2double(D{8});
            elseif NMEA==48
              Dat.PRN_El(34,k)=str2double(D{6});
              Dat.PRN_Az(34,k)=str2double(D{7});
              Dat.PRN_Cnr(34,k)=str2double(D{8});
            elseif NMEA==51
              Dat.PRN_El(35,k)=str2double(D{6});
              Dat.PRN_Az(35,k)=str2double(D{7});
              Dat.PRN_Cnr(35,k)=str2double(D{8});
            else
              El=str2double(D{6});
              Az=str2double(D{7});
              Cnr=str2double(D{8});
              fprintf('Line:%d Decoded NMEA%d El:%f Az:%f Cnr:%f\n',LineNumber,NMEA,El,Az,Cnr);
            end
          end

          if ~isempty(D{9}) && ~isempty(D{10}) && ~isempty(D{11}) && ~isempty(D{12})
            NMEA=str2double(D{9});
            if NMEA>=1 && NMEA<=32
              Dat.PRN_El(NMEA,k)=str2double(D{10});
              Dat.PRN_Az(NMEA,k)=str2double(D{11});
              Dat.PRN_Cnr(NMEA,k)=str2double(D{12});
            elseif NMEA==46
              Dat.PRN_El(33,k)=str2double(D{10});
              Dat.PRN_Az(33,k)=str2double(D{11});
              Dat.PRN_Cnr(33,k)=str2double(D{12});
            elseif NMEA==48
              Dat.PRN_El(34,k)=str2double(D{10});
              Dat.PRN_Az(34,k)=str2double(D{11});
              Dat.PRN_Cnr(34,k)=str2double(D{12});
            elseif NMEA==51
              Dat.PRN_El(35,k)=str2double(D{10});
              Dat.PRN_Az(35,k)=str2double(D{11});
              Dat.PRN_Cnr(35,k)=str2double(D{12});
            else
              El=str2double(D{10});
              Az=str2double(D{11});
              Cnr=str2double(D{12});
              fprintf('Line:%d Decoded NMEA%d El:%f Az:%f Cnr:%f\n',LineNumber,NMEA,El,Az,Cnr);
            end
          end

          if ~isempty(D{13}) && ~isempty(D{14}) && ~isempty(D{15}) && ~isempty(D{16})
            NMEA=str2double(D{13});
            if NMEA>=1 && NMEA<=32
              Dat.PRN_El(NMEA,k)=str2double(D{14});
              Dat.PRN_Az(NMEA,k)=str2double(D{15});
              Dat.PRN_Cnr(NMEA,k)=str2double(D{16});
            elseif NMEA==46
              Dat.PRN_El(33,k)=str2double(D{14});
              Dat.PRN_Az(33,k)=str2double(D{15});
              Dat.PRN_Cnr(33,k)=str2double(D{16});
            elseif NMEA==48
              Dat.PRN_El(34,k)=str2double(D{14});
              Dat.PRN_Az(34,k)=str2double(D{15});
              Dat.PRN_Cnr(34,k)=str2double(D{16});
            elseif NMEA==51
              Dat.PRN_El(35,k)=str2double(D{14});
              Dat.PRN_Az(35,k)=str2double(D{15});
              Dat.PRN_Cnr(35,k)=str2double(D{16});
            else
              El=str2double(D{14});
              Az=str2double(D{15});
              Cnr=str2double(D{16});
              fprintf('Line:%d Decoded NMEA%d El:%f Az:%f Cnr:%f\n',LineNumber,NMEA,El,Az,Cnr);
            end
          end

          if ~isempty(D{17}) && ~isempty(D{18}) && ~isempty(D{19}) && ~isempty(D{20})
            NMEA=str2double(D{17});
            if NMEA>=1 && NMEA<=32
              Dat.PRN_El(NMEA,k)=str2double(D{18});
              Dat.PRN_Az(NMEA,k)=str2double(D{19});
              Dat.PRN_Cnr(NMEA,k)=str2double(D{20});
            elseif NMEA==46
              Dat.PRN_El(33,k)=str2double(D{18});
              Dat.PRN_Az(33,k)=str2double(D{19});
              Dat.PRN_Cnr(33,k)=str2double(D{20});
            elseif NMEA==48
              Dat.PRN_El(34,k)=str2double(D{18});
              Dat.PRN_Az(34,k)=str2double(D{19});
              Dat.PRN_Cnr(34,k)=str2double(D{20});
            elseif NMEA==51
              Dat.PRN_El(35,k)=str2double(D{18});
              Dat.PRN_Az(35,k)=str2double(D{19});
              Dat.PRN_Cnr(35,k)=str2double(D{20});
            else
              El=str2double(D{18});
              Az=str2double(D{19});
              Cnr=str2double(D{20});
              fprintf('Line:%d Decoded NMEA%d El:%f Az:%f Cnr:%f\n',LineNumber,NMEA,El,Az,Cnr);
            end
          end
        end



        %disp('I found a GPGSV message! :)');
        number_GPGSV=number_GPGSV+1; %This is the line where the variable for GPGSV messages I created earlier acts as a counter, and makes the variable value
        %greater each time a new line is read.

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %GPGST = GPS accuracy information
      elseif  ~skipdecode && strcmpi(MsgType{1},'$GPGST') %If a GPGST message is found, then display the following different message.

        %disp('I found a GPGST message! :)');
        number_GPGST=number_GPGST+1; %This is the line where the variable for GPGST messages I created earlier acts as a counter, and makes the variable value
        %greater each time a new line is read.
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %GPRMC = Recommended min. specific GPS/Transit Data
      elseif  ~skipdecode && strcmpi(MsgType{1},'$GPRMC') %If a GPRMC message is found, then display the following different message.

        %disp('I found a GPRMC message! :)');
        number_GPRMC=number_GPRMC+1; %This is the line where the variable for GPRMC messages I created earlier acts as a counter, and makes the variable value
        %greater each time a new line is read.

        %GPZDA = Time and Date


      end
      skipdecode=false;

    else
      fprintf('checksum error in line number %lu\n',LineNumber);
    end



    %greater each time a new line is read.

  end

  fclose(handle); %This line closes the file

  fprintf('The total number of lines is: %d\n',LineNumber-1); %This line displays the number of lines in the end, obiviously 10, because the I only let the file read 10 lines!!!
  fprintf('number_GPGGA: %d\n',number_GPGGA);
  fprintf('number_GPVTG: %d\n',number_GPVTG);
  fprintf('number_GPGLL: %d\n',number_GPGLL);
  fprintf('number_GPGSA: %d\n',number_GPGSA);
  fprintf('number_GPGST: %d\n',number_GPGST);
  fprintf('number_GPGSV: %d\n',number_GPGSV);
  fprintf('number_GPRMC: %d\n',number_GPRMC);
  fprintf('number_GPZDA: %d\n',number_GPZDA);
  %
  % disp(number_GPGGA); %This line displays the number of GPGGA messages read.
  % disp(); %This line displays the number of GPVTG messages read.
  % disp(); %This line displays the number of GPGLL messages read.
  % disp(); %This line displays the number of GPGSA messages read.
  % disp(); %This line displays the number of GPGST messages read.
  % disp(); %This line displays the number of GPGST messages read.
  % disp(); %This line displays the number of GPGST messages read.
  % disp(); %This line displays the number of GPGST messages read.
  save(ProcessedFilename);
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
else %ParseNmeaFile==0
  load(ProcessedFilename);
  Truncate=TruncateAfterLoad;
end

%% Run Plots

fprintf('---------------------------------------------------------------------------------------------------------------\n');
fprintf('Results for: ');
fprintf(NameOfFile);
fprintf('\n---------------------------------------------------------------------------------------------------------------\n\n');

%return

%Truncate everything
if Truncate
  Dat.Time=Dat.Time(DatSelRange);
  Dat.Lat=Dat.Lat(DatSelRange);
  Dat.Lon=Dat.Lon(DatSelRange);
  Dat.Qual=Dat.Qual(DatSelRange);
  Dat.NumSat=Dat.NumSat(DatSelRange);
  Dat.Hdop=Dat.Hdop(DatSelRange);
  Dat.AntHeightMeters=Dat.AntHeightMeters(DatSelRange);
  Dat.GeoidSepMeters=Dat.GeoidSepMeters(DatSelRange);
  Dat.PRN_Az=Dat.PRN_Az(:,DatSelRange);
  Dat.PRN_El=Dat.PRN_El(:,DatSelRange);
  Dat.PRN_Cnr=Dat.PRN_Cnr(:,DatSelRange);
  Dat.GsaUsedSvs=Dat.GsaUsedSvs(DatSelRange,:);
  Dat.GsaPdop=Dat.GsaPdop(DatSelRange);
  Dat.GsaHdop=Dat.GsaHdop(DatSelRange);
  Dat.GsaVdop=Dat.GsaVdop(DatSelRange);
end

%GoodPosIdx=Dat.Qual==2 & Dat.GsaPdop<=PosAvgPdopLimit; works only when WAAS is enabled
GoodPosIdx=Dat.GsaPdop<=PosAvgPdopLimit;

Avg_Lat=mean(Dat.Lat(GoodPosIdx));
Avg_Lon=mean(Dat.Lon(GoodPosIdx));
Avg_Alt=mean(Dat.AntHeightMeters(GoodPosIdx));

fprintf('average position (LLH): %f %f %f\n\n---------------------------------------------------------------------------------------------------------------\n\n',Avg_Lat,Avg_Lon,Avg_Alt);

% convert LLH to ENU with respect to Reference position
Deg2Rad=pi/180;
RefLlh=[Deg2Rad*[Avg_Lat Avg_Lon],Avg_Alt].';
RefEce=llh2ecef(RefLlh);

NumDatPts=size(Dat.Time,2);
East=zeros(1,NumDatPts);
North=zeros(1,NumDatPts);
Up=zeros(1,NumDatPts);

for k=1:NumDatPts
  Enu=ECEF2ENU(llh2ecef([Deg2Rad*Dat.Lat(k);Deg2Rad*Dat.Lon(k);Dat.AntHeightMeters(k)]),RefEce,RefLlh);
  East(k)=Enu(1,1);
  North(k)=Enu(2,1);
  Up(k)=Enu(3,1);
end



MyColors=jet(35);

FigNum=1;


% Plot ENU in a 3x1 plot
LineW=2;
figure(FigNum)
FigNum=FigNum+1;
subplot(3,1,1)
hold on
plot(Dat.Time,East,'-r','LineWidth',LineW,'LineStyle','-');
plot(Dat.Time,North,'-g','LineWidth',LineW,'LineStyle','-');
plot(Dat.Time,Up,'-b','LineWidth',LineW,'LineStyle','-');
hold off
title(sprintf('ENU Errors w.r.t. Ref LLH:[%.6f, %.6f, %.6f]. Std Dev (Meters): [%.2f, %.2f, %.2f]',Avg_Lat,Avg_Lon,Avg_Alt,std(East),std(North),std(Up)));
xlabel('Time [Hours]');
ylabel('[Meters]')
ylim([-15 15])
grid on
%legend('East','North','Vertical','location','best');
%Weather
subplot(3,1,2)
%plot(Dat.Time,Dat.Hdop,'-k','LineWidth',LineW,'LineStyle','-');
hold on
plot(Dat.Time,Dat.GsaPdop,'r','LineWidth',LineW,'LineStyle','-');
plot(Dat.Time,Dat.GsaVdop,'b','LineWidth',LineW,'LineStyle','-');
plot(Dat.Time,Dat.Hdop,'g','LineWidth',LineW,'LineStyle','-');
hold off

title('Dilution of Precision (DOP), Position (Red), Horizontal (Green), Vertical (Blue)')
xlabel('Time [Hours]');
ylabel('DOP')
grid on
%ylim([-10 10])

subplot(3,1,3)
plot(Dat.Time,Dat.NumSat,'r*')
title('Number of Satellites Tracked')
xlabel('Time [Hours]');
ylabel('# of Satellites')
ylim([4 12])
grid on

fprintf(' ---------------------------------------\n');
fprintf('|The Number of SVs tracked averages are:|\n');
fprintf(' ---------------------------------------\n');

%Number of SVs Averages:
fprintf('Number of SVs tracked (minimum): %f\n',min(Dat.NumSat));
fprintf('Number of SVs tracked (maximum): %f\n',max(Dat.NumSat));
fprintf('Number of SVs tracked (mean): %f\n',mean(Dat.NumSat));
fprintf('Number of SVs tracked (median): %f\n',median(Dat.NumSat));
fprintf('Number of SVs tracked (mode): %f\n\n',mode(Dat.NumSat));

fprintf('---------------------------------------------------------------------------------------------------------------\n\n');
figure(FigNum)
FigNum=FigNum+1;
for k=1:35
  hold on
  plot(Dat.Time,Dat.PRN_El(k,:),'color',MyColors(k,:))
  hold off
end
title('Elevation vs Time')

figure(FigNum)
FigNum=FigNum+1;
for k=1:35
  hold on
  plot(Dat.Time,Dat.PRN_Az(k,:),'color',MyColors(k,:))
  hold off
end
title('Azimuth vs Time')

figure(FigNum)
FigNum=FigNum+1;
for k=1:35
  hold on
  plot(Dat.Time,Dat.PRN_Cnr(k,:),'color',MyColors(k,:))
  hold off
end
title('CNR vs Time')

%Acquire CNR Averages
CnrDat=Dat.PRN_Cnr;
k = find(isnan(CnrDat))';
CnrDat(k) = 0;
CnrDat=reshape(CnrDat,1,[]);
CnrDat=CnrDat(CnrDat>25);
CNR_MIN=min(CnrDat);
CNR_MAX=max(CnrDat);
CNR_MEAN=mean(CnrDat);
CNR_MEDIAN=median(CnrDat);
CNR_MODE=mode(CnrDat);
%return
%CNR_MIN=min(min(Dat.PRN_Cnr));
%CNR_MAX=max(max(Dat.PRN_Cnr));
%CNR_MEAN=mean(mean(Dat.PRN_Cnr));
%CNR_MEDIAN=median(median(Dat.PRN_Cnr));
%CNR_MODE=mode(mode(Dat.PRN_Cnr));

%return

%Print CNR Averages:

fprintf(' ---------------------\n');
fprintf('|The CNR Averages are:| \n');
fprintf(' ---------------------\n');
fprintf('CNR_MIN=%f\nCNR_MAX=%f\nCNR_MEAN=%f\nCNR_MEDIAN=%f\nCNR_MODE=%f\n\n',CNR_MIN,CNR_MAX,CNR_MEAN,CNR_MEDIAN,CNR_MODE);
fprintf('---------------------------------------------------------------------------------------------------------------\n\n');

figure(FigNum)
FigNum=FigNum+1;
xlim([0 360])
ylim([0 90])
for k=1:35
  hold on
  plot(Dat.PRN_Az(k,:),Dat.PRN_El(k,:),'color',MyColors(k,:))
  hold off
end
xlabel('Azimuth [Deg]')
ylabel('Elevation [Deg]')
title('Satellite Sky Plot')

figure(FigNum)
FigNum=FigNum+1;
plot(Dat.Time,Dat.Lat)
title('Latitude vs. Time')
xlabel('Time [Hours]');
ylabel('Latitude [deg]')

figure(FigNum)
FigNum=FigNum+1;
plot(Dat.Time,Dat.Lon)
title('Longitude vs. Time')
xlabel('Time [Hours]');
ylabel('Longitude [deg]')

figure(FigNum)
FigNum=FigNum+1;
plot(Dat.Time,Dat.AntHeightMeters)
title('Height vs. Time')
xlabel('Time [Hours]');
ylabel('Height [Meters]')

figure(FigNum)
FigNum=FigNum+1;
plot(Dat.Time,Dat.NumSat,'r*')
title('Number of Satellites Tracked')
xlabel('time');
ylabel('# of satellites')

figure(FigNum)
FigNum=FigNum+1;
hold on
plot(Dat.Time,Dat.GsaPdop,'r')
plot(Dat.Time,Dat.GsaHdop,'g')
plot(Dat.Time,Dat.GsaVdop,'b')
hold off
title('PDOP(Red), HDOP(Green), VDOP(Blue) versus Time')
xlabel('time');
ylabel('HDOP')

%HDOP Averages
fprintf(' ----------------------\n');
fprintf('|The HDOP Averages are:|\n');
fprintf(' ----------------------\n');
fprintf('HDOP (minimum): %f\n',min(Dat.GsaHdop));
fprintf('HDOP (maximum): %f\n',max(Dat.GsaHdop));
fprintf('HDOP (mean): %f\n',mean(Dat.GsaHdop));
fprintf('HDOP (median): %f\n',median(Dat.GsaHdop));
fprintf('HDOP (mode): %f\n\n',mode(Dat.GsaHdop));

%VDOP Averages
fprintf(' ----------------------\n');
fprintf('|The VDOP Averages are:|\n');
fprintf(' ----------------------\n');
fprintf('VDOP (minimum): %f\n',min(Dat.GsaVdop));
fprintf('VDOP (maximum): %f\n',max(Dat.GsaVdop));
fprintf('VDOP (mean): %f\n',mean(Dat.GsaVdop));
fprintf('VDOP (median): %f\n',median(Dat.GsaVdop));
fprintf('VDOP (mode): %f\n\n',mode(Dat.GsaVdop));

%PDOP Averages
fprintf(' ----------------------\n');
fprintf('|The PDOP Averages are:|\n');
fprintf(' ----------------------\n');
fprintf('PDOP (minimum): %f\n',min(Dat.GsaPdop(Dat.GsaPdop>0)));
fprintf('PDOP (maximum): %f\n',max(Dat.GsaPdop));
fprintf('PDOP (mean): %f\n',mean(Dat.GsaPdop(Dat.GsaPdop>0)));
fprintf('PDOP (median): %f\n',median(Dat.GsaPdop(Dat.GsaPdop>0)));
fprintf('PDOP (mode): %f\n\n',mode(Dat.GsaPdop(Dat.GsaPdop>0)));

figure(FigNum)
FigNum=FigNum+1;
plot(Dat.Time,Dat.Qual)
title('Quality versus Time')
xlabel('time');
ylabel('Quality Indicator')

fprintf('---------------------------------------------------------------------------------------------------------------\n');

%Print WAAS Averages Messages Percentage

Percent_WAAS_Messages = 100*sum(Dat.Qual==2)/size(Dat.Qual,2); 
fprintf('Percent WAAS Messages: %.1f\n\n',Percent_WAAS_Messages);
  
figure(FigNum)
FigNum=FigNum+1;
skyPlot(Dat.PRN_Az,Dat.PRN_El,[1:32 133 135 138]);

figure(FigNum)
FigNum=FigNum+1;
skyPlotCnr(Dat.PRN_Az,Dat.PRN_El,[1:32 133 135 138],Dat.PRN_Cnr,30,50);

fprintf('---------------------------------------------------------------------------------------------------------------\n');

%STOP!!! :D