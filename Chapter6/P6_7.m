%P6_7.m
h=8;vp1=5;vs1=vp1/1.732;vp2=7;vs2=vp2/1.732;H=30;%地震的深度、P波和S波的速度以及地壳厚度
i0p=asin(vp1/vp2);i0s=asin(vs1/vs2);   %产生首波的折射角
delta0p=(2*H-h)*vp1/sqrt(vp2^2-vp1^2);   %按（6-7-4）式计算Pn的临界距离
delta0s=(2*H-h)*vs1/sqrt(vs2^2-vs1^2);   %按（6-7-4）式计算Sn的临界距离
deltamax=max(delta0p,delta0s);           %绘制曲线选择最小的临界距离
x=deltamax:1:500;    %震中距
tpn=(2*H-h)*cos(i0p)/vp1+x./vp2;    %按（6-7-3）式的Pn波的走时计算
tsn=(2*H-h)*cos(i0s)/vs1+x./vs2;   %按（6-7-3）式的Sn波的走时计算
plot(x,tpn,'r',x,tsn,'b:')                   %绘制走时曲线
xlabel('震中距/km')   %x轴加上必要的标记
ylabel('走时/s')           %y轴加上必要的标记
legend('Pn波','Sn波','location','NorthWest')   %加图例
