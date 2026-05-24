function [E_Img]   =  WNNM_DeNoising00( N_Img,  Par )

E_Img           =   N_Img;                                                        % Estimated Image
[Hight,Width]   =   size(E_Img);   
TotalPatNum     =   (Hight-Par.patsize+1)*(Width-Par.patsize+1);                 %Total Patch Number in the image
Dim             =   Par.patsize*Par.patsize;  
N               =   Hight-Par.patsize+1;
M               =   Width-Par.patsize+1;
TempOffsetR     =   [1:N];%//[1 2 3 ... N-1 N],1xN的矩阵
TempOffsetC     =   [1:M];  
[Neighbor_arr,Num_arr,Self_arr] =	NeighborIndex(N_Img, Par);                  % PreCompute the all the patch index in the searching window 
NL_mat                          =   zeros(Par.patnum,length(Num_arr));          % NL Patch index matrix
CurPat                          =	zeros( Dim, TotalPatNum );
Sigma_arr                       =   zeros( 1, TotalPatNum);            
EPat                            =   zeros( size(CurPat) );     
W                               =   zeros( size(CurPat) );          
            
for iter = 1 : Par.Iter        
    E_Img             	=	E_Img + Par.delta*(N_Img - E_Img);
    CurPat	=	Im2Patch( E_Img, N_Img, Par );                      % image to patch and estimate local noise variance            
    %Im2Patch函数将图像分块并把每块信息存入CurPat
%     NL_mat  =  Block_matching(CurPat, Par, Neighbor_arr, Num_arr, Self_arr);
    if (mod(iter-1,Par.Innerloop)==0)
        Par.patnum = Par.patnum-10;                                             % Lower Noise level, less NL patches
        NL_mat  =  Block_matching(CurPat, Par, Neighbor_arr, Num_arr, Self_arr);% Caculate Non-local similar patches for each 
        if(iter==1)
            Sigma_arr = Par.nSig * ones(size(Sigma_arr));                       % First Iteration use the input noise parameter
        end
    end       

  %% Estimate all the patches
  
   for  i      =  1 : length(Self_arr)                                 % For each keypatch group
       Temp    =   CurPat(:, NL_mat(1:Par.patnum,i));                  % Non-local similar patches to the keypatch
       M_Temp  =   repmat(mean( Temp, 2 ),1,Par.patnum);
       Temp    =   Temp-M_Temp;
    
     %% WNNM Estimation
      
%        [U,SigmaY,V] =   svd(full(Temp),'econ');
%        Temp         =   (sqrt(max(diag(SigmaY).^2-5,0))+0.25);
%        W_Vec        =   (60*sqrt(30)./(Temp+eps)).^2./diag(SigmaY);
%        SigmaX       =   soft(SigmaY, diag(W_Vec));
%        E_Temp       =   U*SigmaX*V' + M_Temp; 
       
       E_Temp 	=   WNNM( Temp, Par.c, Sigma_arr(Self_arr(i)), M_Temp, Par.ReWeiIter); % WNNM Estimation
    
       EPat(:,NL_mat(1:Par.patnum,i))  = EPat(:,NL_mat(1:Par.patnum,i))+E_Temp;
       W(:,NL_mat(1:Par.patnum,i))     = W(:,NL_mat(1:Par.patnum,i))+ones(Par.patsize*Par.patsize,size(NL_mat(1:Par.patnum,i),1));
   end

    E_Img  	=  zeros(Hight,Width);
    W_Img 	=  zeros(Hight,Width);
    k        =   0;
    for i  = 1:Par.patsize
        for j  = 1:Par.patsize
            k    =  k+1;
            E_Img(TempOffsetR-1+i,TempOffsetC-1+j)  =  E_Img(TempOffsetR-1+i,TempOffsetC-1+j) + reshape( EPat(k,:)', [N M]);
            W_Img(TempOffsetR-1+i,TempOffsetC-1+j)  =  W_Img(TempOffsetR-1+i,TempOffsetC-1+j) + reshape( W(k,:)',  [N M]);
        end
    end
    
     E_Img  =  E_Img./(W_Img+eps);     
     
end
return;


