%P5_20.m
L=2.0;   %弦的长度为2m
c=0.5;   %波的传播速度假定为0.5m/s
Nmode=100;   %采用最初的100个振型进行叠加
dx=0.02;   %空间间隔
x=0:dx:L;    %所求的弦上的坐标点
Nx=length(x);   %空间坐标的点数
dt=0.025;    %时间间隔
t=0:dt:40;    %所求的时间点，要求持续时间为40s
Nt=length(t);   %时间坐标的点数
tau=0.02;    %震源的持续时间
Xs=0.8;    %源放置的位置
u=zeros(Nt,Nx);   %开辟一个数据
for n=1:Nmode    %对于所有振型叠加的循环
    NPIL=n*pi/L;    
    SNXs=sin(NPIL*Xs);  %震源项sin(n*pi*xs/L)
    Wn=n*pi*c/L;    %振型的频率
    SNXr=sin(NPIL*x);   %sin(n*pi*x/L)
    Space=SNXr*SNXs*exp(-(Wn*tau/2)^2);  %在空间的变化因子
    u=u+[cos(Wn*t)]'*Space;   %采用矩阵相乘的方式得到位移的叠加,公式（）    
    %得到的位移的行为时间序列，列为空间序列
end
filename='summation.gif';    %定义空间图像随时间变化的播放文件
h=plot(x,u(1,:));     %绘制空间位置分布
xlabel('X/m')      %给x轴加标记
ylim([-20 20]);    %固定y轴上下限
for ii=1:Nt    %对所有的时间点循环，由此看到图像随时间的变化
    set(h,'Ydata',u(ii,:));   %显示当前文件的数据
    f = getframe(gcf);   %获得当前的图像
    imind=frame2im(f);  %将frame格式变为图像（image）的格式，imind为图像文件
    [imind,cm] = rgb2ind(imind,256);   
    %将RGB图像文件imind转换为编号图像
    if ii==1    %第一次循环
        imwrite(imind,cm,filename,'gif', 'Loopcount',inf,'DelayTime',0.05);
         %将开始的一帧图像写入文件，格式为gif，延迟时间为0.05秒
    else
        imwrite(imind,cm,filename,'gif','WriteMode','append','DelayTime',0.1);
        %在原来文件后面添加一帧图像，延迟时间为0.1秒
    end
end
figure(2)
subplot(2,1,1)   %第一个子图
plot(t',u(:,50));    %绘制空间第50个点处能够记录的位移振动图
xlabel('时间/s');ylabel('位移/m');  %加上轴标记
subplot(2,1,2)   %第二个子图
[vpsd,f]=pwelch(u(:,50),length(t),0,length(t),1/dt); %按照采样间隔,采用Welch方法进行功率谱密度估计
%Pwelch的调用方式为[Pxx,f] = pwelch(x,window,noverlap,nfft,fs)
%x为数据，window为窗长度，noverlap为重叠点数，nfft为进行fft采用的点数,fs为采样间隔，输出Pxx为功率谱密度，f为对应的频率
%参看相应的数字信号处理书籍
plot(f,vpsd);   %将估计的密度谱绘制出来
 hold on   %图形保持
 plot(c/2/L*[1;1]*[1:40],[ylim]'*ones(1,40),'y');   %绘制每个谐振频率的位置
 xlim([0,5])    %固定显示的x轴范围
 xlabel('频率/Hz'); ylabel('功率谱密度');   %加上轴标记
