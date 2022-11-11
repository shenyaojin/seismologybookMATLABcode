%P5_2.m
beta1=3.9;beta2=4.49;%地壳和地幔的S波速度
rou1=2.9;rou2=3.38; %地壳和地幔的密度
H=30;    %假定地壳的厚度
miu1=rou1*beta1*beta1;   %地壳中的剪切模量
miu2=rou2*beta2*beta2;   %地幔中的剪切模量
w0=[];w1=[];w2=[];w3=[];   %基阶，一阶、二阶、三阶波的角频率
for c=beta1:0.05:beta2    %相速度自地壳S波速度到地幔S波速度
    c1=c/H/sqrt((c/beta1)^2-1);   %c1= 
    c2=miu2*sqrt(1-(c/beta2)^2)/miu1/sqrt((c/beta1)^2-1);  %c2= 
   w0=[w0 c1*(atan(c2))];   %基阶角频率按(5-1-15)式计算
   w0c=0;      %基阶阶频率的最小值（渐进值）
   w1=[w1 c1*(atan(c2)+pi)];   %一阶角频率按（5-1-15）式计算
   w1c=pi/(H*sqrt(1/beta1^2-1/beta2^2)); %按（5-1-17）式求得一阶角频率的最小值（渐进值）
   w2=[w2 c1*(atan(c2)+2*pi)]; %二阶角频率按（5-1-15）式计算
   w2c= 2*pi/(H*sqrt(1/beta1^2-1/beta2^2)); %按（5-1-17）式求得二阶角频率的最小值（渐进值）
   w3=[w3 c1*(atan(c2)+3*pi)];    %三阶角频率按（5-1-15）式计算
w3c= 3*pi/(H*sqrt(1/beta1^2-1/beta2^2)); %按（5-1-17）式求得三阶角频率的最小值（渐进值）
end   %循环for结束
c=beta1:0.05:beta2;   %按照计算间隔给出相速度序列
plot(w0,c,'r-',w1,c,'b--',w2,c,'r:',w3,c,'m-.')   %绘制
legend('基阶','一阶','二阶','三阶')
hold on  %使以后的绘图建立在原来绘图的基础上
ylimt=[beta1,beta2];   %在速度可能的范围内绘图
plot(w0c*ones(1,2),ylimt,'r-', w1c*ones(1,2),ylimt,'b--', w2c*ones(1,2),ylimt,'r:', w3c*ones(1,2),ylimt,'m-.')  %绘制基阶、一阶、二阶相速度随频率的变化曲线
xlimit=xlim; 
x=[xlimit(1),xlimit(2)];   %以x轴的范围设置绘图范围
plot(x,beta1*[1,1],'k:')  %以黑色绘制速度下界虚线
plot(x,beta2*[1,1],'k:')  %以黑色绘制速度上界虚线
xlabel('角频率\omega');  %x轴标记
ylabel('相速度/kms^-^1')   %y轴标记
