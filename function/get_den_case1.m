%case1 H�ɐϕ�����܂ޏꍇ

%% �T���v�����O����
Ts = 0.005;

%% �ϕ���Gint��G����ϕ������菜�����`�B�֐�G_s��G
%G = G_s*G_int�ƂȂ�悤��G_int:�ϕ����G_s���`
%G = (0.4q^-1 + 0.3q^-2)/(1-1.8q^-1+1.3q^-2-0.5q^-3)���
%G_int:=1/(1-1^-q)
%G_s:=(0.4q^-1+0.3q^-2)/(1-0.8q^-1+0.5q^-2)
        
numin=[1 0];
denin=[1 -1];
G_int = tf(numin,denin,Ts)

numtilde = [0 0.4  0.3];
dentilde = [1 -0.8 0.5];
G_s = tf(numtilde,dentilde,Ts)
        
G = G_s*G_int

%% �G�����f��H
%H = 1 / A
%H = 1/(1-1.8q^-1+1.3q^-2-0.5q^-3)
%wH = H*w
numH= [1 0 0];
denH= [1 -1.8 1.3 -0.5];
H = tf(numH,denH,Ts) %�T���v������Ts�̗��U���Ԃ̗��U���ԓ`�B�֐��̍쐬