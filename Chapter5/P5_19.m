%P5_19.m
c=3;  %波传播的速度
L=10;   %弦的长度
N=100;    %所用的时间点数
x=0:0.1:L;      %x的坐标
subplot(2,2,1);
plot1=plot(x,zeros(size(x)),'-');grid on
axis([0,10,-1,1]);   %固定坐标范围
subplot(2,2,2);
plot(5,0,'o');   %绘制节点
hold on;
plot2=plot(x,zeros(size(x)),'-');grid on;
axis([0,10,-1,1]);   %固定坐标范围
subplot(2,2,3);
plot([3.3,6.67],zeros(1,2),'o');   %绘制节点
hold on; 
plot3=plot(x,zeros(size(x)),'-');grid on
axis([0,10,-1,1]);   %固定坐标范围
subplot(2,2,4);
hold on;  plot([2.5,5,7.5],zeros(1,3),'o');   %绘制节点
plot4=plot(x,zeros(size(x)),'-');grid on

axis([0,10,-1,1]);   %固定坐标范围
n=0;  %阶数,改变此值可以模拟不同的振型
w1=c*pi/L;   %离散的频率(5-8-9)式
w2=c*2*pi/L;   %离散的频率(5-8-9)式
w3=c*3*pi/L;   %离散的频率(5-8-9)式
w4=c*4*pi/L;   %离散的频率(5-8-9)式
for ii=1:N
    t=(ii-1)*0.1;   %时间点
    y1=cos(w1*t)*sin(w1*x/c);    %按(5-8-10)的实部给出振型
    y2=cos(w2*t)*sin(w2*x/c);    %按(5-8-10)的实部给出振型
    y3=cos(w3*t)*sin(w3*x/c);    %按(5-8-10)的实部给出振型
    y4=cos(w4*t)*sin(w4*x/c);    %按(5-8-10)的实部给出振型
    set(plot1,'xdata',x,'ydata',y1);
    set(plot2,'xdata',x,'ydata',y2);
    set(plot3,'xdata',x,'ydata',y3);
    set(plot4,'xdata',x,'ydata',y4);
    drawnow;
end
