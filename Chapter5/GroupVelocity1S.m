function [GroupVImg,PVG]=GroupVelocity1S(s,dt,D,TPoint,VPoint,v)
%根据单台地震面波提取群速度程序
%输入：
%   s为地震波序列，排列为1行；dt为采样间隔，D为震中距，单位km
%   TPoint为要计算群速度的周期序列，一般要比较稠密，排列为行
%   VPoint为要计算的群速度序列，排列为行
%   v为地震图的震中距除以起始点至终止点的走时得到的速度序列，排列为列
%   这里v的序列要包含VPoint序列的范围
%输出： GroupVImg为横轴为周期，纵轴为群速度的相对幅度图像文件，可以绘图看其准确性
%      PVG为从GroupVImg中提取出的周期、群速度矩阵，其中第一列为周期，第二列为对应的群速度
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
alfa = [0 100 250 500 1000 2000 4000 20000; 
    5  8  12  20  25  35  50 75];  %窗函数设置时需要给窗函数的参数alfa，根据不同的震中距给不同alfa值
guassalfa = interp1(alfa(1,:), alfa(2, :), D);%通过插值得到高斯滤波器的alfa值
NumCtrT = length(TPoint); %群速度的点数
PtNum = length(s);   %地震波时间的点数

nfft = PtNum; %计算进行fft的长度
xxfft = fft(s, PtNum);  %时域的数据转换到频率域
fxx = (0:(PtNum/2))/(PtNum*dt); %Nyquest频率之前的频率
IIf = 1:(PtNum/2+1);    %Nyquest频率之前的数组序号
JJf = (PtNum/2+2):nfft;   %Nyquest频率之后的数组序号

EnvelopeImage = zeros(NumCtrT, PtNum);  %构建包络线图像的矩阵
for i = 1:NumCtrT    %逐一对群速度的点数进行计算包络图像，每次处理得到某一周期的地震波的包络线
    CtrT = TPoint(i);   %要计算的地震波周期
    fc = 1/CtrT;   %要计算的地震波频率，为地震波周期的倒数             
    Hf = exp(-guassalfa*(fxx - fc).^2/fc^2);  %设置高斯滤波器的频率域特性，只有该频率不衰减，其他频率按此距此频率的远近衰减
    yyfft = zeros(1,nfft);  %开辟滤波后的信号Fourier变换的数组，并置为零
    yyfft(IIf) = xxfft(IIf).*Hf;  %频率数据加上窗的作用，对Nyquest频率之前进行频率域滤波，在频率域中为乘积，在时间域即为卷积
    yyfft(JJf) = conj(yyfft((PtNum/2):-1:2)); %对Nyquest之前的频率域数据进行共轭即得到滤波后的频率域数据，参看Fourier变换的分析
    yy = real(ifft(yyfft, PtNum));%采用Fourier逆变换变换到时间域
    filtwave = abs(hilbert(yy(1:PtNum)));%采用希尔伯特变换得到解析函数，其幅值即是上包络线
    EnvelopeImage(i, 1:PtNum) = filtwave(1:PtNum);  %将得到群速度的上包络线存到EnvelopeImage中,其中行为周期变化，列为时间序列，如看做转换为群速度，则第一个点对应于最大群速度，最后一个点对应于最小群速度
end
AmpS_T = max(EnvelopeImage,[],2);   %得到EnvelopeImage矩阵的行的最大值，如果后面为1，则为列的最大值，这里为2，则为行的最大值
nt=length(TPoint);    %横轴为周期，此处为其计算点数
nn=length(VPoint);     %纵轴为其群速度，此处为群速度的点数
GroupVImg=zeros(nn,nt);  %开辟存放周期-群速度的地震波幅值数组
   for i = 1:nt  
      GroupVImg(1:nn, i) = interp1(v(2:end), [EnvelopeImage(i,2:end)]'/AmpS_T(i),VPoint, 'spline');  %将得到的地震某一频率的地震波包络线进行归一化，按照VPoint进行样条函数插值，并赋给变量GroupVImg,
      %注意，由于速度的第一个值为地震发生时刻，如果地震发生时刻到达地震台，此值应为无穷，因此应去掉
   end
 [m,n]=size(GroupVImg);   %得到图像矩阵的行和列总数目
 GVmax=max(GroupVImg);     %求出图像矩阵的列中的最大值
 GroupT=[];    %首先给出一个空矩阵，用于放置周期和对应的群速度
 for ii=1:n
     Indx=find(GroupVImg(:,ii)==GVmax(ii));
     GroupT=[GroupT; TPoint(ii),VPoint(Indx)];
 end
  [m,n]=size(GroupVImg);   %得到图像矩阵的行和列总数目
 GVmax=max(GroupVImg);     %求出图像矩阵的列中的最大值
 GroupT=[];    %首先给出一个空矩阵，用于放置周期和对应的群速度
 for ii=1:n
     Indx=find(GroupVImg(:,ii)==GVmax(ii));
     GroupT=[GroupT; TPoint(ii),VPoint(Indx)];
 end
%下面的程序将具有相同群速度的周期进行求取周期的平均值，在平均值中给出该群速度
PVG=[];   %设置周期和群速度对应的数组
vzall=0;
nv=0;
M=size(GroupT,1);
for ii=2:M
        vzall=vzall+GroupT(ii-1,1);   %如果周期一样，则将速度累加
        nv=nv+1;
    if(GroupT(ii,2)~=GroupT(ii-1,2))
        PVG=[PVG;vzall/nv,GroupT(ii-1,2)];   %将上一行数据存盘，如果有相同的周期，则取相同周期群速度的平均值
        nv=0;    %下一个群速度和周期的求取开始
        vzall=0;
    end
end
PVG=[PVG;GroupT(M,:)];   %将最后一行数据存入
return