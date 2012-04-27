function g = mygraystretch(f, a, b)
%MYGRAYSTRETCH compute the gray scale stretch of an image
%   input f,a,b where f is the input image, a b are parameters of the
%   linear equtation (a*x+b)
%   output is image g

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
        if g(i,j) > 255
            g(i,j) = 255;
        end
        if g(i,j) < 0
            g(i,j) = 0
        end
    end
end
g = uint8(g);