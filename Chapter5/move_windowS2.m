function [PVG]=move_windowS2(s1,s2,dt,D21,t21,TPoint)
%根据两个台站的面波记录提取面波群速度频散曲线程序
%输入：s1和s2为两个地震波记录，按行排列；dt为两个地震图的采样间隔，单位；
%      D21为两个台站之间震中距，单位km；t21为两个截取地震图的起始时刻差别，单位秒；
%      TPoint为计算的周期点，按行排列，单位秒；
%输出：PVG为得到的频散数据，其中第一列为周期，单位秒，第二列为群速度，单位km/s
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
LengthS=length(s1);    %数据长度
LengthT=length(TPoint);      %所要计算的周期点数
PVG=zeros(LengthT,2);    %周期和时间点的矩阵，初始全部设置为0
for jj=1:LengthT    %对所有的周期进行循环求解
    Tk=TPoint(jj);       %周期
    WinLen=5*Tk/dt;    %窗长度，为周期数据长度的5倍
    if(rem(WinLen,2)==0)   WinLen=WinLen+1; end   %使得窗的长度为奇数，这样窗中心为一个数据
    Hw=floor(WinLen/2);     %窗的半长度
    Win=cos(pi*[-Hw:Hw]/2/Hw).^2;   %半余弦平方窗
    temp1=zeros(1,LengthS);temp2=temp1;
    for ii=1:LengthS     %循环移动窗的位置
        %加上窗函数，使得窗的中心点为计算到时的位置
        %如果数据不能覆盖整个窗，则在窗前部或窗后部加零填充
        if(ii-Hw>=1&ii+Hw<=LengthS)
            Sig1=s1(ii-Hw:ii+Hw).*Win;
            Sig2=s2(ii-Hw:ii+Hw).*Win;
        elseif(ii-Hw<1)&(ii+Hw<=LengthS)
            Sig1=[zeros(1,Hw-ii+1),s1(1:ii+Hw)].*Win;
            Sig2=[zeros(1,Hw-ii+1),s2(1:ii+Hw)].*Win;
        elseif(ii-Hw<1)&(ii+Hw>LengthS)
            Sig1=[zeros(1,Hw-ii+1),s1(1:LengthS),zeros(1,Hw-(LengthS-ii)+1)].*Win;
            Sig2=[zeros(1,Hw-ii+1),s2(1:LengthS),zeros(1,Hw-(LengthS-ii)+1)].*Win;
        elseif(ii-Hw>=1)&(ii+Hw>LengthS)
            Sig1=[s1(ii-Hw:LengthS),zeros(1,Hw-(LengthS-ii))].*Win;  
            Sig2=[s2(ii-Hw:LengthS),zeros(1,Hw-(LengthS-ii))].*Win;
        end
        temp1(ii)=abs(sum(Sig1.*exp(-j*2*pi*[-Hw:Hw]*dt/Tk)));   %对应的Fourier变换，得到的数据包含实部和虚部
        temp2(ii)=abs(sum(Sig2.*exp(-j*2*pi*[-Hw:Hw]*dt/Tk)));   %对应的Fourier变换，得到的数据包含实部和虚部        
    end
    Indx1=find(temp1==max(temp1));   %得到第一个台站资料的该频率最大振幅的序号
    Indx2=find(temp2==max(temp2));   %得到第二个台站资料的该频率最大振幅的序号
    PVG(jj,1:2)=[TPoint(jj),D21/((Indx2(1)-Indx1(1))*dt+t21)];    %求解两个台站之间的群速度
end
return