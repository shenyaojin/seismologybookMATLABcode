%P5_21.m
x= eps: 0.2:15;   %横轴的范围
y1= sqrt( pi/2./x).*besselj(1/2,x);   %0阶bessel函数
y2= sqrt( pi/2./x).*besselj(3/2,x); %1阶
y3= sqrt( pi/2./x).*besselj(5/2,x ); %2阶
y4= sqrt( pi/2./x).*besselj(7/2,x ); %3阶
plot( x, y1,'-', x, y2,':', x , y3,'--', x, y4,'-.')%绘制各阶bessel函数的图像
grid on  %在图形上加上网格
legend('j0','j1','j2','j3')   %加图例

