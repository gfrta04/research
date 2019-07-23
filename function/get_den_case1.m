%case1 Hに積分器を含む場合

%% サンプリング時間
Ts = 0.005;

%% 積分器GintとGから積分器を取り除いた伝達関数G_sとG
%G = G_s*G_intとなるようにG_int:積分器とG_sを定義
%G = (0.4q^-1 + 0.3q^-2)/(1-1.8q^-1+1.3q^-2-0.5q^-3)より
%G_int:=1/(1-1^-q)
%G_s:=(0.4q^-1+0.3q^-2)/(1-0.8q^-1+0.5q^-2)
        
numin=[1 0];
denin=[1 -1];
G_int = tf(numin,denin,Ts)

numtilde = [0 0.4  0.3];
dentilde = [1 -0.8 0.5];
G_s = tf(numtilde,dentilde,Ts)
        
G = G_s*G_int

%% 雑音モデルH
%H = 1 / A
%H = 1/(1-1.8q^-1+1.3q^-2-0.5q^-3)
%wH = H*w
numH= [1 0 0];
denH= [1 -1.8 1.3 -0.5];
H = tf(numH,denH,Ts) %サンプル時間Tsの離散時間の離散時間伝達関数の作成