%P5-6.m
kz=0;  %波数k和深度的乘积，取0为地表，随着深度增加kz至逐渐增大，振幅也逐渐减小
fai=0:0.01:2*pi;    %角度旋转360度
x=linspace(0,2*pi,100);    %将360度分为100等份
uxa=exp(-0.8475*kz)-0.5773*exp(-0.3933*kz);   %根据(5-2-25)计算x方向分量的相对值
uza=-0.8475*exp(-0.8475*kz)+1.4679*exp(-0.3933*kz);  %根据(5-2-25)计算y方向分量的相对值
zux=uxa*cos(fai);zuz=uza*sin(fai);   %将x方向和y方向的位移合成位矢量
N=length(x);  %x的数据个数
M = moviein(N);   %电影的帧数
for ii=1:N   %循环给出各帧图像
    ux=uxa*cos(x(ii));  %水平向投影   
    uz=uza*sin(x(ii));   %垂向投影
    plot(zux,zuz,'-',ux,uz,'o');  %绘制质点运动路径及轨迹
    axis equal   %使得坐标单位长度一致
    M(:,ii) = getframe;   %获得当前的图像
end
movie(M)    %播放各帧图像
