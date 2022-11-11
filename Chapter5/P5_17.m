%P5_17.m
close all
load wenchuan.ur;
dt=0.25;   %数据的采样间隔
D21=7*111.199;    %两台站间距为7度，转换为km
ts1=209; ts2=372.5;  %面波的起始计算时刻
t21=ts2-ts1;     %面波地震图的起始时间差别
figure(1)
subplot(2,1,1),plot(wenchuan(:,1),wenchuan(:,2));hold on;plot([1 1]*ts1,ylim,'r-');   %绘出面波在地震图中的位置
subplot(2,1,2),plot(wenchuan(:,1),wenchuan(:,3));hold on;plot([1 1]*ts2,ylim,'r-');   %绘出面波在地震图中的位置
y2=[wenchuan(ts2/dt:end,3);]';   %较远处台站的地震波
N=length(y2);
if(rem(N,2)==0)   N=N+1; y2=[y2,0]; end    %使得数据长度为奇数，便于使用窗函数
y1=[wenchuan(ts1/dt:end,2)]';    %较近处台站的地震波
N1=length(y1);
if(N1<N)  y1=[y1,zeros(1,N-N1)];   end     %使得两种数据的长度相等

TPoint=[10:0.1:40];   %根据观测的周期变化范围估计所求的周期范围 
NumCtrT = length(TPoint); %求取周期的点数
PhaseImg = zeros(N,NumCtrT);  %构建包络线图像的矩阵
Clags=zeros(NumCtrT,2*N-1);
h=0.001;   %窄带滤波器脉冲响应设计参数
for ii = 1:NumCtrT    %逐一对某一周期进行计算
    WinLen=round(TPoint(ii)/dt*5);
    if(rem(WinLen,2)==0) WinLen=WinLen+1; end 
    WinLen2=floor(WinLen/2);
    t=[-WinLen2:WinLen2]*dt;    %窗函数对应的时间
    Win=sin(2*pi*h*t)./(pi*t+eps).*cos(2*pi*t/TPoint(ii)).*cos(pi*t/(10*TPoint(ii)));   %窄带滤波器的脉冲响应
    FilteredWave1=filtfilt(Win,1,[zeros(1,WinLen),y1,zeros(1,WinLen)]);   %采用前向和后向结合的滤波校正相位延迟
    FilteredWave2=filtfilt(Win,1,[zeros(1,WinLen),y2,zeros(1,WinLen)]);   %采用前向和后向结合的滤波校正相位延迟
    [xycorr,Clags(ii,1:2*N-1)]=xcorr(FilteredWave2(WinLen+1:N+WinLen),FilteredWave1(WinLen+1:N+WinLen),N-1);
     PhaseImg(1:N,ii) = xycorr(N:2*N-1); %将滤波后的数据赋给相位的图像
end
figure(2)
VP=D21./(t21+[0:N-1]*dt);
colormap gray
pcolor(TPoint,VP,PhaseImg)
shading interp
set(gca,'YDir','normal')
xlabel('周期/s', 'FontSize', 10, 'FontWeight', 'bold');  %给出横轴标记，字体大小为10，字体粗细属性为粗体
ylabel('相速度/km.s^-^1', 'FontSize', 10, 'FontWeight', 'bold'); %给出纵轴标记，字体大小为10，字体粗细属性为粗体
Pmax=max(max(PhaseImg));   %找到整个矩阵的最大值
[m,n]=find(PhaseImg==Pmax);     %找到矩阵最大值所对应的序号
PTV=[TPoint(n),VP(m)];    %将其放入矩阵，该矩阵放置周期和相速度值
SearchWid=70;     %搜索的宽度
for ii=NumCtrT-1:-1:1
    if((m-SearchWid)<1)  N1=1;else N1=m-SearchWid; end     %上界宽度
    if((m+SearchWid)>N)  N2=N;else N2=m+SearchWid; end    %下界宽度
    [m,n]=find(PhaseImg(N1:N2,ii)==max(PhaseImg(N1:N2,ii)));   %找到前一列搜索范围中的最大值，给出序号
    PTV=[PTV;TPoint(ii),VP(N1+m-1)];    %将给出的序号放置到PTV中
end
hold on
plot(PTV(:,1),PTV(:,2),'wp')    %绘制找到的相速度随周期的变化
xlabel('周期/s', 'FontSize', 10, 'FontWeight', 'bold');  %给出横轴标记，字体大小为10，字体粗细属性为粗体
ylabel('相速度/km.s^-^1', 'FontSize', 10, 'FontWeight', 'bold'); %给出纵轴标记，字体大小为10，字体粗细属性为粗体
figure(3)
%将具有相同相速度的周期点采用平均值的方法合并
PTV1=[];   %设置周期和相速度对应的数组
vzall=0;
nv=0;
M=size(PTV,1);   %矩阵的行数
for ii=2:M
        vzall=vzall+PTV(ii-1,1);   %如果周期一样，则将速度累加
        nv=nv+1;
    if(PTV(ii,2)~=PTV(ii-1,2))
        PTV1=[PTV1;vzall/nv,PTV(ii-1,2)];   %将上一行数据存盘，如果有相同的周期，则取相同周期相速度的平均值
        nv=0;    %下一个相速度和周期的求取开始
        vzall=0;
    end
end
PTV1=[PTV1;PTV(M,:)];   %将最后一行数据存入
NN=size(PTV1,1);   %得到获得数据的行的长度
U=PTV1(1:NN-1,2)./(1+(PTV1(1:NN-1,1)./PTV1(1:NN-1,2)).*diff(PTV1(:,2))./diff(PTV1(:,1)));   %根据公式得到群速度频散曲线
b=fir1(50,0.01);   %为消除求解的面波频散曲线的不光滑，设计50阶的低通FIR滤波器
V=filtfilt(b,1,U);    %对得到的群速度进行滤波
plot(PTV1(:,1),PTV1(:,2),'b',PTV1(1:NN-1,1),V,'k:')    %得到光滑的群速度频散曲线
legend('相速度','群速度','location','northwest');    %给出图例
xlabel('周期/s', 'FontSize', 10, 'FontWeight', 'bold');  %给出横轴标记，字体大小为10，字体粗细属性为粗体
ylabel('速度/km.s^-^1', 'FontSize', 10, 'FontWeight', 'bold'); %给出纵轴标记，字体大小为10，字体粗细属性为粗体
