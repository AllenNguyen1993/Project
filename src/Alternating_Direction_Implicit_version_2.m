a_x=0;
a_y=0;
b_x=2*pi;
b_y=2*pi;
N_x=input('Please enter the number of internal points in x direction:  ');
N_y=input('Please enter the nubmer of internal points in y direction:  ');
del_t=('please enter a value for delta t: '); %since ADI method is uncindtionally stable, del_t technically can be any thing, but error increases with del_t
del_x=(b_x)/(N_x+1);  %N_x+1 is the number of segments resulting from the existence of N_x internal points in x diection.
del_y=(b_y)/(N_y+1);  %N_y+1 is the number of segments resulting from the existence of N_y internal points in y drection.
lamda=del_t/(del_x)^2;
gamma=del_t/(del_y)^2;
a=1+lamda; % a value is constant in space and time dimensions
index_x=0:N_x+1;
index_y=0:N_y+1;
x_k=del_x*index_x; 
y_j=del_y*index_y;
u_x_0=((y_j).^3).';  %Boundary condition in x dimension at x=0
u_x_2pi=(((y_j).^2).*cos(y_j)).'; %Boundary condition in x dimension at x=2pi
u_y_2pi=u_x_0(N_y+2)+(x_k/(2*pi))*(u_x_2pi(N_y+2)-u_x_0(N_y+2)); %Boundary condition in y dimension at y=2pi
u_num_current=zeros(N_y+2,N_x+2);
u_num_half=zer