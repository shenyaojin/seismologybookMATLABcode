%P5_21.m
x= eps: 0.2:15;   %����ķ�Χ
y1= sqrt( pi/2./x).*besselj(1/2,x);   %0��bessel����
y2= sqrt( pi/2./x).*besselj(3/2,x); %1��
y3= sqrt( pi/2./x).*besselj(5/2,x ); %2��
y4= sqrt( pi/2./x).*besselj(7/2,x ); %3��
plot( x, y1,'-', x, y2,':', x , y3,'--', x, y4,'-.')%���Ƹ���bessel������ͼ��
grid on  %��ͼ���ϼ�������
legend('j0','j1','j2','j3')   %��ͼ��

