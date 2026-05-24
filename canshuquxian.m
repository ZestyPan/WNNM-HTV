clear all;
close all;
clc
nSig      = 0.27;  % 0.5 %0.27
lambda1   = 45;  %32  %10
lambda2   = 5;   %11  %26
alpha1    = 0.5;   %0.9  %6
alpha2    = 0.15;

theta     = 0.005;
patsize   = 7;
patnum    = 50;
step      = 2;     
SearchWin = 10;
O_Img = double(imread('barbara.tif'));
O_Img = double(imread('boats.tif'));
O_Img = double(imread('cameraman.tif'));
% O_Img = double(imread('Einstein.tiff'));
forg = O_Img;
peakValue = 30;
O_Img = peakValue*O_Img/max(O_Img(:));
N_Img = imnoise(uint8(O_Img),'poisson');
N_Img = double(N_Img);

%     figure(1); 
%     imshow(uint8(N_Img)); 
psnr_input =    psnr(N_Img, O_Img, peakValue);
fprintf( 'Noisy Image: peak = %.1f, PSNR = %2.2f \n\n\n', peakValue, psnr_input );
% lena256.tif

lambda2 = 0.01;h =1;max =5;data=[];
while lambda2 < max
    fprintf( 'Estimated Image: lambda2 = %2.2f\n',lambda2);
    t1 = cputime;
    Par   = ParSet(nSig,lambda1,lambda2,alpha1,alpha2,theta,patsize,patnum,SearchWin,step);
    [E_Img,MSE,psnr_final,ssim_final] = Deblurring_GSR(N_Img,O_Img,Par,peakValue);
    t1 = cputime - t1; 
    s1 = psnr_final;
    data=[data;lambda2,s1];
    lambda2 = lambda2 +h;
end
figure(1);
plot(data(:,1),data(:,2),'-+r');
ylabel('PSNR');


% lambda1 = 0.05;h =300;max =2000;data1=[];
% while lambda1 < max
%     fprintf( 'Estimated Image: lambda1 = %2.2f\n',lambda1);
%     t1 = cputime;
%     Par   = ParSet(nSig,lambda1,lambda2,alpha1,alpha2,theta,patsize,patnum,SearchWin,step);
%     [E_Img,MSE,psnr_final,ssim_final] = Deblurring_GSR(N_Img,O_Img,Par,peakValue);
%     t1 = cputime - t1; 
%     s1 = psnr_final;
%     data1=[data1;lambda1,s1];
%     lambda1 = lambda1 +h;
% end
% figure(1);
% plot(data1(:,1),data1(:,2),'-+r');
%  ylabel('PSNR');


%  O_Img = double(imread('boats.tif'));
 
% lambda1 = 1;
% h =1;max =5;data2=[];
% while lambda1 < max
%     fprintf( 'Estimated Image: lambda1 = %2.2f\n',lambda1);
%     t1 = cputime;
%     Par   = ParSet(nSig,lambda1,lambda2,alpha1,alpha2,theta,patsize,patnum,SearchWin,step);
%     [E_Img,MSE,psnr_final,ssim_final] = Deblurring_GSR(N_Img,O_Img,Par,peakValue);
%     t1 = cputime - t1; 
%     s1 = psnr_final;
%     data2=[data2;lambda1,s1];
%     lambda1 = lambda1 +h;
% end
% 
% figure(1);
% plot(data1(:,1),data1(:,2),'-+r');
% % ylabel('PSNR');
%  hold on
% % figure(2);
% plot(data2(:,1),data2(:,2),'-*b');
% ylabel('PSNR'); 
 
 
%   O_Img = double(imread('cameraman.tif'));
%   
%   
%     O_Img = double(imread('Einstein.tiff'));
