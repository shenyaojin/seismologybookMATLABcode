%P5_19.m
c=3;  %���������ٶ�
L=10;   %�ҵĳ���
N=100;    %���õ�ʱ�����
x=0:0.1:L;      %x������
subplot(2,2,1);
plot1=plot(x,zeros(size(x)),'-');grid on
axis([0,10,-1,1]);   %�̶����귶Χ
subplot(2,2,2);
plot(5,0,'o');   %���ƽڵ�
hold on;
plot2=plot(x,zeros(size(x)),'-');grid on;
axis([0,10,-1,1]);   %�̶����귶Χ
subplot(2,2,3);
plot([3.3,6.67],zeros(1,2),'o');   %���ƽڵ�
hold on; 
plot3=plot(x,zeros(size(x)),'-');grid on
axis([0,10,-1,1]);   %�̶����귶Χ
subplot(2,2,4);
hold on;  plot([2.5,5,7.5],zeros(1,3),'o');   %���ƽڵ�
plot4=plot(x,zeros(size(x)),'-');grid on

axis([0,10,-1,1]);   %�̶����귶Χ
n=0;  %����,�ı��ֵ����ģ�ⲻͬ������
w1=c*pi/L;   %��ɢ��Ƶ��(5-8-9)ʽ
w2=c*2*pi/L;   %��ɢ��Ƶ��(5-8-9)ʽ
w3=c*3*pi/L;   %��ɢ��Ƶ��(5-8-9)ʽ
w4=c*4*pi/L;   %��ɢ��Ƶ��(5-8-9)ʽ
for ii=1:N
    t=(ii-1)*0.1;   %ʱ���
    y1=cos(w1*t)*sin(w1*x/c);    %��(5-8-10)��ʵ����������
    y2=cos(w2*t)*sin(w2*x/c);    %��(5-8-10)��ʵ����������
    y3=cos(w3*t)*sin(w3*x/c);    %��(5-8-10)��ʵ����������
    y4=cos(w4*t)*sin(w4*x/c);    %��(5-8-10)��ʵ����������
    set(plot1,'xdata',x,'ydata',y1);
    set(plot2,'xdata',x,'ydata',y2);
    set(plot3,'xdata',x,'ydata',y3);
    set(plot4,'xdata',x,'ydata',y4);
    drawnow;
end
