function enu = ECEF2ENU(ece,orgece,orgllh)
%ENU = ECEF2ENU(ECEF,OrgECEF,orgLLH)
%
%   EC2ENU: Convert ECEF coordinates to East-North-Up with
%   respect to orgece and orgllh (orgece is the same
%   location as orgllh, orgLLH in radians).
%
%  VARIABLES:
%
%   OU-ECE-AEC   Oct. 1988  FvG
%   WJP2011: Vectorized. Now accepts ece as a 3x1, a 3xM, 3xMxN, etc matrix


%   Rotate the difference vector into ENU coordinates
sla = sin(orgllh(1,1)); cla = cos(orgllh(1,1));
slo = sin(orgllh(2,1)); clo = cos(orgllh(2,1));

C = [  -slo      clo      0 ; ...
     -sla*clo  -sla*slo  cla; ...
      cla*clo   cla*slo  sla];

  
if size(ece,2)==1 && ndims(ece)==2; %3x1 vector
% enu = [  -slo      clo      0 ; ...
%        -sla*clo  -sla*slo  cla; ...
%         cla*clo   cla*slo  sla] * difece;

    difece = ece - orgece;   % difference between coordinate origins
    enu= C * difece;
else %3xM or 3xMxN etc
    %Vectorized ECEF2ENU function:
    enu=NaN(size(ece));

    %reshape ece to 3xN matrix
    %ece=reshape(ece,3,size(ece,2)*size(ece,3)*size(ece,4));
    ece=reshape(ece,3,[]);

    difece=zeros(size(ece));
    difece(1,:)=ece(1,:)-orgece(1);
    difece(2,:)=ece(2,:)-orgece(2);
    difece(3,:)=ece(3,:)-orgece(3);

    for i=1:3
        enu(i,:)=C(i,1)*difece(1,:)+C(i,2)*difece(2,:)+C(i,3)*difece(3,:);
    end
end

    
