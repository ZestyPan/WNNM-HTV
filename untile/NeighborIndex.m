function  [Neighbor_arr,Num_arr,SelfIndex_arr]  =  NeighborIndex(im, par)
% This Function Precompute the all the patch indexes in the Searching window
% -Neighbor_arr is the array of neighbor patch indexes for each keypatch
% -Num_arr is array of the effective neighbor patch numbers for each keypatch
% -SelfIndex_arr is the index of keypatches in the total patch index array 
%此函数在“搜索”窗口中预计算所有块索引
%-Neighbor_arr 是每个keypatch的邻居块索引数组
%-Num_arr      是每个keypatch的有效邻居补丁号数组
%-SelfIndex_arr是总块索引数组中keypatches的索引
SW      	=   par.SearchWin;
s           =   par.step;
TempR       =   size(im,1)-par.patsize+1;%par.patsize=6,251
TempC       =   size(im,2)-par.patsize+1;%251
R_GridIdx	=   [1:s:TempR];%//[1 5 9 ... fix((N-1)/4)*4-3 fix((N-1)/4)*4+1],1 x fix((N-1)/4)+1的矩阵
R_GridIdx	=   [R_GridIdx R_GridIdx(end)+1:TempR];% [1 5 ... fix((N-1)/4)*4+1 fix((N-1)/4)*4+2 TempR]
C_GridIdx	=   [1:s:TempC];%1x63,[1 5 9 ... 245 249]
C_GridIdx	=   [C_GridIdx C_GridIdx(end)+1:TempC];%[1 5 9 ... 245 249 250 251]

Idx         =   (1:TempR*TempC);%[1 2 3 ... TempR*TempC-1 TempR*TempC],1x(TempR*TempC)的矩阵[1 2 3 ... ]
Idx         =   reshape(Idx, TempR, TempC);%TempR*TempC的矩阵，第一列[1 2 ... TempR]',第二列[TempR+1 ... 2*TempR]
R_GridH     =   length(R_GridIdx);%    
C_GridW     =   length(C_GridIdx);% C_GridIdx的长度：65

Neighbor_arr    =   int32(zeros(4*SW*SW,R_GridH*C_GridW));%zeros(4*30*30,65*65)：3600x4225的零矩阵
Num_arr         =   int32(zeros(1,R_GridH*C_GridW));%zeros(1,65*65)1x4225的矩阵
SelfIndex_arr   =   int32(zeros(1,R_GridH*C_GridW));%zeros(1,65*65)1x4225的矩阵

for  i  =  1 : R_GridH
    for  j  =  1 : C_GridW    
        OffsetR     =   R_GridIdx(i);
        OffsetC     =   C_GridIdx(j);
        Offset1  	=  (OffsetC-1)*TempR + OffsetR;
        Offset2   	=  (j-1)*R_GridH + i;
                
        top         =   max( OffsetR-SW, 1 );
        button      =   min( OffsetR+SW, TempR );        
        left        =   max( OffsetC-SW, 1 );
        right       =   min( OffsetC+SW, TempC );     
        
        NL_Idx     =   Idx(top:button, left:right);
        NL_Idx     =   NL_Idx(:);

        Num_arr(Offset2)  =  length(NL_Idx);
        Neighbor_arr(1:Num_arr(Offset2),Offset2)  =  NL_Idx;   
        SelfIndex_arr(Offset2) = Offset1;
    end
end