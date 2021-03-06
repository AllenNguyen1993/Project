a_x=0;
a_y=0;
b_x=2*pi;
b_y=2*pi;
N_x=input('Please enter the number of internal points in x direction:  ');
N_y=input('Please enter the nubmer of internal points in y direction:  ');
threshold_difference=input('please enter threshold value for average difference, 1e-12(recommended):  ')
%This is threshold for average difference value under which temperature
%distribation is no longer chaning in time and iteration process stops.
del_x=(b_x)/(N_x+1);  %N_x+1 is the number of segments resulting from the existence of N_x internal points in x diection.
del_y=(b_y)/(N_y+1);  %N_y+1 is the number of segments resulting from the existence of N_y internal points in y drection.
sum_del=(del_y^2)+(del_x^2);
del_x_squared=(del_x)^2;
del_y_squared=(del_y)^2;
del_t=(del_x_squared*del_y_squared)/(2*sum_del); % The Von Neumann stability method defines del_t value
index_x=0:N_x+1;
index_y=0:N_y+1;
D=del_t/((del_x*del_y)^2);
x_k=del_x*index_x; 
y_j=del_y*index_y;
u_x_0=((y_j).^3).';  %Boundary condition in x dimension at x=0
u_x_2pi=(((y_j).^2).*cos(y_j)).'; %Boundary condition in x dimension at x=2pi
u_y_2pi=u_x_0(N_y+2)+(x_k/(2*pi))*(u_x_2pi(N_y+2)-u_x_0(N_y+2)); %Boundary condition in y dimension at y=2pi
u_num_current=zeros(N_y+2,N_x+2); %"plus two" is due to boundary points being included 
u_num_newer=[[u_x_0(1:N_y+1),zeros(N_y+1,N_x),u_x_2pi(1:N_y+1)];u_y_2pi];
current_time=0;
total_elements=numel(u_num_current);
average_difference=1; %This initial value for average error is arbitary to kickstart iteration process

while average_difference> threshold_difference
    current_time=current_time+del_t;
    
     for i=2:N_x+1 
        u_num_newer(1,i)=D*(-2*sum_del*u_num_current(1,i)+del_y_squared*(u_num_current(1,i-1)+u_num_current(1,i+1))+2*del_x_squared*u_num_current(2,i))+u_num_current(1,i);
        
        for j=2:N_y+1
            u_num_newer(j,i)=D*(-2*sum_del*u_num_current(j,i)+del_y_squared*(u_num_current(j,i-1)+u_num_current(j,i+1))+del_x_squared*(u_num_current(j-1,i)+u_num_current(j+1,i)))+u_num_current(j,i);
        end 
        
     end 
    
    u_num_old=u_num_current; %When iterations continue through time, current values becomes old values
    u_num_current=u_num_newer; % And newer values become current values
    difference=abs(u_num_current-u_num_old);
    average_difference=(1/total_elements)*sum(difference(:));
end

[X,Y]=meshgrid(x_k,y_j);
surf(X,Y,u_num_current)
plot_name=sprintf('2D Temperature Distribution');
info=sprintf('Number of internal points in x direction: %g\nNumber of internal points in y direction: %g\nDelta t: %1.12g\nMethod: Explicit',N_x,N_y,del_t)
title(plot_name)
text(4,5,240,info)
xlabel('X')
ylabel('Y')
zlabel('Temperature Distribuation')

