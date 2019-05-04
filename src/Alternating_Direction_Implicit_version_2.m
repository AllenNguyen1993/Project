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
b_and_c=-(lamda/2); %b and c are constant and equal to each other
b_c_squared=(b_and_c)^2;
alpha_1=a;
alpha=[alpha_1;zeros(N_x,1)];
index_x=0:N_x+1;
index_y=0:N_y+1;
x_k=del_x*index_x; 
y_j=del_y*index_y;
u_x_0=((y_j).^3).';  %Boundary condition in x dimension at x=0
u_x_2pi=(((y_j).^2).*cos(y_j)).'; %Boundary condition in x dimension at x=2pi
u_y_2pi=u_x_0(N_y+2)+(x_k/(2*pi))*(u_x_2pi(N_y+2)-u_x_0(N_y+2)); %Boundary condition in y dimension at y=2pi
u_num_current=zeros(N_y+2,N_x+2);
u_num_half=[[u_x_0(1:N_y+1),zeros(N_y+1,N_x),u_x_2pi(1:N_y+1)];u_y_2pi];
right_side=zeros(N_x,N_y+1);
current_time=0;
average_difference=1;

for i=2:N_x
    alpha(i)=a-(b_c_squared/alpha(i-1))
end

while average_difference>threshold_difference
    current_time=current_time+del_t;
    right_side(1,1)=
    right_side(N_x,1)=
    
    for k=2:N_y+1
        right_side(1,k)=
        right_side(N_x,k)=
        
        for j=2:N_x-1
            right_side(j,k)=
            right_side(j,1)= 
        end
        
        g_1=right_side(1,k)
        g_1_neumann=right_side(1,1)
        g=[g_1;zeros(N_x-1,1)];
        g_neumann(N_x,1)=[g_1_neumann;zeros(N_x-1,1)];
        
        for I=2:N_x
            g(I)=right_side(I,k)-((b_and_c*g(I-1))/alpha(I-1));
            g_neumann(I)=right_side(I,1)-((b_and_c*g_neumann(I-1))/alpha(I-1));
        end
            
            
            

