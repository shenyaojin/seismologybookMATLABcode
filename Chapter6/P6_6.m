%P6_6.m
h=8;H=30;vs=3;vp=vs*sqrt(3);   %������ȡ��ؿǺ�ȡ�S���ٶȼ�P���ٶ�
x=0:1:200;    %���о�
tpmp=sqrt(x.*x+(2*H-h)*(2*H-h))/vp;  %���գ�6-7-2��ʽ����PmP����ʱ
tsms=sqrt(x.*x+(2*H-h)*(2*H-h))/vs; %���գ�6-7-2��ʽ����SmS����ʱ
tpa=x/vp;
tsa=x/vs;
plot(x,tpmp,'b',x,tsms,'r:',x,tpa,'b-.',x,tsa,'r--')  %����P����S����ʱ����
xlabel('���о�/km') %��x��ı��
ylabel('��ʱ/s')   %��y��ı��
set(gca,'box','on') %����ͼ�ο�
ylim([0 70])    %����Y���������
legend('PmP��','SmS��','PmP������','SmS������','location','NorthWest')   %��ͼ��