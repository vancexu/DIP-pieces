function g = mymorph(f, varargin)
%MYMORPH compute mathematical morphology.
%   mymorph(f, method, template) where f is input image, method is one of the 4
%   arguments {'erosion', 'dilation', 'open', 'close'}, template
%   is a logical matrix contains a center points. Notice that template must
%   take the center point as its center, which means the length and width
%   of the template must be odd. 
%
%   mymorph(f, 'hitmiss', template, template2) need 2 templates.
%   Notice that the 2 templates must be consistent, which means same length
%   and width, and most important noncomplicated at same position.
%
%   mymorph(f, 'slim') will slim the input image.
%   
%   test image: word_bw.bmp
if nargin < 2
    error('At least 2 arguments are needed, use "help mymorph" get detail.');
end
method = varargin{1};
if nargin > 2
    template = varargin{2};
    template = im2bw(template);
end
if ~islogical(f);
    f = im2bw(f);
end
g = f;
[d1,d2] = size(f);

if strcmp(method,'erosion');
    g = erosion(f, template);
end
if strcmp(method,'dilation');
    g = dilation(f, template);
end
if strcmp(method,'open');
    g = erosion(f, template);
    g = dilation(g, template);
end
if strcmp(method,'close');
    g = dilation(f, template);
    g = erosion(g, template);
end
if strcmp(method,'hitmiss');
    if nargin ~= 4
        error('4 arguments are needed, 2 templates included, input "help mymorph" for detail');
    end
    template2 = varargin{3};
    g = hitmiss(f, template, template2);
end
if strcmp(method,'slim');
    a11 = [0,0,0;0,1,0;1,1,1];
    a12 = [1,1,1;0,0,0;0,0,0];
    a21 = [0,0,0;1,1,0;1,1,0];
    a22 = [0,1,1;0,0,1;0,0,0];
    a31 = [1,0,0;1,1,0;1,0,0];
    a32 = [0,0,1;0,0,1;0,0,1];
    a41 = [1,1,0;1,1,0;0,0,0];
    a42 = [0,0,0;0,0,1;0,1,1];
    a51 = [1,1,1;0,1,0;0,0,0];
    a52 = [0,0,0;0,0,0;1,1,1];
    a61 = [0,1,1;0,1,1;0,0,0];
    a62 = [0,0,0;1,0,0;1,1,0];
    a71 = [0,0,1;0,1,1;0,0,1];
    a72 = [1,0,0;1,0,0;1,0,0];
    a81 = [0,0,0;0,1,1;0,1,1];
    a82 = [1,1,0;1,0,0;0,0,0];
    f1 = f;
    f2 = im2bw(zeros(d1,d2));
    result = f1 - f2;
    result = any(any(result));
    while result
        f2 = f1;
        f1 = f1 - hitmiss(f1,a11,a12);
        f1 = f1 - hitmiss(f1,a21,a22);
        f1 = f1 - hitmiss(f1,a31,a32);
        f1 = f1 - hitmiss(f1,a41,a42);
        f1 = f1 - hitmiss(f1,a51,a52);
        f1 = f1 - hitmiss(f1,a61,a62);
        f1 = f1 - hitmiss(f1,a71,a72);
        f1 = f1 - hitmiss(f1,a81,a82);
        result = f1 - f2;
        result = any(any(result));
    end
    g = f1;
end

function g = erosion(f, template)
g = f;
[d1,d2] = size(f);
[t1,t2] = size(template);
a = floor(t1/2);
b = floor(t2/2);
for i = 1+a:d1-a
    for j = 1+b:d2-a
        tmp = f(i-a:i+a,j-b:j+b);
        isIn = 1;
        for m = 1:t1
            for n = 1:t2
                if template(m,n) == 1
                    if tmp(m,n) == 0
                        isIn = 0;
                        break;
                    end
                end
            end
            if isIn == 0
                break;
            end
        end
        if isIn
            g(i,j) = 1;
        else
            g(i,j) = 0;
        end
    end
end

function g = dilation(f, template)
g = f;
[d1,d2] = size(f);
[t1,t2] = size(template);
a = floor(t1/2);
b = floor(t2/2);
for i = 1+a:d1-a
    for j = 1+b:d2-a
        tmp = f(i-a:i+a,j-b:j+b);
        isIn = 0;
        for m = 1:t1
            for n = 1:t2
                if template(m,n) == 1
                    if tmp(m,n) == 1
                        isIn = 1;
                        break;
                    end
                end
            end
            if isIn == 1
                break;
            end
        end
        if isIn
            g(i,j) = 1;
        else
            g(i,j) = 0;
        end
    end
end

function g = hitmiss(f, template, template2)
g1 = erosion(f,template);
g2 = ~f;
g2 = erosion(g2,template2);
g = g1 & g2;

% function g = hitmiss(f, template, template2)
% g = f;
% [d1,d2] = size(f);
% [t1,t2] = size(template);
% a = floor(t1/2);
% b = floor(t2/2);
% for i = 1+a:d1-a
%     for j = 1+b:d2-a
%         tmp = f(i-a:i+a,j-b:j+b);
%         isIn = 1;
%         for m = 1:t1
%             for n = 1:t2
%                 if template(m,n) == 1
%                     if tmp(m,n) == 0
%                         isIn = 0;
%                         break;
%                     end
%                 end
%             end
%             if isIn == 0
%                 break;
%             end
%         end
%         if isIn
%             for m = 1:t1
%                 for n = 1:t2
%                     if template2(m,n) == 1
%                         if tmp(m,n) == 1
%                             isIn = 0;
%                             break;
%                         end
%                     end
%                 end
%                 if isIn == 0
%                     break;
%                 end
%             end
%         end
%         if isIn
%             g(i,j) = 1;
%         else
%             g(i,j) = 0;
%         end
%     end
% end