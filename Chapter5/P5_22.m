%P5_22.m
%����l=5��m=3����ʱm��ȡ0,1,2
l=5;m=3;  %���ò�ͬ��l,m���ı������l,m
n=80;   %��ͼ�ľ���
fai=(-n:2:n)/n*pi;   %����ȡ-pi~pi
theta = [0:n]'/n*pi; %γ��ȡ0~pi
cosfai=cos(fai);   %cosfai
sinfai=sin(fai);   %sinfai
costheta=cos(theta);sintheta=sin(theta);
p=legendre(l,cos(theta)); 
%����Lengedre���������ｫ����m=0,...,l������ֵ�������һ�ж�Ӧ��m=0���ڶ��ж�Ӧm=1,�Դ�����
r=[[p(m+1,:)]'*cos(m*fai)];  %����sin(m*fai)����cos(m*fai)��Ϊsin(m*fai)
%�������н�������ϵ��Ϊֱ������ϵ
x = r.*(sintheta*cosfai);     
y = r.*(sintheta*sinfai);
z = r.*(costheta*ones(1,n+1));
surfl(x,y,z)   %����ռ�ֲ�ͼ��
colormap bone   %���ò�ͬ��ɫ�꣬�Ķ�������
axis equal    %ʹ���������ĳ������  
xlabel('x��');ylabel('y��'); zlabel('z��')
