%P5_11.m
close all
load wenchuan.ur;   %加载地震波数据，第一列为时间，第二列为第一个台的垂直向记录，第三列为第二个台的垂直向记录
dt=0.25;   %数据的采样间隔
D1=10*111.199;    %第一个台站的震中距，转换为km
D2=17*111.199;    %第二个台站的震中距，转换为km
D21=D2-D1;      %；两个台之间的距离
t210=0;     %面波地震图的起始时间差别
ts1=259;    %第一个地震图的面波的大致起始时间
TPoint=[10:0.01:40];   %根据观测的周期变化范围估计所求的周期范围 
s1=[wenchuan(fix(ts1/dt):end,2)]';  %第一个台的垂直向地震图，所截取的时间域第二个地震图相同
s2=[wenchuan(fix(ts1/dt):end,3)]'; %第二个台的垂直向地震图
figure(1)
subplot(2,1,1),plot(wenchuan(:,1),wenchuan(:,2));   %绘出面波在地震图中的位置
xlabel('时间/s');ylabel('垂直位移');
subplot(2,1,2),plot(wenchuan(:,1),wenchuan(:,3));   %绘出面波在地震图中的位置
xlabel('时间/s');ylabel('垂直位移');
[PVG]=move_windowS2(s1,s2,dt,D21,t210,TPoint);   %%调用函数进行群速度提取
figure(2)
b=fir1(200,0.01);   %为消除求解的面波频散曲线的不光滑，设计200阶的低通FIR滤波器
Z=filtfilt(b,1,PVG(:,2));    %采用FIR滤波器对得到的频散曲线前向和后向的滤波
plot(PVG(:,1),Z,'-',PVG(:,1),PVG(:,2),'o');   %绘出得到的频散曲线和测量点的值
legend('内插群速度','测量点','location','NorthWest')    %加图例
xlabel('周期/s', 'FontSize', 10, 'FontWeight', 'bold');  %给出横轴标记，字体大小为10，字体粗细属性为粗体
ylabel('群速度/km.s^-^1', 'FontSize', 10, 'FontWeight', 'bold'); %给出纵轴标记，字体大小为10，字体粗细属性为粗体
