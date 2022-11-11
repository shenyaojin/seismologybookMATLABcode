load LSA318.VHZ   %加载拉萨台第318天的记录
load LSA319.VHZ  %加载拉萨台第319天的记录
load LSA320.VHZ %加载拉萨台第320天的记录
load LSA321.VHZ %加载拉萨台第321天的记录
[m,n]=size(LSA318);   %下面是将拉萨台的记录做成一个矢量
nn=m*n;
b318=reshape(LSA318',nn,1);
[m,n]=size(LSA319);
nn=m*n;
b319=reshape(LSA319',nn,1);
[m,n]=size(LSA320);
nn=m*n;
b320=reshape(LSA320',nn,1);
[m,n]=size(LSA321);
nn=m*n;
b321=reshape(LSA321',nn,1);
b=[b318;b319;b320;b321];   %得到拉萨台的连续记录
[LSAZPxx,f] = psd(b,16384,0.1);   %以0.1HZ（10s）采用对连续数据进行功率谱估计
hold on
plot(f,LSAZPxx);   %绘出功率谱随频率的变化
xlim([ 1.5e-3 3e-3])   %给出频率轴的绘图范围
ylim([0 2.5e8])     %给出y轴显示的范围
%以下语句是绘出PREM模型的球型振荡的理论频率，用黄竖线和绿竖线表示并在图的顶端给出振型
plot(1.5783E-3*ones(1,2),ylim,'y'),text(1.5783E-3,2.6e8,'\fontsize{5}0\fontsize{10}S\fontsize{5}9');
plot(1.7266E-3*ones(1,2),ylim,'y'),text(1.7266E-3,2.6e8,'\fontsize{5}0\fontsize{10}S\fontsize{5}10');
plot(1.8660E-3*ones(1,2),ylim,'g') ,text(1.8652E-3,2.6e8,'\fontsize{5}2\fontsize{10}S\fontsize{5}7');
plot(1.9905E-3*ones(1,2),ylim,'y'),text(1.9905E-3,2.6e8,'\fontsize{5}0\fontsize{10}S\fontsize{5}12');
plot(2.1130E-3*ones(1,2),ylim,'y'),text(2.1130E-3,2.6e8,'\fontsize{5}0\fontsize{10}S\fontsize{5}13');
plot(2.2315E-3*ones(1,2),ylim,'y'),text(2.2315E-3,2.6e8,'\fontsize{5}0\fontsize{10}S\fontsize{5}14');
plot(2.3464E-3*ones(1,2),ylim,'y'),text(2.3464E-3,2.6e8,'\fontsize{5}0\fontsize{10}S\fontsize{5}15');
plot(2.4583E-3*ones(1,2),ylim,'y'),text(2.4583E-3,2.6e8,'\fontsize{5}0\fontsize{10}S\fontsize{5}16');
plot(2.5672E-3*ones(1,2),ylim,'y'),text(2.5672E-3,2.6e8,'\fontsize{5}0\fontsize{10}S\fontsize{5}17');
plot(2.6734E-3*ones(1,2),ylim,'y'),text(2.6734E-3,2.6e8,'\fontsize{5}0\fontsize{10}S\fontsize{5}18');
plot(2.7771E-3*ones(1,2),ylim,'y'),text(2.7771E-3,2.6e8,'\fontsize{5}0\fontsize{10}S\fontsize{5}19');
plot(2.8785E-3*ones(1,2),ylim,'y'),text(2.8785E-3,2.6e8,'\fontsize{5}0\fontsize{10}S\fontsize{5}20');
plot(2.9778E-3*ones(1,2),ylim,'y'),text(2.9778E-3,2.6e8,'\fontsize{5}0\fontsize{10}S\fontsize{5}21');
set(gca,'box','on')  %使绘图四面都有框
xlabel('频率/Hz')