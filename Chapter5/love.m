function f=love(c,omga,dm,betam,roum)    %Love �������
mium=roum.*betam.^2;                  %��=��*��m2
n=length(dm); 
k=omga/c;                             % k=��/c
for ii=1:n
    if(c>betam(ii)) rbetam(ii)=sqrt((c/betam(ii))^2-1);else rbetam(ii)=-i*sqrt(1-(c/betam(ii))^2);end    %r��m(ii)=i*��(1-(c/��m(ii)2))
end
Qm=k*rbetam.*dm;                     %Qm=k* r��m*dm
A=[1,0;0,1];
for ii=n-1:-1:1
    am=[cos(Qm(ii)), i*sin(Qm(ii))/rbetam(ii)/mium(ii);i*mium(ii)*rbetam(ii)*sin(Qm(ii)), cos(Qm(ii))];      %am=[cos(Qm),i*sin(Qm)/ ��/��,i*��* r��m*sin(Qm),cos(Qm)]
    A=A*am;
end
f=(A(2,1)+mium(n)*rbetam(n)*A(1,1))/i;         %f=(A(2,1)+ ��(n)* r��m(n)*A(1,1))/i
return
