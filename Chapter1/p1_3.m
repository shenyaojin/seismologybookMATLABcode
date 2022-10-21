%p1_3.m
%绘制中国大地震和块体边界及断层数据
close all    %关闭所有的图形窗口
load block4mat    %加载张培震院士的块体划分模型
load quatmat.txt    %加载邓起东院士的第四纪断层数据
load hidden1mat.txt   %加载邓起东院士的隐伏断层数据
load hidden2mat.txt  %加载邓起东院士的隐伏断层数据
load holocenemat.txt  %加载邓起东院士的全新世断层数据
load marinemat.txt    %加载邓起东院士的海洋断层数据
load tibetmat.txt     %加载邓起东院士的青藏高原断层数据
load arc11format.txt   %加载中国边界数据
load ms5cat.txt        %加载有历史上Ms>5的地震目录
plot(arc11format(:,1),arc11format(:,2),'c',block4mat(:,1),block4mat(:,2),'k',quatmat(:,1),quatmat(:,2),'b',hidden1mat(:,1),hidden1mat(:,2),'r',...
    marinemat(:,1),marinemat(:,2),'m',holocenemat(:,1),holocenemat(:,2),'y',tibetmat(:,1),tibetmat(:,2),'g',ms5cat(:,8),ms5cat(:,7),'.r');
%采用上面的数据文件绘制断层，块体边界和地震目录图
%legend('State Boundary','Block Boundary','Quaternary','Hidden','Marine','Holocene','Tibet','EarthquakeMs>5','location','Southeast')
%给出图例，最后两个参数给出图例所处的位置
legend('国界','块体边界','第四纪断层','隐伏断层','海洋断层','全新世断层','青藏高原断层','地震Ms>5','location','Southeast')
%给出图例，最后两个参数给出图例所处的位置
axis([70, 140,16, 55])    %给出显示的坐标范围
xlabel('经度/^o')    %给x轴加标记
ylabel('纬度/^o')   %给y轴加标记


