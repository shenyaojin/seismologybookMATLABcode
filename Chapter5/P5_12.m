%P5_12.m
load wenchuan.ur   %加载汶川地震东部10度的理论地震图数据
dt=wenchuan(2,1)-wenchuan(1,1);  %得到地震图的采样间隔
fs=1/dt;    %地震图的采样频率
StaDist=10*111.199;   %震中距
D=10;   %计算周期为10秒的滤波后数据及其包络线
s=[wenchuan(:,2)]';     %采用第一个台的地震波垂直向数据
alfa = [0 100 250 500 1000 2000 4000 20000; 
    5  8  12  20  25  35  50 75];  
%窗函数设置时需要给窗函数的参数alfa，根据不同的震中距给不同alfa值
guassalfa = interp1(alfa(1,:), alfa(2, :), D);
%通过插值得到高斯滤波器的alfa值

PtNum = length(s);   %地震波时间的点数
nfft = PtNum; %计算进行fft的长度
xxfft = fft(s, PtNum);  %时域的数据转换到频率域
fxx = (0:(PtNum/2))/(PtNum*dt); %Nyquest频率之前的频率
IIf = 1:(PtNum/2+1);    %Nyquest频率之前的数组序号
JJf = (PtNum/2+2):nfft;   %Nyquest频率之后的数组序号
fc = 1/T;   %要计算的地震波频率，为地震波周期的倒数             
Hf = exp(-guassalfa*(fxx - fc).^2/fc^2);  %根据(5-5-4)式设置高斯滤波器的频率域特性，只有该频率不衰减，其他频率按此距此频率的远近衰减， 
yyfft = zeros(1,nfft);  %开辟滤波后的信号Fourier变换的数组，并置为零
yyfft(IIf) = xxfft(IIf).*Hf;  %根据(5-5-3)式，对Nyquest频率之前的部分数据进行处理，在频率域中为乘积，在时间域即为卷积
yyfft(JJf) = conj(yyfft((nfft/2):-1:2)); %对Nyquest之前的频率域数据进行共轭即得到滤波后的频率域数据，参看Fourier变换的分析
yy = real(ifft(yyfft, nfft));%采用(5-5-5)式进行Fourier逆变换变换到时间域
filtwave = abs(hilbert(yy(1:nfft)));%采用希尔伯特变换得到解析函数，其幅值即是上包络线
plot([0:PtNum-1]*dt,yy(1:PtNum),[0:PtNum-1]*dt,filtwave(1:PtNum));   %绘制包络线和滤波后数据
legend('滤波后波形','包络线')
xlabel('时间/s'),ylabel('幅值')
