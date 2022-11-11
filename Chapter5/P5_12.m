%P5_12.m
load wenchuan.ur   %�����봨���𶫲�10�ȵ����۵���ͼ����
dt=wenchuan(2,1)-wenchuan(1,1);  %�õ�����ͼ�Ĳ������
fs=1/dt;    %����ͼ�Ĳ���Ƶ��
StaDist=10*111.199;   %���о�
D=10;   %��������Ϊ10����˲������ݼ��������
s=[wenchuan(:,2)]';     %���õ�һ��̨�ĵ��𲨴�ֱ������
alfa = [0 100 250 500 1000 2000 4000 20000; 
    5  8  12  20  25  35  50 75];  
%����������ʱ��Ҫ���������Ĳ���alfa�����ݲ�ͬ�����о����ͬalfaֵ
guassalfa = interp1(alfa(1,:), alfa(2, :), D);
%ͨ����ֵ�õ���˹�˲�����alfaֵ

PtNum = length(s);   %����ʱ��ĵ���
nfft = PtNum; %�������fft�ĳ���
xxfft = fft(s, PtNum);  %ʱ�������ת����Ƶ����
fxx = (0:(PtNum/2))/(PtNum*dt); %NyquestƵ��֮ǰ��Ƶ��
IIf = 1:(PtNum/2+1);    %NyquestƵ��֮ǰ���������
JJf = (PtNum/2+2):nfft;   %NyquestƵ��֮����������
fc = 1/T;   %Ҫ����ĵ���Ƶ�ʣ�Ϊ�������ڵĵ���             
Hf = exp(-guassalfa*(fxx - fc).^2/fc^2);  %����(5-5-4)ʽ���ø�˹�˲�����Ƶ�������ԣ�ֻ�и�Ƶ�ʲ�˥��������Ƶ�ʰ��˾��Ƶ�ʵ�Զ��˥���� 
yyfft = zeros(1,nfft);  %�����˲�����ź�Fourier�任�����飬����Ϊ��
yyfft(IIf) = xxfft(IIf).*Hf;  %����(5-5-3)ʽ����NyquestƵ��֮ǰ�Ĳ������ݽ��д�����Ƶ������Ϊ�˻�����ʱ����Ϊ���
yyfft(JJf) = conj(yyfft((nfft/2):-1:2)); %��Nyquest֮ǰ��Ƶ�������ݽ��й���õ��˲����Ƶ�������ݣ��ο�Fourier�任�ķ���
yy = real(ifft(yyfft, nfft));%����(5-5-5)ʽ����Fourier��任�任��ʱ����
filtwave = abs(hilbert(yy(1:nfft)));%����ϣ�����ر任�õ��������������ֵ�����ϰ�����
plot([0:PtNum-1]*dt,yy(1:PtNum),[0:PtNum-1]*dt,filtwave(1:PtNum));   %���ư����ߺ��˲�������
legend('�˲�����','������')
xlabel('ʱ��/s'),ylabel('��ֵ')
