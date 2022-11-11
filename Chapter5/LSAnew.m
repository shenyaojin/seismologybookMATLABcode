load LSA318.VHZ   %��������̨��318��ļ�¼
load LSA319.VHZ  %��������̨��319��ļ�¼
load LSA320.VHZ %��������̨��320��ļ�¼
load LSA321.VHZ %��������̨��321��ļ�¼
[m,n]=size(LSA318);   %�����ǽ�����̨�ļ�¼����һ��ʸ��
nn=m*n;
b318=reshape(LSA318',nn,1);
[m,n]=size(LSA319);
nn=m*n;
b319=reshape(LSA319',nn,1);
[m,n]=size(LSA320);
nn=m*n;
b320=reshape(LSA320',nn,1);
[m,n]=size(LSA321);
nn=m*n;
b321=reshape(LSA321',nn,1);
b=[b318;b319;b320;b321];   %�õ�����̨��������¼
[LSAZPxx,f] = psd(b,16384,0.1);   %��0.1HZ��10s�����ö��������ݽ��й����׹���
hold on
plot(f,LSAZPxx);   %�����������Ƶ�ʵı仯
xlim([ 1.5e-3 3e-3])   %����Ƶ����Ļ�ͼ��Χ
ylim([0 2.5e8])     %����y����ʾ�ķ�Χ
%��������ǻ��PREMģ�͵������񵴵�����Ƶ�ʣ��û����ߺ������߱�ʾ����ͼ�Ķ��˸�������
plot(1.5783E-3*ones(1,2),ylim,'y'),text(1.5783E-3,2.6e8,'\fontsize{5}0\fontsize{10}S\fontsize{5}9');
plot(1.7266E-3*ones(1,2),ylim,'y'),text(1.7266E-3,2.6e8,'\fontsize{5}0\fontsize{10}S\fontsize{5}10');
plot(1.8660E-3*ones(1,2),ylim,'g') ,text(1.8652E-3,2.6e8,'\fontsize{5}2\fontsize{10}S\fontsize{5}7');
plot(1.9905E-3*ones(1,2),ylim,'y'),text(1.9905E-3,2.6e8,'\fontsize{5}0\fontsize{10}S\fontsize{5}12');
plot(2.1130E-3*ones(1,2),ylim,'y'),text(2.1130E-3,2.6e8,'\fontsize{5}0\fontsize{10}S\fontsize{5}13');
plot(2.2315E-3*ones(1,2),ylim,'y'),text(2.2315E-3,2.6e8,'\fontsize{5}0\fontsize{10}S\fontsize{5}14');
plot(2.3464E-3*ones(1,2),ylim,'y'),text(2.3464E-3,2.6e8,'\fontsize{5}0\fontsize{10}S\fontsize{5}15');
plot(2.4583E-3*ones(1,2),ylim,'y'),text(2.4583E-3,2.6e8,'\fontsize{5}0\fontsize{10}S\fontsize{5}16');
plot(2.5672E-3*ones(1,2),ylim,'y'),text(2.5672E-3,2.6e8,'\fontsize{5}0\fontsize{10}S\fontsize{5}17');
plot(2.6734E-3*ones(1,2),ylim,'y'),text(2.6734E-3,2.6e8,'\fontsize{5}0\fontsize{10}S\fontsize{5}18');
plot(2.7771E-3*ones(1,2),ylim,'y'),text(2.7771E-3,2.6e8,'\fontsize{5}0\fontsize{10}S\fontsize{5}19');
plot(2.8785E-3*ones(1,2),ylim,'y'),text(2.8785E-3,2.6e8,'\fontsize{5}0\fontsize{10}S\fontsize{5}20');
plot(2.9778E-3*ones(1,2),ylim,'y'),text(2.9778E-3,2.6e8,'\fontsize{5}0\fontsize{10}S\fontsize{5}21');
set(gca,'box','on')  %ʹ��ͼ���涼�п�
xlabel('Ƶ��/Hz')