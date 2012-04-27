function g = myhisteq(f)
%MYHISTEQ compute the histogram equalization of an input image
%   input f is the input image
%   output g is the image that f turns out after equalization.

[d1, d2, d3] = size(f);
if d3 > 1
    f = rgb2gray(f);
end
f = im2uint8(f);
defaultn = 256;
histogram = zeros(defaultn);
cdf = zeros(defaultn);
g = zeros(d1, d2);

%get histogram
for i = 1:d1
    for j = 1:d2
        k = f(i,j);
        histogram(k) = histogram(k) + 1;
    end
end

%get cdf
cdf(1) = histogram(1);
for i = 2:defaultn
    cdf(i) = cdf(i-1) + histogram(i);
end

%run point operation
for i = 1:d1
    for j = 1:d2
        k = double(f(i,j));
        g(i,j) = cdf(k) * defaultn / (d1 * d2);
    end
end
g = uint8(g);
