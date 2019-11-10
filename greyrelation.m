function com_xy = greyrelation(x,y) %调用的时候不用function英文前缀！！！我几次都弄错了，看来是Matlab基础薄弱啊~~~
y_row = size(y,1);%;%计算矩阵y的行数
y_col =size(y,2);%;%计算矩阵y的列数
x_col = size(x,2);%;%计算x的列数
if y_col ~= x_col
    error(message('MATLAB:greyrelation:wrong in input data'));
end
temp_y = y;%绝对关联度中比较序列中的数据处理后的矩阵
temp_x = x;%x数据处理后的矩阵
for i =1:x_col
   temp = x(i)-x(1); 
   temp_x(i)=temp;
end
for i =1:y_row
   for j=1:y_col
      temp = y(i,j) - y(i,1);
      temp_y(i,j)=temp;
   end
end%处理过程
%temp_x; 
%temp_y;
s0 = abs(sum(temp_x)-0.5*temp_x(x_col));
abs_xy =[];
for i=1:y_row
   si = abs(sum(temp_y(i,:))-0.5*temp_y(i,y_col));
si_s0 = abs(si-s0);
   abs_xy(i,1) =(1+s0+si)/(1+s0+si+si_s0);
end%计算绝对关联度%该步骤在编程过程中存在的问题是公式理解上存在偏差，公式没理解好
%下面开始计算相关关联度
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
%上述步骤是为了计算相关关联度，
%下面计算综合关联度
com_xy = 0.5*abs_xy +(1-0.5)*rela_xy;%返回的是综合关联度