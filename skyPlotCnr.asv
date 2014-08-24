function hpol = skyPlotCnr(varargin)


% Az, El, PRN, Cnr, CnrMin, CnrMax, line_style




%Function plots "sky view" from the receiver perspective.
%
%h = skyPlot(AZ, EL, PRN, line_style)
%
%   Inputs:
%       AZ              - contains satellite azimuth angles. It is a 2D
%                       matrix. One line contains data of one satellite.
%                       The columns are the calculated azimuth values.
%       EL              - contains satellite elevation angles. It is a 2D
%                       matrix. One line contains data of one satellite.
%                       The columns are the calculated elevations.
%       PRN             - a row vector containing PRN numbers of the
%                       satellites.
%       line_style      - line style of the plot. The same style will be
%                       used to plot all satellite positions (including
%                       color).
%   Outputs:
%       h               - handle to the plot

%--------------------------------------------------------------------------
%                           SoftGNSS v3.0
%
% Copyright (C) Darius Plausinaitis and Kristin Larson
% Written by Darius Plausinaitis and Kristin Larson
%--------------------------------------------------------------------------
%This program is free software; you can redistribute it and/or
%modify it under the terms of the GNU General Public License
%as published by the Free Software Foundation; either version 2
%of the License, or (at your option) any later version.
%
%This program is distributed in the hope that it will be useful,
%but WITHOUT ANY WARRANTY; without even the implied warranty of
%MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%GNU General Public License for more details.
%
%You should have received a copy of the GNU General Public License
%along with this program; if not, write to the Free Software
%Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301,
%USA.
%--------------------------------------------------------------------------

%CVS record:
%$Id: skyPlot.m,v 1.1.2.5 2006/08/18 11:41:57 dpl Exp $

%% Check arguments and sort them ==========================================




[hAxis, args, nargs] = axescheck(varargin{:});

%if nargs < 3 || nargs > 4
if nargs < 6 || nargs > 7
  error('Requires 6 or 7 data arguments.')
  %elseif nargs == 3
elseif nargs == 6
  %[az, el, prn]   = deal(args{1:3});
  [az, el, prn, Cnr, CnrMin, CnrMax]   = deal(args{1:6});
  line_style      = 'auto';
else
  %[az, el, prn, line_style] = deal(args{1:4});
  [az, el, prn, Cnr, CnrMin, CnrMax, line_style] = deal(args{1:7});
end

%if ischar(az) || ischar(el) || ischar(prn)
if ischar(az) || ischar(el) || ischar(prn)
  error('AZ and EL must be numeric.');
end

if ~isequal(size(az), size(el))
  error('AZ and EL must be same size.');
end

Cnr=round(Cnr);
CnrMin=round(CnrMin);
CnrMax=round(CnrMax);

%% Prepare axis ===========================================================
hAxis = newplot(hAxis);

%--- Get x-axis text color so grid is in same color -----------------------
tc = get(hAxis, 'xcolor');

hold(hAxis, 'on');

%--- Plot white background ------------------------------------------------
rectangle('position', [-90, -90, 180, 180], ...
  'Curvature', [1 1], ...
  'facecolor', 'white', ...
  'edgecolor', tc);

%% Plot spokes ============================================================

%--- Find spoke angles ----------------------------------------------------
% Only 6 lines are needed to divide circle into 12 parts
th = (1:6) * 2*pi / 12;

%--- Convert spoke end point coordinate to Cartesian system ---------------
cst = cos(th); snt = sin(th);
cs = [cst; -cst];
sn = [snt; -snt];

%--- Plot the spoke lines -------------------------------------------------
line(90*sn, 90*cs, 'linestyle', ':', 'color', tc, 'linewidth', 0.5, ...
  'handlevisibility', 'off');

%% Annotate spokes in degrees =============================================
rt = 1.1 * 90;

for i = 1:max(size(th))
  
  %--- Write text in the first half of the plot -------------------------
  text(rt*snt(i), rt*cst(i), int2str(i*30), ...
    'horizontalalignment', 'center', 'handlevisibility', 'off');
  
  if i == max(size(th))
    loc = int2str(0);
  else
    loc = int2str(180 + i*30);
  end
  
  %--- Write text in the opposite half of the plot ----------------------
  text(-rt*snt(i), -rt*cst(i), loc, ...
    'handlevisibility', 'off', 'horizontalalignment', 'center');
end

%% Plot elevation grid ====================================================

