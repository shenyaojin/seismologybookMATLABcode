%p1_6.m
%����PREMģ�͵Ĳ��١��ܶȡ����Գ�����ѹ��������
load premmodel.dat   %����PREMģ������
subplot(2,3,1)  %����P,S���ٶȽṹ
plot(premmodel(:,2)/1000,(6371-premmodel(:,1)),'b',premmodel(:,3)/1000,(6371-premmodel(:,1)),'r:')
legend('P���ٶ�','S���ٶ�')%����ͼ��
set(gca,'YDir','reverse')  
%gcaΪ�õ���ǰ�������ᣨGet Current Axis����д����YDirΪY��ķ��򣬱���ʹy��ķ�����Ĭ�ϵ�����Ϊ�������ڸ�Ϊ����Ϊ��
ylabel('���/km');   %����Y��ı��
xlabel('�ٶ�/km.s^-^1') %����X��ı��,ע�⣬^��ʾ������ַ�Ϊ�ϱ�
subplot(2,3,2)    %�����ܶȷֲ�
plot(premmodel(:,4),(6371-premmodel(:,1)),'b')
set(gca,'YDir','reverse')  %ʹY�ᷴ��
ylabel('���/km'); %����Y��ı��
xlabel('�ܶ�/kg.m^-^3') %����X��ı��,ע�⣬^��ʾ������ַ�Ϊ�ϱ�
subplot(2,3,3)    %���Ƶ��Գ���
plot(premmodel(:,5)/1000,(6371-premmodel(:,1)),'b',premmodel(:,6)/1000,(6371-premmodel(:,1)),'r:')
legend('Ks','\mu')  %����ͼ����ע��\mu��������ϣ����ĸ�Ħ�
set(gca,'YDir','reverse')  %ʹY�ᷴ��
ylabel('���/km');%����Y��ı��
xlabel('���Գ���/GPa')   %����X��ı��
subplot(2,3,4)   %���Ƶ���ѹ��
plot(premmodel(:,8),(6371-premmodel(:,1))) 
set(gca,'YDir','reverse')%ʹY�ᷴ��
ylabel('���/km');   %����Y��ı��
xlabel('ѹ��/GPa')%����X��ı��
subplot(2,3,5)    %���������ֲ�
plot(premmodel(:,9),(6371-premmodel(:,1)))
set(gca,'YDir','reverse')%ʹY�ᷴ��
ylabel('���/km');%����Y��ı��
xlabel('����/m.s^-^2') %����X��ı�ǣ�ע�⣬^��ʾ������ַ�Ϊ�ϱ�
