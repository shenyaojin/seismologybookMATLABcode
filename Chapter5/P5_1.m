%P5_1.m
%tanh(x)函数
plot([-10:0.1:10],tanh([-10:0.1:10]))   %绘制tanh(x)函数
hold on   %图形保持，使得后面的绘图基于前面绘图的基础之上
plot([0 0],ylim,'k');    %绘制y轴
grid on   %加上网格
xlabel('x');ylabel('y');   %给定x轴和y轴的标记
title('y=tanh(x)')    %给定标题	
