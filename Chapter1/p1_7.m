%p1_7.m
%绘制PREM模型的球层分布的速度
load wanprem.txt    %加载PREM模型
r=6371-wanprem(:,1);   %地球半径,6371为地球半径，减去层的深度得到每层的半径
vp=wanprem(:,2);   %与P波半径对应的P波速度
figure(1)  %第一个图形绘制P波速度
sph_vel_plot(r,vp);  %调用速度结构参数绘制球形分布的速度
annotation('textbox',[0.80,0.894,0.2,0.05],'linestyle','none','String','速度/km.s^-^1') 
%在色标上加上标记
%以下S波的计算程序按照P波速度绘制进行理解
figure(2)  %绘制S波速度
vs=wanprem(:,3);
sph_vel_plot(r,vs);  %调用速度结构参数绘制球形分布的速度
annotation('textbox',[0.80,0.894,0.2,0.05],'linestyle','none','String','速度/km.s^-^1') 
%在色标上加上标记
