%ASSIGNMENT 1 REQUIREMENTS: 091250183 �첩ΰ
%For a 8-bit gray image (lena.bmp) 
%Generate the ordered ditering image (4*4). 
filename = input('Please input the image file name or absolute path (eg: lena_gray512.bmp): ', 's');
img = imread(filename);
s=size(img);
outImg = zeros(s(1),s(2));

d1=[0 2;3 1];
d2=[4*d1 4*d1+2;4*d1+3 4*d1+1];
for r = 1:s(1)
    for c = 1:s(2)
        i = mod(r-1,4);
        j = mod(c-1,4);
        m = ceil(img(r,c)/15); % 15=255/17
        if isequal(m>=d2(i+1,j+1),1)
            outImg(r,c) = 1;
        end
    end
end
imshow(outImg)
imwrite(outImg,'result2.bmp')
           