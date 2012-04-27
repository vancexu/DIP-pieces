function g = myhisteqcolor(f)
%MYHISTEQCOLOR compute the histogram equalization of an color image
%   input f is the input image
%   output g is the image that f turns out after equalization.

g1 = f(:,:,1);
g1 = histeq(g1);
g2 = f(:,:,2);
g2 = histeq(g2);
g3 = f(:,:,3);
g3 = histeq(g3);

g=cat(3,g1,g2,g3);