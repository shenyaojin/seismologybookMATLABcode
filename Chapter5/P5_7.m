%P5-7.m
kz=0:0.01:10;   %波数和深度的乘积
kcl=kz/2/pi;   %z/lamada
uamp=exp(-0.8475*kz)-0.5773*exp(-0.3933*kz);   %根据(5-2-25)第一式求得水平相对振幅
zamp=-0.8475*exp(-0.8475*kz)+1.4679*exp(-0.3933*kz);  %根据(5-2-25)第二式垂直相对振幅
plot(uamp,kcl,'-',zamp,kcl,':')   %绘制垂直和水平振幅随z/lamada的变化
legend('水平分量','垂直分量','Location','southeast')   %加图例
hold on   %图形保持，保留原来的绘图
plot([0 0],ylim,'k')   %绘制y轴
set(gca,'Ydir','reverse')  %将y轴方向反向
xlabel('相对振幅')   %x轴的标记
ylabel('z/\Lambda')   %y轴的标记
