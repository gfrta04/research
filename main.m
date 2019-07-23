addpath(genpath('\function'))
%% caseA.B,C,D�̂����ꂩ�@case1,case2�̂����ꂩ�����߂�
type1 = input('A,B,C,D�̂��������ꂩ����͂��Ă�������','s')
type2 = input('1,2�̂��������ꂩ����͂��Ă�������','s')

%%
[ a_eu,b_eu,a_ey,b_ey,a_w,b_w ] = get_noize(type1) %�m�C�Y�̐����̎擾
b_eu0 = 10^-8; %eu�̕W���΍��̏����l��ݒ�
iend = 3;
for i = 0:iend
    %% �`�B�֐��ƃT���v�����O����Ts�̎擾
    [ G_int,G_s,G,H,Ts ] = get_den( type2 );
    %% ���͗pM�n�񐶐�
    m = 6;
    N=10^m; %M�n��̎���
    N2=N;  %�M���̒���
    rng(m+i*10000000)
    u  = randn(1,N2); %M�n��u�𐶐�
    %% w
    rng(10000*m+i*10000000);
    w = a_w + b_w.*randn(1,N2); %���K���z�ɏ]���G��w
    
    %% uobs
    rng(100*m+i*10000000);
    b_eu = b_eu0*10^(3*i) %eu�̕��U��ݒ�
    eu = a_eu + b_eu.*randn(1,N2);
    uobs = u + eu;
    t  = 0:Ts:Ts*(N2-1);
    
    uint = lsim(G_int,uobs,t);
    uintd=detrend(uint); %uobs�̐ϕ�uint�̐��`�g�����h������
    
    %% Gu(y=Gu+Hw�̑�ꍀ�j
    %Gu = G*u
    Gu = lsim(G,u,t); %G*u�̃_�C�i�~�N�X�V�X�e���̎��ԉ����𐶐�
    
    %% Hw(y=Gu+Hw�̑�񍀁j���\��
    Hw= lsim(H,w,t); %H*w�̃_�C�i�~�N�X�V�X�e���̎��ԉ����𐶐�
    
    %% y���\��
    y = Gu + Hw;
    
    %% �ϑ��\���l�����߂�
    ey = a_ey + b_ey.*randn(N2,1);
    yobs = y + ey;
    yobsd=detrend(yobs);
    
    %% �`�B�֐�u����y�̓`�B�֐�G
    data = iddata(yobsd,uintd,Ts)
    G_s_est = arx(data,[2 3 0]) %arx(data,[�� ��_+1 option])
    G_est = G_s_est*G_int;
    
    %% �{�[�h
    if i == 0
        figure
        bode(G);       
    end
    %--�ʑ����}�̃v���b�g��0���t�߂ł����Ȃ��悤�ɐݒ� ��������--
    p = bodeoptions;
    p.PhaseMatching = 'on';
    p.PhaseMatchingValue = 0;
    %--�����܂�--
    hold on
    bode(G_est);
    legend('�^�̃{�[�h���}','eu =10^-8','eu =10^-5','eu =10^-2','eu =10^1','eu =10^4')
    
    %% �G���[�o�[�𓋍ڂ���||Gs-Gsest||-����t�̃O���t��\��
    Er = norm(G_s-G_s_est,2);   %H2�m�������v�Z
    if i == 0
        E = zeros(iend,1);
        M = zeros(iend,1);
    end
        E(i+1,1) = Er;
        M(i+1,1) = b_eu;
 
end
figure
loglog(M,E)
xlabel('eu�̕W���΍�')
ylabel('�`�B�֐��̍���H2�m����')
title(strcat('eu�̕W���΍��Ƒ��Ό덷_case',type1,type2))
saveas(gcf,strcat('eu�̕W���΍��Ƒ��Ό덷_case',type1,type2,'.png'))
%--------------------------------%