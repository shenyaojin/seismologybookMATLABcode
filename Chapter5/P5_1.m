%P5_1.m
%tanh(x)����
plot([-10:0.1:10],tanh([-10:0.1:10]))   %����tanh(x)����
hold on   %ͼ�α��֣�ʹ�ú���Ļ�ͼ����ǰ���ͼ�Ļ���֮��
plot([0 0],ylim,'k');    %����y��
grid on   %��������
xlabel('x');ylabel('y');   %����x���y��ı��
title('y=tanh(x)')    %��������	
