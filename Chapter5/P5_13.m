%P5_13.m
load wenchuan.ur;
dt=0.25;   %数据的采样间隔
D=17*111.199;    %这里采用的17度的震中距转换为km
ts=425;   %估计的面波起始计算时刻
te=649.75;   %面波的结束时间
figure(1)
plot(wenchuan(:,1),wenchuan(:,3));hold on;plot([1 1]*ts,ylim,'r-');   %绘出面波在地震图中的位置
VPoint=[D/te:0.01:D/ts];      %根据面波的起始时间和终止时间得到求解群速度的范围,并以0.1进行划分
v=D./wenchuan(:,1);
TPoint=[10:0.01:40];   %根据观测的周期变化范围估计所求的周期范围 
s=[wenchuan(:,3)]';   %将地震图变为横向排列
[GroupVImg,PVG]=GroupVelocity1S(s,dt,D,TPoint,VPoint,v); %调用上面的子程序
 figure(2);  %绘图
 axft=axes('Position',[0.35 0.10 0.55 0.80]);   %绘制振幅随周期和群速度分布的坐标轴位置
 minamp = min(min((GroupVImg)));%找到整个矩阵的最小值
 imagesc(TPoint,VPoint,GroupVImg,[minamp,1]);  %以周期为横坐标、速度为纵坐标，绘制群速度随周期和速度分布的二维图
 set(gca,'YDir','normal');   %设置Y轴的方向为正常
 xlabel('周期/s', 'FontSize', 10, 'FontWeight', 'bold');  %给出横轴标记，字体大小为10，字体粗细属性为粗体
 ylabel('群速度/km.s^-^1', 'FontSize', 10, 'FontWeight', 'bold'); %给出纵轴标记，字体大小为10，字体粗细属性为粗体
axseis=axes('Position',[0.10 0.10 0.15 0.80]);
t=ts:dt:te;    %所做面波频散的时间段
plot(axseis,wenchuan(ts/dt:te/dt,3),wenchuan(ts/dt:te/dt,1))    %绘制时域波形图
set(axseis,'YDir','reverse')       %设置Y轴反向显示
ylabel('时间/s')            %加时间标记
xlabel('振幅')              %加振幅标记
 figure(3)
 P=min(PVG(:,1)):0.1:max(PVG(:,1));   %给出内插的周期序列
 VG=interp1(PVG(:,1),PVG(:,2),P,'spline');   %采用测量群速度和周期的对应点和样条插值给出平滑曲线数据
 plot(P,VG,PVG(:,1),PVG(:,2),'o')   %绘制得到的频散曲线
 legend('内插群速度','测量点','location','NorthWest')    %加图例
 xlabel('周期/s', 'FontSize', 10, 'FontWeight', 'bold');  %给出横轴标记，字体大小为10，字体粗细属性为粗体
 ylabel('群速度/km.s^-^1', 'FontSize', 10, 'FontWeight', 'bold'); %给出纵轴标记，字体大小为10，字体粗细属性为粗体
