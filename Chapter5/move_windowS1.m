function [F,PVG]=move_windowS1(s,dt,D,VPoint,TPoint)
LengthS=length(s);
LengthV=length(VPoint);     %��Ҫ�����ʱ��������Ҳ����Ⱥ�ٶȵĸ���
LengthT=length(TPoint);      %��Ҫ��������ڵ���
F=zeros(LengthV,LengthT);    %���ں�ʱ���ľ��󣬳�ʼȫ������Ϊ0
for jj=1:LengthT    %�����е����ڽ���ѭ�����
    Tk=TPoint(jj);       %����
    WinLen=5*Tk/dt;    %�����ȣ�Ϊ�������ݳ��ȵ�5��
    if(rem(WinLen,2)==0)   WinLen=WinLen+1; end   %ʹ�ô��ĳ���Ϊ����������������Ϊһ������
    Hw=floor(WinLen/2);     %���İ볤��
    Win=cos(pi*[-Hw:Hw]/2/Hw).^2;   %������ƽ����
    Ps=D/VPoint(1)/dt;    %
    for ii=Ps:D/VPoint(end)/dt     %ѭ���ƶ�����λ��
        %���ϴ�������ʹ�ô������ĵ�Ϊ���㵽ʱ��λ��
        %������ݲ��ܸ��������������ڴ�ǰ���򴰺󲿼������
        if(ii-Hw>=1&ii+Hw<=LengthS)
            Sig=s(ii-Hw:ii+Hw).*Win;
        elseif(ii-Hw<1)&(ii+Hw<=LengthS)
            Sig=[zeros(1,Hw-ii+1),s(1:ii+Hw)].*Win;
        elseif(ii-Hw<1)&(ii+Hw>LengthS)
            Sig=[zeros(1,Hw-ii+1),s(1:LengthS),zeros(1,Hw-(LengthS-ii)+1)].*Win;
        elseif(ii-Hw>=1)&(ii+Hw>LengthS)
            Sig=[s(ii-Hw:LengthS),zeros(1,Hw-(LengthS-ii))].*Win;
        end
        temp=sum(Sig.*exp(-j*2*pi*[-Hw:Hw]*dt/Tk));   %��Ӧ��Fourier�任���õ������ݰ���ʵ�����鲿
        F(ii-Ps+1,jj)=abs(temp);     %��ȡ�������
    end
end
 Fmax= max(F,[],1);    %���ÿһ���е����ֵ
for jj=1:LengthT
    F(1:LengthV,jj)=F(1:LengthV,jj)/Fmax(jj);  %��ÿһ�е����ݽ��й�һ��
end
%����ĳ�����ݵõ���ͼ���ҵ�Ⱥ�ٶȵľ���ֵ
 GVmax=max(F);     %���ͼ���������е����ֵ
 GroupT=[];    %���ȸ���һ���վ������ڷ������ںͶ�Ӧ��Ⱥ�ٶ�
 for ii=1:LengthT
     Indx=find(F(:,ii)==GVmax(ii));
     GroupT=[GroupT; TPoint(ii),VPoint(Indx(1))];
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