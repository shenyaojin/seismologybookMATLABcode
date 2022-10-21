%p1_2.m
%����ȫ����߽�
%������վ��http://www.ig.utexas.edu/research/projects/plates/data.htm�е�����
%�ο����ף�Coffin, M.F., Gahagan, L.M., and Lawver, L.A., 1998, Present-day Plate Boundary Digital Data Compilation. University of Texas Institute for Geophysics Technical Report No. 174, pp. 5
%Peter Bird���������ԣ�http://peterbird.name/oldFTP/PB2002/
worldmap([-90,90],[0,360]);   %�������緶Χ��ͼ
load topo;        %���������������
[LAT,LON]=meshgrid([89.5:-1:-89.5],[0:360]);     %�õ������ʽ�ľ�γ��
pcolorm(LAT,LON,fliplr(topo'));     %����ɫ��ʾ���緶Χ�ڵĵ�������
colormap(topomap1);    %���û��Ƶ��ε�ɫ��
colorbar('location','southoutside')    %�ڻ�ͼ�����·�����ɫ�꣬����location��ʾ���Ƶ�ɫ��λ�ã�southoutside��ͼ��ߵ��·�����
load transform.txt   %����ת���ϲ�����
plotm(transform(:,2),transform(:,1),'y')   %�û�ɫ����ת���ϲ㣬���ͼʱ��һ����Ϊγ�ȣ��ڶ�����Ϊ����
load trench.txt   %���غ�������
plotm(trench(:,2),trench(:,1),'m')  %�����ɫ���ƺ�������
load ridge.txt  %���غ�������
plotm(ridge(:,2),ridge(:,1),'r')  %�ú�ɫ���ƺ�������
annotation('textbox',[0.5,0.07,0.05,0.03],'String','����/m','LineStyle','none');  %��ͼ��λ�ø���ͼ���ı��⣬������

%load pb2002_boundaries.txt  %����peter bird�İ��߽�����
%plotm(pb2002_boundaries(:,2),pb2002_boundaries(:,1),'g')  %����ɫ����Peter Bird�İ��߽�����
%load pb2002_plates.txt  %����peter bird�İ������
%plotm(pb2002_plates(:,2),pb2002_plates(:,1),'c')  %����ɫ����Peter Bird�İ������
%load pb2002_orogens.txt  %����peter bird����ɽ������
%plotm(pb2002_orogens(:,2),pb2002_orogens(:,1),'m')  %����ɫ����Peter Bird����ɽ������
%fid=fopen('pb2002_poles.dat.txt','r');   %��������
%while 1
%s=fgets(fid);
%file_end=feof(fid);
%if(file_end==1), break, end
%textm(str2num(s(3:11)),str2num(s(12:22)),s(1:2));
%end
%fclose(fid);
