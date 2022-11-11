%P6_5.m
h=8;vs=3;vp=5;   %设置震源深度，S波和P波的速度
x=0:1:20;   %震中距
tp=x/vp.*sqrt(1+(h./x).^2);   %按（6-7-1）式计算Pg波走时
ts=x/vs.*sqrt(1+(h./x).^2);   %按（6-7-1）式计算Sg波走时
tpa=x./vp;   %震中距较大时的Pg波走时的渐近线
tsa=x./vs;  %震中距较大时的Pg波走时的渐近线
plot(x,tp,'b',x,ts,'r:',x,tpa,'b-.',x,tsa,'r--')   %绘制P波和S波走时曲线及其渐近线
legend('P波','S波','P波渐近线','S波渐近线','location','NorthWest')   %加图例
xlabel('震中距/km') %加x轴的标记
ylabel('走时/s')   %加y轴的标记
set(gca,'box','on') %加上图形框
