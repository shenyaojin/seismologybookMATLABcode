%p1_2.m
%绘制全球板块边界
%采用网站：http://www.ig.utexas.edu/research/projects/plates/data.htm中的数据
%参考文献：Coffin, M.F., Gahagan, L.M., and Lawver, L.A., 1998, Present-day Plate Boundary Digital Data Compilation. University of Texas Institute for Geophysics Technical Report No. 174, pp. 5
%Peter Bird的数据来自：http://peterbird.name/oldFTP/PB2002/
worldmap([-90,90],[0,360]);   %绘制世界范围地图
load topo;        %加载世界地形数据
[LAT,LON]=meshgrid([89.5:-1:-89.5],[0:360]);     %得到矩阵格式的经纬度
pcolorm(LAT,LON,fliplr(topo'));     %用颜色显示世界范围内的地形数据
colormap(topomap1);    %采用绘制地形的色标
colorbar('location','southoutside')    %在绘图的正下方绘制色标，其中location表示绘制的色标位置，southoutside在图外边的下方绘制
load transform.txt   %加载转换断层数据
plotm(transform(:,2),transform(:,1),'y')   %用黄色绘制转换断层，绘地图时第一个数为纬度，第二个数为经度
load trench.txt   %加载海沟数据
plotm(trench(:,2),trench(:,1),'m')  %用洋红色绘制海沟数据
load ridge.txt  %加载海岭数据
plotm(ridge(:,2),ridge(:,1),'r')  %用红色绘制海岭数据
annotation('textbox',[0.5,0.07,0.05,0.03],'String','地形/m','LineStyle','none');  %在图例位置给出图例的标题，不含框

%load pb2002_boundaries.txt  %加载peter bird的板块边界数据
%plotm(pb2002_boundaries(:,2),pb2002_boundaries(:,1),'g')  %用绿色绘制Peter Bird的板块边界数据
%load pb2002_plates.txt  %加载peter bird的板块数据
%plotm(pb2002_plates(:,2),pb2002_plates(:,1),'c')  %用绿色绘制Peter Bird的板块数据
%load pb2002_orogens.txt  %加载peter bird的造山带数据
%plotm(pb2002_orogens(:,2),pb2002_orogens(:,1),'m')  %用绿色绘制Peter Bird的造山带数据
%fid=fopen('pb2002_poles.dat.txt','r');   %极点数据
%while 1
%s=fgets(fid);
%file_end=feof(fid);
%if(file_end==1), break, end
%textm(str2num(s(3:11)),str2num(s(12:22)),s(1:2));
%end
%fclose(fid);
