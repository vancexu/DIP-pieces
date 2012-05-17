function g = myedgedetection(f, varargin)
%MYEDGEDETECTION 
%   myedgedetection(f) where f is input image
%   myedgedetection(f, n) where n is threshod
%   output is image g
%
%   The principle is: for each pixel f(i,j), consider the 8 pixels around
%   it and then record the max and min pixel grey density. Then compute the
%   difference of the max and min and assign it to varaible diff. If diff >
%   threshod, the output g(i,j) = 255, else g(i,j) = 0;

[d1, d2, d3] = size(f);
if d3 > 1
    f = rgb2gray(f);
end
f = im2uint8(f);
g = zeros(d1, d2);
if nargin == 2
    threshold = varargin{1};
else
    threshold = 65;
end

for i = 2:d1-1
    for j = 2:d2-1
        tmp = [
            f(i-1,j-1),f(i-1,j),f(i-1,j+1);
            f(i,j-1),f(i,j),f(i,j+1);
            f(i+1,j-1),f(i+1,j),f(i+1,j+1)];        
        maxp = double(max(tmp(:)));
        minp = double(min(tmp(:)));
        diff = maxp - minp;
        if diff >= threshold
            g(i,j) = 255;
        end
    end
end
g = uint8(g);        