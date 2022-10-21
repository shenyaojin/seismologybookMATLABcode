%p1_4.m
%绘制全球crust1.0所给出的地壳厚度程序
close all;    %关闭当前的所有图形
load crsthk.xyz        %加载Crust1.0的地壳厚度数据
C_thk=reshape(crsthk(:,3),360,180);     %将crust1.0的数据转换为能够绘制的矩阵格式
[LAT,LON]=meshgrid([89.5:-1:-89.5],[-180:1:180]);     %得到矩阵格式的经纬度
ax= worldmap([-90,90],[0,360]);      %绘制世界地图
pcolorm(LAT,LON,C_thk);     %用颜色显示世界范围内的地壳厚度
load coast;    %加载全球海岸线数据，该数据在MATLAB数据库中，加载后的lat为海岸线的纬度数据、long为海岸线的经度数据
plotm(lat,long,'k')   %用黑色线绘制海岸线
colorbar('location','southoutside')    %在绘图的正下方绘制色标，其中location表示绘制的色标位置，southouttside在图外边的下方绘制
annotation('textbox',[0.5,0.07,0.05,0.03],'String','地壳厚度/km','LineStyle','none');  %在图例位置给出图例的标题，不含框
lakes = shaperead('worldlakes', 'UseGeoCoords', true);     %读取世界湖泊的数据，该数据也存在MATLAB数据库中
geoshow(lakes, 'FaceColor', 'blue')      %用蓝色显示全世界的湖泊
rivers = shaperead('worldrivers', 'UseGeoCoords', true);   %读取世界河流数据，该数据也存在MATLAB数据库中
geoshow(rivers, 'Color', 'blue')    %采用蓝色显示全世界的河流
