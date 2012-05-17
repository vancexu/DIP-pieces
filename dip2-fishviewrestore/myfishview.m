% 091250183 xubowei assignment2
% 1.deal with the fishview points
% 2.match. in fact, I just save the points belong to the same line in a
% cell structure.
% 3.find the coordinary by bilinear insert method.
p1 = imread('point.bmp');
p2 = imread('point_sp.bmp');
inputimg = imread('tiger_sp.bmp');
[origin1,origin2] = size(inputimg);
[d1, d2] = size(p1);
inputimg = imresize(inputimg,[d1,d2],'bilinear');
f = p2; % f is the result point_sp
table = zeros(128,2);

% make the point_sp.bmp single point.
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
fishpt = zeros(144,3);
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
% (2nd,3nd) is point coordinate. 
% row 105-120 are remained to be fill with added points.
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
% find the point I want to add
n = 1;
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
    fishpt(104+n,1) = i;
    fishpt(104+n,2:3) = left4;
    n = n + 1;
    fishpt(104+n,1) = i;
    fishpt(104+n,2:3) = right4;
    n = n + 1;
end
for i = 1:4
    r = rowcell{13-i};
    len = size(r);
    len = len(1);
    left1 = r(1,:);
    right1 = r(len,:);
   
    r = rowcell{12-i};
    len = size(r);
    len = len(1);
    left2 = r(1,:);
    left3 = r(2,:);
    right2 = r(len,:);
    right3 = r(len-1,:);
    
    left4 = [left1(1)+left2(1)-left3(1),left1(2)+left2(2)-left3(2)];
    right4 = [right1(1)+right2(1)-right3(1),right1(2)+right2(2)-right3(2)];
    fishpt(104+n,1) = 13-i;
    fishpt(104+n,2:3) = left4;
    n = n + 1;
    fishpt(104+n,1) = 13-i;
    fishpt(104+n,2:3) = right4;
    n = n + 1;
end
% now all add point are computed and put into fishpt
% then I get the final rowcell, which has all the 144 points that should be
% used to restore the fishview image.
fishpt(121:144,:) = [  % ugly but simple, add the normal point
    1,10,10;1,20,10;1,30,10;1,120,10;1,110,10;1,100,10;
    2,10,20;2,20,20;2,110,20;2,120,20;
    3,10,30;3,120,30;
    12,10,120;12,20,120;12,30,120;12,100,120;12,110,120;12,120,120;
    11,10,110;11,20,110;11,110,110;11,120,110;
    10,10,100;10,120,100;
    ];

fishpt = sortrows(fishpt,1);
n = 1;
j = 1;
rowcell = cell(12,1);  
for i = 1:144
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
tmp = fishpt(133:144,2:3);
tmp = sortrows(tmp, 1);
rowcell(12) = {tmp};

rowcell_new = cell(14,1);  % new cell to deal with the outer bound.
ta = zeros(14,2);
ta(1,:) = [1,1];
tb = 2;
for i = 10:10:120
    ta(tb,:) = [i,1];
    tb = tb + 1;
end
ta(14,:) = [128,1];
rowcell_new{1} = ta;

ta = zeros(14,2);
ta(1,:) = [1,128];
tb = 2;
for i = 10:10:120
    ta(tb,:) = [i,128];
    tb = tb + 1;
end
ta(14,:) = [128,128];
rowcell_new{14} = ta;

for i = 2:13
    ta = zeros(14,2);
    ta(1,:) = [1,10*(i-1)];
    ta(2:13,:) = rowcell{i-1};
    ta(14,:) = [128,10*(i-1)];
    rowcell_new{i} = ta;
end

% match, output
outputimg = zeros(d1,d2);
for i = 1:d1
    x = floor(i/10)+1;
    for j = 1:d2
        y = floor(j/10)+1;          
        point1 = rowcell_new{x}(y,:);
        point2 = rowcell_new{x}(y+1,:); 
        point3 = rowcell_new{x+1}(y+1,:);
        point4 = rowcell_new{x+1}(y,:);
        m = (i - (x-1)*10) / 10;
        n = (j - (y-1)*10) / 10;
        a = (point2(1)-point1(1))*n+(point4(1)-point1(1))*m+(point3(1)+point1(1)-point2(1)-point4(1))*m*n+point1(1);
        a = round(a);
        b = (point2(2)-point1(2))*n+(point4(2)-point1(2))*m+(point3(2)+point1(2)-point2(2)-point4(2))*m*n+point1(2);
        b = round(b);
        outputimg(i,j) = inputimg(b,a);        
    end
end

outputimg = uint8(outputimg);
outputimg = imresize(outputimg,[origin1,origin2],'bilinear');
imwrite(outputimg,'tiger.bmp');
