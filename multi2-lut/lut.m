%ASSIGNMENT 2 REQUIREMENTS: 091250183 徐博伟
%For a 24-bit color image (Lena.bmp), statistics all used colors in this image, 
%design the median-cut algorithm to generate a lookup table. 
%And convert the 24-color image to 8-bit index image, compare the difference between them.
filename = input('Please input the image file name or path (eg: lena.bmp): ', 's');
img = imread(filename); 
s = size(img);

%first, make a prepare table which is used to sort to half
imgTable = zeros(s(1)*s(2),5);
i=0;
for row = 1:s(1)
    for col = 1:s(2)
        i=i+1;
        imgTable(i,1) = row;
        imgTable(i,2) = col;
        imgTable(i,3:5) = [img(row,col,1),img(row,col,2),img(row,col,3)]; 
        %这个地方很奇怪，若是将上面3行写成
        %imgTable(i,:) = [row,col,img(row,col,1),img(row,col,2),img(row,col,3)];
        %row和col大于256的时候就写不进去，全变成256
    end
end

%then, mid_cut the imgTable
for n = 1:8
    whichColor = mod((n-1),3) + 3;
    times = 2^(n-1);
    lastBegin = 1;
    lastEnd = i/times;
    for m = 1:times
        imgTable(lastBegin:lastEnd,:) = sortrows(imgTable(lastBegin:lastEnd,:),whichColor);
        lastBegin = lastEnd;
        lastEnd = (m+1)/times*i;
    end
end

%generate the colorMap
colorNum = 2^8;  %colorNum = 256
colorMap = zeros(colorNum,3);
lastBegin = 1;
lastEnd = i/colorNum;
for index = 1:colorNum
    colorMap(index,:) = mean( imgTable(lastBegin:lastEnd,[3 4 5]) );
    lastBegin = lastEnd;
    lastEnd = (index+1)*i/colorNum;
end
colorMap = mat2gray(colorMap);  %essential for imshow(X,map), because map must be within [0,1]

%generate the output indexMap
indexMap = zeros(s(1),s(2));
rowsPerIndex = i/colorNum;
for a = 1:i
    pixIndex = ceil(a/rowsPerIndex);
    indexMap(imgTable(a,1),imgTable(a,2)) = pixIndex;
end

%output the result
imshow(indexMap,colorMap);
imwrite(indexMap,colorMap,'result.bmp');