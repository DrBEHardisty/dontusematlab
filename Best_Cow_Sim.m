% C_n+1 = M.*C tells us how C changes over time
%n = 25 is the number of generations
%g,d,p are values of how many calves, yearlings & 2 year olds there are
%100 = number of calves the sim begins with, 0=g,p
%M = [g,d,p]
%C = [0 .10 1.2; .90 0 0; 0 .90 0]

function x = Best_Cow_Sim(M,C,x0,n)
format long

x = x0;
for i = 1:n
    x = M.*C;
end