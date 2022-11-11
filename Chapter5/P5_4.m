%P5_4.m
H=30;   %�ؿǵĺ��Ϊ30km
c=4.0;    %���ٶ�
c2=c.*c;   %���ٶȵ�ƽ��
vs1=3.6;vs2=4.6; %�ؿǺ͵�ᣵ��ٶȣ���λkm/s
miu21=1.8;   %����ģ���ı�ֵ
sqc1=sqrt(c2/vs1/vs1-1);    % 
sqc2=sqrt(1-c2/vs2/vs2);     % 
atann=atan(miu21.*sqc2./sqc1);   % 
omiga0=c./(H*sqc1).*(atann+1*pi);    %����(5-1-15)�����Ƶ�ʣ��ı�0��ֵ����ģ�ⲻͬ��������������
%���Ըı�pi�ı����ۿ���ͬ���������������ֲ�
k=omiga0/c;   %����
N=100;    %���õ�ʱ�����
cmap=colormap('jet');   %ȡ�õ�ɫ�̣����ò�ͬ����ɫ��ʾ��ͬ��ǳ����
M=moviein(N);   %����һ������
for ii=1:N
    t=(ii-1)*0.1;   %ʱ���
    hold off
    for z=0:3:30   %��ȷ���
        D=cos((omiga0/c*sqc1).*z);  %�����
        cor=[];
        for x=0:0.5:60
        y=D*cos(omiga0*t-k*x);   %����5-1-18����ʵ������λ����ʱ��Ϳռ�ı仯
        cor=[cor;x,y,z];   %�ŵ�������
        end
        Ind=ceil(z/30*64); if(Ind==0) Ind=1;end  %��ò�ͬ��ȵ���ɫ���
        plot3(cor(:,1),cor(:,2),cor(:,3),'.-','Color',cmap(Ind,:))  %���ö�Ӧ����ɫ��ͼ
        hold on
    end
    set(gca,'Zdir','reverse')   %ʹ��z�ᷴ��
    grid on
    xlabel('X');ylabel('Y');zlabel('���/km');   %����������ı��
    axis([0,60,-1,1,0,30]);   %�̶����귶Χ
    view(-91,-20);    %��һ�����ӽǹ۲�ͼ��
    M(:,ii)=getframe;    %��õ�Ӱ�ļ�
end
movie(M)    %���ŵ�Ӱ
