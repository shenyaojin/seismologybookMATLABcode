function f=love(c,omga,dm,betam,roum)    %Love º¯Êý±í´ï
mium=roum.*betam.^2;                  %¦Ì=¦Ñ*¦Âm2
n=length(dm); 
k=omga/c;                             % k=¦Ø/c
for ii=1:n
    if(c>betam(ii)) rbetam(ii)=sqrt((c/betam(ii))^2-1);else rbetam(ii)=-i*sqrt(1-(c/betam(ii))^2);end    %r¦Ñm(ii)=i*¡Ì(1-(c/¦Âm(ii)2))
end
Qm=k*rbetam.*dm;                     %Qm=k* r¦Ñm*dm
A=[1,0;0,1];
for ii=n-1:-1:1
    am=[cos(Qm(ii)), i*sin(Qm(ii))/rbetam(ii)/mium(ii);i*mium(ii)*rbetam(ii)*sin(Qm(ii)), cos(Qm(ii))];      %am=[cos(Qm),i*sin(Qm)/ ¦Ã/¦Ì,i*¦Ì* r¦Ñm*sin(Qm),cos(Qm)]
    A=A*am;
end
f=(A(2,1)+mium(n)*rbetam(n)*A(1,1))/i;         %f=(A(2,1)+ ¦Ì(n)* r¦Ñm(n)*A(1,1))/i
return
