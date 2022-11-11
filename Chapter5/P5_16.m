%P5_16.m
close all
load wenchuan.ur;
dt=0.25;   %���ݵĲ������
D=10*111.199;    %������õ�10�ȵ����о�ת��Ϊkm
ts=259;   %�沨����ʼ����ʱ��
figure(1)
plot(wenchuan(:,1),wenchuan(:,2));hold on;plot([1 1]*ts,ylim,'r-');   %����沨�ڵ���ͼ�е�λ��
t=wenchuan(:,1);   %�����ʱ������
te=400;   %�Ӳ����Ͽ�400����Ϊ�沨�Ľ���
VPoint=[D/te:0.01:D/ts];      %�����沨����ʼʱ�����ֹʱ��õ����Ⱥ�ٶȵķ�Χ,����0.1���л���
VImgPt = length(VPoint); %��Ҫ������ٶȳ���
v=D./wenchuan(:,1);
TPoint=[10:0.01:40];   %���ݹ۲�����ڱ仯��Χ������������ڷ�Χ 
WaveNumPt=size(wenchuan(:,1),1);  %���ݵĳ���
s=[wenchuan(:,2)]'.* [tukeywin(length([wenchuan(:,2)]'), 0.2)]';   %�������˥������,����0.2��ָ�����½���ռ�ܴ����İٷֱ�;
fs=1/dt;   %����Ƶ��
NumCtrT = length(TPoint); %Ⱥ�ٶȵĵ���
%Filter Parameter
Bw=1/TPoint(1)-1/TPoint(2);    %Ƶ�����
Order=1500;   %�˲����Ľ���
KaiserPara = 6;   %���󴰲���
phaseImage = zeros(NumCtrT, WaveNumPt);  %����������ͼ��ľ���
for ii = 1:NumCtrT    %��һ��ĳһ���ڽ��м���
    F_low = 1/TPoint(ii)-Bw/2;   %��Ƶ�Ĺ�һ��Ƶ��
    F_high =1/TPoint(ii)+Bw/2;   %��Ƶ�Ĺ�һ��Ƶ��
      %��fir1��������ƴ�����
    b= fir1(Order, [F_low, F_high]*2/fs, kaiser(Order+1,KaiserPara));  %����Kaiser�����FIR�˲���
    FilteredWave=filtfilt(b,1,[s,zeros(1,2*Order)]);   %����ǰ��ͺ����ϵ��˲�У����λ�ӳ�
    %��������ݺ�����˽�������������������ߴ������˲�����
    PhaseImg(1:WaveNumPt,ii) = FilteredWave(1:WaveNumPt); %���˲�������ݸ�����λ��ͼ��
    PhaseImg(1:WaveNumPt,ii) = PhaseImg(1:WaveNumPt,ii)/max(abs(PhaseImg(1:WaveNumPt,ii)));   %�����ݽ��й�һ��
end
PhaseVImg = zeros(VImgPt, NumCtrT);
for ii = 1:NumCtrT
    TravPtV = D./t(2:end);         %�����õ����ٶ�
    PhaseVImg(1:VImgPt, ii) = interp1(TravPtV, PhaseImg(2:WaveNumPt,ii),VPoint, 'spline');    %���ٶȽ��в�ֵ
    PhaseVImg(1:VImgPt, ii) = PhaseVImg(1:VImgPt, ii)/max(abs(PhaseVImg(1:VImgPt, ii)));   %�Բ�ֵ���ֵ���й�һ��
end
figure(2)
axft=axes('Position',[0.35 0.10 0.55 0.80]);   %������������ں�Ⱥ�ٶȷֲ���������λ��
imagesc(TPoint, VPoint, PhaseVImg,[-1 1]);    %��������Ϊ�����꣬�ٶ�Ϊ�������ͼ
 set(gca,'YDir','normal','FontSize', 8, 'FontWeight', 'bold','FontName','Arial');
xlabel('����/s', 'FontSize', 8, 'FontWeight', 'bold','FontName','Arial');
ylabel('���ٶ�/km.s^-^1', 'FontSize', 8, 'FontWeight', 'bold','FontName','Arial'); 
axseis=axes('Position',[0.10 0.10 0.15 0.80]);
t=ts:dt:te;    %�����沨Ƶɢ��ʱ���
plot(axseis,wenchuan(ts/dt:te/dt,2),wenchuan(ts/dt:te/dt,1))    %����ʱ����ͼ
set(axseis,'YDir','reverse')       %����Y�ᷴ����ʾ
ylabel('ʱ��/s')            %��ʱ����
xlabel('���')              %��������
