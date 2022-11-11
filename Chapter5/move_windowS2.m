function [PVG]=move_windowS2(s1,s2,dt,D21,t21,TPoint)
%��������̨վ���沨��¼��ȡ�沨Ⱥ�ٶ�Ƶɢ���߳���
%���룺s1��s2Ϊ�������𲨼�¼���������У�dtΪ��������ͼ�Ĳ����������λ��
%      D21Ϊ����̨վ֮�����о࣬��λkm��t21Ϊ������ȡ����ͼ����ʼʱ�̲�𣬵�λ�룻
%      TPointΪ��������ڵ㣬�������У���λ�룻
%�����PVGΪ�õ���Ƶɢ���ݣ����е�һ��Ϊ���ڣ���λ�룬�ڶ���ΪȺ�ٶȣ���λkm/s
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
LengthS=length(s1);    %���ݳ���
LengthT=length(TPoint);      %��Ҫ��������ڵ���
PVG=zeros(LengthT,2);    %���ں�ʱ���ľ��󣬳�ʼȫ������Ϊ0
for jj=1:LengthT    %�����е����ڽ���ѭ�����
    Tk=TPoint(jj);       %����
    WinLen=5*Tk/dt;    %�����ȣ�Ϊ�������ݳ��ȵ�5��
    if(rem(WinLen,2)==0)   WinLen=WinLen+1; end   %ʹ�ô��ĳ���Ϊ����������������Ϊһ������
    Hw=floor(WinLen/2);     %���İ볤��
    Win=cos(pi*[-Hw:Hw]/2/Hw).^2;   %������ƽ����
    temp1=zeros(1,LengthS);temp2=temp1;
    for ii=1:LengthS     %ѭ���ƶ�����λ��
        %���ϴ�������ʹ�ô������ĵ�Ϊ���㵽ʱ��λ��
        %������ݲ��ܸ��������������ڴ�ǰ���򴰺󲿼������
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
        temp1(ii)=abs(sum(Sig1.*exp(-j*2*pi*[-Hw:Hw]*dt/Tk)));   %��Ӧ��Fourier�任���õ������ݰ���ʵ�����鲿
        temp2(ii)=abs(sum(Sig2.*exp(-j*2*pi*[-Hw:Hw]*dt/Tk)));   %��Ӧ��Fourier�任���õ������ݰ���ʵ�����鲿        
    end
    Indx1=find(temp1==max(temp1));   %�õ���һ��̨վ���ϵĸ�Ƶ�������������
    Indx2=find(temp2==max(temp2));   %�õ��ڶ���̨վ���ϵĸ�Ƶ�������������
    PVG(jj,1:2)=[TPoint(jj),D21/((Indx2(1)-Indx1(1))*dt+t21)];    %�������̨վ֮���Ⱥ�ٶ�
end
return