function [PVG]=GroupVelocity2S(s1,s2,dt,D1,D2,t21,TPoint)
%根据同一传播弧线上的两个台地震面波提取群速度程序
%输入：
%   s1为第一个地震波序列，s2为第二个台站的地震波序列，排列均为1行；dt为两个台站的采样间隔，D1，D2为两个台站的震中距，单位km
%   TPoint为要计算群速度的周期序列，一般要比较稠密，排列为行
%输出： PVG为根据两个台的资料提取出的周期、群速度矩阵，其中第一列为周期，第二列为对应的群速度
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
alfa = [0 100 250 500 1000 2000 4000 20000; 
    5  8  12  20  25  35  50 75];  %窗函数设置时需要给窗函数的参数alfa，根据不同的震中距给不同alfa值
guassalfa = interp1(alfa(1,:), alfa(2, :), [D1,D2]);%通过插值得到两个台站高斯滤波器的alfa值
NumCtrT = length(TPoint); %群速度的点数
PtNum = length(s1);   %地震波时间的点数
D21=D2-D1;
nfft = PtNum; %计算进行fft的长度
xxfft1 = fft(s1, PtNum);  %时域的数据转换到频率域
xxfft2 = fft(s2, PtNum);  %时域的数据转换到频率域
fxx = (0:(PtNum/2))/(PtNum*dt); %Nyquest频率之前的频率
IIf = 1:(PtNum/2+1);    %Nyquest频率之前的数组序号
JJf = (PtNum/2+2):nfft;   %Nyquest频率之后的数组序号
PVG=zeros(NumCtrT,2);
for ii = 1:NumCtrT    %逐一对群速度的点数进行计算包络图像，每次处理得到某一周期的地震波的包络线
    CtrT = TPoint(ii);   %要计算的地震波周期
    fc = 1/CtrT;   %要计算的地震波频率，为地震波周期的倒数             
    Hf= exp(-guassalfa(1)*(fxx - fc).^2/fc^2);  %设置高斯滤波器的频率域特性，只有该频率不衰减，其他频率按此距此频率的远近衰减
    yyfft = zeros(1,nfft);  %开辟滤波后的信号Fourier变换的数组，并置为零
    yyfft(IIf) = xxfft1(IIf).*Hf;  %频率数据加上窗的作用，对Nyquest频率之前进行频率域滤波，在频率域中为乘积，在时间域即为卷积
    yyfft(JJf) = conj(yyfft((PtNum/2):-1:2)); %对Nyquest之前的频率域数据进行共轭即得到滤波后的频率域数据，参看Fourier变换的分析
    yy = real(ifft(yyfft, PtNum));%采用Fourier逆变换变换到时间域
    filtwave1 = abs(hilbert(yy(1:PtNum)));%采用希尔伯特变换得到解析函数，其幅值即是上包络线
    Indx1=find(filtwave1==max(filtwave1));    %找到第一台站此周期的最大包络值的序号
    Hf = exp(-guassalfa(2)*(fxx - fc).^2/fc^2);  %设置高斯滤波器的频率域特性，只有该频率不衰减，其他频率按此距此频率的远近衰减
    yyfft = zeros(1,nfft);  %开辟滤波后的信号Fourier变换的数组，并置为零
    yyfft(IIf) = xxfft2(IIf).*Hf;  %频率数据加上窗的作用，对Nyquest频率之前进行频率域滤波，在频率域中为乘积，在时间域即为卷积
    yyfft(JJf) = conj(yyfft((PtNum/2):-1:2)); %对Nyquest之前的频率域数据进行共轭即得到滤波后的频率域数据，参看Fourier变换的分析
    yy = real(ifft(yyfft, PtNum));%采用Fourier逆变换变换到时间域
    filtwave2 = abs(hilbert(yy(1:PtNum)));%采用希尔伯特变换得到解析函数，其幅值即是上包络线
    Indx2=find(filtwave2==max(filtwave2));    %找到第二台站此周期的最大包络值的序号
    PVG(ii,1:2)=[CtrT,D21/((Indx2-Indx1)*dt+t21)];   %震中距除以两者之间检测的时间差，再考虑两个地震图的起始时间差别，就得到群速度
end
return