%p1_7.m
%����PREMģ�͵����ֲ����ٶ�
load wanprem.txt    %����PREMģ��
r=6371-wanprem(:,1);   %����뾶,6371Ϊ����뾶����ȥ�����ȵõ�ÿ��İ뾶
vp=wanprem(:,2);   %��P���뾶��Ӧ��P���ٶ�
figure(1)  %��һ��ͼ�λ���P���ٶ�
sph_vel_plot(r,vp);  %�����ٶȽṹ�����������ηֲ����ٶ�
annotation('textbox',[0.80,0.894,0.2,0.05],'linestyle','none','String','�ٶ�/km.s^-^1') 
%��ɫ���ϼ��ϱ��
%����S���ļ��������P���ٶȻ��ƽ������
figure(2)  %����S���ٶ�
vs=wanprem(:,3);
sph_vel_plot(r,vs);  %�����ٶȽṹ�����������ηֲ����ٶ�
annotation('textbox',[0.80,0.894,0.2,0.05],'linestyle','none','String','�ٶ�/km.s^-^1') 
%��ɫ���ϼ��ϱ��
