function [ a_eu,b_eu,a_ey,b_ey,a_w,b_w ] = get_noize(type1)
%get_noize type='A'��'B'��'C'�̂����ꂩ�ɂ����
%���̃P�[�X�̃m�C�Y�̕��ςƕW���΍����o��
if type1 == 'A'
    a_eu = 3;
    b_eu = 0; %eu�̕W���΍�
    
    a_ey = 3;
    b_ey = 0; %ey�̕W���΍�
    
    a_w  = 0;
    b_w  = 0.1; %w�̕W���΍�
end

if type1 == 'B'    
    a_eu = 3;
    b_eu = 0.1; %eu�̕W���΍�
    
    a_ey = 3;
    b_ey = 0; %ey�̕W���΍�
    
    a_w  = 0;
    b_w  = 0.1; %w�̕W���΍�
end

if type1 == 'C'
    a_eu = 3;
    b_eu = 0; %eu�̕W���΍�
    
    a_ey = 3;
    b_ey = 0.001; %ey�̕W���΍�
    
    a_w  = 0;
    b_w  = 0.1; %w�̕W���΍�
end

if type1 == 'D'
    a_eu = 3;
    b_eu = 0.1; %eu�̕W���΍�
    
    a_ey = 0;
    b_ey = 0; %ey�̕W���΍�
    
    a_w  = 0;
    b_w  = 0; %w�̕W���΍�
end
end