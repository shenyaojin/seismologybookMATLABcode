%P5_17.m
close all
load wenchuan.ur;
dt=0.25;   %���ݵĲ������
D21=7*111.199;    %��̨վ���Ϊ7�ȣ�ת��Ϊkm
ts1=209; ts2=372.5;  %�沨����ʼ����ʱ��
t21=ts2-ts1;     %�沨����ͼ����ʼʱ����
figure(1)
subplot(2,1,1),plot(wenchuan(:,1),wenchuan(:,2));hold on;plot([1 1]*ts1,ylim,'r-');   %����沨�ڵ���ͼ�е�λ��
subplot(2,1,2),plot(wenchuan(:,1),wenchuan(:,3));hold on;plot([1 1]*ts2,ylim,'r-');   %����沨�ڵ���ͼ�е�λ��
y2=[wenchuan(ts2/dt:end,3);]';   %��Զ��̨վ�ĵ���
N=length(y2);
if(rem(N,2)==0)   N=N+1; y2=[y2,0]; end    %ʹ�����ݳ���Ϊ����������ʹ�ô�����
y1=[wenchuan(ts1/dt:end,2)]';    %�Ͻ���̨վ�ĵ���
N1=length(y1);
if(N1<N)  y1=[y1,zeros(1,N-N1)];   end     %ʹ���������ݵĳ������

TPoint=[10:0.1:40];   %���ݹ۲�����ڱ仯��Χ������������ڷ�Χ 
NumCtrT = length(TPoint); %��ȡ���ڵĵ���
PhaseImg = zeros(N,NumCtrT);  %����������ͼ��ľ���
Clags=zeros(NumCtrT,2*N-1);
h=0.001;   %խ���˲���������Ӧ��Ʋ���
for ii = 1:NumCtrT    %��һ��ĳһ���ڽ��м���
    WinLen=round(TPoint(ii)/dt*5);
    if(rem(WinLen,2)==0) WinLen=WinLen+1; end 
    WinLen2=floor(WinLen/2);
    t=[-WinLen2:WinLen2]*dt;    %��������Ӧ��ʱ��
    Win=sin(2*pi*h*t)./(pi*t+eps).*cos(2*pi*t/TPoint(ii)).*cos(pi*t/(10*TPoint(ii)));   %խ���˲�����������Ӧ
    FilteredWave1=filtfilt(Win,1,[zeros(1,WinLen),y1,zeros(1,WinLen)]);   %����ǰ��ͺ����ϵ��˲�У����λ�ӳ�
    FilteredWave2=filtfilt(Win,1,[zeros(1,WinLen),y2,zeros(1,WinLen)]);   %����ǰ��ͺ����ϵ��˲�У����λ�ӳ�
    [xycorr,Clags(ii,1:2*N-1)]=xcorr(FilteredWave2(WinLen+1:N+WinLen),FilteredWave1(WinLen+1:N+WinLen),N-1);
     PhaseImg(1:N,ii) = xycorr(N:2*N-1); %���˲�������ݸ�����λ��ͼ��
end
figure(2)
VP=D21./(t21+[0:N-1]*dt);
colormap gray
pcolor(TPoint,VP,PhaseImg)
shading interp
set(gca,'YDir','normal')
xlabel('����/s', 'FontSize', 10, 'FontWeight', 'bold');  %���������ǣ������СΪ10�������ϸ����Ϊ����
ylabel('���ٶ�/km.s^-^1', 'FontSize', 10, 'FontWeight', 'bold'); %���������ǣ������СΪ10�������ϸ����Ϊ����
Pmax=max(max(PhaseImg));   %�ҵ�������������ֵ
[m,n]=find(PhaseImg==Pmax);     %�ҵ��������ֵ����Ӧ�����
PTV=[TPoint(n),VP(m)];    %���������󣬸þ���������ں����ٶ�ֵ
SearchWid=70;     %�����Ŀ��
for ii=NumCtrT-1:-1:1
    if((m-SearchWid)<1)  N1=1;else N1=m-SearchWid; end     %�Ͻ���
    if((m+SearchWid)>N)  N2=N;else N2=m+SearchWid; end    %�½���
    [m,n]=find(PhaseImg(N1:N2,ii)==max(PhaseImg(N1:N2,ii)));   %�ҵ�ǰһ��������Χ�е����ֵ���������
    PTV=[PTV;TPoint(ii),VP(N1+m-1)];    %����������ŷ��õ�PTV��
end
hold on
plot(PTV(:,1),PTV(:,2),'wp')    %�����ҵ������ٶ������ڵı仯
xlabel('����/s', 'FontSize', 10, 'FontWeight', 'bold');  %���������ǣ������СΪ10�������ϸ����Ϊ����
ylabel('���ٶ�/km.s^-^1', 'FontSize', 10, 'FontWeight', 'bold'); %���������ǣ������СΪ10�������ϸ����Ϊ����
figure(3)
%��������ͬ���ٶȵ����ڵ����ƽ��ֵ�ķ����ϲ�
PTV1=[];   %�������ں����ٶȶ�Ӧ������
vzall=0;
nv=0;
M=size(PTV,1);   %���������
for ii=2:M
        vzall=vzall+PTV(ii-1,1);   %�������һ�������ٶ��ۼ�
        nv=nv+1;
    if(PTV(ii,2)~=PTV(ii-1,2))
        PTV1=[PTV1;vzall/nv,PTV(ii-1,2)];   %����һ�����ݴ��̣��������ͬ�����ڣ���ȡ��ͬ�������ٶȵ�ƽ��ֵ
        nv=0;    %��һ�����ٶȺ����ڵ���ȡ��ʼ
        vzall=0;
    end
end
PTV1=[PTV1;PTV(M,:)];   %�����һ�����ݴ���
NN=size(PTV1,1);   %�õ�������ݵ��еĳ���
U=PTV1(1:NN-1,2)./(1+(PTV1(1:NN-1,1)./PTV1(1:NN-1,2)).*diff(PTV1(:,2))./diff(PTV1(:,1)));   %���ݹ�ʽ�õ�Ⱥ�ٶ�Ƶɢ����
b=fir1(50,0.01);   %Ϊ���������沨Ƶɢ���ߵĲ��⻬�����50�׵ĵ�ͨFIR�˲���
V=filtfilt(b,1,U);    %�Եõ���Ⱥ�ٶȽ����˲�
plot(PTV1(:,1),PTV1(:,2),'b',PTV1(1:NN-1,1),V,'k:')    %�õ��⻬��Ⱥ�ٶ�Ƶɢ����
legend('���ٶ�','Ⱥ�ٶ�','location','northwest');    %����ͼ��
xlabel('����/s', 'FontSize', 10, 'FontWeight', 'bold');  %���������ǣ������СΪ10�������ϸ����Ϊ����
ylabel('�ٶ�/km.s^-^1', 'FontSize', 10, 'FontWeight', 'bold'); %���������ǣ������СΪ10�������ϸ����Ϊ����
