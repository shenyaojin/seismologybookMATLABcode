%P6_6.m
h=8;H=30;vs=3;vp=vs*sqrt(3);   %地震深度、地壳厚度、S波速度及P波速度
x=0:1:200;    %震中距
tpmp=sqrt(x.*x+(2*H-h)*(2*H-h))/vp;  %按照（6-7-2）式计算PmP波走时
tsms=sqrt(x.*x+(2*H-h)*(2*H-h))/vs; %按照（6-7-2）式计算SmS波走时
tpa=x/vp;
tsa=x/vs;
plot(x,tpmp,'b',x,tsms,'r:',x,tpa,'b-.',x,tsa,'r--')  %绘制P波和S波走时曲线
xlabel('震中距/km') %加x轴的标记
ylabel('走时/s')   %加y轴的标记
set(gca,'box','on') %加上图形框
ylim([0 70])    %给定Y轴的上下限
legend('PmP波','SmS波','PmP渐近线','SmS渐近线','location','NorthWest')   %加图例