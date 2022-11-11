%P5_9.m
dt=0.25;   %采样间隔
t=0:0.25:100;   %产生面波记录的时间段
x=chirp(t,0.05,50,0.1,'logarithmic');  %产生面波数据，使产生数据的频率从0.05HZ在50秒时达到0.1Hz
x=x(21:end);     %由于产生的数据不从零开始，我们去掉前面的20个数据
delta=10*111.199; %假定震中距为10度
t0=290;     %给出相对于发震时刻的延迟秒数
[m,N]=size(x);   %给出地震波的总长度为N
xmean=mean(x);
EPS=max(x)*1.0e-4;      %采用最大值的万分之一作为峰谷值的精度
Indx=find(abs(x-xmean)>EPS);   %找到超过峰谷值精度的序号，从第一个开始计算峰谷值
if(x(Indx(1)+1)>x(Indx(1))) Increase=1; else Increase=-1; end
T=[];   %设置一个空矩阵，用于放置找到的波峰和波谷的时间点和值的大小
for ii=1:N-1
    if(abs(x(ii+1)-xmean)<EPS) continue; end
    if((x(ii+1)-x(ii))*Increase<0)     %是否找到了峰谷点
        Increase=-1*Increase;    %如果原来为增加，现在改为减小，如果原来为减小，现在改为增加。
        T=[T;ii*dt,x(ii)];
    end
end
subplot(3,1,1),plot([1:N]*dt,x,'r',T(:,1),T(:,2),'o');     %绘制原始波形并将找到的波峰波谷点用圆圈标出
legend('地震波','峰谷点','location','NorthWest')   %加图例
text(100,0.8,'(a)');
M=size(T,1);   %得到T矩阵的行数
text(T(:,1),T(:,2),num2str([1:M]'))  %在图中给出测量的峰谷序号
xlim([min(T(:,1))-10,max(T(:,1))+10]) ; %设置能找到峰谷点的窗口显示范围
xlabel('时间/s');ylabel('位移')     %坐标轴加标记
subplot(3,1,2),plot([1:size(T,1)]',T(:,1),'o-')
text([1:M]',T(:,1),num2str([1:M]'))    %在图中给出测量的峰谷序号
text(24,90,'(b)');
xlabel('峰谷序号');ylabel('到时/s')  %坐标轴加标记
%计算地震波的周期和群速度
Period=diff(T(:,1))*2;    %峰谷之间的时间之差的2倍为周期
t1=t0+T(1:M-1,1);   %开始测量周期的时间
t2=t0+T(2:M,1);   %结束测量周期的时间
t=(t1+t2)/2;  %将两次测量的平均时间作为该周期波的到时
vg=delta./t;    %给出群速度，采用（）式计算
[Pascend,Ind] = sort(Period);   %将周期和群速度按降序排列
Y=[Pascend,vg(Ind)];    %将数据进行排列
PVG=[];   %设置周期和群速度对应的数组
vzall=0;
nv=0;
for ii=2:M-1
        vzall=vzall+Y(ii-1,2);   %如果周期一样，则将速度累加
        nv=nv+1;
    if(Y(ii,1)~=Y(ii-1,1))
        PVG=[PVG;Y(ii-1,1),vzall/nv];   %将上一行数据存盘，如果有相同的周期，则取相同周期群速度的平均值
        nv=0;    %下一个群速度和周期的求取开始
        vzall=0;
    end
end
PVG=[PVG;Y(M-1,:)];   %将最后一行数据存入
P=min(Period):0.1:max(Period);   %给出内插的周期序列
VG=interp1(PVG(:,1),PVG(:,2),P,'spline');   %采用测量群速度和周期的对应点和样条插值给出平滑曲线数据
subplot(3,1,3),plot(P,VG,'r-',PVG(:,1),PVG(:,2),'o')                %绘制群速度相对于周期的曲线
text(17.5,3.6,'(c)');
legend('内插群速度','测量点','location','SouthEast')    %加图例
%ylim([3.5 6.5])
xlabel('周期/s');    %加x轴的标记
ylabel('群速度/km.s^-^1');    %加y轴的标记
