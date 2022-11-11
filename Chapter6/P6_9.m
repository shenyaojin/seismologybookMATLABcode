%P6_9.m
h0=12;% 地震深度
epi=130; %震中距
moholayer=7;   %Moho面的层号
v=[2.0,2.5,3.0,3.8,4.5,5.0,7.5];%地壳模型的各层速度
deep=[0,1,3,10,15,23,33,35]; %地壳模型的各层界面深度
figure(1)  %给出射线路径
x=[-10,140];nlength=2;   %给出绘图中震中距的范围
vcolor=[];
deep1=[];
for ii=1:length(deep)-1
    deep1=[deep1,deep(ii),deep(ii+1)];  %两个界面所夹的层为均匀层具有相同的速度
    vcolor=[vcolor;ones(1,nlength)*v(ii);ones(1,nlength)*v(ii)];
end
pcolor(x,deep1,vcolor);   %绘制速度结构
%caxis([min(v),max(v)]);
colorbar    %加上色标
annotation('textbox',[0.80,0.894,0.5,0.1],'linestyle','none','String','速度/km.s^-^1') 
hold on%图形保持，使得后面的绘图在此基础上
plot(0,h0,'p')
%求出地震所在的层和地震距震源层顶部的距离dz
dz = h0;
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
h1=h0;
x=epi;thetaj=asin(v(SLayerNum)/v(moholayer));     %根据(6-7-14)式
thick=2*(deep(SLayerNum+1)-deep(SLayerNum))-dz; %在震源层传播的总厚度
x0=thick*tan(thetaj); %震源层的地震波传播的水平距离总和
Pntime=thick/(v(SLayerNum)*cos(thetaj)); %根据（6-7-17）式计算
for l=SLayerNum+1:moholayer-1    %震源层下面的传播
thick= deep(l+1)-deep(l);
x0=x0+2*thick*tan(asin(v(l)/v(moholayer)));  %
  Pntime=Pntime+2*thick/(v(l)*cos(asin(v(l)/v(moholayer))));
end
for l=SLayerNum-1:-1:1   %震源层上面的传播
thick= deep(l+1)-deep(l);
  x0=x0+thick*tan(asin(v(l)/v(moholayer)));   %根据(6-7-16)式计算
  Pntime=Pntime+thick/(v(l)*cos(asin(v(l)/v(moholayer)))); %根据（6-7-17）式计算
end
if(x<x0)Pntime=0;exit;end
PnTim=[];
xx0=x0;
for epi=xx0:5:140
x=epi;thetaj=asin(v(SLayerNum)/v(moholayer));     %根据(6-7-14)式
thick=2*(deep(SLayerNum+1)-deep(SLayerNum))-dz; %在震源层传播的总厚度
x0=thick*tan(thetaj); %震源层的地震波传播的水平距离总和
Pntime=thick/(v(SLayerNum)*cos(thetaj)); %根据（6-6-17）式计算
for l=SLayerNum+1:moholayer-1    %震源层下面的传播
thick= deep(l+1)-deep(l);
x0=x0+2*thick*tan(asin(v(l)/v(moholayer)));  %
  Pntime=Pntime+2*thick/(v(l)*cos(asin(v(l)/v(moholayer))));
end
for l=SLayerNum-1:-1:1   %震源层上面的传播
thick= deep(l+1)-deep(l);
  x0=x0+thick*tan(asin(v(l)/v(moholayer)));   %根据(6-7-16)式计算
  Pntime=Pntime+thick/(v(l)*cos(asin(v(l)/v(moholayer)))); %根据（6-7-17）式计算
end
if(x<x0)Pntime=0;exit;end
Pntime=Pntime+(x-x0)/v(moholayer)   %根据（6-7-17）式计算
PnTim=[PnTim,Pntime];
xmoho=x-x0;
%绘出首波路径
h0=h1;
thick= deep(SLayerNum+1)-deep(SLayerNum)-dz;
xx=thick*tan(thetaj);
plot([0,xx],[h0,h0+thick],'w','LineWidth',2);
h0=h0+thick;
for l=SLayerNum+1:moholayer-1    %震源层下面的传播
thick=deep(l+1)-deep(l);
dx=thick*tan(asin(v(l)/v(moholayer)));
plot([xx,xx+dx],[h0,h0+thick],'w','LineWidth',2);
xx=xx+dx;  %震中距累加
  h0=h0+thick; 
end
plot([xx,xx+xmoho],[h0,h0],'w','LineWidth',2);
xx=xx+xmoho;
for l=moholayer-1:-1:1   %向上传播
thick=deep(l+1)-deep(l);  
dx=thick*tan(asin(v(l)/v(moholayer)));
plot([xx,xx+dx],[h0,h0-thick],'w','LineWidth',2);
  xx=xx+dx;   %根据(6-7-16)式计算
  h0=h0-thick;
end
set(gca,'Ydir','reverse','box','on') %使得y轴方向并在四周加上框
%将当前绘图的y轴方向反向，使得符合深度大在下部的情况，并且将右边和上边均加上框
pause
end
xlabel('震中距/km')   %加x轴的标记
ylabel('深度/km')    %加y轴的标记
figure(2)
plot(xx0:5:140,PnTim,'r-*');
xlabel('震中距/km')   %加x轴的标记
ylabel('走时/s')   %加y轴的标记
