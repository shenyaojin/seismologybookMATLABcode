%P6_12.m
vp1=5;vp2=7;h=30;%�ؿǺ͵��P���ٶ��Լ���Դ�����ľ���
w=15;  %Moho�����б�Ƕ�
i0p=asin(vp1/vp2);  %����Snell�������i0
x=100:1:500;    %���о�
Pnh=2*h*cos(i0p)/vp1+x./vp2;    %����6-7-3��ʽ��Pn������ʱ����
Pnup=(2*h*sin(i0p)+x*sin(i0p-deg2rad(w)))/vp1;  %���ݣ�6-8-2��������յ������µ�Pn����ʱ
Pndown=(2*h*sin(i0p)+x*sin(i0p+deg2rad(w)))/vp1;  %���ݣ�6-8-2��������յ������µ�Pn����ʱ
plot(x,Pnup,'b-.',x,Pndown,'r:',x,Pnh,'b')                   %������ʱ����
xlabel('���о�/km')   %x����ϱ�Ҫ�ı��
ylabel('��ʱ/s')           %y����ϱ�Ҫ�ı��
set(gca,'box','on') %����ͼ�ο�
legend('����Pn��','����Pn��','ƽ����Pn��','location','NorthWest')   %��ͼ��
