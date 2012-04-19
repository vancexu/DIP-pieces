%convert bmp img to jpeg 
%091250183 �첩ΰ
%the program first get the head data from a bmp image 
%and then use the data array I to write into a jpeg image.

clc;clear all;close all;
fid=fopen( 'test.bmp','rb');%bmp file opend
bfType=fread(fid,2);
[s, errmsg] = sprintf('file type:%s',char(bfType));
disp(s);

%bmp file size
bfSize=fread(fid,4);
fsize=bfSize(4)*256^3+bfSize(3)*256^2+bfSize(2)*256+bfSize(1);
[s, errmsg] = sprintf('file size:%d byte',fsize);
disp(s);

%bmp file offset bits to the pixel data
bfOffbits=fread(fid,8);
foffset=bfOffbits(8)*256^3+bfOffbits(7)*256^2+bfOffbits(6)*256+bfOffbits(5);
[s, errmsg] = sprintf('offset to pixel data:%d byte',foffset);
disp(s);

%bmp info header size
biSize=fread(fid,4);
isize=biSize(4)*256^3+biSize(3)*256^2+biSize(2)*256+biSize(1);
[s, errmsg] = sprintf('size of infoheader:%d byte',isize);
disp(s);

%fetch width and height
infoRead=fread(fid,8);
biWidth=infoRead(4)*256^3+infoRead(3)*256^2+infoRead(2)*256+infoRead(1);
biHeight=infoRead(8)*256^3+infoRead(7)*256^2+infoRead(6)*256+infoRead(5);
[s, errmsg] = sprintf('width:%d\nheight:%d ',biWidth,biHeight);
disp(s);

infoRead=fread(fid,28);
biBitCount=infoRead(4)*256+infoRead(3);

%construct the data array I,
%this step is the core for the convert
skip=mod((4-mod(((biWidth * biBitCount)/8),4)),4);
%skip=(4-mod(((biWidth * biBitCount)/8),4));
if ((biBitCount==24)&&(foffset==54))
    for i=1:biHeight         
        if biHeight>0
            indHeight=biHeight+1-i;
        else
            indHeight=i;
        end
        for j=1:biWidth
            colorRead=fread(fid,3);
            I(indHeight,j,1)=colorRead(3);
            I(indHeight,j,2)=colorRead(2);
            I(indHeight,j,3)=colorRead(1);
        end
        fread(fid,skip);
    end
else if(biBitCount==32)&&(bfOffbits==54)
    for i=1:biHeight
        if biHeight>0
            indHeight=biHeight+1-i;
        else
            indHeight=i;
        end
        for j=1:biWidth
            colorRead=fread(fid,4);
            I(indHeight,j,1)=colorRead(3);
            I(indHeight,j,2)=colorRead(2);
            I(indHeight,j,3)=colorRead(1);
        end
        fread(fid,skip);
    end
else 
     LUT=fread(fid,(2^biBitCount)*4);
     for i=1:biHeight
        if biHeight>0
            indHeight=biHeight+1-i; 
        else
            indHeight=i;
        end
        for j=1:biWidth
            LUTIndex=fread(fid,1);
            I(indHeight,j,1)=LUT(LUTIndex*4+3);
            I(indHeight,j,2)=LUT(LUTIndex*4+2);
            I(indHeight,j,3)=LUT(LUTIndex*4+1);
        end
        fread(fid,skip);
    end
    end
end

%write data into jpeg image
imshow(uint8(I));
imwrite(uint8(I),'result1.jpg');