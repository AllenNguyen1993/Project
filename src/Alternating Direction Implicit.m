N_x=input('Please enter the number of internal points in x direction:  ');
N_y=input('Please enter the nubmer of internal points in y direction:  ');
time=input('Please enter the amount of running time: '); % Setting the time interval this code will run.
T_points=input('Please enter the number of internal points for time dimension: ');
del_x=(2*pi)/(N_x+1);  %N_x+1 is the number of segments resulting from the existence of N_x internal points in x diection.
del_y=(2*pi)/(N_y+1);  %N_y+1 is the number of segments resulting from the existence of N_y internal points in y drection.
del_t=time/(T_points+1) %T_points+1 is the numer of segments resulting from the existence of T_points in time dimension.
lamda=del_t/(del_x)^2;
gamma=del_t/(del_y)^2;
a= 1+lamda; % a value is constant in space and time dimensions
b=-lamda/2;

