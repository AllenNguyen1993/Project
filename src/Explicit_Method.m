a_x=0;
a_y=0;
b_x=2*pi;
b_y=2*pi;
N_x=input('Please enter the number of internal points in x direction:  ');
N_y=input('Please enter the nubmer of internal points in y direction:  ');
del_x=(b_x)/(N_x+1);  %N_x+1 is the number of segments resulting from the existence of N_x internal points in x diection.
del_y=(b_y)/(N_y+1);  %N_y+1 is the number of segments resulting from the existence of N_y internal points in y drection.
del_t=((del_x*del_y)^2)/2((del_y^2)+(del_x^2)); % The Von Neumann stability method defines del_t value
index_x=0:N_x+1;
index_y=0:N_y+1;
D=del_t/((del_x*del_y)^2);
sum_del=(del_y^2)+(del_x^2);
del_x_squared=(del_x)^2;
del_y_squared=(del_y)^2;
x_k=del_x*index_x; 
y_j=del_y*index_y;
u_x_0=((y_j).^3).';  %Boundary condition in x dimension at x=0
u_x_2pi=(((y_j).^2).*cos(y_j)).'; %Boundary condition in x dimension at x=2pi
u_y_2pi=u_x_0(N_y+2)+(x_k/(2*pi))*(u_x_2pi(N_y+2)-u_x_0(N_y+2)); %Boundary condition in y dimension at y=2pi
u_num_current=[[u_x_0(1:N_y+1),zeros(N_y+1,N_x),u_x_2pi(1:N_y+1)];u_y_2pi]; 
u_num_newer=[[u_x_0(1:N_y+1),zeros(N_y+1,N_x),u_x_2pi(1:N_y+1)];u_y_2pi]
current_time=0;
total_elements=numel(u_num_current);
average_error=1; %This initial value for average error is arbitary to kickstart iteration process

while average_error>0.001
    current_time=current_time+del_t;
    
    for i=2:N_x+1
        u_num_newer(1,i)=D*(-2*sum_del*u_num_current(1,i)+del_y_squared*(u_num_current(1,i-1)+u_num_current(1,i+1))+2*del_x_squared*u_num_current(2,i));
        for j=2:N_y+1
            u_num_newer(j,i)=D*(-2*sum_del*u_num_current(j,i)+del_y_squared*(u_num_current(j,i-1)+u_num_current(j,i+1)+del_x_squared*(u_num_current(j-1,i)+u_num_current(j+1,i);
        end
    end
    
    u_num_old=u_num_current; %When iterations continue through time, current values becomes old values
    u_num_current=u_num_newer; % And newer values become current values
    relative_error=abs((u_num_current-u_num_old).\u_num_old);
    avergae_error=(1/total_elements)*sum(relative_error(:));
end

