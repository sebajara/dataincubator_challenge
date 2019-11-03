function [] = section2()
% Answers to section 2 of the Data Incubator Challenge 2019.
% https://github.com/sebajara/dataincubator_challenge/tree/master/section2
%
% Rather brute way of doing it over all, but managed to get 2 answers.
% The method is not efficient to answer all questions. I guess there was a
% cleaver way using combinatorics, but I have not been able to figure out
% how to deal with the boundaries.
    
    tic
    % ================== Question 1:
    count1 = count_paths_4D_10STEPS(10,[0,0,0,0]);
    display(['A1: ',num2str(count1)]);
    toc
    % A1: 44569724
    
    % ================== Question 2:
    % max count must be in the middle and the min is from one corner
    %count2 = count_paths_4D_10STEPS(10,[4,4,4,4]);
    %display(['A2: ',num2str(count2/count1),' Max: ',num2str(count2)]);
    toc
    % A2: 23.8121 Max: 1061298332
    
    % ================== Question 3:
    if(isfile('tempQ3.mat'))
        counts3 = zeros(10,10,10,10);
        % we can use symmetry to calculate just some
        for d1 = 1:5
            for d2 = 1:4
                for d3 = 1:3
                    for d4 = 1:2
                        x0 = [d1,d2,d3,d4]-1;
                        counts3(d1,d2,d3,d4) = count_paths_4D_10STEPS(10,x0);
                    end
                end
            end
        end
        save('tempQ3.mat', 'counts3');
        toc % it took 7.3 hrs
    else 
        % in principle should be able to recover the whole matrix by taking the
        % elements w the same distance to the closest corner
    end
    
    % ================== Question 4:
    if(isfile('tempQ4.mat'))
        count4 = count_paths_8D_12STEPS(12,[0;0;0;0;0;0;0;0]);
        save('tempQ4.mat', 'count4');
    else
        load('tempQ4.mat');
    end
    display(['A4: ',num2str(count4)]);
    toc;
    
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
    function [count] = count_paths_8D_12STEPS(n,x0)
        d = 8; % fixed
        m = 12; % fixed
        deltas = [1,0,0,0,0,0,0,0;...
                  -1,0,0,0,0,0,0,0;...
                  0,1,0,0,0,0,0,0;...
                  0,-1,0,0,0,0,0,0;...
                  0,0,1,0,0,0,0,0;...
                  0,0,-1,0,0,0,0,0;...
                  0,0,0,1,0,0,0,0;...
                  0,0,0,-1,0,0,0,0;...
                  0,0,0,0,1,0,0,0;...
                  0,0,0,0,-1,0,0,0;...
                  0,0,0,0,0,1,0,0;...
                  0,0,0,0,0,-1,0,0;...
                  0,0,0,0,0,0,1,0;...
                  0,0,0,0,0,0,-1,0;...
                  0,0,0,0,0,0,0,1;...
                  0,0,0,0,0,0,0,-1];
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
        x11 = zeros(1,d);
        x12 = zeros(1,d);
        count = 0;
        for s1 = 1:size(deltas,1)
            x1 = x0+deltas(s1,:);
            if(x1(1)==-1 | x1(2)==-1 | x1(3)==-1 | x1(4)==-1 | ...
               x1(5)==-1 | x1(6)==-1 | x1(7)==-1 | x1(8)==-1 | ...
               x1(1)==n  | x1(2)==n  | x1(3)==n | x1(4)==n | ...
               x1(5)==n  | x1(6)==n  | x1(7)==n | x1(8)==n)
                continue;
            end
            for s2 = 1:size(deltas,1)
                x2 = x1+deltas(s2,:);
                if(x2(1)==-1 | x2(2)==-1 | x2(3)==-1 | x2(4)==-1 | ...
                   x2(5)==-1 | x2(6)==-1 | x2(7)==-1 | x2(8)==-1 | ...
                   x2(1)==n  | x2(2)==n  | x2(3)==n | x2(4)==n | ...
                   x2(5)==n  | x2(6)==n  | x2(7)==n | x2(8)==n)
                    continue;
                end
                for s3 = 1:size(deltas,1)
                    x3 = x2+deltas(s3,:);
                    if(x3(1)==-1 | x3(2)==-1 | x3(3)==-1 | x3(4)==-1 | ...
                       x3(5)==-1 | x3(6)==-1 | x3(7)==-1 | x3(8)==-1 | ...
                       x3(1)==n  | x3(2)==n  | x3(3)==n | x3(4)==n | ...
                       x3(5)==n  | x3(6)==n  | x3(7)==n | x3(8)==n)
                        continue;
                    end
                    for s4 = 1:size(deltas)
                        x4 = x3+deltas(s4,:);
                        if(x4(1)==-1 | x4(2)==-1 | x4(3)==-1 | x4(4)==-1 | ...
                           x4(5)==-1 | x4(6)==-1 | x4(7)==-1 | x4(8)==-1 | ...
                           x4(1)==n  | x4(2)==n  | x4(3)==n | x4(4)==n | ...
                           x4(5)==n  | x4(6)==n  | x4(7)==n | x4(8)==n)
                            continue;
                        end
                        for s5 = 1:size(deltas)
                            x5 = x4+deltas(s5,:);
                            if(x5(1)==-1 | x5(2)==-1 | x5(3)==-1 | x5(4)==-1 | ...
                               x5(5)==-1 | x5(6)==-1 | x5(7)==-1 | x5(8)==-1 | ...
                               x5(1)==n  | x5(2)==n  | x5(3)==n | x5(4)==n | ...
                               x5(5)==n  | x5(6)==n  | x5(7)==n | x5(8)==n)
                                continue;
                            end
                            for s6 = 1:size(deltas)
                                x6 = x5+deltas(s6,:);
                                if(x6(1)==-1 | x6(2)==-1 | x6(3)==-1 | x6(4)==-1 | ...
                                   x6(5)==-1 | x6(6)==-1 | x6(7)==-1 | x6(8)==-1 | ...
                                   x6(1)==n  | x6(2)==n  | x6(3)==n | x6(4)==n | ...
                                   x6(5)==n  | x6(6)==n  | x6(7)==n | x6(8)==n)
                                    continue;
                                end
                                for s7 = 1:size(deltas)
                                    x7 = x6+deltas(s7,:);
                                    if(x7(1)==-1 | x7(2)==-1 | x7(3)==-1 | x7(4)==-1 | ...
                                       x7(5)==-1 | x7(6)==-1 | x7(7)==-1 | x7(8)==-1 | ...
                                       x7(1)==n  | x7(2)==n  | x7(3)==n | x7(4)==n | ...
                                       x7(5)==n  | x7(6)==n  | x7(7)==n | x7(8)==n)
                                        continue;
                                    end
                                    for s8 = 1:size(deltas)
                                        x8 = x7+deltas(s8,:);
                                        if(x8(1)==-1 | x8(2)==-1 | x8(3)==-1 | x8(4)==-1 | ...
                                           x8(5)==-1 | x8(6)==-1 | x8(7)==-1 | x8(8)==-1 | ...
                                           x8(1)==n  | x8(2)==n  | x8(3)==n | x8(4)==n | ...
                                           x8(5)==n  | x8(6)==n  | x8(7)==n | x8(8)==n)
                                            continue;
                                        end
                                        for s9 = 1:size(deltas)
                                            x9 = x8+deltas(s9,:);
                                            if(x9(1)==-1 | x9(2)==-1 | x9(3)==-1 | x9(4)==-1 | ...
                                               x9(5)==-1 | x9(6)==-1 | x9(7)==-1 | x9(8)==-1 | ...
                                               x9(1)==n  | x9(2)==n  | x9(3)==n | x9(4)==n | ...
                                               x9(5)==n  | x9(6)==n  | x9(7)==n | x9(8)==n)
                                                continue;
                                            end
                                            for s10 = 1:size(deltas)
                                                x10 = x9+deltas(s10,:);
                                                if(x10(1)==-1 | x10(2)==-1 | x10(3)==-1 | x10(4)==-1 | ...
                                                   x10(5)==-1 | x10(6)==-1 | x10(7)==-1 | x10(8)==-1 | ...
                                                   x10(1)==n  | x10(2)==n  | x10(3)==n | x10(4)==n | ...
                                                   x10(5)==n  | x10(6)==n  | x10(7)==n | x10(8)==n)
                                                    continue;
                                                end
                                                for s11 = 1:size(deltas)
                                                    x11 = x10+deltas(s11,:);
                                                    if(x11(1)==-1 | x11(2)==-1 | x11(3)==-1 | x11(4)==-1 | ...
                                                       x11(5)==-1 | x11(6)==-1 | x11(7)==-1 | x11(8)==-1 | ...
                                                       x11(1)==n  | x11(2)==n  | x11(3)==n | x11(4)==n | ...
                                                       x11(5)==n  | x11(6)==n  | x11(7)==n | x11(8)==n)
                                                        continue;
                                                    end
                                                    for s12 = 1:size(deltas)
                                                        x12 = x11+deltas(s12,:);
                                                        if(x12(1)==-1 | x12(2)==-1 | x12(3)==-1 | x12(4)==-1 | ...
                                                           x12(5)==-1 | x12(6)==-1 | x12(7)==-1 | x12(8)==-1 | ...
                                                           x12(1)==n  | x12(2)==n  | x12(3)==n | x12(4)==n | ...
                                                           x12(5)==n  | x12(6)==n  | x12(7)==n | x12(8)==n)
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
    end
end