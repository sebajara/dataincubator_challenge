function [] = section2()
% Answers to section 2 of the Data Incubator Challenge 2019.
% https://github.com/sebajara/dataincubator_challenge/tree/master/section2
%
% Rather brute way of doing it over all, but managed to get 2 answers.
% The method is not efficient to answer all questions. I guess there was a
% cleaver way using combinatorics, but I have not been able to figure out
% how to deal with the boundaries to solve it analytically.
%
% Computation could be optimised by taking advantage of the
% symmetries, as points with the same distance to the edges will have
% the same count value. Still this optimization would not be enough to answer cases with d=8.
    
    tic
    % ================== Question 1:
    %count1 = count_paths_4D_10STEPS(10,[0,0,0,0]);
    %display(['A1: ',num2str(count1)]);
    toc
    % A1: 44569724
    
    % ================== Question 2:
    % max count must be in the middle and the min is from one corner
    %count2 = count_paths_4D_10STEPS(10,[4,4,4,4]);
    %display(['A2: ',num2str(count2/count1),' Max: ',num2str(count2)]);
    toc
    % A2: 23.8121 Max: 1061298332
    
    % ================== Question 3:
    if(~isfile('tempQ3.mat'))
        a = 1
        dists = zeros(10,10,10,10);
        for d1 = 1:10
            for d2 = 1:10
                for d3 = 1:10
                    for d4 = 1:10
                        dist = sqrt(sum(abs([d1,d2,d3,d4]-5).^2));
                        dists(d1,d2,d3,d4) = dist;
                    end
                end
            end
        end
        targets      = unique(dists(:));
        reducecounts = zeros(size(targets));
        counts3      = zeros(10,10,10,10);
        for d1 = 1:10
            for d2 = 1:10
                for d3 = 1:10
                    for d4 = 1:10
                        dist = sqrt(sum(abs([d1,d2,d3,d4]-5).^2));
                        pos  = find(targets==dist);
                        if(reducecounts(pos)==0)
                            x0 = [d1,d2,d3,d4]-1;
                            count = count_paths_4D_10STEPS(10,x0);
                            reducecounts(pos) = count;
                        end
                        counts3(d1,d2,d3,d4) = reducecounts(pos);
                    end
                end
            end
        end
        save('tempQ3.mat', 'counts3');
        toc % it took
    else
        load('tempQ3.mat');
    end
    vals = counts3(:);
    ans3 = std(vals)/mean(vals);
    display(['A3: ',num2str(0)]);
    toc
    
    % ================== Question 4:

    
    % ================== Question 5:

    
    % ================== Question 6:

    function [count] = count_paths_4D_10STEPS(n,x0)
        d = 4; % fixed
        m = 10; % fixed
        deltas = [1,0,0,0;...
                  -1,0,0,0;...
                  0,1,0,0;...
                  0,-1,0,0;...
                  0,0,1,0;...
                  0,0,-1,0;...
                  0,0,0,1;...
                  0,0,0,-1];
        % each step
        x1 = zeros(1,d);
        x2 = zeros(1,d);
        x3 = zeros(1,d);
        x4 = zeros(1,d);
        x5 = zeros(1,d);
        x6 = zeros(1,d);
        x7 = zeros(1,d);
        x8 = zeros(1,d);
        x9 = zeros(1,d);
        x10 = zeros(1,d);
        count = 0;
        for s1 = 1:size(deltas,1)
            x1 = x0+deltas(s1,:);
            if(x1(1)==-1 | x1(2)==-1 | x1(3)==-1 | x1(4)==-1 | ...
               x1(1)==n  | x1(2)==n  | x1(3)==n | x1(4)==n)
                continue;
            end
            for s2 = 1:size(deltas,1)
                x2 = x1+deltas(s2,:);
                if(x2(1)==-1 | x2(2)==-1 | x2(3)==-1 | x2(4)==-1 | ...
                   x2(1)==n  | x2(2)==n  | x2(3)==n | x2(4)==n)
                    continue;
                end
                for s3 = 1:size(deltas,1)
                    x3 = x2+deltas(s3,:);
                    if(x3(1)==-1 | x3(2)==-1 | x3(3)==-1 | x3(4)==-1 | ...
                       x3(1)==n  | x3(2)==n  | x3(3)==n | x3(4)==n)
                        continue;
                    end
                    for s4 = 1:size(deltas)
                        x4 = x3+deltas(s4,:);
                        if(x4(1)==-1 | x4(2)==-1 | x4(3)==-1 | x4(4)==-1 | ...
                           x4(1)==n  | x4(2)==n  | x4(3)==n | x4(4)==n)
                            continue;
                        end
                        for s5 = 1:size(deltas)
                            x5 = x4+deltas(s5,:);
                            if(x5(1)==-1 | x5(2)==-1 | x5(3)==-1 | x5(4)==-1 | ...
                               x5(1)==n  | x5(2)==n  | x5(3)==n | x5(4)==n)
                                continue;
                            end
                            for s6 = 1:size(deltas)
                                x6 = x5+deltas(s6,:);
                                if(x6(1)==-1 | x6(2)==-1 | x6(3)==-1 | x6(4)==-1 | ...
                                   x6(1)==n  | x6(2)==n  | x6(3)==n | x6(4)==n)
                                    continue;
                                end
                                for s7 = 1:size(deltas)
                                    x7 = x6+deltas(s7,:);
                                    if(x7(1)==-1 | x7(2)==-1 | x7(3)==-1 | x7(4)==-1 | ...
                                       x7(1)==n  | x7(2)==n  | x7(3)==n | x7(4)==n)
                                        continue;
                                    end
                                    for s8 = 1:size(deltas)
                                        x8 = x7+deltas(s8,:);
                                        if(x8(1)==-1 | x8(2)==-1 | x8(3)==-1 | x8(4)==-1 | ...
                                           x8(1)==n  | x8(2)==n  | x8(3)==n | x8(4)==n)
                                            continue;
                                        end
                                        for s9 = 1:size(deltas)
                                            x9 = x8+deltas(s9,:);
                                            if(x9(1)==-1 | x9(2)==-1 | x9(3)==-1 | x9(4)==-1 | ...
                                               x9(1)==n  | x9(2)==n  | x9(3)==n | x9(4)==n)
                                                continue;
                                            end
                                            for s10 = 1:size(deltas)
                                                x10 = x9+deltas(s10,:);
                                                if(x10(1)==-1 | x10(2)==-1 | x10(3)==-1 | x10(4)==-1 | ...
                                                   x10(1)==n  | x10(2)==n  | x10(3)==n | x10(4)==n)
                                                    continue;
                                                end
                                                count = count + 1;
                                            end  
                                        end  
                                    end  
                                end  
                            end  
                        end  
                    end
                end
            end
        end
    end
end