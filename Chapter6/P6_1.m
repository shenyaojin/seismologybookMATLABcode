%P6_1.m
v10=2;v20=7;H=30;  %Velocity from 2km/s(Surface) to 7km/s(Mantle)
b=(v20-v10)/H;    %The slope
x=[0,60];    %There're two points
v=[];
for z=0:15   
%得到16*2的速度分布图象，其中在横向上是均匀的，纵向随深度而变化
    v=[v;ones(1,2)*(v10+b*z)];
end
figure(1)
pcolor(x,[0:15],v);   
shading interp
colorbar;
annotation('textbox',[0.80,0.894,0.5,0.1],'linestyle','none','String','Velocity/km.s^-^1') 
hold on;
xall0=0;tall0=0;   %绘制走时曲线需要的初始点
p0=0.5;   %p starts from 0.5
for p=0.5:-0.01:0.25
%calculate ray parameter in a loop
maxz=(1-p*v10)/b/p;  %p参数对应的大小深度
maxlayer=50;      %将穿透的地壳深度分为50层
z=linspace(0,maxz,maxlayer);  %将层分成均匀的
h=z(2)-z(1);     %所分层的厚度
z1=z(1:maxlayer-1);  %所有层的顶部深度
z2=z(2:maxlayer);   %所有层的底部深度
xall=0;tall=0;     %总的震中距和走时从初始的零开始累加
u1=1./(v10+b*z1);u2=1./(v10+b*z2);   %所有层的顶层慢度
dx=zeros(1,2*maxlayer-1); dt=dx; %所有层的震中距，初始设置为零
figure(1)
for ii=1:maxlayer-1   %对每一层分别进行循环计算
    [dx(ii),dt(ii),irtr]=layertx(p,h,u1(ii),u2(ii));   
%调用layertx函数，每个参数得到走时和震中距。这里将每层震中距增量存盘，以便在计算对称的射线折返上升时用
    plot([xall,xall+dx(ii)],[z1(ii) z2(ii)],'w'); %采用白色绘制每层中的射线路径
    xall=xall+dx(ii);  %下一层的震中距开始为上一层震中距的结束
tall=tall+dt(ii);
end
text(xall,z2(ii),num2str(p));
for ii=maxlayer-1:-1:1  %将原来计算的震中距用在对称的折返路径上
    plot([xall,xall+dx(ii)],[z2(ii) z1(ii)],'w');  %用白色绘制每层中的射线路径
    xall=xall+dx(ii); %下一层的震中距开始为上一层震中距的结束
tall=tall+dt(ii);
end
set(gca,'Ydir','reverse','box','on')
figure(2)
plot([xall0,xall],[tall0,tall],'.-');
hold on
figure(3)
plot([p0,p],[xall0,xall],'.-');
xall0=xall;
tall0=tall;
p0=p;
hold on
end

figure(1)
axis([0,60,0,15]) 
xlabel('Epicenter distance/km') 
ylabel('Depth/km') 
figure(2)
xlabel('Epicenter distance/km')
ylabel('Travel Time/s')  
figure(3)
xlabel('p/s.km^-^1')  
ylabel('Epicenter distance/km')
