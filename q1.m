A=[0.99 0.03 -0.02 -0.32; 0.01 0.47 4.70 0; 0.02 -0.06 0.40 0; 0.01 -0.04 0.72 0.99];
B=[0.01 0.99; -3.44 1.66; -0.83 0.44; -0.47 0.25];
C=[1 0 0 0; 0 0 0 0];

E=eig(A);

control_mat=ctrb(A,B);
control_mat_rank=rank(control_mat);


oberv_mat=obsv(A,C);
oberv_mat_rank=rank(oberv_mat);
p1=[-2i; 2i; -11i; 11i]; %eigen values for  Lyapunov stable condition
K1=place(A,B,p); %gain matrix for Lyapunov stable condition
p2=[-1; -3.1; -1.5; -7]; %eigen values for  asymptotically stable condition
K2=place(A,B,p); %Gain matrix  for  asymptotically stable condition

Q=eye(4,4);
R=eye(2,2);
N=zeros(4,2);
[K3,S,e]=lqr(A,B,Q,R,N); %K3=LQR gain matrix