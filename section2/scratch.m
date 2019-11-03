

d = 2;
n = 2;
m = n;
npaths = zeros(n,n);
for i = 1:size(npaths,1)
    for j = 1:size(npaths,1)
        [paths]      = enumerate_paths(d,n,m,[i-1;j-1]);
        [~,~,nps] = size(paths);
        npaths(i,j) = nps;
    end
end
npaths

d = 2;
n = 3;
m = n;
npaths = zeros(n,n);
for i = 1:size(npaths,1)
    for j = 1:size(npaths,1)
        [paths]      = enumerate_paths(d,n,m,[i-1;j-1]);
        [~,~,nps] = size(paths);
        npaths(i,j) = nps;
    end
end
npaths

d = 2;
n = 4;
m = n;
npaths = zeros(n,n);
for i = 1:size(npaths,1)
    for j = 1:size(npaths,1)
        npaths(i,j) = enumerate_paths2(d,n,m,[i-1;j-1]);
    end
end
npaths

d = 2;
n = 6;
m = n;
npaths = zeros(n,n);
for i = 1:size(npaths,1)
    for j = 1:size(npaths,1)
        npaths(i,j) = enumerate_paths2(d,n,m,[i-1;j-1]);
    end
end
npaths

%npaths = enumerate_paths2(4,10,10,[0;0;0;0])
% run out of memory, although is possible to run enumerate_paths2(4,8,8,[0;0;0;0])

%[npaths] = smarter_count(4,[0;0]);

% $$$ % Example 
% $$$     [paths]      = enumerate_paths(2,3,2,[0;0]);
% $$$     [~,~,npaths] = size(paths);
% $$$     display(['Number of paths for the example is ',num2str(npaths)]);
% $$$ 
% $$$     [paths]      = enumerate_paths(2,3,3,[0;0]);
% $$$     [~,~,npaths] = size(paths);
% $$$     display(['Number of paths for the example is ',num2str(npaths)]);
% $$$ 
% $$$     [paths]      = enumerate_paths(3,3,2,[0;0;0]);
% $$$     [~,~,npaths] = size(paths);
% $$$     display(['Number of paths for the example is ',num2str(npaths)]);
% $$$     
% $$$     
% $$$     % Question 1:
% $$$     %[paths]      = enumerate_paths(4,10,10,[0;0;0;0]);
% $$$     %[~,~,npaths] = size(paths);
% $$$     %display(['Answer question 1: ',num2str(npaths), ' paths']);

