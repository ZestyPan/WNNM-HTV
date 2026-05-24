function v = HTV(f,lambda,t)
p1=zeros(size(f));
p2=zeros(size(f));
p3=zeros(size(f));
p4=zeros(size(f));
for itr=1:5
      M=suanziA(p1,p2,p3,p4);
      g=M-lambda*f;
      A1=dxx(g);
      A2=dxy2(g);
      A3=dxy1(g);
      A4=dyy(g);
      c=sqrt(A1.^2+A2.^2+A3.^2+A4.^2);
      p1n=(p1-t*A1)./(1+t*c);
      p2n=(p2-t*A2)./(1+t*c);
      p3n=(p3-t*A3)./(1+t*c);
      p4n=(p4-t*A4)./(1+t*c);
      p1=p1n;
      p2=p2n;
      p3=p3n;
      p4=p4n;
      v=f-suanziA(p1,p2,p3,p4)/lambda;
end
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