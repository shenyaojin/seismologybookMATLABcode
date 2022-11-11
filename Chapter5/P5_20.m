%P5_20.m
L=2.0;   %�ҵĳ���Ϊ2m
c=0.5;   %���Ĵ����ٶȼٶ�Ϊ0.5m/s
Nmode=100;   %���������100�����ͽ��е���
dx=0.02;   %�ռ���
x=0:dx:L;    %��������ϵ������
Nx=length(x);   %�ռ�����ĵ���
dt=0.025;    %ʱ����
t=0:dt:40;    %�����ʱ��㣬Ҫ�����ʱ��Ϊ40s
Nt=length(t);   %ʱ������ĵ���
tau=0.02;    %��Դ�ĳ���ʱ��
Xs=0.8;    %Դ���õ�λ��
u=zeros(Nt,Nx);   %����һ������
for n=1:Nmode    %�����������͵��ӵ�ѭ��
    NPIL=n*pi/L;    
    SNXs=sin(NPIL*Xs);  %��Դ��sin(n*pi*xs/L)
    Wn=n*pi*c/L;    %���͵�Ƶ��
    SNXr=sin(NPIL*x);   %sin(n*pi*x/L)
    Space=SNXr*SNXs*exp(-(Wn*tau/2)^2);  %�ڿռ�ı仯����
    u=u+[cos(Wn*t)]'*Space;   %���þ�����˵ķ�ʽ�õ�λ�Ƶĵ���,��ʽ����    
    %�õ���λ�Ƶ���Ϊʱ�����У���Ϊ�ռ�����
end
filename='summation.gif';    %����ռ�ͼ����ʱ��仯�Ĳ����ļ�
h=plot(x,u(1,:));     %���ƿռ�λ�÷ֲ�
xlabel('X/m')      %��x��ӱ��
ylim([-20 20]);    %�̶�y��������
for ii=1:Nt    %�����е�ʱ���ѭ�����ɴ˿���ͼ����ʱ��ı仯
    set(h,'Ydata',u(ii,:));   %��ʾ��ǰ�ļ�������
    f = getframe(gcf);   %��õ�ǰ��ͼ��
    imind=frame2im(f);  %��frame��ʽ��Ϊͼ��image���ĸ�ʽ��imindΪͼ���ļ�
    [imind,cm] = rgb2ind(imind,256);   
    %��RGBͼ���ļ�imindת��Ϊ���ͼ��
    if ii==1    %��һ��ѭ��
        imwrite(imind,cm,filename,'gif', 'Loopcount',inf,'DelayTime',0.05);
         %����ʼ��һ֡ͼ��д���ļ�����ʽΪgif���ӳ�ʱ��Ϊ0.05��
    else
        imwrite(imind,cm,filename,'gif','WriteMode','append','DelayTime',0.1);
        %��ԭ���ļ��������һ֡ͼ���ӳ�ʱ��Ϊ0.1��
    end
end
figure(2)
subplot(2,1,1)   %��һ����ͼ
plot(t',u(:,50));    %���ƿռ��50���㴦�ܹ���¼��λ����ͼ
xlabel('ʱ��/s');ylabel('λ��/m');  %��������
subplot(2,1,2)   %�ڶ�����ͼ
[vpsd,f]=pwelch(u(:,50),length(t),0,length(t),1/dt); %���ղ������,����Welch�������й������ܶȹ���
%Pwelch�ĵ��÷�ʽΪ[Pxx,f] = pwelch(x,window,noverlap,nfft,fs)
%xΪ���ݣ�windowΪ�����ȣ�noverlapΪ�ص�������nfftΪ����fft���õĵ���,fsΪ������������PxxΪ�������ܶȣ�fΪ��Ӧ��Ƶ��
%�ο���Ӧ�������źŴ����鼮
plot(f,vpsd);   %�����Ƶ��ܶ��׻��Ƴ���
 hold on   %ͼ�α���
 plot(c/2/L*[1;1]*[1:40],[ylim]'*ones(1,40),'y');   %����ÿ��г��Ƶ�ʵ�λ��
 xlim([0,5])    %�̶���ʾ��x�᷶Χ
 xlabel('Ƶ��/Hz'); ylabel('�������ܶ�');   %��������
