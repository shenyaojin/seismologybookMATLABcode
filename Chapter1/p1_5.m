%p1_5
%�Ƚϲ�ͬģ�͵��ٶ�����ȵķֲ�
%load wan1066a.txt  %����1066aģ�ͣ�
%load wan1066b.txt  %����1066bģ��
load wanjb.txt     %����JBģ��
load wanak135.txt   %����AK135ģ��
load wanalfs.txt   %����ALFSģ��
load wanherrin.txt  %����HERRINģ��
load waniasp91.txt   %����IASP91ģ��
load wanprem.txt     %����PREMģ��
%load wanpwdk.txt   %����PWDKģ��
load wansp6.txt     %����SP6ģ��
%ע��������ɫ�������ޣ��˴�������7��ģ�͵ıȽϣ����߿���ѡ����������7��ģ�ͽ��бȽ�
plot(wanjb(:,2),wanjb(:,1),'r',wanalfs(:,2),wanalfs(:,1),'g',wanak135(:,2),wanak135(:,1),'b',wanherrin(:,2),wanherrin(:,1),'k',wanprem(:,2),wanprem(:,1),'y',waniasp91(:,2),waniasp91(:,1),'c',wansp6(:,2),wansp6(:,1),'m')
%�ò�ͬ��ɫ��ʵ�߻���P���ٶ�����ȵı仯
legend('JB','ALFS','AK135','Herrin','PREM','IASP91','SP6')   %����ͼ����ע�⣬��������������߳��ֵ�˳��һ��
hold on   %ͼ�α��֣�ʹ�ú���ͼ�λ��ƻ���ԭ������ͼ��
plot(wanjb(:,3),wanjb(:,1),'r:',wanalfs(:,3),wanalfs(:,1),'g:',wanak135(:,3),wanak135(:,1),'b:',wanherrin(:,3),wanherrin(:,1),'k:',wanprem(:,3),wanprem(:,1),'y:',waniasp91(:,3),waniasp91(:,1),'c:',wansp6(:,3),wansp6(:,1),'m:')
%�ò�ͬ��ɫ�����߻���S���ٶ�����ȵı仯
ylabel('���/km');xlabel('�ٶ�/km.s^-^1')   %��x���y����ϱ��,^��ʾ������ַ�Ϊ�ϱ꣬��ֵ����һ���ַ�
set(gca,'YDir','reverse'); 
%gcaΪ�õ���ǰ�������ᣨGet Current Axis����д����YDirΪY��ķ��򣬱���ʹy��ķ�����Ĭ�ϵ�����Ϊ�������ڸ�Ϊ����Ϊ��
