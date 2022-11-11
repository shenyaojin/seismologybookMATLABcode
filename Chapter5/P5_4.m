%P5_4.m
H=30;   %地壳的厚度为30km
c=4.0;    %相速度
c2=c.*c;   %相速度的平方
vs1=3.6;vs2=4.6; %地壳和地幔的速度，单位km/s
miu21=1.8;   %剪切模量的比值
sqc1=sqrt(c2/vs1/vs1-1);    % 
sqc2=sqrt(1-c2/vs2/vs2);     % 
atann=atan(miu21.*sqc2./sqc1);   % 
omiga0=c./(H*sqc1).*(atann+1*pi);    %根据(5-1-15)计算角频率，改变0的值可以模拟不同振型随深度振动情况
%可以改变pi的倍数观看不同的振型在深部的振幅分布
k=omiga0/c;   %波数
N=100;    %所用的时间点数
cmap=colormap('jet');   %取得调色盘，采用不同的颜色表示不同深浅的振动
M=moviein(N);   %开辟一个数组
for ii=1:N
    t=(ii-1)*0.1;   %时间点
    hold off
    for z=0:3:30   %深度方向
        D=cos((omiga0/c*sqc1).*z);  %振动振幅
        cor=[];
        for x=0:0.5:60
        y=D*cos(omiga0*t-k*x);   %按（5-1-18）的实部计算位移随时间和空间的变化
        cor=[cor;x,y,z];   %放到数组中
        end
        Ind=ceil(z/30*64); if(Ind==0) Ind=1;end  %获得不同深度的颜色序号
        plot3(cor(:,1),cor(:,2),cor(:,3),'.-','Color',cmap(Ind,:))  %采用对应的颜色绘图
        hold on
    end
    set(gca,'Zdir','reverse')   %使得z轴反向
    grid on
    xlabel('X');ylabel('Y');zlabel('深度/km');   %给出各个轴的标记
    axis([0,60,-1,1,0,30]);   %固定坐标范围
    view(-91,-20);    %以一定的视角观察图形
    M(:,ii)=getframe;    %获得电影文件
end
movie(M)    %播放电影
