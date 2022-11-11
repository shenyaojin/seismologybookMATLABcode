%P5_16.m
close all
load wenchuan.ur;
dt=0.25;   %数据的采样间隔
D=10*111.199;    %这里采用的10度的震中距转换为km
ts=259;   %面波的起始计算时刻
figure(1)
plot(wenchuan(:,1),wenchuan(:,2));hold on;plot([1 1]*ts,ylim,'r-');   %绘出面波在地震图中的位置
t=wenchuan(:,1);   %地震的时间序列
te=400;   %从波形上看400基本为面波的结束
VPoint=[D/te:0.01:D/ts];      %根据面波的起始时间和终止时间得到求解群速度的范围,并以0.1进行划分
VImgPt = length(VPoint); %所要计算的速度长度
v=D./wenchuan(:,1);
TPoint=[10:0.01:40];   %根据观测的周期变化范围估计所求的周期范围 
WaveNumPt=size(wenchuan(:,1),1);  %数据的长度
s=[wenchuan(:,2)]'.* [tukeywin(length([wenchuan(:,2)]'), 0.2)]';   %设计余弦衰减窗口,其中0.2是指两个下降沿占总窗长的百分比;
fs=1/dt;   %采样频率
NumCtrT = length(TPoint); %群速度的点数
%Filter Parameter
Bw=1/TPoint(1)-1/TPoint(2);    %频带宽度
Order=1500;   %滤波器的阶数
KaiserPara = 6;   %凯泽窗参数
phaseImage = zeros(NumCtrT, WaveNumPt);  %构建包络线图像的矩阵
for ii = 1:NumCtrT    %逐一对某一周期进行计算
    F_low = 1/TPoint(ii)-Bw/2;   %低频的归一化频率
    F_high =1/TPoint(ii)+Bw/2;   %高频的归一化频率
      %用fir1函数来设计窗函数
    b= fir1(Order, [F_low, F_high]*2/fs, kaiser(Order+1,KaiserPara));  %采用Kaiser窗设计FIR滤波器
    FilteredWave=filtfilt(b,1,[s,zeros(1,2*Order)]);   %采用前向和后向结合的滤波校正相位延迟
    %这里的数据后均加了阶数个零来避免阶数过高带来的滤波问题
    PhaseImg(1:WaveNumPt,ii) = FilteredWave(1:WaveNumPt); %将滤波后的数据赋给相位的图像
    PhaseImg(1:WaveNumPt,ii) = PhaseImg(1:WaveNumPt,ii)/max(abs(PhaseImg(1:WaveNumPt,ii)));   %将数据进行归一化
end
PhaseVImg = zeros(VImgPt, NumCtrT);
for ii = 1:NumCtrT
    TravPtV = D./t(2:end);         %计算点得到的速度
    PhaseVImg(1:VImgPt, ii) = interp1(TravPtV, PhaseImg(2:WaveNumPt,ii),VPoint, 'spline');    %对速度进行插值
    PhaseVImg(1:VImgPt, ii) = PhaseVImg(1:VImgPt, ii)/max(abs(PhaseVImg(1:VImgPt, ii)));   %对插值后的值进行归一化
end
figure(2)
axft=axes('Position',[0.35 0.10 0.55 0.80]);   %绘制振幅随周期和群速度分布的坐标轴位置
imagesc(TPoint, VPoint, PhaseVImg,[-1 1]);    %采用周期为横坐标，速度为纵坐标绘图
 set(gca,'YDir','normal','FontSize', 8, 'FontWeight', 'bold','FontName','Arial');
xlabel('周期/s', 'FontSize', 8, 'FontWeight', 'bold','FontName','Arial');
ylabel('相速度/km.s^-^1', 'FontSize', 8, 'FontWeight', 'bold','FontName','Arial'); 
axseis=axes('Position',[0.10 0.10 0.15 0.80]);
t=ts:dt:te;    %所做面波频散的时间段
plot(axseis,wenchuan(ts/dt:te/dt,2),wenchuan(ts/dt:te/dt,1))    %绘制时域波形图
set(axseis,'YDir','reverse')       %设置Y轴反向显示
ylabel('时间/s')            %加时间标记
xlabel('振幅')              %加振幅标记
