% Gillespie algorithm for the SIR epidemic model
function SIR_DE
clear
global c

%specify parameter values
%set the rate constants
c(1) = .40;  %S->I
c(2) = 0.7; %I->R

 N = 100;  % number of samples
 
%initialize the state space

S0 =10000; % total number of substrate
E0 = 10;  % total number of enzyme
x = [S0*ones(N,1),E0*ones(N,1)];

 % specify the change matrix
 
 C = [-1,1;0,-1];

S = x(:,1);
Inf=x(:,2);
T = zeros(N,1);
t = zeros(N,1);
j = 1;
 Ht = 1;
K = 3000; % max number of time steps
while (Ht>0& j<K)
    j = j+1
    % list the reaction rates:
    r(:,1) =  c(1)*x(:,1).*x(:,2);
    r(:,2) = c(2)*x(:,2);
     H = sum(r');
     Ht = sum(H');
     hc = cumsum(r');
     % find the next reaction time
    rn = rand(N,1);
   
    t = t -(H'>0).*log(rn)./(H'+(H'==0));
    T = [T,t];
   % find the next reaction:
   rn = rand(N,1);
   for k = 1:N
       if (H(k)>0)
   rk = min(find(rn(k)<=hc(:,k)/H(k))); % this determines which reaction occurs
    x(k,:) = x(k,:) + C(rk,:);
   
       end
   end
    S = [S,x(:,1)]
    Inf = [Inf,x(:,2)];
    
   
   
end

%this routine solves the system of odes for an SIR epidemic
% now solve the deterministic equations

%specify the temporal output points
tspan = [0:.1:50];

%specify initial data

y0 = [100,.001];

[Tm,Y] = ode23(@SIR_deRHS,tspan, y0); 

% make figures
 figure(1)
 for k = 1:N
     plot(S(k,:),Inf(k,:))
     hold on
 end
 
plot(Y(:,1),Y(:,2),'linewidth',2)
xlabel('S')
ylabel('I')

hold off
figure(2)
 size(T)
 size(S)
 for k = 1:N
     plot(T(k,:),Inf(k,:))
     hold on
 end
plot(Tm,Y)
xlabel('time')
hold off
figure(3)
hist(S(:,end),[0:S0])

function F_prime=SIR_deRHS(t,y)
global c

s = y(1);
i = y(2);

Sp = -c(1)*i*s;
Ip = c(1)*i*s -c(2)*i;

F_prime = [Sp;Ip];
