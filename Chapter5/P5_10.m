%P5_10.m
close all;   %�ر����е�ͼ�δ���
clear all��    %������еı���
load wenchuan.ur;   %���ص������ݣ�%���е�һ��Ϊʱ�䣬�ڶ���Ϊ10��̨վ�Ĵ�ֱ������
dt=0.25;   %���ݵĲ������
D=10*111.199;    %������õ�10�ȵ����о�ת��Ϊkm
ts=259;   %�沨����ʼ����ʱ��
te=400;   %�Ӳ����Ͽ�400����Ϊ�沨�Ľ���
figure(1)   %��һ��ͼ��
plot(wenchuan(:,1),wenchuan(:,2));hold on;plot([1 1]*ts,ylim,'r-');   %����沨�ڵ���ͼ�е�λ��
xlabel('ʱ��/s'); ylabel('���')
s=[wenchuan(:,2)]';   %������ͼ��Ϊ��������
Ps=ts/dt;Pe=te/dt;
VPoint=D./[Ps:Pe]/dt;      %�����沨����ʼʱ�����ֹʱ��õ����Ⱥ�ٶȵķ�Χ,����0.1���л���
TPoint=[10:0.1:40];   %���ݹ۲�����ڱ仯��Χ������������ڷ�Χ 
[F,PVG]=move_windowS1(s,dt,D,VPoint,TPoint);
figure(2);  %�ڶ���ͼ��
axft=axes('Position',[0.35 0.10 0.55 0.80]);
imagesc(TPoint,VPoint,F) %,[minamp,1]);  %������Ϊ�����ꡢ�ٶ�Ϊ�����꣬����Ⱥ�ٶ������ں��ٶȷֲ��Ķ�άͼ\
set(gca,'YDir','normal');   %����Y��ķ���Ϊ����
xlabel('����/s', 'FontSize', 10, 'FontWeight', 'bold');  %���������ǣ������СΪ10�������ϸ����Ϊ����
ylabel('Ⱥ�ٶ�/km.s^-^1', 'FontSize', 10, 'FontWeight', 'bold'); %���������ǣ������СΪ10�������ϸ����Ϊ����
axseis=axes('Position',[0.10 0.10 0.15 0.80]);
t=[Ps:Pe]*dt;    %�����沨Ƶɢ��ʱ���
plot(axseis,wenchuan(Ps:Pe,2),wenchuan(Ps:Pe,1))    %����ʱ����ͼ
set(axseis,'YDir','reverse')       %����Y�ᷴ����ʾ
ylabel('ʱ��/s')            %��ʱ����
xlabel('���')              %��������
figure(3)                 %������ͼ��
P=min(PVG(:,1)):0.1:max(PVG(:,1));   %�����ڲ����������
VG=interp1(PVG(:,1),PVG(:,2),P,'spline');   %���ò���Ⱥ�ٶȺ����ڵĶ�Ӧ���������ֵ����ƽ����������
plot(P,VG,PVG(:,1),PVG(:,2),'o')   %���Ƶõ���Ƶɢ����
legend('�ڲ�Ⱥ�ٶ�','������','location','NorthWest')    %��ͼ��
xlabel('����/s', 'FontSize', 10, 'FontWeight', 'bold');  %���������ǣ������СΪ10�������ϸ����Ϊ����
ylabel('Ⱥ�ٶ�/km.s^-^1', 'FontSize', 10, 'FontWeight', 'bold'); %���������ǣ������СΪ10�������ϸ����Ϊ����
