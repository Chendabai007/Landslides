function com_xy = greyrelation(x,y) %���õ�ʱ����functionӢ��ǰ׺�������Ҽ��ζ�Ū���ˣ�������Matlab����������~~~
y_row = size(y,1);%;%�������y������
y_col =size(y,2);%;%�������y������
x_col = size(x,2);%;%����x������
if y_col ~= x_col
    error(message('MATLAB:greyrelation:wrong in input data'));
end
temp_y = y;%���Թ������бȽ������е����ݴ����ľ���
temp_x = x;%x���ݴ����ľ���
for i =1:x_col
   temp = x(i)-x(1); 
   temp_x(i)=temp;
end
for i =1:y_row
   for j=1:y_col
      temp = y(i,j) - y(i,1);
      temp_y(i,j)=temp;
   end
end%�������
%temp_x; 
%temp_y;
s0 = abs(sum(temp_x)-0.5*temp_x(x_col));
abs_xy =[];
for i=1:y_row
   si = abs(sum(temp_y(i,:))-0.5*temp_y(i,y_col));
si_s0 = abs(si-s0);
   abs_xy(i,1) =(1+s0+si)/(1+s0+si+si_s0);
end%������Թ�����%�ò����ڱ�̹����д��ڵ������ǹ�ʽ����ϴ���ƫ���ʽû����
%���濪ʼ������ع�����
temp_y2 = y;
temp_x2 = x;
for i =1:x_col
   temp = x(i)/x(1); 
   temp_x2(i)=temp-1;
end
for i =1:y_row
   for j=1:y_col
      temp = y(i,j) / y(i,1);
      temp_y2(i,j)=temp-1;
   end
end
s02 = abs(sum(temp_x2)-0.5*temp_x2(x_col));
rela_xy=[];
for i=1:y_row
   si2 = abs(sum(temp_y2(i,:))-0.5*temp_y2(i,y_col));
si2_s02 = abs(si2-s02);
   rela_xy(i,1) =(1+s02+si2)/(1+s02+si2+si2_s02);
end
%����������Ϊ�˼�����ع����ȣ�
%��������ۺϹ�����
com_xy = 0.5*abs_xy +(1-0.5)*rela_xy;%���ص����ۺϹ�����