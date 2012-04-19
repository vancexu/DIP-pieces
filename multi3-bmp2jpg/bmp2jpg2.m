%convert bmp img to jpeg 
%091250183 徐博伟
%the program folow the step described in the text book. 

clc;clear all;close all;
%亮度量化表（值没与书上一致）
qy=[...
    3   2   2   3   5   8  10  12
    2   2   3   4   5  12  12  11
    3   3   3   5   8  11  14  11
    3   3   4   6  10  17  16  12
    4   4   7  11  14  22  21  15
    5   7  11  13  16  21  23  18
    10  13  16  17  21  24  24  20
    14  18  19  20  22  20  21  20]; 
%颜色量化表 
qc=[...
    3   4   5   9  20  20  20  20
    4   4   5  13  20  20  20  20
    5   5  11  20  20  20  20  20
    9   13  20  20  20 20 20  20
    20  20  20  20  20  20  20  20
    20  20  20  20  20  20  20  20
    20  20  20  20  20  20  20  20
    20  20  20  20  20  20  20  20];

row= [1 1 2 3 2 1 1 2 3 4 5 4 3 2 1 1 2 3 4 5 6 7 6 5 4 3 2 1 1 2 3 4 5 6 7 8 8 7 6 5 4 3 2 3 4 5 6 7 8 8 7 6 5 4 5 6 7 8 8 7 6 7 8 8];
col= [1 2 1 1 2 3 4 3 2 1 1 2 3 4 5 6 5 4 3 2 1 1 2 3 4 5 6 7 8 7 6 5 4 3 2 1 2 3 4 5 6 7 8 8 7 6 5 4 3 4 5 6 7 8 8 7 6 5 6 7 8 8 7 8];

%DC AC
%run - no of bits required to encode data- total 
%length - base code length(imp) -  base code use for both luminance and chr as in hex file...
tabledc=[...
     3 0 1 0 0 0 0 0 0 0
     3 0 1 1 0 0 0 0 0 0
     3 1 0 0 0 0 0 0 0 0
     3 1 0 1 0 0 0 0 0 0
     3 1 1 0 0 0 0 0 0 0
     4 1 1 1 0 0 0 0 0 0
     5 1 1 1 1 0 0 0 0 0
     6 1 1 1 1 1 0 0 0 0
     7 1 1 1 1 1 1 0 0 0
     8 1 1 1 1 1 1 1 0 0
     9 1 1 1 1 1 1 1 1 0];
tableac=[...
 0  1   3  2 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
 0  2   4  2 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0
 0  3   6  3 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 
 0  4   8  4 1 0 1 1 0 0 0 0 0 0 0 0 0 0 0 0
 0  5  10  5 1 1 0 1 0 0 0 0 0 0 0 0 0 0 0 0 
 0  6  13  7 1 1 1 1 0 0 0 0 0 0 0 0 0 0 0 0 
 0  7  15  8 1 1 1 1 1 0 0 0 0 0 0 0 0 0 0 0 
 0  8  18 10 1 1 1 1 1 1 0 1 1 0 0 0 0 0 0 0
 0  9  25 16 1 1 1 1 1 1 1 1 1 0 0 0 0 0 1 0
 0 10  26 16 1 1 1 1 1 1 1 1 1 0 0 0 0 0 1 1
 1  1   5  4 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 
 1  2   7  5 1 1 0 1 1 0 0 0 0 0 0 0 0 0 0 0 
 1  3  10  7 1 1 1 1 0 0 1 0 0 0 0 0 0 0 0 0
 1  4  13  9 1 1 1 1 1 0 1 1 0 0 0 0 0 0 0 0
 1  5  16 11 1 1 1 1 1 1 1 0 1 1 0 0 0 0 0 0
 1  6  22 16 1 1 1 1 1 1 1 1 1 0 0 0 0 1 0 0
 1  7  23 16 1 1 1 1 1 1 1 1 1 0 0 0 0 1 0 1
 1  8  24 16 1 1 1 1 1 1 1 1 1 0 0 0 0 1 1 0
 1  9  25 16 1 1 1 1 1 1 1 1 1 0 0 0 0 1 1 1
 1 10  26 16 1 1 1 1 1 1 1 1 1 0 0 0 1 0 0 0
 2  1   6  5 1 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 
 2  2  10  8 1 1 1 1 1 0 0 1 0 0 0 0 0 0 0 0
 2  3  13 10 1 1 1 1 1 1 0 1 1 1 0 0 0 0 0 0 
 2  4  16 12 1 1 1 1 1 1 1 1 0 1 0 0 0 0 0 0
 2  5  21 16 1 1 1 1 1 1 1 1 1 0 0 0 1 0 0 1
 2  6  22 16 1 1 1 1 1 1 1 1 1 0 0 0 1 0 1 0
 2  7  23 16 1 1 1 1 1 1 1 1 1 0 0 0 1 0 1 1
 2  8  24 16 1 1 1 1 1 1 1 1 1 0 0 0 1 1 0 0
 2  9  25 16 1 1 1 1 1 1 1 1 1 0 0 0 1 1 0 1
 2 10  26 16 1 1 1 1 1 1 1 1 1 0 0 0 1 1 1 0
 3  1   7  6 1 1 1 0 1 0 0 0 0 0 0 0 0 0 0 0
 3  2  11  9 1 1 1 1 1 0 1 1 1 0 0 0 0 0 0 0
 3  3  15 12 1 1 1 1 1 1 1 1 0 1 0 1 0 0 0 0 
 3  4  20 16 1 1 1 1 1 1 1 1 1 0 0 0 1 1 1 1
 3  5  21 16 1 1 1 1 1 1 1 1 1 0 0 1 0 0 0 0
 3  6  22 16 1 1 1 1 1 1 1 1 1 0 0 1 0 0 0 1
 3  7  23 16 1 1 1 1 1 1 1 1 1 0 0 1 0 0 1 0
 3  8  24 16 1 1 1 1 1 1 1 1 1 0 0 1 0 0 1 1
 3  9  25 16 1 1 1 1 1 1 1 1 1 0 0 1 0 1 0 0
 3 10  26 16 1 1 1 1 1 1 1 1 1 0 0 1 0 1 0 1
 4  1   7  6 1 1 1 0 1 1 0 0 0 0 0 0 0 0 0 0
 4  2  12 10 1 1 1 1 1 1 1 0 0 0 0 0 0 0 0 0 
 4  3  19 16 1 1 1 1 1 1 1 1 1 0 0 1 0 1 1 0
 4  4  20 16 1 1 1 1 1 1 1 1 1 0 0 1 0 1 1 1
 4  5  21 16 1 1 1 1 1 1 1 1 1 0 0 1 1 0 0 0
 4  6  22 16 1 1 1 1 1 1 1 1 1 0 0 1 1 0 0 1
 4  7  23 16 1 1 1 1 1 1 1 1 1 0 0 1 1 0 1 0
 4  8  24 16 1 1 1 1 1 1 1 1 1 0 0 1 1 0 1 1
 4  9  25 16 1 1 1 1 1 1 1 1 1 0 0 1 1 1 0 0
 4 10  26 16 1 1 1 1 1 1 1 1 1 0 0 1 1 1 0 1
 5  1   8  7 1 1 1 1 0 1 0 0 0 0 0 0 0 0 0 0
 5  2  13 11 1 1 1 1 1 1 1 0 1 1 1 0 0 0 0 0 
 5  3  19 16 1 1 1 1 1 1 1 1 1 0 0 1 1 1 1 0
 5  4  20 16 1 1 1 1 1 1 1 1 1 0 0 1 1 1 1 1
 5  5  21 16 1 1 1 1 1 1 1 1 1 0 1 0 0 0 0 0
 5  6  22 16 1 1 1 1 1 1 1 1 1 0 1 0 0 0 0 1
 5  7  23 16 1 1 1 1 1 1 1 1 1 0 1 0 0 0 1 0
 5  8  24 16 1 1 1 1 1 1 1 1 1 0 1 0 0 0 1 1
 5  9  25 16 1 1 1 1 1 1 1 1 1 0 1 0 0 1 0 0
 5 10  26 16 1 1 1 1 1 1 1 1 1 0 1 0 0 1 0 1
 6  1   8  7 1 1 1 1 0 1 1 0 0 0 0 0 0 0 0 0
 6  2  14 12 1 1 1 1 1 1 1 1 0 1 1 0 0 0 0 0 
 6  3  19 16 1 1 1 1 1 1 1 1 1 0 1 0 0 1 1 0
 6  4  20 16 1 1 1 1 1 1 1 1 1 0 1 0 0 1 1 1
 6  5  21 16 1 1 1 1 1 1 1 1 1 0 1 0 1 0 0 0
 6  6  22 16 1 1 1 1 1 1 1 1 1 0 1 0 1 0 0 1
 6  7  23 16 1 1 1 1 1 1 1 1 1 0 1 0 1 0 1 0
 6  8  24 16 1 1 1 1 1 1 1 1 1 0 1 0 1 0 1 1
 6  9  25 16 1 1 1 1 1 1 1 1 1 0 1 0 1 1 0 0
 6 10  26 16 1 1 1 1 1 1 1 1 1 0 1 0 1 1 0 1
 7  1   9  8 1 1 1 1 1 0 1 0 0 0 0 0 0 0 0 0
 7  2  14 12 1 1 1 1 1 1 1 1 0 1 1 1 0 0 0 0 
 7  3  19 16 1 1 1 1 1 1 1 1 1 0 1 0 1 1 1 0
 7  4  20 16 1 1 1 1 1 1 1 1 1 0 1 0 1 1 1 1
 7  5  21 16 1 1 1 1 1 1 1 1 1 0 1 1 0 0 0 0
 7  6  22 16 1 1 1 1 1 1 1 1 1 0 1 1 0 0 0 1
 7  7  23 16 1 1 1 1 1 1 1 1 1 0 1 1 0 0 1 0
 7  8  24 16 1 1 1 1 1 1 1 1 1 0 1 1 0 0 1 1
 7  9  25 16 1 1 1 1 1 1 1 1 1 0 1 1 0 1 0 0
 7 10  26 16 1 1 1 1 1 1 1 1 1 0 1 1 0 1 0 1
 8  1  10  9 1 1 1 1 1 1 0 0 0 0 0 0 0 0 0 0
 8  2  17 15 1 1 1 1 1 1 1 1 1 0 0 0 0 0 0 0
 8  3  19 16 1 1 1 1 1 1 1 1 1 0 1 1 0 1 1 0
 8  4  20 16 1 1 1 1 1 1 1 1 1 0 1 1 0 1 1 1
 8  5  21 16 1 1 1 1 1 1 1 1 1 0 1 1 1 0 0 0
 8  6  22 16 1 1 1 1 1 1 1 1 1 0 1 1 1 0 0 1
 8  7  23 16 1 1 1 1 1 1 1 1 1 0 1 1 1 0 1 0
 8  8  24 16 1 1 1 1 1 1 1 1 1 0 1 1 1 0 1 1
 8  9  25 16 1 1 1 1 1 1 1 1 1 0 1 1 1 1 0 0
 8 10  26 16 1 1 1 1 1 1 1 1 1 0 1 1 1 1 0 1
 9  1  10  9 1 1 1 1 1 1 0 0 1 0 0 0 0 0 0 0 
 9  2  18 16 1 1 1 1 1 1 1 1 1 0 1 1 1 1 1 0
 9  3  19 16 1 1 1 1 1 1 1 1 1 0 1 1 1 1 1 1
 9  4  20 16 1 1 1 1 1 1 1 1 1 1 0 0 0 0 0 0
 9  5  21 16 1 1 1 1 1 1 1 1 1 1 0 0 0 0 0 1
 9  6  22 16 1 1 1 1 1 1 1 1 1 1 0 0 0 0 1 0
 9  7  23 16 1 1 1 1 1 1 1 1 1 1 0 0 0 0 1 1
 9  8  24 16 1 1 1 1 1 1 1 1 1 1 0 0 0 1 0 0
 9  9  25 16 1 1 1 1 1 1 1 1 1 1 0 0 0 1 0 1
 9 10  26 16 1 1 1 1 1 1 1 1 1 1 0 0 0 1 1 0
10  1  10  9 1 1 1 1 1 1 0 1 0 0 0 0 0 0 0 0 
10  2  18 16 1 1 1 1 1 1 1 1 1 1 0 0 0 1 1 1
10  3  19 16 1 1 1 1 1 1 1 1 1 1 0 0 1 0 0 0
10  4  20 16 1 1 1 1 1 1 1 1 1 1 0 0 1 0 0 1
10  5  21 16 1 1 1 1 1 1 1 1 1 1 0 0 1 0 1 0
10  6  22 16 1 1 1 1 1 1 1 1 1 1 0 0 1 0 1 1
10  7  23 16 1 1 1 1 1 1 1 1 1 1 0 0 1 1 0 0
10  8  24 16 1 1 1 1 1 1 1 1 1 1 0 0 1 1 0 1
10  9  25 16 1 1 1 1 1 1 1 1 1 1 0 0 1 1 1 0
10 10  26 16 1 1 1 1 1 1 1 1 1 1 0 0 1 1 1 1
11  1  11 10 1 1 1 1 1 1 1 0 0 1 0 0 0 0 0 0 
11  2  18 16 1 1 1 1 1 1 1 1 1 1 0 1 0 0 0 0
11  3  19 16 1 1 1 1 1 1 1 1 1 1 0 1 0 0 0 1
11  4  20 16 1 1 1 1 1 1 1 1 1 1 0 1 0 0 1 0
11  5  21 16 1 1 1 1 1 1 1 1 1 1 0 1 0 0 1 1
11  6  22 16 1 1 1 1 1 1 1 1 1 1 0 1 0 1 0 0
11  7  23 16 1 1 1 1 1 1 1 1 1 1 0 1 0 1 0 1
11  8  24 16 1 1 1 1 1 1 1 1 1 1 0 1 0 1 1 0
11  9  25 16 1 1 1 1 1 1 1 1 1 1 0 1 0 1 1 1
11 10  26 16 1 1 1 1 1 1 1 1 1 1 0 1 1 0 0 0
12  1  11 10 1 1 1 1 1 1 1 0 1 0 0 0 0 0 0 0 
12  2  18 16 1 1 1 1 1 1 1 1 1 1 0 1 1 0 0 1
12  3  19 16 1 1 1 1 1 1 1 1 1 1 0 1 1 0 1 0
12  4  20 16 1 1 1 1 1 1 1 1 1 1 0 1 1 0 1 1
12  5  21 16 1 1 1 1 1 1 1 1 1 1 0 1 1 1 0 0
12  6  22 16 1 1 1 1 1 1 1 1 1 1 0 1 1 1 0 1
12  7  23 16 1 1 1 1 1 1 1 1 1 1 0 1 1 1 1 0
12  8  24 16 1 1 1 1 1 1 1 1 1 1 0 1 1 1 1 1
12  9  25 16 1 1 1 1 1 1 1 1 1 1 1 0 0 0 0 0
12 10  26 16 1 1 1 1 1 1 1 1 1 1 1 0 0 0 0 1
13  1  12 11 1 1 1 1 1 1 1 1 0 0 0 0 0 0 0 0 
13  2  18 16 1 1 1 1 1 1 1 1 1 1 1 0 0 0 1 0
13  3  19 16 1 1 1 1 1 1 1 1 1 1 1 0 0 0 1 1
13  4  20 16 1 1 1 1 1 1 1 1 1 1 1 0 0 1 0 0
13  5  21 16 1 1 1 1 1 1 1 1 1 1 1 0 0 1 0 1
13  6  22 16 1 1 1 1 1 1 1 1 1 1 1 0 0 1 1 0
13  7  23 16 1 1 1 1 1 1 1 1 1 1 1 0 0 1 1 1
13  8  24 16 1 1 1 1 1 1 1 1 1 1 1 0 1 0 0 0
13  9  25 16 1 1 1 1 1 1 1 1 1 1 1 0 1 0 0 1
13 10  26 16 1 1 1 1 1 1 1 1 1 1 1 0 1 0 1 0
14  1  17 16 1 1 1 1 1 1 1 1 1 1 1 0 1 0 1 1
14  2  18 16 1 1 1 1 1 1 1 1 1 1 1 0 1 1 0 0
14  3  19 16 1 1 1 1 1 1 1 1 1 1 1 0 1 1 0 1
14  4  20 16 1 1 1 1 1 1 1 1 1 1 1 0 1 1 1 0
14  5  21 16 1 1 1 1 1 1 1 1 1 1 1 0 1 1 1 1
14  6  22 16 1 1 1 1 1 1 1 1 1 1 1 1 0 0 0 0
14  7  23 16 1 1 1 1 1 1 1 1 1 1 1 1 0 0 0 1
14  8  24 16 1 1 1 1 1 1 1 1 1 1 1 1 0 0 1 0
14  9  25 16 1 1 1 1 1 1 1 1 1 1 1 1 0 0 1 1
14 10  26 16 1 1 1 1 1 1 1 1 1 1 1 1 0 1 0 0
15  1  17 16 1 1 1 1 1 1 1 1 1 1 1 1 0 1 0 1
15  2  18 16 1 1 1 1 1 1 1 1 1 1 1 1 0 1 1 0
15  3  19 16 1 1 1 1 1 1 1 1 1 1 1 1 0 1 1 1
15  4  20 16 1 1 1 1 1 1 1 1 1 1 1 1 1 0 0 0
15  5  21 16 1 1 1 1 1 1 1 1 1 1 1 1 1 0 0 1
15  6  22 16 1 1 1 1 1 1 1 1 1 1 1 1 1 0 1 0
15  7  23 16 1 1 1 1 1 1 1 1 1 1 1 1 1 0 1 1
15  8  24 16 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0 0
15  9  25 16 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0 1
15 10  26 16 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0];

img=imread('test.bmp','bmp');
prop=imfinfo('test.bmp','bmp');

h=ceil((prop.Height)/8);
w=ceil((prop.Width)/8);

ycbcrmap=zeros(h*8,w*8,3);
ycbcrmap(1:prop.Height,1:prop.Width,1:3) = rgb2ycbcr(img);

fid1=  fopen('result2.jpg','w');
fid2=  fopen('header','r');
hread=fread(fid2);
fwrite(fid1,hread);
fclose(fid2);
buf=[];
bufstr='';
accode=[];

for i=1:h
    for j=1:w
        temp=zeros(8,8);
        for y=1:3
            for k=1:8
                for l=1:8
                    temp(k,l)=ycbcrmap(((i-1)*8)+k,((j-1)*8)+l,y);
                end
            end
            temp=temp-128;         
            temp=dct2(temp);      
        
            if(y==1)
                temp=temp./qy;
            else
                temp=temp./qc;
            end
      
            temp=round(temp);
                 
            for ct=1:64
                str(ct)=temp(row(ct),col(ct));
            end
   
            if j==1 & i==1
                dc=temp(1);
                dcl(y)=temp(1);
            else
            dc=temp(1)-dcl(y);
            dcl(y)=temp(1);
            end
   
            if dc==0
                dccode=[0 0];
            else
                dcabs=abs(dc);
                dcbin=dec2bin(dcabs);
                dclen=length(dcbin);
                if dc<0
                    comp=repmat(49,[1 dclen]);
                    dcbin=comp-dcbin;
                else
                    comp=repmat(48,[1 dclen]);
                    dcbin=dcbin-comp;
                end
                dccode=tabledc(dclen,2:1+tabledc(dclen,1));
                dccode=[dccode dcbin];
            end
            
        %ac dec for lum
        str=str(2:64);
        nozac=find(str~=0);
        acno=length(nozac);

        for o=1:acno
            ac=str(nozac(o));
            acabs=abs(ac);
            acbin=dec2bin(acabs);
            aclen=length(acbin);
            if ac<0
                comp=repmat(49,[1 aclen]);
                acbin=comp-acbin;
            else
                comp=repmat(48,[1 aclen]);
                acbin=acbin-comp;
            end
   
            if(nozac(o)==1)
                acseq=tableac(aclen,5:4+tableac(aclen,4));
                accode=[accode acseq acbin];
            else
                if o==1
                    z=nozac(o)-1;
                else
                    z=nozac(o)-nozac(o-1)-1;
                end
         
            %check 4 if z>=15
            noz=floor(z/15);
            zrl=[1 1 1 1 1 1 1 1 0 0 1];
            accode=[accode repmat(zrl,[1,noz])];
            z=rem(z,15);
         
            %generate the huffman sequence from table
            acseq=tableac((z*10)+aclen,5:4+tableac((z*10)+aclen,4));
            accode=[accode acseq acbin];
            end
        end
   
        accode=[accode 1 0 1 0];
        accode=[dccode accode];  
        if(i==h)
            if(j==w)
                accode=[accode 0 0 1 0 1 0];
            end
        end
        %fwrite to file
        q=1;     
        while(q<=length(accode))
            if length(buf)~=8
                buf=[buf accode(q)];
                q=q+1;
            else
                for e=1:8
                    if buf(e)==0
                        bufstr=[bufstr '0'];
                    else
                        bufstr=[bufstr '1'];
                    end
                end
                kk=bin2dec(bufstr);
                fwrite(fid1,kk,'uint8');
                if kk==255
                    fwrite(fid1,0,'uint8');
                end
                buf=[];
                bufstr=[];
            end
        end
        temp=[];
        accode=[];
        dccode=[];  
   
        end   
    end
end

if length(buf)~=0
    buf=[buf zeros(1,8-length(buf))];
    for e=1:8
        if buf(e)==0
            bufstr=[bufstr '0'];
        else
            bufstr=[bufstr '1'];
        end
    end
    kk=bin2dec(bufstr);
    fwrite(fid1,kk,'uint8');
    if kk==255
        fwrite(fid1,0,'uint8');
    end
end
%corresponding to ff
fwrite(fid1,255,'uint8');
%corresponding to d9
fwrite(fid1,217,'uint8');

fseek(fid1,163,-1);
if(prop.Height<255)
    fwrite(fid1,0,'uint8');
    fwrite(fid1,prop.Height,'uint8');
else
    fwrite(fid1,(prop.Height/256),'uint8');
    fwrite(fid1,rem(prop.Height,256),'uint8');
end
fseek(fid1,165,-1);
%specify height at an offset of a4
if(prop.Width<255)
    fwrite(fid1,0,'uint8');
    fwrite(fid1,prop.Width,'uint8');
else
    fwrite(fid1,(prop.Width/256),'uint8');
    fwrite(fid1,rem(prop.Width,256),'uint8');
end
  
fclose(fid1);