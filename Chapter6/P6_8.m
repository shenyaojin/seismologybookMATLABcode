%P6_8.m
%ģ�����ֱ�ﲨ��ʱ�����о༰·��
v=[2.0,2.5,3.0,3.8,4.5,5.0,7.5];%�ؿ�ģ�͵ĸ����ٶ�
deep=[0,1,3,10,15,23,33,35]; %�ؿ�ģ�͵ĸ���������
figure(1)  %��������·��
x=[-5,140];nlength=length(x);
vcolor=[];
deep1=[];
for ii=1:length(v)
    deep1=[deep1,deep(ii),deep(ii+1)];  %�����������еĲ�Ϊ���Ȳ������ͬ���ٶ�
    vcolor=[vcolor;ones(1,nlength)*v(ii);ones(1,nlength)*v(ii)];
end
pcolor(x,deep1,vcolor);   %�����ٶȽṹ
colorbar    %����ɫ��
annotation('textbox',[0.80,0.894,0.5,0.1],'linestyle','none','String','�ٶ�/km.s^-^1') 
hold on%ͼ�α��֣�ʹ�ú���Ļ�ͼ�ڴ˻�����
h0=22;% �������
plot(0,h0,'p')
%����������ڵĲ�͵������Դ�㶥���ľ���Dz
Dz  = h0;
SLayerNum = 1;
for l=2:length(deep)
%����Դ���С���ٶ�ģ����ĳ�㣬��ô��Դ�ڸò����һ��
if (h0 < deep(l))
Dz  = h0 - deep(l-1);
%������Դ���ڲ�
        SLayerNum = l-1;
break;
end%End IF    
end%End FOR
%�����Դ��ȴ����ٶ�ģ��������㣬������Դ��㶥��������ڲ�
if h0 > deep(length(deep)) 
Dz  = h0 - deep(length(deep));
       SLayerNum = length(deep);
end%End IF
  xx=[];   %���о�����
  tt=[];   %��ʱ����
for x=10:10:140
%���������Դ�ǵ����ֵ
        Maxthetaj = atan(x/Dz);
%���������Դ�ǵ���С��
        Minthetaj = atan(x/h0);
        thetaj= (Maxthetaj + Minthetaj)/2; %��������ǳ�ֵ
%�����µ�����Ǻ��ٶ�ģ�ͣ����¼������о�
        EpiDis=Dz*tan(thetaj);
for l=SLayerNum-1:-1:1
           tanThetajl = sin(thetaj)/sqrt((v(SLayerNum)/v(l))^2 - (sin(thetaj))^2);   %(6-7-7)�ĵڶ�ʽ
            EpiDis= EpiDis + (deep(l+1)-deep(l))*tanThetajl;  %���𲨴������ĺ�����룬����(6-7-10)
end
%�����������ǣ��ƽ���ϵͳ����ֵ����������
while (abs(EpiDis - x) > 1.0e-3)  
%�������о���������
if x > EpiDis
               Minthetaj = thetaj;
elseif x < EpiDis
               Maxthetaj = thetaj;
end
thetaj = (Maxthetaj + Minthetaj)/2;      
%�����µ�����ǣ����¼������о�
           EpiDis=Dz*tan(thetaj);
for l=SLayerNum-1:-1:1
            tanThetajl = sin(thetaj)/sqrt((v(SLayerNum)/v(l))^2 - (sin(thetaj))^2);   %(6-7-7)�ĵڶ�ʽ
            EpiDis= EpiDis + (deep(l+1)-deep(l))*tanThetajl;  %���𲨴������ĺ�����룬����(6-7-10)
end
%������С�ǲ�ֵС��10E-10����������
if(abs(Minthetaj - Maxthetaj)<10e-10)
break;   %�˳�����
end
end%WHILEѭ������
%�ҵ������ŵ���Դ�ǣ����ոýǼ����䵽����̨վ
h1=h0;x1=0;
sinthetaj=sin(thetaj);
  x=x1+Dz*tan(thetaj);
%���о�ĳ�ʼֵΪ��������Դ�㴫����ˮƽ����
h=h1-Dz;
  plot([x1,x],[h1,h],'w-')
  x1=x;h1=h;
  t=Dz/(cos(thetaj)*v(SLayerNum));
%��ʱ�ĳ�ʼֵΪ��Դ��ĵ�ˮƽ����
for l=SLayerNum-1:-1:1
tanThetajl = sinthetaj/sqrt((v(SLayerNum)/v(l))^2 - (sinthetaj)^2);   %(6-7-7)�ڶ�ʽ
            cosThetajl =  sqrt(1-( v(l)* sinthetaj/v(SLayerNum))^2); %(6-7-7)ʽ��һʽ
            x = x1 + (deep(l+1)-deep(l))*tanThetajl;  %���𲨴������ĺ�����룬����(6-7-10)
            h=h1-(deep(l+1)-deep(l));   %���𲨴����������
plot([x1,x],[h1,h],'w-')
            x1=x;   h1=h;
            t = t + (deep(l+1)-deep(l))/(cosThetajl*v(l));   %������ʱ(6-7-9)
end
        xx=[xx,x];
        tt=[tt,t];
end
  set(gca,'Ydir','reverse','box','on') %ʹ��y�᷽�������ܼ��Ͽ�
%����ǰ��ͼ��y�᷽����ʹ�÷�����ȴ����²�����������ҽ��ұߺ��ϱ߾����Ͽ�
xlabel('���о�/km')   %��x��ı��
ylabel('���/km')    %��y��ı��
figure(2) %����ֱ�ﲨ����ʱ����
plot(xx,tt,'-*');
xlabel('���о�/km')
ylabel('��ʱ/s')
