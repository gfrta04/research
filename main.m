addpath(genpath('\function'))
%% caseA.B,C,Dのいずれか　case1,case2のいずれかを決める
type1 = input('A,B,C,Dのうちいずれかを入力してください','s')
type2 = input('1,2のうちいずれかを入力してください','s')

%%
[ a_eu,b_eu,a_ey,b_ey,a_w,b_w ] = get_noize(type1) %ノイズの性質の取得
b_eu0 = 10^-8; %euの標準偏差の初期値を設定
iend = 3;
for i = 0:iend
    %% 伝達関数とサンプリング周期Tsの取得
    [ G_int,G_s,G,H,Ts ] = get_den( type2 );
    %% 入力用M系列生成
    m = 6;
    N=10^m; %M系列の周期
    N2=N;  %信号の長さ
    rng(m+i*10000000)
    u  = randn(1,N2); %M系列uを生成
    %% w
    rng(10000*m+i*10000000);
    w = a_w + b_w.*randn(1,N2); %正規分布に従う雑音w
    
    %% uobs
    rng(100*m+i*10000000);
    b_eu = b_eu0*10^(3*i) %euの分散を設定
    eu = a_eu + b_eu.*randn(1,N2);
    uobs = u + eu;
    t  = 0:Ts:Ts*(N2-1);
    
    uint = lsim(G_int,uobs,t);
    uintd=detrend(uint); %uobsの積分uintの線形トレンドを除去
    
    %% Gu(y=Gu+Hwの第一項）
    %Gu = G*u
    Gu = lsim(G,u,t); %G*uのダイナミクスシステムの時間応答を生成
    
    %% Hw(y=Gu+Hwの第二項）を構成
    Hw= lsim(H,w,t); %H*wのダイナミクスシステムの時間応答を生成
    
    %% yを構成
    y = Gu + Hw;
    
    %% 観測予測値を求める
    ey = a_ey + b_ey.*randn(N2,1);
    yobs = y + ey;
    yobsd=detrend(yobs);
    
    %% 伝達関数uからyの伝達関数G
    data = iddata(yobsd,uintd,Ts)
    G_s_est = arx(data,[2 3 0]) %arx(data,[極 零点+1 option])
    G_est = G_s_est*G_int;
    
    %% ボード
    if i == 0
        figure
        bode(G);       
    end
    %--位相線図のプロットを0°付近でおこなうように設定 ここから--
    p = bodeoptions;
    p.PhaseMatching = 'on';
    p.PhaseMatchingValue = 0;
    %--ここまで--
    hold on
    bode(G_est);
    legend('真のボード線図','eu =10^-8','eu =10^-5','eu =10^-2','eu =10^1','eu =10^4')
    
    %% エラーバーを搭載した||Gs-Gsest||-時間tのグラフを表示
    Er = norm(G_s-G_s_est,2);   %H2ノルムを計算
    if i == 0
        E = zeros(iend,1);
        M = zeros(iend,1);
    end
        E(i+1,1) = Er;
        M(i+1,1) = b_eu;
 
end
figure
loglog(M,E)
xlabel('euの標準偏差')
ylabel('伝達関数の差のH2ノルム')
title(strcat('euの標準偏差と相対誤差_case',type1,type2))
saveas(gcf,strcat('euの標準偏差と相対誤差_case',type1,type2,'.png'))
%--------------------------------%