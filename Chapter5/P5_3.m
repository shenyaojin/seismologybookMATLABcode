%P5_3.m
H=30;   %地壳的厚度为30km
vs1=3.6;vs2=4.6; %地壳和地幔的速度，单位km/s
miu21=1.8;   %剪切模量的比值
c=vs1:0.01:vs2;   %相速度序列
c2=c.*c;    %相速度的平方
sqc1=sqrt(c2/vs1/vs1-1);  % 
sqc2=sqrt(1-c2/vs2/vs2);   % 
atann=atan(miu21.*sqc2./sqc1);  % 
omiga0=c./(H*sqc1).*(atann);   %根据(5-1-15)计算基阶频率
omiga1=c./(H*sqc1).*(atann+1*pi);  %根据(5-1-15)计算一阶频率
omiga2=c./(H*sqc1).*(atann+2*pi);   %根据(5-1-15)计算二阶频率
omiga3=c./(H*sqc1).*(atann+3*pi);   %根据(5-1-15)计算三阶频率
figure(1)
semilogx(2*pi./omiga0,c,'-',2*pi./omiga1,c,':',2*pi./omiga2,c,'--',2*pi./omiga3,c,'-.')   %以半对数轴绘制频率、相速度曲线
legend('基阶', '一阶', '二阶', '三阶','location','northwest')   %加上图例
xlabel('周期/s');    %加x轴标记
ylabel('速度/km.s^-^1')   %加y轴标记
figure(2)    %第二幅图画板，绘制基阶、一阶、二阶的相对振幅随深度的分布
c=4.0;    %相速度
c2=c.*c;   %相速度的平方
sqc1=sqrt(c2/vs1/vs1-1);    % 
sqc2=sqrt(1-c2/vs2/vs2);     % 
atann=atan(miu21.*sqc2./sqc1);   % 
omiga0=c./(H*sqc1).*(atann+0*pi);    %根据(5-1-15)计算基阶频率
z1=[0:30];      %地壳深度范围
D0=cos((omiga0/c*sqc1).*z1);    %根据(5-1-23)的第一式计算基阶振型地壳中相对振幅
z2= [31:40];     %地幔范围      
D0=[D0,cos(omiga0/c*sqc1*H)*exp(-omiga0/c*sqc2*(z2-H))]; %根据(5-1-23)第二式计算基阶振型地幔的相对振幅
omiga1=c./(H*sqc1).*(atann+1*pi); %根据(5-1-15)计算一阶频率
D1=cos((omiga1/c*sqc1).*[0:30]); %根据(5-1-23)的第一式计算一阶振型地壳中相对振幅
D1=[D1,cos(omiga1/c*sqc1*H)*exp(-omiga1/c*sqc2*([31:40]-H))]; %根据根据(5-1-23)的第二式计算一阶振型地幔相对振幅
omiga2=c./(H*sqc1).*(atann+2*pi);  %根据(5-1-15)计算二阶频率
D2=cos((omiga2/c*sqc1).*[0:30]);  %根据(5-1-23)的第一式计算二阶振型地壳相对振幅
D2=[D2,cos(omiga2/c*sqc1*H)*exp(-omiga2/c*sqc2*([31:40]-H))]; %根据根据(5-1-23)的第二式计算二阶振型地幔相对振幅
fill([-1,1,1,-1,-1],[40,40,30,30,40],'y');    %将地幔涂为黄色
hold on   %图形保持
plot(D0,[z1,z2],'r-', D1,[z1,z2],'g:', D2,[z1,z2],'b-.');   
plot(0,11.1847,'go');    % 标出1阶的一个节点的深度位置
plot(0,6.4075,'bo'); plot(0,19.2219,'bo');   % 标出2阶的两个节点的深度位置

%绘制基阶、一阶、二阶的相对振幅
legend('地幔','基阶', '一阶', '二阶','location','NorthWest')   %绘制图例
plot([0,0],ylim,'k')    %绘制零线
set(gca,'Ydir','reverse')   %将y轴的显示反向，向下为正
xlabel('相对振幅')    %加x轴标记
ylabel('深度/km')   %加y轴标记
