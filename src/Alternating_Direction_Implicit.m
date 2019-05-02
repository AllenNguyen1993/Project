% Dimensions 
% a_x=0 <x<b_x=2pi
% a_y=0 <y<b_y=2pi
a_x=0;
a_y=0;
b_x=2*pi;
b_y=2*pi;
N_x=input('Please enter the number of internal points in x direction:  ');
N_y=input('Please enter the nubmer of internal points in y direction:  ');
total_elements=(N_x*N_y)+N_x; %Total number of elements u, not counting the u at boundary (but only u at the boundary a_y=0) 
del_t=('please enter a value for delta t: '); %since ADI method is uncindtionally stable, del_t technically can be any thing, but error increases with del_t
del_x=(b_x)/(N_x+1);  %N_x+1 is the number of segments resulting from the existence of N_x internal points in x diection.
del_y=(b_y)/(N_y+1);  %N_y+1 is the number of segments resulting from the existence of N_y internal points in y drection.
lamda=del_t/(del_x)^2;
gamma=del_t/(del_y)^2;
a=1+lamda; % a value is constant in space and time dimensions
b_and_c=-lamda/2;
b_c_squared=(b_and_c)^2;
index_x=0:N_x+1;
index_y=0:N_y+1;
x_k=del_x*index_x; 
y_j=del_y*index_y;
u_x_0=((y_j ).^3).';  %Boundary condition in x dimension at x=0
u_x_2pi=(((y_j).^2).*cos(y_j)).'; %Boundary condition in x dimension at x=2pi
u_y_2pi=u_x_0(N_y+2)+(x_k/(2*pi))*(u_x_2pi(N_y+2)-u_x_0(N_y+2)); %Boundary condition in y dimension at y=2pi
u_num_current=[[u_x_0(1:N_y+1),zeros(N_y+1,N_x),u_x_2pi(1:N_y+1)];u_y_2pi ]; %u distribution at current time
u_num_plus_half=[[u_x_0(1:N_y+1),zeros(N_y+1,N_x),u_x_2pi(1:N_y+1)];u_y_2pi];%u distribution at 1/2 time step computed from current time
u_array=zeros(total_elements,1); % this arranges numerical u in an column array.
alpha_1=a; 
Alpha=[alpha_1;zeros(total_elements-1,1)];
right_side=zeros(N_x,N_y+1);
current_time=0;

for I=2:total_elements
    Alpha(I)=a-(b_c_squared/Alpha(I-1));
end
    
while average_error<= %0.001
    current_time=current_time+del_t
    right_side(1,1)=gamma*u_num_current(2,2)+(1-gamma)*u_num_current(1,2)+(lamda/2)*u_num_current(1,1);
    right_side(N_x,1)=gamma*u_num_current(2,N_x+1)+(1-gamma)*u_num_current(1,N_x+1)+(lamda/2)*u_num_current(1,N_x+2);
    
    for i=2:N_y+1
        right_side(1,i)=(gamma/2)*u_num_current(i-1,2)+(1-gamma)*u_num_current(i,2)+(gamma/2)*u_num_current(i+1,2)+(lamda/2)*u_num_current(i,1);
        right_side(N_x,i)=(gamma/2)*u_num_current(i-1,N_x+1)+(1-gamma)*u_num_current(i,N_x+1)+(gamma/2)*u_num_current(i+1,N_x+1)+(lamda/2)*u_num_current(i,N_x+2);
    end
    
    for j=2
        for k= 
        right_side(j,k)=(gamma/2)*u_num_current(k-1,j)+(1-gamma)*u_num_current(k,j)+(gamma/2)*u_num_current(k+1,j);
        end
    end
    
    right_side_matrix=right_side(:);
    g=[right_side(1);zeros(total_elements-1)];
    
    for I=2:total_elements
        g(I)=right_side_matix(I)-((b_and_c*g(I-1))/Alpha(I-1);
    end
    
    u_array(total_elements)=g(total_elements)/Alpha(total_elements);
    
    for J=total_elements-1:-1:1
        u_array(J)=(g(J)-(b_and_c*u_array(J+1)))/Alpha(J);
    end
    
    u_num_plus_half([1:N_y+1],[2:N_x+1])=(reshape(u_array,N_x,N_y+1)).';
    u_num_old=u_num_current;
    
    
    
    
    
    


 



