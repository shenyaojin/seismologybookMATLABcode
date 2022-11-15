%P6_5.m
h=8;vs=3;vp=5;   
x=0:1:20;   
tp=x/vp.*sqrt(1+(h./x).^2);   
ts=x/vs.*sqrt(1+(h./x).^2);   
tpa=x./vp;  
tsa=x./vs; 
plot(x,tp,'b',x,ts,'r:',x,tpa,'b-.',x,tsa,'r--')  
legend('P Wave','S Wave','P wave asymptote','S wave asymptote','location','NorthWest')
xlabel('Epicenter Distance/km')
ylabel('Travel Time/s')   
set(gca,'box','on')
print -dpng P6_5.png
