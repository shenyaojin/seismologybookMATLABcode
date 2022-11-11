function [dx,dt,irtr]=layertx(p,h,utop,ubot)
% LAYERTX 计算线形速度梯度的平层介质中的地震波走时dt和震中距
%dx.该程序根据Chris Chapman's WKBJ的FORTRAN程序修改
%  输入参数: p     =水平慢度或射线参数
%            h     =层的厚度
%            utop  =层顶部的慢度
%            ubot  =层顶部的慢度
% 返回参数:  dx    =震中距增加量
%            dt    =该层中的地震波走时
%            irtr  = 返回代码
%                  =-1, 表示层的厚度为零
%                  =0,  射线在上层已经折返，不能到达此层
%                  =1,  射线穿过该层
%                  =2,  射线在此层折返，此时射线不能到达该层的底部
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if (p>=utop) %射线在上层已经折返，不能到达此层
dx=0.;
dt=0.;
irtr=0;
return;
elseif (h==0)  %层的厚度为零的情况
dx=0.;
dt=0.;
irtr=-1;
return;
end
         u1=utop;
         u2=ubot;
         v1=1./u1;
         v2=1./u2;
         b=(v2-v1)/h;      %速度随深度增加的斜率(6-4-1)式
         eta1=sqrt(u1^2-p^2);  %在上限值的垂直慢度
if (b==0)         %对于速度为常值的情况，这直接采用公式
            dx=h*p/eta1;    %直接根据(6-3-5)计算
            dt=h*u1^2/eta1; %直接根据(6-3-10)计算
irtr=1;
return;
end
         x1=eta1/(u1*b*p);  %(6-4-2)式的上限代入值
         tau1=(log((u1+eta1)/p))/b; %(6-4-3)式的上限代入值
if (p>=ubot)        %射线在该层中向上折返,此时只需将顶层的慢度值代入即可
dx=x1-0;                   
            dt= tau1-0;
            irtr=2;
return;
end
         irtr=1;
         eta2=sqrt(u2^2-p^2);   %层底部的垂直慢度值
         x2=eta2/(u2*b*p);  %(6-4-2)式的下限代入值
         tau2=(log((u2+eta2)/p))/b; %(6-4-3)式的下限代入值
         dx=x1-x2;  %震中距上下限的代入值的差
dt=tau1-tau2;  %走时上下限的代入值的差
return
