%p1_6.m
%绘制PREM模型的波速、密度、弹性常数、压力和重力
load premmodel.dat   %加载PREM模型数据
subplot(2,3,1)  %绘制P,S波速度结构
plot(premmodel(:,2)/1000,(6371-premmodel(:,1)),'b',premmodel(:,3)/1000,(6371-premmodel(:,1)),'r:')
legend('P波速度','S波速度')%加上图例
set(gca,'YDir','reverse')  
%gca为得到当前的坐标轴（Get Current Axis的缩写），YDir为Y轴的方向，本句使y轴的方向反向，默认的向上为正，现在改为向下为正
ylabel('深度/km');   %加上Y轴的标记
xlabel('速度/km.s^-^1') %加上X轴的标记,注意，^表示后面的字符为上标
subplot(2,3,2)    %绘制密度分布
plot(premmodel(:,4),(6371-premmodel(:,1)),'b')
set(gca,'YDir','reverse')  %使Y轴反向
ylabel('深度/km'); %加上Y轴的标记
xlabel('密度/kg.m^-^3') %加上X轴的标记,注意，^表示后面的字符为上标
subplot(2,3,3)    %绘制弹性常数
plot(premmodel(:,5)/1000,(6371-premmodel(:,1)),'b',premmodel(:,6)/1000,(6371-premmodel(:,1)),'r:')
legend('Ks','\mu')  %加上图例，注意\mu给出的是希腊字母的μ
set(gca,'YDir','reverse')  %使Y轴反向
ylabel('深度/km');%加上Y轴的标记
xlabel('弹性常数/GPa')   %加上X轴的标记
subplot(2,3,4)   %绘制地下压力
plot(premmodel(:,8),(6371-premmodel(:,1))) 
set(gca,'YDir','reverse')%使Y轴反向
ylabel('深度/km');   %加上Y轴的标记
xlabel('压力/GPa')%加上X轴的标记
subplot(2,3,5)    %绘制重力分布
plot(premmodel(:,9),(6371-premmodel(:,1)))
set(gca,'YDir','reverse')%使Y轴反向
ylabel('深度/km');%加上Y轴的标记
xlabel('重力/m.s^-^2') %加上X轴的标记，注意，^表示后面的字符为上标
