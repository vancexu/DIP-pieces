
p1 = imread('point.bmp');
p2 = imread('point_sp.bmp');
[d1, d2] = size(p1);
f = p2; % f is the result point_sp
table = zeros(128,2);

% make the point_sp.bmp simple point.
for i = 1:d1
    for j = 1:d2
        if p2(i,j)==128 || p2(i,j)==129
            f(i,j) = 255;
        end
    end
end
for i = 2:d1-1
    for j = 2:d2-1
        tmp = f(i-1:i+1,j-1:j+1);        
        minp = double(min(tmp(:)));
        for m = i-1:i+1
            for n = j-1:j+1
                if f(m,n) ~= minp
                    f(m,n) = 255;
                end
            end
        end
    end
end
for i = 2:d1-1
    for j = 2:d2-1
        if f(i-1,j+1) == f(i,j)
            f(i-1,j+1) = 255;
        end
        if f(i+1,j+1) == f(i,j)
            f(i+1,j+1) = 255;
        end
    end
end
% get the fish points in a table
n=1;
for i = 1:d1
    for j = 1:d2
        if f(i,j) ~= 255
            table(n,1) = i;
            table(n,2) = j;
            n = n + 1;
        end
    end
end
% remove the 6*4 normal fishpoint
table_rm = table;
for i = 1:128
    if mod([table(i,1),table(i,2)], 10) == [0,0]
        table_rm(i,:) = [0,0];
    end
end
% col_table is sorted by col, then I scan the row to match
col_table = sortrows(table_rm,2);
col_table(1:24,:) = [];
fishpt = zeros(104,3);
n = 1;
line = 0;
for i = 4:2:12
    line = line + 1;
    for j = 1:i
        fishpt(n,1) = line;
        fishpt(n,2) = col_table(n,1);
        fishpt(n,3) = col_table(n,2);
        n = n + 1;
    end
end
line = line + 1;
for i = 1:12
    fishpt(n,1) = line;
    fishpt(n,2) = col_table(n,1);
    fishpt(n,3) = col_table(n,2);
    n = n + 1;
end
line = line + 1;
for i = 1:12
    fishpt(n,1) = line;
    fishpt(n,2) = col_table(n,1);
    fishpt(n,3) = col_table(n,2);
    n = n + 1;
end
for i = 12:-2:4
    line = line + 1;
    for j = 1:i
        fishpt(n,1) = line;
        fishpt(n,2) = col_table(n,1);
        fishpt(n,3) = col_table(n,2);
        n = n + 1;
    end
end
% now I got fishpt, 104 rows and 3 cols, the 1st col is row number.
% (2nd,3nd) is point coordinate
% 
% now, add the miss point in the original point_sp.bmp
% I use Parallelogram, to add 4 * 4 = 16 points
n = 1;
j = 1;
rowcell = cell(12,1);  % use to get each row, seperated.
for i = 1:104
    if fishpt(i,1) == n
        ;
    else
        tmp = fishpt(j:i-1,2:3);
        tmp = sortrows(tmp, 1);
        rowcell(n) = {tmp};
        n = n + 1;
        j = i;
    end
end
tmp = fishpt(101:104,2:3);
tmp = sortrows(tmp, 1);
rowcell(12) = {tmp};

for i = 1:4
    r = rowcell{i};
    len = size(r);
    len = len(1);
    left1 = r(1,:);
    right1 = r(len,:);
   
    r = rowcell{i+1};
    len = size(r);
    len = len(1);
    left2 = r(1,:);
    left3 = r(2,:);
    right2 = r(len,:);
    right3 = r(len-1,:);
    
    left4 = [left1(1)+left2(1)-left3(1),left1(2)+left2(2)-left3(2)];
    right4 = [right1(1)+right2(1)-right3(1),right1(2)+right2(2)-right3(2)];
    disp(left4);
    disp(right4);
end
