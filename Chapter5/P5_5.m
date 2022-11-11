%P5_5.m
fai=0:0.01:2*pi;    %�Ƕ���ת360��
beta=3.8;    %S���ٶ�
c=0.9194*beta;   %Rayleigh�����ٶ�
f=0.2;    %Ƶ��Ϊ0.2Hz����Ӧ������Ϊ5��
w=2*pi*f;    %��Ƶ��
k=w/c;       %����
N=100;    %���õ�ʱ�����
filename='Rayleigh.gif'; %������Ŷ����ļ����ļ���
for ii=1:N
    t=(ii-1)*0.5;   %ʱ���
for z=0:2:20     %���ѭ��
   kz=k*z;      
   uxa=exp(-0.8475*kz)-0.5773*exp(-0.3933*kz);   %����(5-2-25)����x������������ֵ
   uza=-0.8475*exp(-0.8475*kz)+1.4679*exp(-0.3933*kz);  %����(5-2-25)����y������������ֵ
   zux=uxa*cos(fai);zuz=uza*sin(fai);   %��x�����y�����λ�ƺϳ�λʸ��
   for x=0:30   %�����������ѭ��
      ux=uxa*sin(w*t-k*x);  %����(5-2-25)����x������������ֵ
      uz=uza*cos(w*t-k*x);  %����(5-2-25)����y������������ֵ
      plot(zux+x,zuz+z,'b-',x+ux,z+uz,'r.');  %�����ʵ��˶�·�����켣    
   hold on
   end
end        
plot(xlim,[0,0],'k-','lineWidth',2);  %���Ƶ�ƽ��
set(gca,'Ydir','reverse','box','on');  %��z���Ϊ����Ϊ��
axis equal     %ʹ��������ȣ��������Կ�����Բ����ȷ��״
text(31,0,'�ر�')   %�����ر�ı�־
axis([-1,31,-1,20]);     %����x���z��ķ�Χ
xlabel('����������x/km');    %��x��ı��
ylabel('���/km');    %��y��ı��
title('Rayleigh�����ʵ��˶��켣ģ��')
f=getframe(gcf); % ������
imind=frame2im(f);   
[imind,cm] = rgb2ind(imind,256);
   if ii==1
        imwrite(imind,cm,filename,'gif', 'Loopcount',inf,'DelayTime',0.05); %�����ӳ�ʱ��Ϊ0.05��д��������ļ�
    else
        imwrite(imind,cm,filename,'gif','WriteMode','append','DelayTime',0.1); %�����ӳ�ʱ��Ϊ0.1��д��������ļ�
   end
hold off      %�´λ�ͼʱ���ԭ����ͼ��
end
