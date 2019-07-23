function y=Mseq(a,reg,N)

%       a：シフトレジスタの係数　次元はR^(1×n) ここでnはm系列の周期

%       reg：レジスタの初期値　xk(k=0,1...n-1) 次元はR^(1×n)

%       N：M系列のデータ長 周期nをM回繰り返す場合 N=M(2^n-1)となる
%       0or1のM系列を出力

y=zeros(1,N); %yのサイズを宣言

%% x(k) = Σ(ai*xi)を計算 ここで+はEXORをあらわす (GF(2))
for k=1:N
        y(k)=reg(end); 
        regk=rem(dot(reg,a),2); %GF(2)でのΣ(ai*xi)は実数空間の足し合わせを2で割ったときの剰余となる
        %dot(A,B) :AとBの内積 , rem(A,B):実数空間A÷Bの剰余
        reg=[regk reg(1:end-1)];
end
y=2*(y-0.5); %平均0となるように線形変換