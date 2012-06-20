function g = myfakecolor(f)
%MYFAKECOLOR compute the histogram of an input image
%   myfakecolor(f) where f is the input image
%   for low-pass filter, r = 5, assign to red
%   for bond-pass filter, r = [4,20], assign to blue
%   for high-pass filter, r = 50, assign to green
%   output g is the fake-color-image.
[d1, d2, d3] = size(f);
if d3 > 1
    f = rgb2gray(f);
end
g = zeros(d1,d2,3);
r = myfilter(f, 'BLPF', 5, 0);
g = myfilter(f, 'BHPF', 50, 0);
b = myFilter(f, 'BBPF', 12, 8);
for i = 1:d1
    for j = 1:d2
        g(i,j,1) = r(i,j);
        g(i,j,2) = g(i,j);
        g(i,j,3) = b(i,j);
    end
end
