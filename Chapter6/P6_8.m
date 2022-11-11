%P6_8.m
%模拟地震波直达波走时和震中距及路径
v=[2.0,2.5,3.0,3.8,4.5,5.0,7.5];%地壳模型的各层速度
deep=[0,1,3,10,15,23,33,35]; %地壳模型的各层界面深度
figure(1)  %给出射线路径
x=[-5,140];nlength=length(x);
vcolor=[];
deep1=[];
for ii=1:length(v)
    deep1=[deep1,deep(ii),deep(ii+1)];  %两个界面所夹的层为均匀层具有相同的速度
    vcolor=[vcolor;ones(1,nlength)*v(ii);ones(1,nlength)*v(ii)];
end
pcolor(x,deep1,vcolor);   %绘制速度结构
colorbar    %加上色标
annotation('textbox',[0.80,0.894,0.5,0.1],'linestyle','none','String','速度/km.s^-^1') 
hold on%图形保持，使得后面的绘图在此基础上
h0=22;% 地震深度
plot(0,h0,'p')
%求出地震所在的层和地震距震源层顶部的距离Dz
Dz  = h0;
SLayerNum = 1;
for l=2:length(deep)
%如震源深度小于速度模型中某层，那么震源在该层的上一层
if (h0 < deep(l))
Dz  = h0 - deep(l-1);
%计算震源所在层
        SLayerNum = l-1;
break;
end%End IF    
end%End FOR
%如果震源深度大于速度模型中最深层，计算震源距层顶距离和所在层
if h0 > deep(length(deep)) 
Dz  = h0 - deep(length(deep));
       SLayerNum = length(deep);
end%End IF
  xx=[];   %震中距数组
  tt=[];   %走时数据
for x=10:10:140
%计算迭代离源角的最大值
        Maxthetaj = atan(x/Dz);
%计算迭代离源角的最小角
        Minthetaj = atan(x/h0);
        thetaj= (Maxthetaj + Minthetaj)/2; %计算入射角初值
%根据新的入射角和速度模型，重新计算震中距
        EpiDis=Dz*tan(thetaj);
for l=SLayerNum-1:-1:1
           tanThetajl = sin(thetaj)/sqrt((v(SLayerNum)/v(l))^2 - (sin(thetaj))^2);   %(6-7-7)的第二式
            EpiDis= EpiDis + (deep(l+1)-deep(l))*tanThetajl;  %地震波传播到的横向距离，根据(6-7-10)
end
%迭代求出入射角（逼近到系统设置值迭代结束）
while (abs(EpiDis - x) > 1.0e-3)  
%根据震中距计算入射角
if x > EpiDis
               Minthetaj = thetaj;
elseif x < EpiDis
               Maxthetaj = thetaj;
end
thetaj = (Maxthetaj + Minthetaj)/2;      
%根据新的入射角，重新计算震中距
           EpiDis=Dz*tan(thetaj);
for l=SLayerNum-1:-1:1
            tanThetajl = sin(thetaj)/sqrt((v(SLayerNum)/v(l))^2 - (sin(thetaj))^2);   %(6-7-7)的第二式
            EpiDis= EpiDis + (deep(l+1)-deep(l))*tanThetajl;  %地震波传播到的横向距离，根据(6-7-10)
end
%如大角与小角差值小于10E-10，迭代结束
if(abs(Minthetaj - Maxthetaj)<10e-10)
break;   %退出迭代
end
end%WHILE循环结束
%找到了最优的离源角，按照该角即可射到地震台站
h1=h0;x1=0;
sinthetaj=sin(thetaj);
  x=x1+Dz*tan(thetaj);
%震中距的初始值为地震波在震源层传播的水平距离
h=h1-Dz;
  plot([x1,x],[h1,h],'w-')
  x1=x;h1=h;
  t=Dz/(cos(thetaj)*v(SLayerNum));
%走时的初始值为震源层的的水平距离
for l=SLayerNum-1:-1:1
tanThetajl = sinthetaj/sqrt((v(SLayerNum)/v(l))^2 - (sinthetaj)^2);   %(6-7-7)第二式
            cosThetajl =  sqrt(1-( v(l)* sinthetaj/v(SLayerNum))^2); %(6-7-7)式第一式
            x = x1 + (deep(l+1)-deep(l))*tanThetajl;  %地震波传播到的横向距离，根据(6-7-10)
            h=h1-(deep(l+1)-deep(l));   %地震波传播到的深度
plot([x1,x],[h1,h],'w-')
            x1=x;   h1=h;
            t = t + (deep(l+1)-deep(l))/(cosThetajl*v(l));   %地震波走时(6-7-9)
end
        xx=[xx,x];
        tt=[tt,t];
end
  set(gca,'Ydir','reverse','box','on') %使得y轴方向并在四周加上框
%将当前绘图的y轴方向反向，使得符合深度大在下部的情况，并且将右边和上边均加上框
xlabel('震中距/km')   %加x轴的标记
ylabel('深度/km')    %加y轴的标记
figure(2) %给出直达波的走时曲线
plot(xx,tt,'-*');
xlabel('震中距/km')
ylabel('走时/s')
