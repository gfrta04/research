function [ a_eu,b_eu,a_ey,b_ey,a_w,b_w ] = get_noize(type1)
%get_noize type='A'か'B'か'C'のいずれかによって
%そのケースのノイズの平均と標準偏差を出力
if type1 == 'A'
    a_eu = 3;
    b_eu = 0; %euの標準偏差
    
    a_ey = 3;
    b_ey = 0; %eyの標準偏差
    
    a_w  = 0;
    b_w  = 0.1; %wの標準偏差
end

if type1 == 'B'    
    a_eu = 3;
    b_eu = 0.1; %euの標準偏差
    
    a_ey = 3;
    b_ey = 0; %eyの標準偏差
    
    a_w  = 0;
    b_w  = 0.1; %wの標準偏差
end

if type1 == 'C'
    a_eu = 3;
    b_eu = 0; %euの標準偏差
    
    a_ey = 3;
    b_ey = 0.001; %eyの標準偏差
    
    a_w  = 0;
    b_w  = 0.1; %wの標準偏差
end

if type1 == 'D'
    a_eu = 3;
    b_eu = 0.1; %euの標準偏差
    
    a_ey = 0;
    b_ey = 0; %eyの標準偏差
    
    a_w  = 0;
    b_w  = 0; %wの標準偏差
end
end