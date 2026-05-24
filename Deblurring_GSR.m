function [u_final,MSE,psnr_final,ssim_final] = Deblurring_GSR(f,O_Img,Par,peakValue)
% function [u_final,MSE,psnr_final,ssim_final] = Deblurring_GSR(f,O_Img,Par)
u_org    = O_Img;
IterNums = Par.IterNums;
lambda1   = Par.lambda1;
lambda2   = Par.lambda2;
alpha1   = Par.alpha1;
alpha2   = Par.alpha2;
theta    = Par.theta;
lamalp1  = lambda1/alpha1;
u = f;
b1 = zeros(size(f));
b2 = zeros(size(f));
MSE    = zeros(1,IterNums+1);
MSE(1) = sum(sum((u-u_org).^2))/numel(u);
fprintf('Initial PSNR = %f\n',psnr(u, O_Img, peakValue));
% fprintf('Initial PSNR = %f\n',csnr(u,O_Img,0,0));

AllPSNR     =  zeros(1,IterNums );
AllSSIM     =  zeros(1,IterNums );
Denoising  =   cell (1,IterNums );
for iter = 1:IterNums
    
    v  = WNNM_DeNoising( u-b1, Par ,lamalp1);
    
    z  = HTV(u-b2,alpha2./lambda2 ,theta);
    
    uold = u;
    b  = (alpha1*(v+b1) + alpha2*(z+b2) - 1)/(alpha1+alpha2);
    c  = f/(alpha1+alpha2);
    u  = 0.5*(b + sqrt( b.^2 + 4*c ));
    
    b1 = b1 -(u - v);
    b2 = b2 -(u - z);
    
    u_resid     = u - u_org;
    MSE(iter+1) =  (u_resid(:)'*u_resid(:))/numel(u);
    relerr = norm(abs(u(:))-abs(uold(:)))/norm(abs(u(:)));
    Denoising{iter} =   u;
  
%     AllPSNR(iter)   =  csnr(u,O_Img,0,0);
%     AllSSIM(iter)   =  cal_ssim(u,O_Img,0,0);
    AllPSNR(iter)   =  psnr(u, O_Img, peakValue);
    AllSSIM(iter)   =  ssim(u, O_Img, 'DynamicRange', peakValue);    
   if iter>1
%         Err_or      =  norm(abs(Denoising{iter}) - abs(Denoising{iter-1}),'fro')/norm(abs(Denoising{iter-1}), 'fro');
        if AllPSNR(iter) - AllPSNR(iter-1) <0
           break;
%        if relerr<0.0001
%            break;
       end    
   end 
   if relerr<0.001
      break;
   end 
    fprintf('iter number = %d, PSNR = %f, SSIM = %.3f, relerr = %.4f\n',...
        iter,psnr(u, O_Img, peakValue),AllSSIM(iter),relerr);

end
psnr_final = AllPSNR(iter-1);
ssim_final = AllSSIM(iter-1);
u_final = u;
fprintf('Final PSNR = %f\n',psnr_final);

function derivert=dxx(u)
%ANDRE_DERIVERT_x regner ut 2 deriverte i x retning
[x,y]=size(u);
derivert=zeros(x,y);
derivert(2:x-1,:)=u(1:x-2,:)-2*u(2:x-1,:)+u(3:x,:);
end


function derivert=dxy1(u)
[x,y]=size(u);
derivert=zeros(x,y);
derivert(2:x,2:y)=u(2:x,2:y)-u(1:x-1,2:y)-u(2:x,1:y-1)+u(1:x-1,1:y-1);
end

%
function derivert=dxy2(u)
[x,y]=size(u);
derivert=zeros(x,y);
derivert(1:x-1,1:y-1)=u(2:x,2:y)-u(2:x,1:y-1)-u(1:x-1,2:y)+u(1:x-1,1:y-1);
end

%
function derivert=dyy(u)
%ANDRE_DERIVERT_y regner ut 2 deriverte i y retning
[x,y]=size(u);
derivert=zeros(x,y);
derivert(:,2:y-1)=u(:,1:y-2)-2*u(:,2:y-1)+u(:,3:y);
end
end