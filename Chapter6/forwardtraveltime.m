function forwardtraveltime()
clc
SubDel=0.0001;  %��Դ�ǵ���ʱ��С�ڸ�ֵ��������
Stx=[150 0 150 300 300 300 150 0 0];   %̨վ��x����
Sty=[150 300 300 300 150 0 0 0 150];  %̨վ��y����
Stz=zeros(1,9);                      %̨վ��z����
FirLocal=[75.071,50.000,19,0.0];    %�ٶ���Դ��x��y��z�ͷ���ʱ��
plot(Stx,Sty,'^','MarkerFaceColor','b')
text(Stx+5,Sty,num2str([1 2 3 4 5 6 7 8 9]'))
hold on
plot(75.071,50.000,'p','MarkerFaceColor','r')
text(75.071,50.0,'��Դ');
xlabel('X/km');ylabel('Y/km')
axis([-10 310,-10,310])
Vp=[2.5,5.3,6.1,6.6,7.2,7.9];   %P���ٶ�ģ��
Vs=[1.1,3.1,3.5,3.8,4.0,4.5];   %S���ٶ�ģ��
deep=[0,1,3,24,38,46];   %������������
%ע����ڵؿ��ٶ�ģ�ͣ��ر����Ϊ��Ϊ��һ�����棬����Ϊ�ڶ����棬�ȵȣ�����һ���ٶ�Ϊ�ڶ�����͵�һ������в�Ľ����ٶ�
%��ˣ���i����ٶ�Ϊ��i�������i+1���������еĽ����ٶȣ�����ΪDeep(i+1)-Deep(i)
Pg=zeros(1,length(Stx));
for ii=1:length(Stx)  
%����������ڵĲ�͵������Դ�㶥���ľ���DisDeep
[Disdep,SLayerNum]=getParam(deep,FirLocal(3));
%����̨վP�������
[takeoff,Azim] = getangle(Vp,deep,FirLocal,SLayerNum,Stx(ii),Sty(ii),Disdep,SubDel);
%����̨վP����ʱ
Pg(ii) = gettime(Vp,deep,takeoff,SLayerNum,Disdep); 
%����̨վS�������
[SeiTakeoff,Azi]= getangle(Vs,deep,FirLocal,SLayerNum,Stx(ii),Sty(ii),Disdep,SubDel);
%����̨վS����ʱ
Sg(ii) = gettime(Vs,deep,SeiTakeoff,SLayerNum,Disdep); 
SeiDelta=sqrt((Stx(ii)-FirLocal(1))^2+(Sty(ii)-FirLocal(2))^2);
[Pn(ii),takeoff]=PnTraveltime(Vp,deep,SeiDelta,SLayerNum,Disdep);
end
[Pg;Sg;Pn]

function [Disdep,SLayerNum]=getParam(deep,Sdep)
%�õ���Դ���һ��̨վ�Ĳ���
% output
%      Disdep:  ��Դ��㶥����
%      LayerNum: ��Դ���ڲ�
% input
%      deep��ÿ��Ľ������
%      Sdep������λ��Դ���

%������Դ��㶥����
DisDeep  = Sdep- deep(1);
        SLayerNum = 1;
for l=2:length(deep)
%����Դ���С���ٶ�ģ����ĳ�㣬��ô��Դ�ڸò����һ��
if (Sdep < deep(l))
Disdep  = Sdep - deep(l-1);
%������Դ���ڲ�
                SLayerNum = l-1;
break;
end%End IF    
end%End FOR
%�����Դ��ȴ����ٶ�ģ��������㣬������Դ��㶥��������ڲ�
if Sdep > deep(length(deep)) 
Disdep  = Sdep - deep(length(deep));
            SLayerNum = length(deep);
end%End IF
% End FUNCTION

function [SeiTakeoff,Azi]=getangle(speed,deep,FirLocal,SLayerNum,lon,lat,Disdep,SubDel)
%������Դ���ڲ�������
% output
%      SeiTakeoff: ��Դ��̨վ������ǣ�ʹ�õ��������������ֵ��
% input
%      speed�������ٶ�
%      deep���ٶ�ģ�͵Ľ������
%      Firlocal���޶�����Դ��������һ�μ���Ϊ����λ��Դ������
%      SLayerNum����Դ���ڲ�
%      lon��̨վ����
%      lat��̨վγ��
%      Disdep����㶥����
%      SubDel��ϵͳ��������Դ�ǵ���ʱ��С�ڸ�ֵ����������

%�������в����������о�
        X=lon-FirLocal(1);
        Y=lat-FirLocal(2);
        Dist = sqrt(X^2 + Y^2);  %�������о�
        Azi=atan2(X,Y);   %�����λ��,����������ļн�
%�����������
        MaxTakeoff = atan(Dist/Disdep);
%���������С��
        MinTakeoff = atan(Dist/(FirLocal(3)-deep(1)));  
%������Ӧ����FirLocal(3),����ʱ��̨վ�̣߳�����̨վ�߳�ʱ��Ҫ����
%��������ǳ�ֵ
        SeiTakeoff = (MaxTakeoff + MinTakeoff)/2;
%��������Ǻ��ٶ�ģ�ͣ��������о�
        NewDist = getdisk(speed,deep,SeiTakeoff,SLayerNum,Disdep);
%�����������ǣ��ƽ���ϵͳ����ֵ����������
while (abs(NewDist - Dist) > SubDel)  
%�������оࣨNewDist��Dist�����������
if Dist > NewDist
               MinTakeoff = SeiTakeoff;
elseif Dist < NewDist
               MaxTakeoff = SeiTakeoff;
end%End IF
           SeiTakeoff = (MaxTakeoff + MinTakeoff)/2;

%�����µ�����ǣ����¼������о�
           NewDist = getdisk(speed,deep,SeiTakeoff,SLayerNum,Disdep);

%���ǵ���С�ǣ���������
if (MinTakeoff == MaxTakeoff)
break;
end% End IF    
%������С�ǲ�ֵС��SubDel*(10^(-10))����������
if(abs(MinTakeoff - MaxTakeoff)< SubDel*(10^(-10)))
break;
end%End IF
end%End WHILE   
% End FUNCTION    
function ModelTime = gettime(speed,deep,takeoff,SLayerNum,Disdep)
%����̨վ��ʱ
% output
%      ModelTime��̨վ��ʱ
% input
%      speed�������ٶ�
%      deep���ٶ�ģ�͵Ľ������
%      angle�������
%      SLayerNum����Դ���ڲ�
%      Disdep����Դ��㶥����

%������Դ���ڲ����ʱ
        ModelTime = Disdep/(cos(takeoff)*speed(SLayerNum)); %��6-7-9��ʽ
%������Դ�ڸ�������ʱ֮�ͣ���Դ��̨վ����ʱ��
for l=SLayerNum-1:-1:1
            cosAngle = sqrt(1 - (speed(l)*sin(takeoff)/speed(SLayerNum))^2);   %��6-7-8����һʽ
            ModelTime = ModelTime + (deep(l+1)-deep(l))/(cosAngle*speed(l));    %��6-7-9��ʽ
end%End FOR
function [Pntime,takeoff]=PnTraveltime(speed,deep,Delta,SLayerNum,Disdep)
%�����ײ��ٽ���룬�ٶ����һ��Ϊ��᣶���
       m=length(speed);
       Delta0=0;
for l=SLayerNum+1:m-1    %��Դ������Ĵ���
         Delta0=Delta0+2*(deep(l+1)-deep(l))*tan(asin(speed(l)/speed(m)));         
end
      takeoff=asin(speed(SLayerNum)/speed(m));   %��ó�Ϊ�ײ�����Դ��
Delta0=Delta0+(2*((deep(SLayerNum+1)-deep(SLayerNum)))-Disdep)*tan(takeoff); %��Դ�㴫����ˮƽ����
for l=SLayerNum-1:-1:1   %��Դ������Ĵ���
        Delta0=Delta0+(deep(l+1)-deep(l))*tan(asin(speed(l)/speed(m)));
end
if(Delta<Delta0)Pntime=0;return;end
      Pntime=0;
for l=SLayerNum+1:m-1    %��Դ������Ĵ���
         Pntime=Pntime+2*(deep(l+1)-deep(l))/(speed(l)*cos(asin(speed(l)/speed(m))));
end
      Pntime=Pntime+(2*((deep(SLayerNum+1)-deep(SLayerNum)))-Disdep)/(speed(SLayerNum)*cos(takeoff)); %��Դ��Ĵ���
for l=SLayerNum-1:-1:1   %��Դ������Ĵ���
        Pntime=Pntime+(deep(l+1)-deep(l))/(speed(l)*cos(asin(speed(l)/speed(m))));
end
      Pntime=Pntime+(Delta-Delta0)/speed(m);
return

function  ModelDelta = getdisk(speed,deep,takeoff,SLayerNum,Disdep)
% output
%      ModelDelta�����о�
% input
%      speed���ٶ�ģ���и����ٶ�
%      deep����Դ���
%      takeoff����Դ��
%      SLayerNum����Դ���ڲ�
%      Disdep����㶥����

%��������ڣ�������ߵľ���
        ModelDelta = Disdep*tan(takeoff);  %��6-7-11��ʽ
%��������ڸ������ߵľ���֮�ͣ����оࣩ
for l=SLayerNum-1:-1:1
            tanAngle = sin(takeoff)/sqrt((speed(SLayerNum)/speed(l))^2 - (sin(takeoff))^2);   %(6-7-8)�ڶ�ʽ
            ModelDelta = ModelDelta + (deep(l+1)-deep(l))*tanAngle;   %��6-7-11��ʽ
end%End FOR
