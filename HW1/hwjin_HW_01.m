hwjin@ucdavis.edu%Hangshi Jin    913142686
load HW_01;%load the .dat file to input
figure(1);
stem(x); hold on; plot(x); grid;%plot x over figure 1
figure(2);%open a new window for figure 2
for k=1:8 %use for loop to plot 8 graphs
   subplot(8,1,k);
   %plot 8 graphs on 1 window with each representing the value of one of the entries of U
   stem(U(:,k)); axis([0 9 -0.5 0.5]); axis off; hold on;
   %discrete graph with x-axis ranges from 0 to 9, y-axis from -0.5 to 0,5
end
for k=1:8
    subplot(8,1,k); 
    plot(U(:,k));%connect the points on figure 2 with lines%
end
a=U'*x;%compute the expansion coefficients
[val, idx]=maxk(abs(a),2);%catch the values and indices of the two largest 
                          %entries of a in terms of their absolute values
a2 = zeros(8,1);%set a2 to a zero vector with 8x1
for k=1:2
   a2(idx(k)) = a(idx(k));
   %plug in the values of the two largest entries of a to the corresponding entries in a2
end
x2=U*a2;%Construct an approximation x2 of x using a2
figure(1); stem(x2,'r*'); plot(x2,'r');
%plot x2 over figure 1
[val1, idx1]=maxk(abs(a),4);%catch the values and indices of the four largest 
                          %entries of a in terms of their absolute values
a4 = zeros(8,1);%set a4 to a zero vector with 8x1
for k=1:4
   a4(idx1(k)) = a(idx1(k));
   %plug in the values of the four largest entries of a to the corresponding entries in a4
end
x4=U*a4;%Construct an approximation x4 of x using a4
figure(1); stem(x4,'gx'); plot(x4,'g');
%plot x4 over figure 1
x8=U*a;%full reconstruction x8 of x
sqrt(sum((x-x8).^2)/sum(x.^2))%the relative error of x8
sqrt(sum((x-x4).^2)/sum(x.^2))%the relative error of x4
sqrt(sum((x-x2).^2)/sum(x.^2))%the relative error of x2