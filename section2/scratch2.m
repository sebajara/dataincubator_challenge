
d = 2;
n = 3;
deltas = [1,0;...
          -1,0;...
          0,1;...
          0,-1];

x0 = [1,1];
x1 = zeros(1,d);
x2 = zeros(1,d);
x3 = zeros(1,d);
x4 = zeros(1,d);

m = 4;% steps
tic
count = 0;
for s1 = 1:size(deltas,1)
    x1 = x0+deltas(s1,:);
    if(x1(1)==-1 | x1(2)==-1 | x1(1)==n | x1(2)==n)
        continue;
    end
    for s2 = 1:size(deltas,1)
        x2 = x1+deltas(s2,:);
        if(x2(1)==-1 | x2(2)==-1 | x2(1)==n | x2(2)==n)
            continue;
        end
        for s3 = 1:size(deltas,1)
            x3 = x2+deltas(s3,:);
            if(x3(1)==-1 | x3(2)==-1 | x3(1)==n | x3(2)==n)
                continue;
            end
            for s4 = 1:size(deltas,1)
                x4 = x3+deltas(s4,:);
                if(x4(1)==-1 | x4(2)==-1 | x4(1)==n | x4(2)==n)
                    continue;
                else
                    count = count + 1;
                end
            end
        end
    end
end
count
toc

[paths]      = enumerate_paths(d,n,m,x0);
[~,~,nps] = size(paths)
toc

nps = enumerate_paths2(d,n,m,x0)
toc

