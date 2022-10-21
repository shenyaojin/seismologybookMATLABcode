function   []=sph_vel_plot(r,para)
%将全球参数结构绘制成球形分布表示的程序
%输入： r为地球半径,应该从大到小排列，para为对应半径的地球参数，可以为P波速度、S波速度、Qs、Qp或其他参数
%没有输出
cmap=jet(64); %制作调色板
%蓝色最小，红色最大，由兰到红分为64个值颜色值，每个颜色值由兰、黄、红三原色的比例组成
R=6371;    %地球半径
alpha=0:0.01:2*pi;   %旋转角度
x=R*cos(alpha);y=R*sin(alpha); %绘制地球表面的直角坐标系数据
[m,n]=size(r);   %获得PREM数据的行数和列数
Premin=min(para);Premax=max(para);   %找到参数的最大值和最小值
max_min=Premax-Premin;    %得到最大值和最小值的差
hold on    %图形保持，如果没有此句，则绘制新的数据时，前面的数据会被清除
for ii=1:1:m   %对数据的每一行数据进行操作
    Indx=round((para(ii)-Premin)/max_min*64);
    %根据当前层的参数求得绘制该颜色的调色板颜色序号
    if(Indx==0) Indx=1;end    %由于没有0序号，所以如果得到0序号，则采用序号1的颜色进行绘图
    fill(r(ii)*cos(alpha),r(ii)*sin(alpha),cmap(Indx,:),'EdgeColor',cmap(Indx,:))   
    %采用颜色序号填充指定半径r(ii)的圆内区域，填充区的边缘与填充颜色相同
end  %循环结束
plot(x,y,'k');   %将地表突出出来
axis equal     %使地球为正球，而不是扁球，需要将纵横坐标的两个坐标轴刻度一致
axis off     %不显示坐标轴
caxis([Premin,Premax]);    %原来的颜色轴为【0 1】,现在改为我们设置的最大值和最小值的范围，这样绘出的色棒才是正确的
colorbar  %绘出颜色棒
return