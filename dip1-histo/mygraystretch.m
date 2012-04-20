% lab1 - gray scale stretch 091250183 xubowei
function g = mygraystretch(f, a, b)
%MYHISTEQ compute the histogram of an input image
%
%
if nargin ~= 3
    error('Not enough parameters, 3 must be input!');
end
[d1, d2, d3] = size(f);
if d3 > 1
    f = rgb2gray(f);
end
f = im2uint8(f);
g = zeros(d1, d2);
for i = 1:d1
    for j = 1:d2
        k = double(f(i,j));
        g(i,j) = a * k + b;
    end
end
g = uint8(g);