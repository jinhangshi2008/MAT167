%Hangshi Jin    913142686
load HW_02;%load the .dat file to input
whos%check the variables' sizes, bytes and classes in the data
plot(x,y); grid;%plot a graph with x as horizontal axis and y as vertical axis
A=[x.^0 x.^1];%create the Vendermonde matrix for polynomials of degree 1;
              %the first column is each entry of x with power 0;
              %the second column is each entry of x with power 1;
sol = inv(A'*A)*A'*y;%compute the least square line using normal equation
hold on; plot(x, sol(1)+sol(2)*x, '--');%plot the least square line over the current plot 
                                        %with the first solution times the
                                        %first column of A and the second
                                        %solution times the second column
                                        %of A.
title('Least Squares Linear Fit'); xlabel('x'); ylabel('y');%label the axes and name the plot