% simulate a Markov process

%gambler's ruin

%specify the size of the problem

N = 100;

% specify the probability of winning
p = 0.01;
%B = .1;
%Y = .1;
tk  = 100000;
count = zeros(N+1,1);
S(1) = 1;
for j = 2:tk
    q = (S(j-1)>0&S(j-1)<N);
S(j) = S(j-1) + (2*(rand(1)<p)-1)*q +(S(j-1)==0)-(S(j-1)==N);
count(S(j)+1)= count(S(j)+1) + 1;
end
plot(S)

% second algorithm - splitting probability
sS = [];
sj = [];

count = zeros(100,1);
for k = 1:tk
    S = 1;
K = 1;
j = 0;
while( K ==1)
    S = S + 2*(rand(1)<p)-1;
    j = j+1;
    K = (S>0&S<N);
end
sS(k) =S;
sj(k) =j;
count(j) = count(j) + 1;
end
innn = [1:100];
innn*count/tk  % expected value of j
sum(sS)/N/tk  % percentage of wins
    
\