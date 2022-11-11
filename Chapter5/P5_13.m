%P5_13.m
load wenchuan.ur;
dt=0.25;   %���ݵĲ������
D=17*111.199;    %������õ�17�ȵ����о�ת��Ϊkm
ts=425;   %���Ƶ��沨��ʼ����ʱ��
te=649.75;   %�沨�Ľ���ʱ��
figure(1)
plot(wenchuan(:,1),wenchuan(:,3));hold on;plot([1 1]*ts,ylim,'r-');   %����沨�ڵ���ͼ�е�λ��
VPoint=[D/te:0.01:D/ts];      %�����沨����ʼʱ�����ֹʱ��õ����Ⱥ�ٶȵķ�Χ,����0.1���л���
v=D./wenchuan(:,1);
TPoint=[10:0.01:40];   %���ݹ۲�����ڱ仯��Χ������������ڷ�Χ 
s=[wenchuan(:,3)]';   %������ͼ��Ϊ��������
[GroupVImg,PVG]=GroupVelocity1S(s,dt,D,TPoint,VPoint,v); %����������ӳ���
 figure(2);  %��ͼ
 axft=axes('Position',[0.35 0.10 0.55 0.80]);   %������������ں�Ⱥ�ٶȷֲ���������λ��
 minamp = min(min((GroupVImg)));%�ҵ������������Сֵ
 imagesc(TPoint,VPoint,GroupVImg,[minamp,1]);  %������Ϊ�����ꡢ�ٶ�Ϊ�����꣬����Ⱥ�ٶ������ں��ٶȷֲ��Ķ�άͼ
 set(gca,'YDir','normal');   %����Y��ķ���Ϊ����
 xlabel('����/s', 'FontSize', 10, 'FontWeight', 'bold');  %���������ǣ������СΪ10�������ϸ����Ϊ����
 ylabel('Ⱥ�ٶ�/km.s^-^1', 'FontSize', 10, 'FontWeight', 'bold'); %���������ǣ������СΪ10�������ϸ����Ϊ����
axseis=axes('Position',[0.10 0.10 0.15 0.80]);
t=ts:dt:te;    %�����沨Ƶɢ��ʱ���
plot(axseis,wenchuan(ts/dt:te/dt,3),wenchuan(ts/dt:te/dt,1))    %����ʱ����ͼ
set(axseis,'YDir','reverse')       %����Y�ᷴ����ʾ
ylabel('ʱ��/s')            %��ʱ����
xlabel('���')              %��������
 figure(3)
 P=min(PVG(:,1)):0.1:max(PVG(:,1));   %�����ڲ����������
 VG=interp1(PVG(:,1),PVG(:,2),P,'spline');   %���ò���Ⱥ�ٶȺ����ڵĶ�Ӧ���������ֵ����ƽ����������
 plot(P,VG,PVG(:,1),PVG(:,2),'o')   %���Ƶõ���Ƶɢ����
 legend('�ڲ�Ⱥ�ٶ�','������','location','NorthWest')    %��ͼ��
 xlabel('����/s', 'FontSize', 10, 'FontWeight', 'bold');  %���������ǣ������СΪ10�������ϸ����Ϊ����
 ylabel('Ⱥ�ٶ�/km.s^-^1', 'FontSize', 10, 'FontWeight', 'bold'); %���������ǣ������СΪ10�������ϸ����Ϊ����
