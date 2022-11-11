function rt=findroot(h,prea,omga,dm,betam,roum)
%得到方程的根
	x=prea;
	F0 = love(x,omga,dm,betam,roum);
    x=x+h;
	F1 = love(x,omga,dm,betam,roum);
	while(F1/F0>0.0) 
        F0=F1;
        if(x-10.0>=0) 'cannot find the answer'   
        else x=x+h;  F1 = love(x,omga,dm,betam,roum);
        end
    end
   i=0;            %迭代此处记数 　
   t1=x-h;         %迭代初值t1 
   t2=x;           %迭代初值t2 　
   while i<=100; y=t2-love(t2,omga,dm,betam,roum)/(love(t2,omga,dm,betam,roum)-love(t1,omga,dm,betam,roum))*(t2-t1);                    %弦截法迭代格式 　　
       if abs(y-t2)>10^(-6);      %收敛判据 　　    
           t1=t2;     t2=y; 
       else break 
       end
       i=i+1;
   end
   rt=y;
   return
