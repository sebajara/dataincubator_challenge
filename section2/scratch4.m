load('tempQ3.mat');

for d1 = 1:5
    for d2 = 1:4
        for d3 = 1:3
            for d4 = 1:2
                c = counts3(d1,d2,d3,d4);
                sets = perms([d1,d2,d3,d4]);
                for s = 1:size(sets,1)
                    counts3(sets(s,1),sets(s,2),sets(s,3),sets(s,4)) = c;
                    counts3(sets(s,1)+5,sets(s,2)+5,sets(s,3)+5,sets(s,4)+5) = c;
                end
            end
        end
    end
end