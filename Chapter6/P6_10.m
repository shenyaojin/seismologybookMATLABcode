%P6_10.m
close all
h0=12;% 地震深度
epi=100; %震中距
v=[2.0,2.5,3.0,3.8,4.5,5.0,7.5];%地壳模型的各层速度
deep=[0,1,3,10,15,23,33,35]; %地壳模型的各层界面深度
moholayer=7;   %第7个界面为moho面
figure(1)  %给出射线路径
x=[-5,epi];nlength=2;   %给出绘图中震中距的范围
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
plot(0,h0,'p')
%求出地震所在的层和地震距震源层顶部的距离dz
dz  = h0 - deep(1);
SLayerNum = 1;
for l=2:length(deep)
%如震源深度小于速度模型中某层，那么震源在该层的上一层
if (h0 < deep(l))
dz  = h0 - deep(l-1);
%计算震源所在层
        SLayerNum = l-1;
break;
end%End IF    
end%End FOR
%如果震源深度大于速度模型中最深层，计算震源距层顶距离和所在层
if h0 > deep(length(deep)) 
dz  = h0 - deep(length(deep));
       SLayerNum = length(deep);
end%End IF
xx=[];
  tt=[];
for ii=2:3:45
  h=h0;x=0;
thetaj=deg2rad(ii);
thick=(deep(SLayerNum+1)-deep(SLayerNum)-dz);
dx=thick*tan(thetaj);
%震中距的初始值为震源层的的水平距离
plot([x,x+dx],[h,h0+thick],'w-','LineWidth',1)
h=h0+thick;
  x=x+dx;
  t=thick/(cos(thetaj)*v(SLayerNum));  %在该层中的地震波走时
for l=SLayerNum+1:moholayer-1    %下行波传播
    SinThetajl=v(l)/v(SLayerNum)*sin(thetaj);
if(SinThetajl>1) 
        error('不能穿过该层介质，请缩小模拟的最大离源角') 
end
    cosThetajl =sqrt(1-SinThetajl*SinThetajl);
tanThetajl = SinThetajl/cosThetajl;   %(6-7-8)
thick=deep(l+1)-deep(l);
    dx = thick*tanThetajl;  %地震波传播到的横向距离，根据（6-7-11）
plot([x,x+dx],[h,h+thick],'w-','LineWidth',1)
    x=x+dx;
    h=h+thick;   %对称波传播到的深度
    t = t + thick/(cosThetajl*v(l));   %地震波走时(6-7-10)
end
for l=moholayer-1:-1:1   %震源层上面的传播
SinThetajl=v(l)/v(SLayerNum)*sin(thetaj);
cosThetajl =sqrt(1-SinThetajl*SinThetajl);
tanThetajl = SinThetajl/cosThetajl;   %(6-7-8)
thick=deep(l+1)-deep(l);
    dx = thick*tanThetajl;  %地震波传播到的横向距离，根据（6-7-11）
plot([x,x+dx],[h,h-thick],'w-','LineWidth',1)
    x=x+dx;
    h=h-thick;   %对称波传播到的深度
    t = t + thick/(cosThetajl*v(l));   %地震波走时(6-7-10)
end
xx=[xx,x];
tt=[tt,t];
end
set(gca,'Ydir','reverse','box','on') %使得y轴方向并在四周加上框
%将当前绘图的y轴方向反向，使得符合深度大在下部的情况，并且将右边和上边均加上框
xlabel('震中距/km')   %加x轴的标记
ylabel('深度/km')    %加y轴的标记
figure(2)
plot(xx,tt,'-*');
xlabel('震中距/km')
ylabel('走时/s')
