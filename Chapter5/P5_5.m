%P5_5.m
fai=0:0.01:2*pi;    %角度旋转360度
beta=3.8;    %S波速度
c=0.9194*beta;   %Rayleigh波相速度
f=0.2;    %频率为0.2Hz，对应的周期为5秒
w=2*pi*f;    %角频率
k=w/c;       %波数
N=100;    %所用的时间点数
filename='Rayleigh.gif'; %给出存放动画文件的文件名
for ii=1:N
    t=(ii-1)*0.5;   %时间点
for z=0:2:20     %深度循环
   kz=k*z;      
   uxa=exp(-0.8475*kz)-0.5773*exp(-0.3933*kz);   %根据(5-2-25)计算x方向分量的相对值
   uza=-0.8475*exp(-0.8475*kz)+1.4679*exp(-0.3933*kz);  %根据(5-2-25)计算y方向分量的相对值
   zux=uxa*cos(fai);zuz=uza*sin(fai);   %将x方向和y方向的位移合成位矢量
   for x=0:30   %波传播方向的循环
      ux=uxa*sin(w*t-k*x);  %根据(5-2-25)计算x方向分量的相对值
      uz=uza*cos(w*t-k*x);  %根据(5-2-25)计算y方向分量的相对值
      plot(zux+x,zuz+z,'b-',x+ux,z+uz,'r.');  %绘制质点运动路径及轨迹    
   hold on
   end
end        
plot(xlim,[0,0],'k-','lineWidth',2);  %绘制地平线
set(gca,'Ydir','reverse','box','on');  %将z轴改为向下为正
axis equal     %使坐标轴相等，这样可以看出椭圆的正确形状
text(31,0,'地表')   %给出地表的标志
axis([-1,31,-1,20]);     %给出x轴和z轴的范围
xlabel('波传播距离x/km');    %加x轴的标记
ylabel('深度/km');    %加y轴的标记
title('Rayleigh波的质点运动轨迹模拟')
f=getframe(gcf); % 捕获画面
imind=frame2im(f);   
[imind,cm] = rgb2ind(imind,256);
   if ii==1
        imwrite(imind,cm,filename,'gif', 'Loopcount',inf,'DelayTime',0.05); %采用延迟时间为0.05秒写入给定的文件
    else
        imwrite(imind,cm,filename,'gif','WriteMode','append','DelayTime',0.1); %采用延迟时间为0.1秒写入给定的文件
   end
hold off      %下次绘图时清除原来的图形
end
