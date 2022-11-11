%P6_11.m
h=30;vp=5;w=15;   %震源距界面距离、P波速度及界面倾斜角度
x=0:1:60;    %震中距
tup=sqrt(x.*x+4*h*h-4*h*x*sind(w))/vp;  %按照（6-8-1）式计算接收点在上坡的反射P波走时
tdown=sqrt(x.*x+4*h*h+4*h*x*sind(w))/vp;  %按照（6-8-1）式计算接收点在下坡的反射P波走时
th=sqrt(x.*x+4*h*h)/vp;   %按照（6-7-2）式计算接收点在下坡的反射P波走时
plot(x,tup,'b-.',x,tdown,'r:',x,th,'b')  %绘制P波走时曲线
xlabel('震中距/km') %加x轴的标记
ylabel('走时/s')   %加y轴的标记
set(gca,'box','on') %加上图形框
grid on;   %加上坐标网格
legend('上坡P波走时','下坡P波走时','平界面P波走时','location','NorthWest')   %加图例

