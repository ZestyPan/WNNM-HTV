function v= chambolle(f,beta,theta)
n  = length(f);
p1 = zeros(n);
p2 = zeros(n);
for itr=1:50
     %% solve p-subproblem
      divp = dx(p1)+dy(p2);
      g    = beta*divp -f;
      A1   = dx(g);
      A2   = dy(g);
      AA   = sqrt(A1.^2 + A2.^2);
      p1   = (p1+theta*A1)./(1+theta*AA);
      p2   = (p2+theta*A2)./(1+theta*AA);
     %% solve u-subproblem by newton method
      divp = dx(p1)+dy(p2);
      v    = f - beta*divp;
     
end
function derivert=dy(u)
    derivert = [diff(u,1,2),u(:,1)-u(:,end)];
end

%%
function derivert=dx(u)
    derivert = [diff(u,1,1);u(1,:)-u(end,:)];
end
end