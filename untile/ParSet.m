function  [par]=ParSet(nSig,lambda1,lambda2,alpha1,alpha2,theta,patsize,patnum,SearchWin,step)
par.IterNums = 50;
par.lambda1  = lambda1;
par.lambda2  = lambda2;
par.alpha1   = alpha1;
par.alpha2   = alpha2;
par.theta    = theta;
% par.r1   = r1;
% par.r2   = r2;

par.nSig      =   nSig;                                 % Variance of the noise image
par.delta     =   0.1;                                  % Parameter between each iter
par.c         =   2*sqrt(2);                            % Constant num for the weight vector
par.Innerloop =   2;                                    % InnerLoop Num of between re-blockmatching
par.ReWeiIter =   3;
    par.step      =   step;     
    par.SearchWin =   SearchWin;                            % Non-local patch searching window
    par.patsize       =   patsize;                            % Patch size
    par.patnum        =   patnum;                           % Initial Non-local Patch number
    par.Iter          =   1;                            % total iter numbers
    par.lamada        =   0.54;
% if nSig<=20
%     par.patsize       =   6;                            % Patch size
%     par.patnum        =   30;                           % Initial Non-local Patch number
%     par.Iter          =   1;                            % total iter numbers
%     par.lamada        =   0.54;                         % Noise estimete parameter
% elseif nSig <= 40
%     par.patsize       =   7;
%     par.patnum        =   90;
%     par.Iter          =   12;
%     par.lamada        =   0.56; 
% elseif nSig<=60
%     par.patsize       =   8;
%     par.patnum        =   120;
%     par.Iter          =   14;
%     par.lamada        =   0.58; 
% else
%     par.patsize       =   9;
%     par.patnum        =   140;
%     par.Iter          =   14;
%     par.lamada        =   0.58; 
% end

              
% Blockmatching and perform WNNM algorithm on all the patches in the image
% is time consuming, we just perform the blockmatching and WNNM on parts of
% patches in the image (we call these patches keypatch in explanatory notes)
% par.step is the step between each keypatch, smaller step will further
% improve the denoisng result