function [GroupVImg,PVG]=GroupVelocity1S(s,dt,D,TPoint,VPoint,v)
%���ݵ�̨�����沨��ȡȺ�ٶȳ���
%���룺
%   sΪ�������У�����Ϊ1�У�dtΪ���������DΪ���о࣬��λkm
%   TPointΪҪ����Ⱥ�ٶȵ��������У�һ��Ҫ�Ƚϳ��ܣ�����Ϊ��
%   VPointΪҪ�����Ⱥ�ٶ����У�����Ϊ��
%   vΪ����ͼ�����о������ʼ������ֹ�����ʱ�õ����ٶ����У�����Ϊ��
%   ����v������Ҫ����VPoint���еķ�Χ
%����� GroupVImgΪ����Ϊ���ڣ�����ΪȺ�ٶȵ���Է���ͼ���ļ������Ի�ͼ����׼ȷ��
%      PVGΪ��GroupVImg����ȡ�������ڡ�Ⱥ�ٶȾ������е�һ��Ϊ���ڣ��ڶ���Ϊ��Ӧ��Ⱥ�ٶ�
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
alfa = [0 100 250 500 1000 2000 4000 20000; 
    5  8  12  20  25  35  50 75];  %����������ʱ��Ҫ���������Ĳ���alfa�����ݲ�ͬ�����о����ͬalfaֵ
guassalfa = interp1(alfa(1,:), alfa(2, :), D);%ͨ����ֵ�õ���˹�˲�����alfaֵ
NumCtrT = length(TPoint); %Ⱥ�ٶȵĵ���
PtNum = length(s);   %����ʱ��ĵ���

nfft = PtNum; %�������fft�ĳ���
xxfft = fft(s, PtNum);  %ʱ�������ת����Ƶ����
fxx = (0:(PtNum/2))/(PtNum*dt); %NyquestƵ��֮ǰ��Ƶ��
IIf = 1:(PtNum/2+1);    %NyquestƵ��֮ǰ���������
JJf = (PtNum/2+2):nfft;   %NyquestƵ��֮����������

EnvelopeImage = zeros(NumCtrT, PtNum);  %����������ͼ��ľ���
for i = 1:NumCtrT    %��һ��Ⱥ�ٶȵĵ������м������ͼ��ÿ�δ���õ�ĳһ���ڵĵ��𲨵İ�����
    CtrT = TPoint(i);   %Ҫ����ĵ�������
    fc = 1/CtrT;   %Ҫ����ĵ���Ƶ�ʣ�Ϊ�������ڵĵ���             
    Hf = exp(-guassalfa*(fxx - fc).^2/fc^2);  %���ø�˹�˲�����Ƶ�������ԣ�ֻ�и�Ƶ�ʲ�˥��������Ƶ�ʰ��˾��Ƶ�ʵ�Զ��˥��
    yyfft = zeros(1,nfft);  %�����˲�����ź�Fourier�任�����飬����Ϊ��
    yyfft(IIf) = xxfft(IIf).*Hf;  %Ƶ�����ݼ��ϴ������ã���NyquestƵ��֮ǰ����Ƶ�����˲�����Ƶ������Ϊ�˻�����ʱ����Ϊ���
    yyfft(JJf) = conj(yyfft((PtNum/2):-1:2)); %��Nyquest֮ǰ��Ƶ�������ݽ��й���õ��˲����Ƶ�������ݣ��ο�Fourier�任�ķ���
    yy = real(ifft(yyfft, PtNum));%����Fourier��任�任��ʱ����
    filtwave = abs(hilbert(yy(1:PtNum)));%����ϣ�����ر任�õ��������������ֵ�����ϰ�����
    EnvelopeImage(i, 1:PtNum) = filtwave(1:PtNum);  %���õ�Ⱥ�ٶȵ��ϰ����ߴ浽EnvelopeImage��,������Ϊ���ڱ仯����Ϊʱ�����У��翴��ת��ΪȺ�ٶȣ����һ�����Ӧ�����Ⱥ�ٶȣ����һ�����Ӧ����СȺ�ٶ�
end
AmpS_T = max(EnvelopeImage,[],2);   %�õ�EnvelopeImage������е����ֵ���������Ϊ1����Ϊ�е����ֵ������Ϊ2����Ϊ�е����ֵ
nt=length(TPoint);    %����Ϊ���ڣ��˴�Ϊ��������
nn=length(VPoint);     %����Ϊ��Ⱥ�ٶȣ��˴�ΪȺ�ٶȵĵ���
GroupVImg=zeros(nn,nt);  %���ٴ������-Ⱥ�ٶȵĵ��𲨷�ֵ����
   for i = 1:nt  
      GroupVImg(1:nn, i) = interp1(v(2:end), [EnvelopeImage(i,2:end)]'/AmpS_T(i),VPoint, 'spline');  %���õ��ĵ���ĳһƵ�ʵĵ��𲨰����߽��й�һ��������VPoint��������������ֵ������������GroupVImg,
      %ע�⣬�����ٶȵĵ�һ��ֵΪ������ʱ�̣����������ʱ�̵������̨����ֵӦΪ������Ӧȥ��
   end
 [m,n]=size(GroupVImg);   %�õ�ͼ�������к�������Ŀ
 GVmax=max(GroupVImg);     %���ͼ���������е����ֵ
 GroupT=[];    %���ȸ���һ���վ������ڷ������ںͶ�Ӧ��Ⱥ�ٶ�
 for ii=1:n
     Indx=find(GroupVImg(:,ii)==GVmax(ii));
     GroupT=[GroupT; TPoint(ii),VPoint(Indx)];
 end
  [m,n]=size(GroupVImg);   %�õ�ͼ�������к�������Ŀ
 GVmax=max(GroupVImg);     %���ͼ���������е����ֵ
 GroupT=[];    %���ȸ���һ���վ������ڷ������ںͶ�Ӧ��Ⱥ�ٶ�
 for ii=1:n
     Indx=find(GroupVImg(:,ii)==GVmax(ii));
     GroupT=[GroupT; TPoint(ii),VPoint(Indx)];
 end
%����ĳ��򽫾�����ͬȺ�ٶȵ����ڽ�����ȡ���ڵ�ƽ��ֵ����ƽ��ֵ�и�����Ⱥ�ٶ�
PVG=[];   %�������ں�Ⱥ�ٶȶ�Ӧ������
vzall=0;
nv=0;
M=size(GroupT,1);
for ii=2:M
        vzall=vzall+GroupT(ii-1,1);   %�������һ�������ٶ��ۼ�
        nv=nv+1;
    if(GroupT(ii,2)~=GroupT(ii-1,2))
        PVG=[PVG;vzall/nv,GroupT(ii-1,2)];   %����һ�����ݴ��̣��������ͬ�����ڣ���ȡ��ͬ����Ⱥ�ٶȵ�ƽ��ֵ
        nv=0;    %��һ��Ⱥ�ٶȺ����ڵ���ȡ��ʼ
        vzall=0;
    end
end
PVG=[PVG;GroupT(M,:)];   %�����һ�����ݴ���
return