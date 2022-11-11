%P5_19_1.m
c=3;  %波传播的速度
L=10;   %弦的长度
N=100;    %所用的时间点数
x=0:0.1:L;      %x的坐标
w1=c*pi/L;   %离散的频率(5-8-8)式
w2=c*2*pi/L;   %离散的频率(5-8-8)式
w3=c*3*pi/L;   %离散的频率(5-8-8)式
w4=c*4*pi/L;   %离散的频率(5-8-8)式
subplot(2,2,1);
plot(x,sin(w1*x/c),'b-',x,0.707*sin(w1*x/c),'b-',x,0.315*sin(w1*x/c),'b-',x,0,'b-',x,-0.707*sin(w1*x/c),'b-',x,-0.315*sin(w1*x/c),'b-',x,-sin(w1*x/c),'b-');grid on
hold on
axis([0,10,-1,1]);   %固定坐标范围
xlabel('X轴');
subplot(2,2,2);
plot(x,sin(w2*x/c),'b-',x,0.707*sin(w2*x/c),'b-',x,0.315*sin(w2*x/c),'b-',x,0,'b-',x,-0.707*sin(w2*x/c),'b-',x,-0.315*sin(w2*x/c),'b-',x,-sin(w2*x/c),'b-');grid on
hold on;  plot(5,0,'o');   %绘制节点
axis([0,10,-1,1]);   %固定坐标范围
xlabel('X轴');
subplot(2,2,3);
plot(x,sin(w3*x/c),'b-',x,0.707*sin(w3*x/c),'b-',x,0.315*sin(w3*x/c),'b-',x,0,'b-',x,-0.707*sin(w3*x/c),'b-',x,-0.315*sin(w3*x/c),'b-',x,-sin(w3*x/c),'b-');grid on
hold on;  plot([3.3,6.67],zeros(1,2),'o');   %绘制节点
axis([0,10,-1,1]);   %固定坐标范围
xlabel('X轴');
subplot(2,2,4);
plot(x,sin(w4*x/c),'b-',x,0.707*sin(w4*x/c),'b-',x,0.315*sin(w4*x/c),'b-',x,0,'b-',x,-0.707*sin(w4*x/c),'b-',x,-0.315*sin(w4*x/c),'b-',x,-sin(w4*x/c),'b-');grid on
hold on;  plot([2.5,5,7.5],zeros(1,3),'o');   %绘制节点
axis([0,10,-1,1]);   %固定坐标范围
xlabel('X轴');
