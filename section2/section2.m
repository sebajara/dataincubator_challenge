function [] = section2()
% Answers to section 2 of the Data Incubator Challenge 2019.
% Conventions:
% d  = dimensionality
% n  = number of grids
% m  = number of steps
% x0 = initial position (vector d x 1)
    
% Example 
    [paths]      = enumerate_paths(2,3,2,[0;0]);
    [~,~,npaths] = size(paths);
    display(['Number of paths for the example is ',num2str(npaths)]);

    [paths]      = enumerate_paths(2,3,3,[0;0]);
    [~,~,npaths] = size(paths);
    display(['Number of paths for the example is ',num2str(npaths)]);

    [paths]      = enumerate_paths(3,3,2,[0;0;0]);
    [~,~,npaths] = size(paths);
    display(['Number of paths for the example is ',num2str(npaths)]);
    
    
    % Question 1:
    %[paths]      = enumerate_paths(4,10,10,[0;0;0;0]);
    %[~,~,npaths] = size(paths);
    %display(['Answer question 1: ',num2str(npaths), ' paths']);

    
    function [npaths] = smart_count_2(d,n,m,x0)
    % We will take all posible paths with steps m, and then remove all
    % combination that are not valid. 
        total_paths = (d*2)^m; % without accounting for grid
        
    end
    
    %
    function [paths] = enumerate_paths(d,n,m,x0)
    % brute force approach: non scalable, but useful for checking the
    % smart approach.
        prev_pcount = 1;
        prev_paths{1} = zeros(m+1,d);
        prev_paths{1}(1,:) = x0;        
        for s = 2:(m+1) % each step
            next_pcount = 1;
            next_paths  = cell(1,1);
            for p = 1:prev_pcount % for each current paths
                path     = prev_paths{p};
                last_pos = path(s-1,:);
                for nd = 1:d
                    if(last_pos(nd)<n-1) % upper edge limit
                        new_pos       = last_pos;
                        new_pos(nd)   = new_pos(nd)+1; % move one up
                        new_path      = path;
                        new_path(s,:) = new_pos;
                        next_paths{next_pcount} = new_path;
                        next_pcount = next_pcount+1;
                    end
                    if(last_pos(nd)>0) % lower edge limit
                        new_pos       = last_pos;
                        new_pos(nd)   = new_pos(nd)-1; % move one down
                        new_path      = path;
                        new_path(s,:) = new_pos;
                        next_paths{next_pcount} = new_path;
                        next_pcount = next_pcount+1;
                    end
                end
            end
            % update
            prev_paths  = next_paths;
            prev_pcount = next_pcount-1;
            clearvars next_paths;
        end
        paths = zeros(m+1,d,prev_pcount);
        for p = 1:prev_pcount
            paths(:,:,p) = prev_paths{p};
        end
        clearvars prev_paths;
    end
end