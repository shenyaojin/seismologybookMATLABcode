load sedthk.xyz
sed_thk=reshape(sedthk(:,3),360,180);
[LAT,LON]=meshgrid([89.5:-1:-89.5],[-179.5:1:179.5]);
%[LAT,LON]=meshgrid([89.5:-1:-89.5],[0.5:1:359.5]);
%C_THK=[C_thk(181:360,:);C_thk(1:180,:)];
pcolor(LON,LAT,sed_thk);
shading interp
hold on
load coast;
plot(long,lat,'k')