%--- Define a "unit" radius circle ----------------------------------------
th = 0 : pi/50 : 2*pi;
xunit = cos(th);
yunit = sin(th);

%--- Plot elevation grid lines and tick text ------------------------------
for elevation = 0 : 15 : 90
  elevationSpherical = 90*cos((pi/180) * elevation);
  
  line(yunit * elevationSpherical, xunit * elevationSpherical, ...
    'lineStyle', ':', 'color', tc, 'linewidth', 0.5, ...
    'handlevisibility', 'off');
  
  text(0, elevationSpherical, num2str(elevation), ...
    'BackgroundColor', 'white', 'horizontalalignment','center', ...
    'handlevisibility', 'off');
end

%--- Set view to 2-D ------------------------------------------------------
view(0, 90);

%--- Set axis limits ------------------------------------------------------
%save some space for the title
axis([-95 95 -90 101]);

%% Transform elevation angle to a distance to the center of the plot ------
elSpherical = 90*cos(el * pi/180);

%--- Transform data to Cartesian coordinates ------------------------------
yy = elSpherical .* cos(az * pi/180);
xx = elSpherical .* sin(az * pi/180);


% CNR colors
CnrNumColors=CnrMax-CnrMin;
CnrColors=[[1 1 1]; jet(CnrNumColors)];
Cnr(isnan(Cnr))=0;
CnrColorIndex=Cnr-CnrMin+1;
%return
[r c]=size(yy);
%[r c]=size(xx);

%return

%% Plot data on top of the grid ===========================================

if strcmp(line_style, 'auto')
  %--- Plot with "default" line style -----------------------------------
  %hpol = plot(hAxis, xx', yy', '.-');
  
  %hpol = plot(hAxis, xx', yy', '.-');
  
  
  
  %hpol = plot(hAxis, xx', yy', '.-');
  
  
%   for rr=1:r
%     
%     for kk=1:c
%       if CnrColorIndex(rr,kk)~=1
%         
%         %hpol = plot(hAxis, xx(rr,kk), yy(rr,kk),'.-','color',CnrColors(CnrColorIndex(rr,kk),:));
%         hpol = plot(hAxis, xx(rr,kk), yy(rr,kk),'lineStyle', ':','color',CnrColors(CnrColorIndex(rr,kk),:),'Marker','.','MarkerSize',5);
%       end
%     end
%   end
  
Decim=60;

Lim=Decim*floor(c/Decim);



for rr=1:r
  
  xxLim=reshape(xx(rr,1:Lim),Decim,[]);
  xxLim=xxLim(1,:);
  
  yyLim=reshape(yy(rr,1:Lim),Decim,[]);
  yyLim=yyLim(1,:);
  
  CnrLim=reshape(Cnr(rr,1:Lim),Decim,[]);
  CnrLim=CnrLim(1,:);
  
  idx=CnrLim>0;
  
  %xxx=reshape(xx(rr,idx),Decim,[]);
  %xxx=xxx(1,:);
  
  %yyy=reshape(yy(rr,idx),Decim,[]);
  %yyy=yyy(1,:);
  
  %Cnrx=reshape(Cnr(rr,idx),Decim,[]);
  %Cnrx=Cnrx(1,:);
  
  %hpol = scatter(hAxis, xx(rr,idx), yy(rr,idx),7,Cnr(rr,idx));
  hpol = scatter(hAxis, xxLim(idx), yyLim(idx),200,CnrLim(idx),'.');
  set(gca,'CLim',[CnrMin CnrMax]);
end

else
  %--- Plot with user specified line style ------------------------------
  % The same line style and color will be used for all satellites
  hpol = plot(hAxis, xx', yy', line_style);
end

%--- Mark the last position of the satellite ------------------------------
plot(hAxis, xx(:,end)', yy(:,end)', 'o', 'MarkerSize', 10);

%--- Place satellite PRN numbers at the latest position -------------------
for i = 1:length(prn)
  if(prn(i) ~= 0)
    % The empthy space is used to place the text a side of the last
    % point. This solution results in constant offset even if a zoom
    % is used.
    text(xx(i, end), yy(i, end), ['  ', int2str(prn(i))], 'color', 'b');
  end
end

%--- Make sure both axis have the same data aspect ratio ------------------
axis(hAxis, 'equal');

%--- Switch off the standard Cartesian axis -------------------------------
axis(hAxis, 'off');