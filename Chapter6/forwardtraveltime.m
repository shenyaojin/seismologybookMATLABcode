function forwardtraveltime()
clc
SubDel=0.0001;  %离源角迭代时，小于该值迭代结束
Stx=[150 0 150 300 300 300 150 0 0];   %台站的x坐标
Sty=[150 300 300 300 150 0 0 0 150];  %台站的y坐标
Stz=zeros(1,9);                      %台站的z坐标
FirLocal=[75.071,50.000,19,0.0];    %假定震源的x，y，z和发震时刻
plot(Stx,Sty,'^','MarkerFaceColor','b')
text(Stx+5,Sty,num2str([1 2 3 4 5 6 7 8 9]'))
hold on
plot(75.071,50.000,'p','MarkerFaceColor','r')
text(75.071,50.0,'震源');
xlabel('X/km');ylabel('Y/km')
axis([-10 310,-10,310])
Vp=[2.5,5.3,6.1,6.6,7.2,7.9];   %P波速度模型
Vs=[1.1,3.1,3.5,3.8,4.0,4.5];   %S波速度模型
deep=[0,1,3,24,38,46];   %各个界面的深度
%注意对于地壳速度模型，地表深度为零为第一个界面，依次为第二界面，等等，但第一层速度为第二界面和第一界面相夹层的介质速度
%因此，第i层的速度为第i个界面和i+1个界面所夹的介质速度，其厚度为Deep(i+1)-Deep(i)
Pg=zeros(1,length(Stx));
for ii=1:length(Stx)  
%求出地震所在的层和地震距震源层顶部的距离DisDeep
[Disdep,SLayerNum]=getParam(deep,FirLocal(3));
%计算台站P波入射角
[takeoff,Azim] = getangle(Vp,deep,FirLocal,SLayerNum,Stx(ii),Sty(ii),Disdep,SubDel);
%计算台站P波走时
Pg(ii) = gettime(Vp,deep,takeoff,SLayerNum,Disdep); 
%计算台站S波入射角
[SeiTakeoff,Azi]= getangle(Vs,deep,FirLocal,SLayerNum,Stx(ii),Sty(ii),Disdep,SubDel);
%计算台站S波走时
Sg(ii) = gettime(Vs,deep,SeiTakeoff,SLayerNum,Disdep); 
SeiDelta=sqrt((Stx(ii)-FirLocal(1))^2+(Sty(ii)-FirLocal(2))^2);
[Pn(ii),takeoff]=PnTraveltime(Vp,deep,SeiDelta,SLayerNum,Disdep);
end
[Pg;Sg;Pn]

function [Disdep,SLayerNum]=getParam(deep,Sdep)
%得到震源相对一个台站的参数
% output
%      Disdep:  震源距层顶距离
%      LayerNum: 震源所在层
% input
%      deep：每层的界面深度
%      Sdep：初定位震源深度

%计算震源距层顶距离
DisDeep  = Sdep- deep(1);
        SLayerNum = 1;
for l=2:length(deep)
%如震源深度小于速度模型中某层，那么震源在该层的上一层
if (Sdep < deep(l))
Disdep  = Sdep - deep(l-1);
%计算震源所在层
                SLayerNum = l-1;
break;
end%End IF    
end%End FOR
%如果震源深度大于速度模型中最深层，计算震源距层顶距离和所在层
if Sdep > deep(length(deep)) 
Disdep  = Sdep - deep(length(deep));
            SLayerNum = length(deep);
end%End IF
% End FUNCTION

function [SeiTakeoff,Azi]=getangle(speed,deep,FirLocal,SLayerNum,lon,lat,Disdep,SubDel)
%计算震源所在层的入射角
% output
%      SeiTakeoff: 震源到台站的入射角（使用迭代方法求出近似值）
% input
%      speed：各层速度
%      deep：速度模型的界面深度
%      Firlocal：修订后震源参数（第一次计算为初定位震源参数）
%      SLayerNum：震源所在层
%      lon：台站经度
%      lat：台站纬度
%      Disdep：距层顶距离
%      SubDel：系统参数（离源角迭代时，小于该值迭代结束）

%根据震中参数计算震中距
        X=lon-FirLocal(1);
        Y=lat-FirLocal(2);
        Dist = sqrt(X^2 + Y^2);  %计算震中距
        Azi=atan2(X,Y);   %求出方位角,与正北方向的夹角
%计算迭代最大角
        MaxTakeoff = atan(Dist/Disdep);
%计算迭代最小角
        MinTakeoff = atan(Dist/(FirLocal(3)-deep(1)));  
%理论上应该是FirLocal(3),但有时有台站高程，考虑台站高程时需要考虑
%计算入射角初值
        SeiTakeoff = (MaxTakeoff + MinTakeoff)/2;
%根据入射角和速度模型，计算震中距
        NewDist = getdisk(speed,deep,SeiTakeoff,SLayerNum,Disdep);
%迭代求出入射角（逼近到系统设置值迭代结束）
while (abs(NewDist - Dist) > SubDel)  
%根据震中距（NewDist和Dist）计算入射角
if Dist > NewDist
               MinTakeoff = SeiTakeoff;
elseif Dist < NewDist
               MaxTakeoff = SeiTakeoff;
end%End IF
           SeiTakeoff = (MaxTakeoff + MinTakeoff)/2;

%根据新的入射角，重新计算震中距
           NewDist = getdisk(speed,deep,SeiTakeoff,SLayerNum,Disdep);

%如大角等于小角，迭代结束
if (MinTakeoff == MaxTakeoff)
break;
end% End IF    
%如大角与小角差值小于SubDel*(10^(-10))，迭代结束
if(abs(MinTakeoff - MaxTakeoff)< SubDel*(10^(-10)))
break;
end%End IF
end%End WHILE   
% End FUNCTION    
function ModelTime = gettime(speed,deep,takeoff,SLayerNum,Disdep)
%计算台站走时
% output
%      ModelTime：台站走时
% input
%      speed：各层速度
%      deep：速度模型的界面深度
%      angle：入射角
%      SLayerNum：震源所在层
%      Disdep：震源距层顶距离

%计算震源所在层的走时
        ModelTime = Disdep/(cos(takeoff)*speed(SLayerNum)); %（6-7-9）式
%计算震源在各层中走时之和（震源到台站的走时）
for l=SLayerNum-1:-1:1
            cosAngle = sqrt(1 - (speed(l)*sin(takeoff)/speed(SLayerNum))^2);   %（6-7-8）第一式
            ModelTime = ModelTime + (deep(l+1)-deep(l))/(cosAngle*speed(l));    %（6-7-9）式
end%End FOR
function [Pntime,takeoff]=PnTraveltime(speed,deep,Delta,SLayerNum,Disdep)
%计算首波临界距离，假定最后一层为地幔顶部
       m=length(speed);
       Delta0=0;
for l=SLayerNum+1:m-1    %震源层下面的传播
         Delta0=Delta0+2*(deep(l+1)-deep(l))*tan(asin(speed(l)/speed(m)));         
end
      takeoff=asin(speed(SLayerNum)/speed(m));   %求得成为首波的离源角
Delta0=Delta0+(2*((deep(SLayerNum+1)-deep(SLayerNum)))-Disdep)*tan(takeoff); %震源层传播的水平距离
for l=SLayerNum-1:-1:1   %震源层上面的传播
        Delta0=Delta0+(deep(l+1)-deep(l))*tan(asin(speed(l)/speed(m)));
end
if(Delta<Delta0)Pntime=0;return;end
      Pntime=0;
for l=SLayerNum+1:m-1    %震源层下面的传播
         Pntime=Pntime+2*(deep(l+1)-deep(l))/(speed(l)*cos(asin(speed(l)/speed(m))));
end
      Pntime=Pntime+(2*((deep(SLayerNum+1)-deep(SLayerNum)))-Disdep)/(speed(SLayerNum)*cos(takeoff)); %震源层的传播
for l=SLayerNum-1:-1:1   %震源层上面的传播
        Pntime=Pntime+(deep(l+1)-deep(l))/(speed(l)*cos(asin(speed(l)/speed(m))));
end
      Pntime=Pntime+(Delta-Delta0)/speed(m);
return

function  ModelDelta = getdisk(speed,deep,takeoff,SLayerNum,Disdep)
% output
%      ModelDelta：震中距
% input
%      speed：速度模型中各层速度
%      deep：震源深度
%      takeoff：离源角
%      SLayerNum：震源所在层
%      Disdep：距层顶距离

%计算地震波在，发震层走的距离
        ModelDelta = Disdep*tan(takeoff);  %（6-7-11）式
%计算地震波在各层中走的距离之和（震中距）
for l=SLayerNum-1:-1:1
            tanAngle = sin(takeoff)/sqrt((speed(SLayerNum)/speed(l))^2 - (sin(takeoff))^2);   %(6-7-8)第二式
            ModelDelta = ModelDelta + (deep(l+1)-deep(l))*tanAngle;   %（6-7-11）式
end%End FOR
