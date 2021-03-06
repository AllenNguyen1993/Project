a_x=0;
a_y=0;
b_x=2*pi;
b_y=2*pi;
N_x=input('Please enter the number of internal points in x direction:  ');
N_y=input('Please enter the nubmer of internal points in y direction:  ');
del_t=input('please enter a value for delta t: '); %since ADI method is uncindtionally stable, del_t technically can be any thing, but error increases with del_t
threshold_difference=input('please enter threshold value for average difference, 1e-12(recommended):  ');
%This is threshold for  average difference value under which temperature
%distribation is no longer chaning in time and iteration process stops.
tic
del_x=(b_x)/(N_x+1);  %N_x+1 is the number of segments resulting from the existence of N_x internal points in x diection.
del_y=(b_y)/(N_y+1);  %N_y+1 is the number of segments resulting from the existence of N_y internal points in y drection.
lamda=del_t/(del_x)^2;
gamma=del_t/(del_y)^2;
lamda_half=lamda/2; %These constant parameters help optimize the code since they don't have 
gamma_half=gamma/2; %to be computed again and again in while and for loops
minus_lamda=1-lamda;
minus_gamma=1-gamma;

a=1+lamda; % a value is constant in space and time dimensions
b_and_c=-(lamda/2); %b and c are constant and equal to each other
b_c_squared=b_and_c^2;
alpha_1=a;
alpha=[alpha_1;zeros(N_x-1,1)];
right_side=zeros(N_x,N_y+1);

a_new=1+gamma; % "a" parameter for the new time step
b_new=-(gamma/2); %"b" paramter for new time step
c_new=[(-gamma);(-gamma/2)*ones(N_y-1,1)];  %"c" parameter for new time step
alpha_new_1=a_new;
alpha_new=[alpha_new_1;zeros(N_y,1)];
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
u_num_newer=[[u_x_0(1:N_y+1),zeros(N_y+1,N_x),u_x_2pi(1:N_y+1)];u_y_2pi];
total_elements=numel(u_num_current);

current_time=0;
average_difference=1; %The initial value of average difference is arbitrary to kickstart the iteration process

for i=2:N_x
    alpha(i)=a-(b_c_squared/alpha(i-1));
end

for II=2:N_y+1
    alpha_new(II)=a_new-((b_new*c_new(II-1))/alpha_new(II-1));
end

while average_difference>threshold_difference
    current_time=current_time+del_t;
    right_side(1,1)=(gamma)*u_num_current(2,2)+(minus_gamma)*u_num_current(1,2)+(lamda_half)*u_num_half(1,1);
    right_side(N_x,1)=(gamma)*u_num_current(2,N_x+1)+(minus_gamma)*u_num_current(1,N_x+1)+(lamda_half)*u_num_half(1,N_x+2);
    
    %This block iterates to get u at half time step along a row of u.
    for k=2:N_y+1
        right_side(1,k)=(gamma_half)*u_num_current(k-1,2)+(minus_gamma)*u_num_current(k,2)+(gamma_half)*u_num_current(k+1,2)+(lamda_half)*u_num_half(k,1);
        right_side(N_x,k)=(gamma_half)*u_num_current(k-1,N_x+1)+(minus_gamma)*u_num_current(k,N_x+1)+(gamma_half)*u_num_current(k+1,N_x+1)+(lamda_half)*u_num_half(k,N_x+2);
        
         for j=2:N_x-1
          right_side(j,k)=(gamma_half)*u_num_current(k-1,j+1)+(minus_gamma)*u_num_current(k,j+1)+(gamma_half)*u_num_current(k+1,j+1);
          right_side(j,1)= (gamma)*u_num_current(2,j+1)+(minus_gamma)*u_num_current(1,j+1);
        end
        
        g_1=right_side(1,k);
        g_1_neumann=right_side(1,1);
        g=[g_1;zeros(N_x-1,1)];
        g_neumann=[g_1_neumann;zeros(N_x-1,1)];
        
         for I=2:N_x
            g(I)=right_side(I,k)- ((b_and_c*g(I-1))/alpha(I-1));
            g_neumann(I)=right_side(I,1)-((b_and_c*g_neumann(I-1))/alpha(I-1));
        end
        
        u_num_half(1,N_x+1)=g_neumann(N_x)/alpha(N_x);
        u_num_half(k,N_x+1)=g(N_x)/alpha(N_x);
        
        for J=N_x:-1:2
            u_num_half(1,J)=(g_neumann(J-1)-(b_and_c*u_num_half(1,J+1)))/alpha(J-1); %Due to misalignment in indices between u in x direction and g
            u_num_half(k,J)=(g(J-1)-(b_and_c*u_num_half(k,J+1)))/alpha(J-1);  % Care and caution must to taken here, for every index value in x, substract 1 to get corresding index in g.
        end 
        
    end    
     
    u_num_old=u_num_current;
    
    %This block iterates to get at 1 newer time step along a column.
    for K=1:N_x
        right_side_new(N_y+1,K)=(lamda_half)*u_num_half(N_y+1,K)+(minus_lamda)*u_num_half(N_y+1,K+1)+(lamda_half)*u_num_half(N_y+1,K+2)+(gamma_half)*u_num_newer(N_y+2,K+1);
        
        for ii=1:N_y
            right_side_new(ii,K)=(lamda_half)*u_num_half(ii,K)+(minus_lamda)*u_num_half(ii,K+1)+(lamda_half)*u_num_half(ii,K+2);
        end
     
        g_new_1=right_side_new(1,K);
        g_new=[g_new_1;zeros(N_y,1)];
        
        for jj=2:N_y+1
            g_new(jj)=right_side_new(jj,K)-((b_new*g_new(jj-1))/alpha_new(jj-1)); 
        end
         
        u_num_newer(N_y+1,K+1)=g_new(N_y+1)/alpha_new(N_y+1);
        
        for kk=N_y:-1:1
            u_num_newer(kk,K+1)=(g_new(kk)-(c_new(kk)*u_num_newer(kk+1,K+1)))/alpha_new(kk);
        end
    end       
    
    u_num_current=u_num_newer;
    difference=abs(u_num_current-u_num_old);
    average_difference=(1/total_elements)*sum(difference(:));
    
end

[X,Y]=meshgrid(x_k,y_j);
surf(X,Y,u_num_current)
plot_name=sprintf('2D Temperature Distribution');
info=sprintf('Number of internal points in x direction: %g\nNumber of internal points in y direction: %g\nDelta t: %1.12g\nMethod: ADI',N_x,N_y,del_t);
title(plot_name);
text(4,5,240,info);
xlabel('X')
ylabel('Y')
zlabel('Temperature Distribuation')
toc           
            
            

