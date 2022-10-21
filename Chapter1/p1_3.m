%p1_3.m
%�����й������Ϳ���߽缰�ϲ�����
close all    %�ر����е�ͼ�δ���
load block4mat    %����������Ժʿ�Ŀ��廮��ģ��
load quatmat.txt    %���ص���Ժʿ�ĵ��ļͶϲ�����
load hidden1mat.txt   %���ص���Ժʿ�������ϲ�����
load hidden2mat.txt  %���ص���Ժʿ�������ϲ�����
load holocenemat.txt  %���ص���Ժʿ��ȫ�����ϲ�����
load marinemat.txt    %���ص���Ժʿ�ĺ���ϲ�����
load tibetmat.txt     %���ص���Ժʿ����ظ�ԭ�ϲ�����
load arc11format.txt   %�����й��߽�����
load ms5cat.txt        %��������ʷ��Ms>5�ĵ���Ŀ¼
plot(arc11format(:,1),arc11format(:,2),'c',block4mat(:,1),block4mat(:,2),'k',quatmat(:,1),quatmat(:,2),'b',hidden1mat(:,1),hidden1mat(:,2),'r',...
    marinemat(:,1),marinemat(:,2),'m',holocenemat(:,1),holocenemat(:,2),'y',tibetmat(:,1),tibetmat(:,2),'g',ms5cat(:,8),ms5cat(:,7),'.r');
%��������������ļ����ƶϲ㣬����߽�͵���Ŀ¼ͼ
%legend('State Boundary','Block Boundary','Quaternary','Hidden','Marine','Holocene','Tibet','EarthquakeMs>5','location','Southeast')
%����ͼ�������������������ͼ��������λ��
legend('����','����߽�','���ļͶϲ�','�����ϲ�','����ϲ�','ȫ�����ϲ�','��ظ�ԭ�ϲ�','����Ms>5','location','Southeast')
%����ͼ�������������������ͼ��������λ��
axis([70, 140,16, 55])    %������ʾ�����귶Χ
xlabel('����/^o')    %��x��ӱ��
ylabel('γ��/^o')   %��y��ӱ��


