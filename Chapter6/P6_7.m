%P6_7.m
h=8;vp1=5;vs1=vp1/1.732;vp2=7;vs2=vp2/1.732;H=30;%�������ȡ�P����S�����ٶ��Լ��ؿǺ��
i0p=asin(vp1/vp2);i0s=asin(vs1/vs2);   %�����ײ��������
delta0p=(2*H-h)*vp1/sqrt(vp2^2-vp1^2);   %����6-7-4��ʽ����Pn���ٽ����
delta0s=(2*H-h)*vs1/sqrt(vs2^2-vs1^2);   %����6-7-4��ʽ����Sn���ٽ����
deltamax=max(delta0p,delta0s);           %��������ѡ����С���ٽ����
x=deltamax:1:500;    %���о�
tpn=(2*H-h)*cos(i0p)/vp1+x./vp2;    %����6-7-3��ʽ��Pn������ʱ����
tsn=(2*H-h)*cos(i0s)/vs1+x./vs2;   %����6-7-3��ʽ��Sn������ʱ����
plot(x,tpn,'r',x,tsn,'b:')                   %������ʱ����
xlabel('���о�/km')   %x����ϱ�Ҫ�ı��
ylabel('��ʱ/s')           %y����ϱ�Ҫ�ı��
legend('Pn��','Sn��','location','NorthWest')   %��ͼ��
