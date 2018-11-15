% Hearbeat.m
% this program is to iterate a nonlinear map that captures essential properties of the human heart
% the model is DIn = B - A(DI), we are given a formula for A(DI)

N = 100; %number of iterates
B = 40; %initial DI value

y = [x;x]; %store the x values
z = [0:100]/100;
fz = B-(100-(100./z-25));
xz = [x];

for j = 1:N
	f = B-(100-(100./x-25));
	x = f;
	xz = [xz;x];
	y = [y;x;x];
end
figure(1)
plot(y(1:2*N+1) , [0;y(3:2*N+2)],z,fz, 'r',z,z,'b--')
xlabel('DIn')
ylabel('DIn*')

figure(2)
plot(xz, '*');
xlabel('DIn')
ylabel('DIn*')
