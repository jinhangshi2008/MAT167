%Hangshi Jin    913142686
%Load the input .mat file
load USPS.mat;
%Declare the matrices that will be used.
train_aves=zeros(256,10);
test_classif=zeros(10,4649);
test_classif_res=zeros(1,4649);
test_confusion=zeros(10,10);
train_u=zeros(256,17,10);
test_svd17=zeros(17,4649,10);
test_svd17res=zeros(10,4649);
test_svd17_confusion=zeros(10,10);
test_svd17res_res=zeros(1,4649);
%Step 01(b)
%Declare 16X1 cell matrix A for iterations.
A=cell(16,1);
%Reshape train_patterns by restoring each column into each subcell matrix
%of A, A{l},by using a for loop with two inner for loops.
%l for loop iterates for creating A{l}.
for l=1:16
    %k for loop iterates for creating each row of corresponding A{k}.
    for k=1:16
        %j for loop iterates for creating each column of corresponding
        %A{k}.
        for j=1:16
            %Each column of train_pattern is copied as 16 entries once an iteration in the k for loop. 
        A{l}(k,j)=train_patterns((k-1)*16+j,l);
        end
    end
end
%Plot and print the first 16 images of train_pattern by using a for loop,
%since A is a cell matrix with size of 16X1.
for k=1:16
    subplot(4,4,k);
    imagesc(A{k})
end
%Step 02
%Declare 10X1 cell matrix C for iterations.
C=cell(10,1);
for k=1:10
    %Restore the images that truly represent corresponding kind of digit in each
    %iteration into C{k}.
    C{k}=train_patterns(:, train_labels(k,:)==1);
    %Get the row and colunm size of the corresponding C{k} in one
    %iteration.
    [a,b]=size(C{k});
    %Note each C{k} has dimensional 2.
    %Divide the sum of the entries of corresponding C{k} by the column size of the
    %that C{k} to compute the mean digit image once an iteration.
    train_aves(:,k)=sum(C{k},2)/b;
end
%Declare 10X1 cell matrix B for iterations.
B=cell(10,1);
%Use the same method in step 01(b) to reshape train_aves into 10 16X16
%matrices for plotting the mean digit images.
for l=1:10
    for k=1:16
        for j=1:16
        B{l}(k,j)=train_aves((k-1)*16+j,l);
        end
    end
end
%Plot and print the 10 mean digit images.
for k=1:10
    subplot(2,5,k);
    imagesc(B{k})
    %Step 03(a) (use the same for loop for different steps to reduce running time)
    
    %Compute the squred Euclidean distances between all the digit images of one kind in
    %test_patterns and the corresponding mean digit image once an
    %iteration.
    test_classif(k,:)=sum((test_patterns-repmat(train_aves(:,k),[1 4649])).^2);
end
%Step 03(b)
for k=1:4649
    %Classify the value of one test digit image by choosing the mean digit
    %image that has the smallest Euclidean distance with the test digit
    %image, once an iteration.
    %Extract the squared Euclidean distance and the index which represents one kind
    %of digit.
    [tmp, ind] = min(test_classif(:,k));
    %Restore the value of each classifcation in test_classif_res.
    test_classif_res(1,k)=ind;
end
%Step 03(c)
for k=1:10
    for j=1:10
        %Choose the values in test_classif_res for which the positions of the values are that of the 
        %true digit images of corresponding kind digit.
       tmp=test_classif_res(test_labels(k,:)==1);
       %Record the chosen values in test_classif_res into one column of
       %test_confusion once an iteration, where each column vector presents
       %how many test digit images were classified correct or wrong for corresponding kind digit.
       %In other words, the columns represent digits from 0-9, and the rows
       %represent the values classified.
       test_confusion(k,j)=sum(tmp==j);
    end
end
%Step 04(a)
%Obtain each left singular vectors for corresponding kind digit.
%Restore all ten sets of left singular vectors into train_u.
for k=1:10
    %Gather the information of corresponding kind digit from train_patterns.
    [train_u(:,:,k),tmp,tmp2] = svds(train_patterns(:,train_labels(k,:)==1),17);
end
%Step 04(b)
%Obtain the expansion coefficients of each test digit image of
%corresponding kind digit once an iteration.
for k=1:10
    %Restore the expansion coefficients in test_svd17 for each corresponding
    %kind digit.
    test_svd17(:,:,k) = train_u(:,:,k)' * test_patterns;

%Step 04(c)
%Compute the squared Euclidean distances between each test digit image and its rank
%17 approximation as the approximation errors.
%Restore the approximation errors in test_svd17res.
    test_svd17res(k,:)=sum((test_patterns-(train_u(:,:,k)*test_svd17(:,:,k))).^2);
end
%Step 04(d)
%Apply the same method used in step 03(b) to obtain the classification
%results.
for k=1:4649
    [tmp, ind] = min(test_svd17res(:,k));
    %Restore the classification results into test_svd17res_res.
    test_svd17res_res(1,k)=ind;
end
%Apply the same method used in step 03(c) to obtain test_svd17_confusion
%which shows the accuracy of the classification.
for k=1:10
    for j=1:10
      tmp=test_svd17res_res(test_labels(k,:)==1);
      %Record the checking results into test_svd17_confusion.
      test_svd17_confusion(k,j)=sum(tmp==j);
    end
end