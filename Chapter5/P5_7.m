%P5-7.m
kz=0:0.01:10;   %��������ȵĳ˻�
kcl=kz/2/pi;   %z/lamada
uamp=exp(-0.8475*kz)-0.5773*exp(-0.3933*kz);   %����(5-2-25)��һʽ���ˮƽ������
zamp=-0.8475*exp(-0.8475*kz)+1.4679*exp(-0.3933*kz);  %����(5-2-25)�ڶ�ʽ��ֱ������
plot(uamp,kcl,'-',zamp,kcl,':')   %���ƴ�ֱ��ˮƽ�����z/lamada�ı仯
legend('ˮƽ����','��ֱ����','Location','southeast')   %��ͼ��
hold on   %ͼ�α��֣�����ԭ���Ļ�ͼ
plot([0 0],ylim,'k')   %����y��
set(gca,'Ydir','reverse')  %��y�᷽����
xlabel('������')   %x��ı��
ylabel('z/\Lambda')   %y��ı��
