A = [1.2 -0.5 0.1; 1 0 0; 0 1 0];

B = [-0.4; 0.6; 0.5];

C = [1 0 0];

D = 0;

Ts = -1;
sys = ss(A,[B B],C,D,Ts,'InputName',{'u' 'w'},'OutputName','y');


Q = 2.3; 
R = 1;

[kalmf,L,~,Mx,Z] = kalman(sys,Q,R);
kalmf = kalmf(1,:);

sys.InputName = {'u','w'};
sys.OutputName = {'yt'};
vIn = sumblk('y=yt+v');

kalmf.InputName = {'u','y'};
kalmf.OutputName = 'ye';

SimModel = connect(sys,vIn,kalmf,{'u','w','v'},{'yt','ye'});

t = (0:50)';
u = sin(3*t/17);

rng(10,'twister');
w = sqrt(Q)*randn(length(t),1);
v = sqrt(R)*randn(length(t),1);

out = lsim(SimModel,[u,w,v]);

yt = out(:,1);   % true response
ye = out(:,2);  % filtered response
y = yt + v; 

clf
subplot(211), plot(t,yt,'b',t,ye,'r--'), 
xlabel('Number of Samples'), ylabel('Output')
title('Kalman Filter Response')
legend('True','Filtered')
subplot(212), plot(t,yt-y,'g',t,yt-ye,'r--'),
xlabel('Number of Samples'), ylabel('Error')
legend('True - measured','True - filtered')