%ASSIGNMENT 1 REQUIREMENTS: 091250183 �첩ΰ
%For a 8-bit gray image (lena.bmp) 
%Use a dithering matrix (4*4), generate the dithered image. 
filename = input('Please input the image file name or absolute path (eg: lena_gray.jpg): ', 's');
img = imread(filename);
s = size(img);
outImg = zeros(4*s(1));

for r = 1:s(1)
    for c = 1:s(2)
        m = ceil(img(r,c)/15); % 15=255/17
        switch m
            case 1
                %outImg(4*r-3:4*r,4*c-3:4*c) = [0 0 0 0;0 0 0 0;0 0 0 0;0 0 0 0];
            case 2
                outImg(4*r-3:4*r,4*c-3:4*c) = [1 0 0 0;0 0 0 0;0 0 0 0;0 0 0 0];
            case 3
                outImg(4*r-3:4*r,4*c-3:4*c) = [1 0 0 0;0 0 0 0;0 0 1 0;0 0 0 0];
            case 4
                outImg(4*r-3:4*r,4*c-3:4*c) = [1 0 1 0;0 0 0 0;0 0 1 0;0 0 0 0];
            case 5
                outImg(4*r-3:4*r,4*c-3:4*c) = [1 0 1 0;0 0 0 0;1 0 1 0;0 0 0 0];
            case 6
                outImg(4*r-3:4*r,4*c-3:4*c) = [1 0 1 0;0 1 0 0;1 0 1 0;0 0 0 0];
            case 7
                outImg(4*r-3:4*r,4*c-3:4*c) = [1 0 1 0;0 1 0 0;1 0 1 0;0 0 0 1];
            case 8
                outImg(4*r-3:4*r,4*c-3:4*c) = [1 0 1 0;0 1 0 1;1 0 1 0;0 0 0 1];
            case 9
                outImg(4*r-3:4*r,4*c-3:4*c) = [1 0 1 0;0 1 0 1;1 0 1 0;0 1 0 1];
            case 10
                outImg(4*r-3:4*r,4*c-3:4*c) = [1 1 1 0;0 1 0 1;1 0 1 0;0 1 0 1];
            case 11
                outImg(4*r-3:4*r,4*c-3:4*c) = [1 1 1 0;0 1 0 1;1 0 1 1;0 1 0 1];
            case 12
                outImg(4*r-3:4*r,4*c-3:4*c) = [1 1 1 1;0 1 0 1;1 0 1 1;0 1 0 1];
            case 13
                outImg(4*r-3:4*r,4*c-3:4*c) = [1 1 1 1;0 1 0 1;1 1 1 1;0 1 0 1];
            case 14
                outImg(4*r-3:4*r,4*c-3:4*c) = [1 1 1 1;1 1 0 1;1 1 1 1;0 1 0 1];
            case 15
                outImg(4*r-3:4*r,4*c-3:4*c) = [1 1 1 1;1 1 0 1;1 1 1 1;0 1 1 1];
            case 16
                outImg(4*r-3:4*r,4*c-3:4*c) = [1 1 1 1;1 1 1 1;1 1 1 1;0 1 1 1];
            case 17 
                outImg(4*r-3:4*r,4*c-3:4*c) = [1 1 1 1;1 1 1 1;1 1 1 1;1 1 1 1];
            otherwise
                outImg(4*r-3:4*r,4*c-3:4*c) = [1 1 1 1;1 1 1 1;1 1 1 1;1 1 1 1];
        end
    end
end
imshow(outImg)  %the result doesn't looks well through imshow becasue of the scale
imwrite(outImg,'result1.bmp');  %this looks better~
           