%p6_2.m
v10=2;v20=3;H1=4;  % The speed is from 2km/s on the surface to 3km/s at a depth of 4km, and the layer thickness is 4km, increasing by 0.25km/s per kilometer
b1=(v20-v10)/H1;
v11=v20;v21=5;H2=2;  % The speed is from 3km/s to 5km/s, and the speed increases by 1km/s per kilometer. This layer is a speed-changing zone
b2=(v21-v11)/H2;
v12=v21;v22=8;H3=12;  % The speed is from 5km/s to 8km/s, and the speed per kilometer increases by 0.25km/s
b3=(v22-v12)/H3;
x=[0,60];
v=[];
for z=0:15
if(z<=H1)
    v=[v;ones(1,2)*v10+b1*z];
elseif(z>H1&z<=(H2+H1))
    v=[v;ones(1,2)*(v11+b2*(z-H1))];
elseif(z>(H2+H1)&z<=(H1+H2+H3))
    v=[v;ones(1,2)*(v21+b3*(z-(H1+H2)))];
end
end
figure(1)
pcolor(x,[0:15],v);   %plot the valocity distribution
fig1=gca;
shading interp % using interpolation to make the shade looking better
colorbar
annotation('textbox',[0.80,0.894,0.5,0.1],'linestyle','none','String','velocity/km.s^-^1') 
% Add mark to the colorbar
hold on
h=0.1;
xall0=0;tall0=0;p0=0.5;
for p=0.5:-0.02:0.15
xall=0;tall=0;
dx=zeros(1,300);dt=dx;
for ii=1:300
    z=ii*h;
if(z<=H1)
        u1=1/(v10+b1*(z-h));
        u2=1/(v10+b1*z);
elseif(z>H1&z<=(H2+H1))
        u1=1/(v11+b2*(z-(H1+h)));
        u2=1/(v11+b2*(z-H1));
elseif(z>(H2+H1)&z<=(H1+H2+H3))
        u1=1/(v21+b3*(z-(h+H1+H2)));
        u2=1/(v21+b3*(z-(H1+H2)));
end
if(p>=u1)break;end
    [dx(ii),dt(ii),irtr]=layertx(p,h,u1,u2);
tall=tall+dt(ii);
figure(1)
plot([xall,xall+dx(ii)],[z-h z],'w');
xall=xall+dx(ii);
end
for jj=ii-1:-1:1
    z=jj*h;
tall=tall+dt(jj);
figure(1)
plot([xall,xall+dx(jj)],[z z-h],'w');
xall=xall+dx(jj);
set(gca,'Ydir','reverse','box','on')
axis([0,60,0,15])
hold on
end
figure(2)
plot([xall0,xall],[tall0,tall]);  %绘制走时-震中距曲线
hold on
%end
figure(3)
plot([p0,p],[xall0 xall],'-');  %绘制p参数和震中距曲线
hold on
figure(4)
plot([xall0,xall],[tall0-p0*xall0,tall-p*xall],'-');  %绘制震中距-折合走时曲线
hold on
figure(5)
plot([tall0-p0*xall0,tall-p*xall],[p0,p],'-');  %绘制tau-p曲线
hold on

xall0=xall;tall0=tall;p0=p;
end
figure(1)
xlabel('震中距/km')  %x轴标记
ylabel('深度/km')   %y轴标记
figure(2)
text(18,7.4853,'焦散点','rotation',45)
text(7.5,4.5,'焦散点','rotation',45)
text(8,2.9,'顺行','rotation',45)
text(25,7.5,'顺行','rotation',30)
text(14,6.8,'逆行','rotation',45)
xlabel('震中距/km')  %x轴标记
ylabel('走时/s')   %y轴标记
figure(3)
text(0.17,10,'焦散点')
text(0.31,20,'焦散点')
text(0.15,30,'顺行','rotation',-60);
text(0.38,12,'顺行','rotation',-45);
text(0.24,15,'逆行')
xlabel('p/s.km^-1')  %x轴标记
ylabel('震中距/km') %y轴标记
figure(4)
text(18,1.6,'焦散点')
text(7,3.5,'焦散点')
text(25,4,'顺行','rotation',30);
text(7,0.5,'顺行','rotation',40);
text(14,2.3,'逆行')
xlabel('震中距/km')  %x轴标记
ylabel('\tau/s')   %y轴标记
figure(5)
text(0.5,0.47,'顺行','rotation',-30)
text(1.5,0.31,'逆行','rotation',-30)
text(3.9,0.2,'顺行','rotation',-30)
xlabel('\tau/s')  %x轴标记
ylabel('p/s.km^-^1')   %y轴标记
