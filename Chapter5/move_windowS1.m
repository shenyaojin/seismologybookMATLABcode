function [F,PVG]=move_windowS1(s,dt,D,VPoint,TPoint)
LengthS=length(s);
LengthV=length(VPoint);     %所要计算的时间点个数，也就是群速度的个数
LengthT=length(TPoint);      %所要计算的周期点数
F=zeros(LengthV,LengthT);    %周期和时间点的矩阵，初始全部设置为0
for jj=1:LengthT    %对所有的周期进行循环求解
    Tk=TPoint(jj);       %周期
    WinLen=5*Tk/dt;    %窗长度，为周期数据长度的5倍
    if(rem(WinLen,2)==0)   WinLen=WinLen+1; end   %使得窗的长度为奇数，这样窗中心为一个数据
    Hw=floor(WinLen/2);     %窗的半长度
    Win=cos(pi*[-Hw:Hw]/2/Hw).^2;   %半余弦平方窗
    Ps=D/VPoint(1)/dt;    %
    for ii=Ps:D/VPoint(end)/dt     %循环移动窗的位置
        %加上窗函数，使得窗的中心点为计算到时的位置
        %如果数据不能覆盖整个窗，则在窗前部或窗后部加零填充
        if(ii-Hw>=1&ii+Hw<=LengthS)
            Sig=s(ii-Hw:ii+Hw).*Win;
        elseif(ii-Hw<1)&(ii+Hw<=LengthS)
            Sig=[zeros(1,Hw-ii+1),s(1:ii+Hw)].*Win;
        elseif(ii-Hw<1)&(ii+Hw>LengthS)
            Sig=[zeros(1,Hw-ii+1),s(1:LengthS),zeros(1,Hw-(LengthS-ii)+1)].*Win;
        elseif(ii-Hw>=1)&(ii+Hw>LengthS)
            Sig=[s(ii-Hw:LengthS),zeros(1,Hw-(LengthS-ii))].*Win;
        end
        temp=sum(Sig.*exp(-j*2*pi*[-Hw:Hw]*dt/Tk));   %对应的Fourier变换，得到的数据包含实部和虚部
        F(ii-Ps+1,jj)=abs(temp);     %求取振幅部分
    end
end
 Fmax= max(F,[],1);    %求出每一列中的最大值
for jj=1:LengthT
    F(1:LengthV,jj)=F(1:LengthV,jj)/Fmax(jj);  %对每一列的数据进行归一化
end
%下面的程序根据得到的图像找到群速度的具体值
 GVmax=max(F);     %求出图像矩阵的列中的最大值
 GroupT=[];    %首先给出一个空矩阵，用于放置周期和对应的群速度
 for ii=1:LengthT
     Indx=find(F(:,ii)==GVmax(ii));
     GroupT=[GroupT; TPoint(ii),VPoint(Indx(1))];
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