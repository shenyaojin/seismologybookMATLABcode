%P6_9.m
h0=12;% �������
epi=130; %���о�
moholayer=7;   %Moho��Ĳ��
v=[2.0,2.5,3.0,3.8,4.5,5.0,7.5];%�ؿ�ģ�͵ĸ����ٶ�
deep=[0,1,3,10,15,23,33,35]; %�ؿ�ģ�͵ĸ���������
figure(1)  %��������·��
x=[-10,140];nlength=2;   %������ͼ�����о�ķ�Χ
vcolor=[];
deep1=[];
for ii=1:length(deep)-1
    deep1=[deep1,deep(ii),deep(ii+1)];  %�����������еĲ�Ϊ���Ȳ������ͬ���ٶ�
    vcolor=[vcolor;ones(1,nlength)*v(ii);ones(1,nlength)*v(ii)];
end
pcolor(x,deep1,vcolor);   %�����ٶȽṹ
%caxis([min(v),max(v)]);
colorbar    %����ɫ��
annotation('textbox',[0.80,0.894,0.5,0.1],'linestyle','none','String','�ٶ�/km.s^-^1') 
hold on%ͼ�α��֣�ʹ�ú���Ļ�ͼ�ڴ˻�����
plot(0,h0,'p')
%����������ڵĲ�͵������Դ�㶥���ľ���dz
dz = h0;
SLayerNum = 1;
for l=2:length(deep)
%����Դ���С���ٶ�ģ����ĳ�㣬��ô��Դ�ڸò����һ��
if (h0 < deep(l))
dz  = h0 - deep(l-1);
%������Դ���ڲ�
        SLayerNum = l-1;
break;
end%End IF    
end%End FOR
%�����Դ��ȴ����ٶ�ģ��������㣬������Դ��㶥��������ڲ�
if h0 > deep(length(deep)) 
dz  = h0 - deep(length(deep));
       SLayerNum = length(deep);
end%End IF
h1=h0;
x=epi;thetaj=asin(v(SLayerNum)/v(moholayer));     %����(6-7-14)ʽ
thick=2*(deep(SLayerNum+1)-deep(SLayerNum))-dz; %����Դ�㴫�����ܺ��
x0=thick*tan(thetaj); %��Դ��ĵ��𲨴�����ˮƽ�����ܺ�
Pntime=thick/(v(SLayerNum)*cos(thetaj)); %���ݣ�6-7-17��ʽ����
for l=SLayerNum+1:moholayer-1    %��Դ������Ĵ���
thick= deep(l+1)-deep(l);
x0=x0+2*thick*tan(asin(v(l)/v(moholayer)));  %
  Pntime=Pntime+2*thick/(v(l)*cos(asin(v(l)/v(moholayer))));
end
for l=SLayerNum-1:-1:1   %��Դ������Ĵ���
thick= deep(l+1)-deep(l);
  x0=x0+thick*tan(asin(v(l)/v(moholayer)));   %����(6-7-16)ʽ����
  Pntime=Pntime+thick/(v(l)*cos(asin(v(l)/v(moholayer)))); %���ݣ�6-7-17��ʽ����
end
if(x<x0)Pntime=0;exit;end
PnTim=[];
xx0=x0;
for epi=xx0:5:140
x=epi;thetaj=asin(v(SLayerNum)/v(moholayer));     %����(6-7-14)ʽ
thick=2*(deep(SLayerNum+1)-deep(SLayerNum))-dz; %����Դ�㴫�����ܺ��
x0=thick*tan(thetaj); %��Դ��ĵ��𲨴�����ˮƽ�����ܺ�
Pntime=thick/(v(SLayerNum)*cos(thetaj)); %���ݣ�6-6-17��ʽ����
for l=SLayerNum+1:moholayer-1    %��Դ������Ĵ���
thick= deep(l+1)-deep(l);
x0=x0+2*thick*tan(asin(v(l)/v(moholayer)));  %
  Pntime=Pntime+2*thick/(v(l)*cos(asin(v(l)/v(moholayer))));
end
for l=SLayerNum-1:-1:1   %��Դ������Ĵ���
thick= deep(l+1)-deep(l);
  x0=x0+thick*tan(asin(v(l)/v(moholayer)));   %����(6-7-16)ʽ����
  Pntime=Pntime+thick/(v(l)*cos(asin(v(l)/v(moholayer)))); %���ݣ�6-7-17��ʽ����
end
if(x<x0)Pntime=0;exit;end
Pntime=Pntime+(x-x0)/v(moholayer)   %���ݣ�6-7-17��ʽ����
PnTim=[PnTim,Pntime];
xmoho=x-x0;
%����ײ�·��
h0=h1;
thick= deep(SLayerNum+1)-deep(SLayerNum)-dz;
xx=thick*tan(thetaj);
plot([0,xx],[h0,h0+thick],'w','LineWidth',2);
h0=h0+thick;
for l=SLayerNum+1:moholayer-1    %��Դ������Ĵ���
thick=deep(l+1)-deep(l);
dx=thick*tan(asin(v(l)/v(moholayer)));
plot([xx,xx+dx],[h0,h0+thick],'w','LineWidth',2);
xx=xx+dx;  %���о��ۼ�
  h0=h0+thick; 
end
plot([xx,xx+xmoho],[h0,h0],'w','LineWidth',2);
xx=xx+xmoho;
for l=moholayer-1:-1:1   %���ϴ���
thick=deep(l+1)-deep(l);  
dx=thick*tan(asin(v(l)/v(moholayer)));
plot([xx,xx+dx],[h0,h0-thick],'w','LineWidth',2);
  xx=xx+dx;   %����(6-7-16)ʽ����
  h0=h0-thick;
end
set(gca,'Ydir','reverse','box','on') %ʹ��y�᷽�������ܼ��Ͽ�
%����ǰ��ͼ��y�᷽����ʹ�÷�����ȴ����²�����������ҽ��ұߺ��ϱ߾����Ͽ�
pause
end
xlabel('���о�/km')   %��x��ı��
ylabel('���/km')    %��y��ı��
figure(2)
plot(xx0:5:140,PnTim,'r-*');
xlabel('���о�/km')   %��x��ı��
ylabel('��ʱ/s')   %��y��ı��
