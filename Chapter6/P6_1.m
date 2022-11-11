%P6_1.m
v10=2;v20=7;H=30;  %Velocity from 2km/s(Surface) to 7km/s(Mantle)
b=(v20-v10)/H;    %The slope
x=[0,60];    %There're two points
v=[];
for z=0:15   
%�õ�16*2���ٶȷֲ�ͼ�������ں������Ǿ��ȵģ���������ȶ��仯
    v=[v;ones(1,2)*(v10+b*z)];
end
figure(1)
pcolor(x,[0:15],v);   
shading interp
colorbar;
annotation('textbox',[0.80,0.894,0.5,0.1],'linestyle','none','String','Velocity/km.s^-^1') 
hold on;
xall0=0;tall0=0;   %������ʱ������Ҫ�ĳ�ʼ��
p0=0.5;   %p starts from 0.5
for p=0.5:-0.01:0.25
%calculate ray parameter in a loop
maxz=(1-p*v10)/b/p;  %p������Ӧ�Ĵ�С���
maxlayer=50;      %����͸�ĵؿ���ȷ�Ϊ50��
z=linspace(0,maxz,maxlayer);  %����ֳɾ��ȵ�
h=z(2)-z(1);     %���ֲ�ĺ��
z1=z(1:maxlayer-1);  %���в�Ķ������
z2=z(2:maxlayer);   %���в�ĵײ����
xall=0;tall=0;     %�ܵ����о����ʱ�ӳ�ʼ���㿪ʼ�ۼ�
u1=1./(v10+b*z1);u2=1./(v10+b*z2);   %���в�Ķ�������
dx=zeros(1,2*maxlayer-1); dt=dx; %���в�����о࣬��ʼ����Ϊ��
figure(1)
for ii=1:maxlayer-1   %��ÿһ��ֱ����ѭ������
    [dx(ii),dt(ii),irtr]=layertx(p,h,u1(ii),u2(ii));   
%����layertx������ÿ�������õ���ʱ�����оࡣ���ｫÿ�����о��������̣��Ա��ڼ���ԳƵ������۷�����ʱ��
    plot([xall,xall+dx(ii)],[z1(ii) z2(ii)],'w'); %���ð�ɫ����ÿ���е�����·��
    xall=xall+dx(ii);  %��һ������о࿪ʼΪ��һ�����о�Ľ���
tall=tall+dt(ii);
end
text(xall,z2(ii),num2str(p));
for ii=maxlayer-1:-1:1  %��ԭ����������о����ڶԳƵ��۷�·����
    plot([xall,xall+dx(ii)],[z2(ii) z1(ii)],'w');  %�ð�ɫ����ÿ���е�����·��
    xall=xall+dx(ii); %��һ������о࿪ʼΪ��һ�����о�Ľ���
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
