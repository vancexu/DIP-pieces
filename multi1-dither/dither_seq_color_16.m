%ASSIGNMENT 1 REQUIREMENTS: 091250183 �첩ΰ
%For a 24-bit color image, generate the dithered image (4*4)
filename = input('Please input the image file name or absolute path (eg: lena512.bmp): ', 's');
img = imread(filename);
s=size(img);
imgR = img(:,:,1);
imgG = img(:,:,2);
imgB = img(:,:,3);
outImg = zeros(s(1),s(2),s(3));
outImgR = zeros(s(1),s(2));
outImgG = zeros(s(1),s(2));
outImgB = zeros(s(1),s(2));

d1=[0 2;3 1];
d2=[4*d1 4*d1+2;4*d1+3 4*d1+1];
for r = 1:s(1)
    for c = 1:s(2)
        i = mod(r-1,4);
        j = mod(c-1,4);
        mR = ceil(imgR(r,c)/15); % 15=255/17
        mG = ceil(imgG(r,c)/15);
        mB = ceil(imgB(r,c)/15);
        if isequal(mR>=d2(i+1,j+1),1)
            outImgR(r,c) = 1;
        end
        if isequal(mG>=d2(i+1,j+1),1)
            outImgG(r,c) = 1;
        end
        if isequal(mB>=d2(i+1,j+1),1)
            outImgB(r,c) = 1;
        end
    end
end
outImg(:,:,1) = outImgR ; 
outImg(:,:,2) = outImgG ; 
outImg(:,:,3) = outImgB ; 
imshow(outImg);  %this looks better than below
imwrite(outImg,'result3.bmp');  %from this we can see repeate pattern (the white pots)
           