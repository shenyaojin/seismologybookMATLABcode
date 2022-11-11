%P5_22.m
%对于l=5，m=3，此时m可取0,1,2
l=5;m=3;  %采用不同的l,m，改变这里的l,m
n=80;   %绘图的精度
fai=(-n:2:n)/n*pi;   %经度取-pi~pi
theta = [0:n]'/n*pi; %纬度取0~pi
cosfai=cos(fai);   %cosfai
sinfai=sin(fai);   %sinfai
costheta=cos(theta);sintheta=sin(theta);
p=legendre(l,cos(theta)); 
%调用Lengedre函数，这里将所有m=0,...,l的所有值输出，第一列对应于m=0，第二列对应m=1,以此类推
r=[[p(m+1,:)]'*cos(m*fai)];  %采用sin(m*fai)，将cos(m*fai)改为sin(m*fai)
%以下三行将球坐标系改为直角坐标系
x = r.*(sintheta*cosfai);     
y = r.*(sintheta*sinfai);
z = r.*(costheta*ones(1,n+1));
surfl(x,y,z)   %绘出空间分布图像
colormap bone   %采用不同的色标，改动此设置
axis equal    %使坐标轴代表的长度相等  
xlabel('x轴');ylabel('y轴'); zlabel('z轴')
