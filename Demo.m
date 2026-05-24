clear all;
close all;
clc
for ImgNo = 12
    switch ImgNo
        case 1
            O_Img = double(imread('baby.tif'));
        case 2
            O_Img = double(imread('barbara.tif'));
        case 3
            O_Img = double(imread('boats.tif'));
        case 4
%             O_Img = double(imread('cameraman.tif'));
        case 5
            O_Img = double(imread('lena256.tif'));
        case 6
            O_Img = double(imread('liver.jpg'));
            O_Img = O_Img(:,:,1);
            O_Img = imresize(O_Img, 256/320);
        case 7
            O_Img = double(imread('peppers.tif'));
        case 8
            O_Img = double(imread('Saturn_0.jpg'));
            O_Img = O_Img(:,:,1);
            figure;imshow(O_Img,[]);
        case 9
            O_Img = double(imread('moon_0.png'));
            O_Img = O_Img(:,:,1);
            figure;imshow(O_Img,[]);
        case 10
            O_Img = double(imread('Ankle-1.jpg'));
            O_Img = O_Img(:,:,1);
%             O_Img = imresize(O_Img, 256/498);
            figure;imshow(O_Img,[]);
        case 11
            Einstein.tiff
            O_Img = double(imread('Brain_00.png'));
            O_Img = O_Img(:,:,1);
            O_Img = imresize(O_Img, 256/442);
        case 12
             O_Img = double(imread('Einstein.tiff'));
    end
end
% F=size(O_Img);
 % O_Img = double(imread('Einstein.tiff'));
 % O_Img = double(imread('boats.tif'));
  O_Img = double(imread('cameraman.tif'));
   % O_Img = double(imread('barbara.tif'));
%  O_Img = double(imread('liver.jpg'));
%             O_Img = O_Img(:,:,1);
%             O_Img = imresize(O_Img, 256/320);
forg = O_Img;
peakValue = 15;
O_Img = peakValue*O_Img/max(O_Img(:));
N_Img = imnoise(uint8(O_Img),'poisson');
N_Img = double(N_Img);

%     figure(1); 
%     imshow(uint8(N_Img)); 
psnr_input =    psnr(N_Img, O_Img, peakValue);
fprintf( 'Noisy Image: peak = %.1f, PSNR = %2.2f \n\n\n', peakValue, psnr_input );
% lena256.tif
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

% nSig = 0.2;h = 0.08;max = 0.5;data=[];
% while nSig < max
%     fprintf( 'Estimated Image: nSig = %2.1f\n',nSig);
%     t1 = cputime;
%     Par   = ParSet(nSig,lambda1,lambda2,alpha1,alpha2,theta,patsize,patnum,SearchWin,step);
%     [E_Img,MSE,psnr_final,ssim_final] = Deblurring_GSR(N_Img,O_Img,Par,peakValue);
%     t1 = cputime - t1;
%     s1 = psnr_final;
%     data=[data;nSig,s1];
%     nSig = nSig +h;
% end
% figure(1);
% plot(data(:,1),data(:,2),'-+r');
% ylabel('PSNR');

% lambda1 = 0.5;h =1000;max = 5000;data=[];
% while lambda1 < max
%     fprintf( 'Estimated Image: lambda1 = %2.2f\n',lambda1);
%     t1 = cputime;
%     Par   = ParSet(nSig,lambda1,lambda2,alpha1,alpha2,theta,patsize,patnum,SearchWin,step);
%     [E_Img,MSE,psnr_final,ssim_final] = Deblurring_GSR(N_Img,O_Img,Par,peakValue);
%     t1 = cputime - t1; 
%     s1 = psnr_final;
%     data=[data;lambda1,s1];
%     lambda1 = lambda1 +h;
% end
% figure(1);
% plot(data(:,1),data(:,2),'-+r');
% ylabel('PSNR');

% lambda2 = 0.01;h =1;max =5;data=[];
% while lambda2 < max
%     fprintf( 'Estimated Image: lambda2 = %2.2f\n',lambda2);
%     t1 = cputime;
%     Par   = ParSet(nSig,lambda1,lambda2,alpha1,alpha2,theta,patsize,patnum,SearchWin,step);
%     [E_Img,MSE,psnr_final,ssim_final] = Deblurring_GSR(N_Img,O_Img,Par,peakValue);
%     t1 = cputime - t1; 
%     s1 = psnr_final;
%     data=[data;lambda2,s1];
%     lambda2 = lambda2 +h;
% end
% figure(1);
% plot(data(:,1),data(:,2),'-+r');
% ylabel('PSNR');

% alpha1 =0.005;h = 1.5;max =15;data=[];
% while alpha1 < max
%     fprintf( 'Estimated Image: alpha1 = %2f\n',alpha1);
%     t1 = cputime;
%     Par   = ParSet(nSig,lambda1,lambda2,alpha1,alpha2,theta,patsize,patnum,SearchWin,step);
%     [E_Img,MSE,psnr_final,ssim_final] = Deblurring_GSR(N_Img,O_Img,Par,peakValue);
%     t1 = cputime - t1; 
%     s1 = psnr_final;
%     data=[data;alpha1,s1];
%     alpha1 = alpha1 +h;
% end
% figure(1);
% plot(data(:,1),data(:,2),'-+r');
% ylabel('PSNR');

% alpha2 =0.05;h =0.1;max = 0.45;data=[];
% while alpha2 < max
%     fprintf( 'Estimated Image: alpha2 = %2.3f\n',alpha2);
%     t1 = cputime;
%     Par   = ParSet(nSig,lambda1,lambda2,alpha1,alpha2,theta,patsize,patnum,SearchWin,step);
%     [E_Img,MSE,psnr_final,ssim_final] = Deblurring_GSR(N_Img,O_Img,Par,peakValue);
%     t1 = cputime - t1; 
%     s1 = psnr_final;
%     data=[data;alpha2,s1];
%     alpha2 = alpha2 +h;
% end
% figure(1);
% plot(data(:,1),data(:,2),'-+r');
% ylabel('PSNR');

% theta = 0.001;h = 0.001;max =0.15;data=[];
% while theta < max
%     fprintf( 'Estimated Image: theta = %2.4f\n',theta);
%     t1 = cputime;
%     Par   = ParSet(nSig,lambda1,lambda2,alpha1,alpha2,theta,patsize,patnum,SearchWin,step);
%     [E_Img,MSE,psnr_final,ssim_final] = Deblurring_GSR(N_Img,O_Img,Par,peakValue);
%     t1 = cputime - t1; 
%     s1 = psnr_final;
%     data=[data;theta,s1];
%     theta = theta +h;
% end
% figure(1);
% plot(data(:,1),data(:,2),'-+r');
% ylabel('PSNR');


patsize =3;h = 1;max =15;data=[];
while patsize < max
    fprintf( 'Estimated Image: patsize = %2f\n',patsize);
    t1 = cputime;
    Par   = ParSet(nSig,lambda1,lambda2,alpha1,alpha2,theta,patsize,patnum,SearchWin,step);
    [E_Img,MSE,psnr_final,ssim_final] = Deblurring_GSR(N_Img,O_Img,Par,peakValue);
    t1 = cputime - t1; 
    s1 = psnr_final;
    data=[data;patsize,s1];
    patsize = patsize +h;
end
figure(1);
plot(data(:,1),data(:,2),'-+r');
ylabel('PSNR');


%  patnum =10;h = 20;max =51;data=[];
% while patnum < max
%     fprintf( 'Estimated Image: patnum = %3f\n',patnum);
%     t1 = cputime;
%     Par   = ParSet(nSig,lambda1,lambda2,alpha1,alpha2,theta,patsize,patnum,SearchWin,step);
%     [E_Img,MSE,psnr_final,ssim_final] = Deblurring_GSR(N_Img,O_Img,Par,peakValue);
%     t1 = cputime - t1; 
%     s1 = psnr_final;
%     data=[data;patnum,s1];
%     patnum = patnum +h;
% end
% figure(1);
% plot(data(:,1),data(:,2),'-+r');
% ylabel('PSNR');


% step =2;h = 1;max = 5;data=[];
% while step < max
%     fprintf( 'Estimated Image: step = %2f\n',step);
%     t1 = cputime;
%     Par   = ParSet(nSig,lambda1,lambda2,alpha1,alpha2,theta,patsize,patnum,SearchWin,step);
%     [E_Img,psnr_final,ssim_final] = Deblurring_GSR(N_Img,O_Img,Par,peakValue);
%     t1 = cputime - t1; 
%     s1 = psnr_final;
%     data=[data;step,s1];
%     step = step +h;
% end

% SearchWin =10;h = 10;max = 51;data=[];
% while SearchWin < max
%     fprintf( 'Estimated Image: SearchWin = %2f\n',SearchWin);
%     t1 = cputime;
%     Par   = ParSet(nSig,lambda1,lambda2,alpha1,alpha2,theta,patsize,patnum,SearchWin,step);
%     [E_Img,psnr_final,ssim_final] = Deblurring_GSR(N_Img,O_Img,Par,peakValue);
%     t1 = cputime - t1;
%     s1 = psnr_final;
%     data=[data;SearchWin,s1];
%     SearchWin = SearchWin +h;
% end
% figure(1);
% plot(data(:,1),data(:,2),'-+r');
% ylabel('PSNR');

Par   = ParSet(nSig,lambda1,lambda2,alpha1,alpha2,theta,patsize,patnum,SearchWin,step);
tic
[E_Img,MSE,psnr_final,ssim_final] = Deblurring_GSR(N_Img,O_Img,Par,peakValue);
toc
figure
imshow(E_Img,[])
% im =         E_Img*max(forg(:))/peakValue;
% PSNR_Final   =  csnr (im, forg,0,0);
% fprintf('PSNR = %2.2f\n',PSNR_Final);

% PSNR  =  psnr(E_Img, O_Img, peakValue);
% fprintf( 'Estimated Image: nSig = %2.3f, PSNR = %2.2f, SSIM = %.3f \n\n\n'...
%     , nSig, psnr_final,ssim_final);
% [x,y]=size(O_Img);
% figure(98);
% imshow(E_Img,[],'border','tight','initialmagnification','fit'); 
% axis normal;
% set(gcf,'Position',[0,0,y,x]);
% figure(2); 
% subplot(221),imshow(O_Img,[0,peakValue]);
% subplot(222); imshow(N_Img,[0,peakValue]);
% subplot(223); imshow(E_Img,[0,peakValue]);
