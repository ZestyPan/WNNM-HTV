function u_final= chambolle00(A,v,s,uold,alpha2,alpha1,theta)
NIT = 50;
n  = length(uold);
p1 = zeros(n);
p2 = zeros(n);
p3 = zeros(n);
p4 = zeros(n);
u1 = uold;
u  = uold;
AT = A';
for itr=1:NIT
     %% solve p-subproblem
      A1   = dxx (u1);
      A2   = dxy2(u1);
      A3   = dxy1(u1);
      A4   = dyy (u1);
      p1   = (p1-theta*A1)./max(1,abs(p1+theta*A1));
      p2   = (p2-theta*A2)./max(1,abs(p2+theta*A2));
      p3   = (p3-theta*A3)./max(1,abs(p3+theta*A3));
      p4   = (p4-theta*A4)./max(1,abs(p4+theta*A4));
      
     %% solve u-subproblem by newton method
     Uold = u;
     div2p = dp1(p1)+dp2(p2)+dp3(p3)+dp4(p4);
     temp1 = alpha2*AT*s + alpha1*v - div2p;
     temp2 = 1./(1 + theta*(alpha2*AT*A + alpha1)); 
     u     = temp2*(Uold + theta*temp1);
     
     %% solve u_-subproblem by the Chambolle projection algorithm
     u1   = 2*u - Uold;
end

u_final = u;

function derivert=dxx(u)
%ANDRE_DERIVERT_x regner ut 2 deriverte i x retning
[x,y]=size(u);
derivert=zeros(x,y);
derivert(2:x-1,:)=u(1:x-2,:)-2*u(2:x-1,:)+u(3:x,:);
end

%%
function derivert=dxy1(u)
[x,y]=size(u);
derivert=zeros(x,y);
derivert(2:x,2:y)=u(2:x,2:y)-u(1:x-1,2:y)-u(2:x,1:y-1)+u(1:x-1,1:y-1);
end

%%
function derivert=dxy2(u)
[x,y]=size(u);
derivert=zeros(x,y);
derivert(1:x-1,1:y-1)=u(2:x,2:y)-u(2:x,1:y-1)-u(1:x-1,2:y)+u(1:x-1,1:y-1);
end

%%
function derivert=dyy(u)
%ANDRE_DERIVERT_y regner ut 2 deriverte i y retning
[x,y]=size(u);
derivert=zeros(x,y);
derivert(:,2:y-1)=u(:,1:y-2)-2*u(:,2:y-1)+u(:,3:y);
end

%%
function derivert=dp1(u)
%ANDRE_DERIVERT_x regner ut 2 deriverte i x retning
[x,y]=size(u);
derivert=zeros(x,y);
derivert(2:x-1,:)=u(1:x-2,:)-2*u(2:x-1,:)+u(3:x,:);
derivert(1,:)=u(2,:) -2*u(1,:);
derivert(x,:)=u(x-1,:) -2*u(x,:);
end
%%
function derivert=dp2(u)
[x,y]=size(u);
derivert=zeros(x,y);
derivert(2:x,2:y)=u(2:x,2:y)-u(1:x-1,2:y)-u(2:x,1:y-1)+u(1:x-1,1:y-1);
derivert(1,:)=u(1,:);
derivert(:,1)=u(:,1);
end
%%
function derivert=dp3(u)
[x,y]=size(u);
derivert=zeros(x,y);
derivert(1:x-1,1:y-1)=u(2:x,2:y)-u(2:x,1:y-1)-u(1:x-1,2:y)+u(1:x-1,1:y-1);
derivert(x,:)=u(x,:);
derivert(:,y)=u(:,y);
end
%%
function derivert=dp4(u)
%ANDRE_DERIVERT_y regner ut 2 deriverte i y retning
[x,y]=size(u);
derivert=zeros(x,y);
derivert(:,2:y-1)=u(:,1:y-2)-2*u(:,2:y-1)+u(:,3:y);
derivert(:,1)=u(:,2)-2* u(:,1);
derivert(:,y)=u(:,y-1)-2* u(:,y);
end
%%
function y=suanziA(p1,p2,p3,p4)
y=dp1(p1)+dp2(p2)+dp3(p3)+dp4(p4);
end

end