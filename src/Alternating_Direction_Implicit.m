% Dimensions 
% a_x=0 <x<b_x=2pi
% a_y=0 <y<b_y=2pi
N_x=input('Please enter the number of internal points in x direction:  ');
N_y=input('Please enter the nubmer of internal points in y direction:  ');
total_elements=N_x*N_y; %Total number of elements u, not counting the u at boundary (add 1 to index to account for that u).
time=input('Please enter the amount of running time: '); % Setting the time interval this code will run.
T_points=input('Please enter the number of internal points for time dimension: ');
del_x=(2*pi)/(N_x+1);  %N_x+1 is the number of segments resulting from the existence of N_x internal points in x diection.
del_y=(2*pi)/(N_y+1);  %N_y+1 is the number of segments resulting from the existence of N_y internal points in y drection.
del_t=time/(T_points+1) %T_points+1 is the numer of segments resulting from the existence of T_points in time dimension.
lamda=del_t/(del_x)^2;
gamma=del_t/(del_y)^2;
a= 1+lamda; % a value is constant in space and time dimensions
b=[0,(-lamda/2)*ones(1,total_elements-1)];
c=[-lamda,(-lamda/2)*ones(1,total_elements-2)];
index_x=0:N_x+1;
index_y=0:N_y+1;
x_j=del_x*index_x; 
y_k=del_y*index_y;
u_x_0=((y_k).^3).';  %Boundary condition in x dimension at x=0
u_x_2pi=(((y_k).^2).*cos(y_k)).'; %Boundary condition in x dimension at x=2pi
u_y_2pi=u_x_0(N_y+2)+(x_j/(2*pi))*(u_x_2pi(N_y+2)-u_x_0(N_y+2)); %Boundary condition in y dimension at y=2pi
u_numerical_current=[u_x_0(1:N_y+1),zeros(N_y+1,N_x),u_x_2pi(1:N_y+1);u_y_2pi]; %u distribution at current time
u_numerical_plus_half=[u_x_0([1:n,zeros(N_y+2,N_x),u_x_2pi;u_y_2pi];%u distribution at 1/2 time step from current time
alpha_1=a;
Alpha=[alpha_1,zeros(1,total_elements-1)];
right_side=zeros(1,total_elements);
current_time=0;
%for A=N_y+1:N_y+1:total_elements+1;
        %right_side(A)=(gamma/2)*u(
        
%while current_time<=time
    %for B=2:N_x+1
        %for C=1:N_y+1 
            %right_side(C)=(gamma/2)*u_numerical_current(C,B-1)+(1+gamma)*u_numerical_current(C,B)+(gamma/2)*u_numerical_current(C,B+1);
            


 



