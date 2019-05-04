a_x=0;
a_y=0;
b_x=2*pi;
b_y=2*pi;
N_x=input('Please enter the number of internal points in x direction:  ');
N_y=input('Please enter the nubmer of internal points in y direction:  ');
del_t=('please enter a value for delta t: '); %since ADI method is uncindtionally stable, del_t technically can be any thing, but error increases with del_t
threshold_difference=input('please enter threshold value for average difference, 1e-12(recommended):  ')
%This is threshold for average difference value under which temperature
%distribation is no longer chaning in time and iteration process stops.

del_x=(b_x)/(N_x+1);  %N_x+1 is the number of segments resulting from the existence of N_x internal points in x diection.
del_y=(b_y)/(N_y+1);  %N_y+1 is the number of segments resulting from the existence of N_y internal points in y drection.
lamda=del_t/(del_x)^2;
gamma=del_t/(del_y)^2;

a=1+lamda; % a value is constant in space and time dimensions
b_and_c=-(lamda/2); %b and c are constant and equal to each other
b_c_squared=(b_and_c)^2;
alpha_1=a;
alpha=[alpha_1;zeros(N_x-1,1)];
right_side=zeros(N_x,N_y+1);

a_new=1+gamma; % "a" parameter for the new time step
b_new=-(gamma/2); %"b" paramter for new time step
c_new=[(-gamma);(-gamma/2)*ones(N_y,1)]; %"c" parameter for new time step
alpha_new_1=
alpha_new=
right_side_new=zeros(N_y+1,N_x); %right_side for the new time step

index_x=0:N_x+1;
index_y=0:N_y+1;
x_k=del_x*index_x; 
y_j=del_y*index_y;
u_x_0=((y_j).^3).';  %Boundary condition in x dimension at x=0
u_x_2pi=(((y_j).^2).*cos(y_j)).'; %Boundary condition in x dimension at x=2pi
u_y_2pi=u_x_0(N_y+2)+(x_k/(2*pi))*(u_x_2pi(N_y+2)-u_x_0(N_y+2)); %Boundary condition in y dimension at y=2pi
u_num_current=zeros(N_y+2,N_x+2);
u_num_half=[[u_x_0(1:N_y+1),zeros(N_y+1,N_x),u_x_2pi(1:N_y+1)];u_y_2pi];
total_elements=numel(u_num_current);

current_time=0;
average_difference=1; %The initial value of average difference is arbitrary to kickstart the iteration process

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
        
        u_num_half(1,N_x+1)=g_neumann(N_x)/alpha(N_x);
        u_num_half(k,N_x+1)=g(N_x)/alpha(N_x);
        
        for J=N_x:-1:2
            u_num_half(1,J)=(g_neumann(J)-(b_c*u_num_half(1,J+1)))/alpha(J);
            u_num_half(k,J)=(g(J)-(b_c*u_num_half(k,J+1)))/alpha(J);
        end 
        
    end
     
    u_num_old=u_num_current
    
    for K=1:N_x
        rigt_side_new(N_y+1,K)=
        
        for ii=1:N_y
            right_side_new(ii,K)=
        end
     
        g_new_1=right_side_new(1,K);
        g_new=[g_new_1;zeros(N_y,1)];
        
        for jj=2:N_y+1
            g_new(jj)=right_side_new(jj,K)-((b_new*g_new(jj-1))/alpha(jj-1));
        end
        
        u_num_current(N_y+1,K)=g_new(N_y+1)/alpha(N_y+1)
        
        for kk=N_y:-1:1
            u_num_current(kk,K)=(g_new(kk)-(c_new(kk)*u_num_currrent(kk+1,K )))/alpha(kk);
        end
    end
    
    difference=abs(u_num_current-u_num_old);
    average_difference=(1/total_elements)*sum(difference(:));
    
end
            
            
            

