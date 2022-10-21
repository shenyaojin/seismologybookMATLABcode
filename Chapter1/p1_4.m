%p1_4.m
%����ȫ��crust1.0�������ĵؿǺ�ȳ���
close all;    %�رյ�ǰ������ͼ��
load crsthk.xyz        %����Crust1.0�ĵؿǺ������
C_thk=reshape(crsthk(:,3),360,180);     %��crust1.0������ת��Ϊ�ܹ����Ƶľ����ʽ
[LAT,LON]=meshgrid([89.5:-1:-89.5],[-180:1:180]);     %�õ������ʽ�ľ�γ��
ax= worldmap([-90,90],[0,360]);      %���������ͼ
pcolorm(LAT,LON,C_thk);     %����ɫ��ʾ���緶Χ�ڵĵؿǺ��
load coast;    %����ȫ�򺣰������ݣ���������MATLAB���ݿ��У����غ��latΪ�����ߵ�γ�����ݡ�longΪ�����ߵľ�������
plotm(lat,long,'k')   %�ú�ɫ�߻��ƺ�����
colorbar('location','southoutside')    %�ڻ�ͼ�����·�����ɫ�꣬����location��ʾ���Ƶ�ɫ��λ�ã�southouttside��ͼ��ߵ��·�����
annotation('textbox',[0.5,0.07,0.05,0.03],'String','�ؿǺ��/km','LineStyle','none');  %��ͼ��λ�ø���ͼ���ı��⣬������
lakes = shaperead('worldlakes', 'UseGeoCoords', true);     %��ȡ������������ݣ�������Ҳ����MATLAB���ݿ���
geoshow(lakes, 'FaceColor', 'blue')      %����ɫ��ʾȫ����ĺ���
rivers = shaperead('worldrivers', 'UseGeoCoords', true);   %��ȡ����������ݣ�������Ҳ����MATLAB���ݿ���
geoshow(rivers, 'Color', 'blue')    %������ɫ��ʾȫ����ĺ���
