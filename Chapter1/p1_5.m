%p1_5
%比较不同模型的速度随深度的分布
%load wan1066a.txt  %加载1066a模型，
%load wan1066b.txt  %加载1066b模型
load wanjb.txt     %加载JB模型
load wanak135.txt   %加载AK135模型
load wanalfs.txt   %加载ALFS模型
load wanherrin.txt  %加载HERRIN模型
load waniasp91.txt   %加载IASP91模型
load wanprem.txt     %加载PREM模型
%load wanpwdk.txt   %加载PWDK模型
load wansp6.txt     %加载SP6模型
%注意由于颜色种类所限，此处仅给出7种模型的比较，读者可以选择上面任意7种模型进行比较
plot(wanjb(:,2),wanjb(:,1),'r',wanalfs(:,2),wanalfs(:,1),'g',wanak135(:,2),wanak135(:,1),'b',wanherrin(:,2),wanherrin(:,1),'k',wanprem(:,2),wanprem(:,1),'y',waniasp91(:,2),waniasp91(:,1),'c',wansp6(:,2),wansp6(:,1),'m')
%用不同颜色的实线绘制P波速度随深度的变化
legend('JB','ALFS','AK135','Herrin','PREM','IASP91','SP6')   %加上图例，注意，必须与上面的曲线出现的顺序一致
hold on   %图形保持，使得后面图形绘制基于原来所绘图形
plot(wanjb(:,3),wanjb(:,1),'r:',wanalfs(:,3),wanalfs(:,1),'g:',wanak135(:,3),wanak135(:,1),'b:',wanherrin(:,3),wanherrin(:,1),'k:',wanprem(:,3),wanprem(:,1),'y:',waniasp91(:,3),waniasp91(:,1),'c:',wansp6(:,3),wansp6(:,1),'m:')
%用不同颜色的虚线绘制S波速度随深度的变化
ylabel('深度/km');xlabel('速度/km.s^-^1')   %给x轴和y轴加上标记,^表示后面的字符为上标，但值控制一个字符
set(gca,'YDir','reverse'); 
%gca为得到当前的坐标轴（Get Current Axis的缩写），YDir为Y轴的方向，本句使y轴的方向反向，默认的向上为正，现在改为向下为正
