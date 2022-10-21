%p1_1.m
%用于从ISC给出的地震目录中读取时间的经纬度、深度和震级
c='cat1960_65.txt';
cmap=jet(64);   %产生调色板，蓝色最小，红色最大，由兰到红分为64个值颜色值，每个颜色值由兰、黄、红三原色的比例组成
mindep=0;    %所显示的最小深度
maxdep=720;   %所显示的最大深度
Max_Min=maxdep-mindep;   %最小深度与最大深度的差
fp=fopen(c,'r');   %以读的形式打开目录文件
worldmap([-90,90],[0,360]);   %绘制世界范围地图，前面的数据为绘图纬度范围，后面的数据为绘图经度范围
load coast;    %加载全球海岸线数据，该数据在MATLAB数据库中，加载后的lat为海岸线的纬度数据、long为海岸线的经度数据
plotm(lat,long,'k')   %用黑色线绘制海岸线
%将目录文件中的解释语句略过
for ii=1:1:21  %文本文件共有21行注释
    sr=fgets(fp);  %读取打开文件的一行
end
NumEQ=0;   %地震个数计数
while 1   %这里设计一个死循环
   sr=fgets(fp);   %读取文件一行数据
   file_end=feof(fp);  %检查文件是否读到文件末尾，到末尾返回1，否则返回0
   if (file_end==1)|(sr(1:4)=='STOP'),break,end   %如果读到文件，或者读的文本的前4个字符为STOP，则跳出循环
     NumEQ=NumEQ+1;   %地震个数累加
         Elat=str2num(sr(44:51));Elon=str2num(sr(53:61));Edep=str2num(sr(63:67));
         %从指定的位置读取地震纬度、经度、深度
         %Emag=str2num(sr(93:96));  %如果用到震级，可以读取震级信息
         Ind=fix((maxdep-Edep)/Max_Min*64);    %找到此深度对应的调色板序号
         if(Ind<1)  Ind=1;  end  %如果序号为0，则按照序号为1的颜色绘图
         plotm(Elat,Elon,'.','MarkerSize',5,'Color',cmap(Ind,:))  %用指定的颜色序号用大小为5的点绘制地震
end  %死循环结束
fclose(fp);  %关闭文件
colorbar('location','southoutside','XTick',linspace(0,1,10),'Xticklabel',num2str(flipud([linspace(mindep,maxdep,10)]')));   
%加上色棒，位置在图外的下方(southoutside),刻度为10个；
%linspace(0,1,10)为将0和1之间等间隔分为10个值，刻度标记也为10个，采用最大值和最大值之间的10个数翻转后绘图,flipud为
%将后面的数据上下反转
annotation('textbox',[0.5,0.07,0.05,0.03],'String','深度/km','LineStyle','none');  %在图例位置给出图例的标题，不含框
s=sprintf('所用地震数目：%d',NumEQ)   %将NumEQ按照'所用地震数目：%f'的格式写入字符串s,由于本句没有分号，所以将该串显示到命令窗口中
