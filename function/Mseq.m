function y=Mseq(a,reg,N)

%       a�F�V�t�g���W�X�^�̌W���@������R^(1�~n) ������n��m�n��̎���

%       reg�F���W�X�^�̏����l�@xk(k=0,1...n-1) ������R^(1�~n)

%       N�FM�n��̃f�[�^�� ����n��M��J��Ԃ��ꍇ N=M(2^n-1)�ƂȂ�
%       0or1��M�n����o��

y=zeros(1,N); %y�̃T�C�Y��錾

%% x(k) = ��(ai*xi)���v�Z ������+��EXOR������킷 (GF(2))
for k=1:N
        y(k)=reg(end); 
        regk=rem(dot(reg,a),2); %GF(2)�ł̃�(ai*xi)�͎�����Ԃ̑������킹��2�Ŋ������Ƃ��̏�]�ƂȂ�
        %dot(A,B) :A��B�̓��� , rem(A,B):�������A��B�̏�]
        reg=[regk reg(1:end-1)];
end
y=2*(y-0.5); %����0�ƂȂ�悤�ɐ��`�ϊ