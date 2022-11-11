%P5_18.m
dm=[35,1000];   %地层厚度
betam=[3.5,4.5];  %地层S波速度
roum=[2.7,3.3];   %地层密度
T=[5.0 6.0 7.0 8.0 9.0 10.0 11.0 12.0 13.0 14.0 15.0 16.0 17.0 18.0 19.0 20.0 22.0 24.0 26.0 28.0 30.0 32.0 34.0 37.0 40.0 43.0 47.0 50.0 60.0 80.0];
%周期
n=length(T);   %所计算的周期个数
vph=zeros(1,n);  %相速度数组
vgrp=vph;    %群速度数组
prea=min(betam); %最小S波速度
for ii=1:n   %对每层进行计算
omga=2*pi/T(ii);   %角频率
 %找到角频率所对应的相速度
vph(ii)=findroot(0.05,prea,omga,dm,betam,roum);  %求解频散方程(5-7-18)得到相速度的值
%使周期减去0.01秒计算对应的相速度
vpha=findroot(0.05,prea,2*pi/(T(ii)-0.01),dm,betam,roum);
%使周期增加0.01秒计算对应的相速度
vphb=findroot(0.05,prea,2*pi/(T(ii)+0.01),dm,betam,roum);
dcdt=(vphb-vpha)/0.02;  %相速度对时间的偏导数
vgrp(ii)=vph(ii)/(1.0+T(ii)/vph(ii)*dcdt); %根据公式(5-4-5)计算
end
[T' vph' vgrp']  %显示周期及对应的相速度和群速度的值
plot(T,vph,T,vgrp,':')  %绘制群速度和相速度曲线
legend('相速度','群速度')  %绘制图例
xlabel('周期/s');   %加上x轴标记
ylabel('速度/km.s^-^1')  %加上y轴标记
