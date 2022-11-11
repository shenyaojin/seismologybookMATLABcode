%P6_12.m
vp1=5;vp2=7;h=30;%地壳和地幔P波速度以及震源距界面的距离
w=15;  %Moho面的倾斜角度
i0p=asin(vp1/vp2);  %根据Snell定律求出i0
x=100:1:500;    %震中距
Pnh=2*h*cos(i0p)/vp1+x./vp2;    %按（6-7-3）式的Pn波的走时计算
Pnup=(2*h*sin(i0p)+x*sin(i0p-deg2rad(w)))/vp1;  %根据（6-8-2）计算接收点在上坡的Pn波走时
Pndown=(2*h*sin(i0p)+x*sin(i0p+deg2rad(w)))/vp1;  %根据（6-8-2）计算接收点在下坡的Pn波走时
plot(x,Pnup,'b-.',x,Pndown,'r:',x,Pnh,'b')                   %绘制走时曲线
xlabel('震中距/km')   %x轴加上必要的标记
ylabel('走时/s')           %y轴加上必要的标记
set(gca,'box','on') %加上图形框
legend('上坡Pn波','下坡Pn波','平界面Pn波','location','NorthWest')   %加图例
