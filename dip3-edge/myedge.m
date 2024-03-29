function g = myedge(f, varargin)
%MYEDGE Find edges in intensity image.
%   myedge(f, method) where f is input image, method is one of the 5
%   methods { 'roberts', 'prewitt', 'sobel', 'marr', 'canny' }
%   myedge(f, method, threshold) where threshold is used to adjust the result
%   output is image g
%
%   threshold is important, it affect the result directely
%   default threshold is chosen by experiment with "lena picture"

if nargin < 2
    error('At least 2 arguments are needed');
elseif nargin > 3
    error('Too many arguments there');
elseif nargin == 3
    threshold = varargin{2};
end
method = varargin{1};

[d1, d2, d3] = size(f);
if d3 > 1
    f = rgb2gray(f);
end
f = im2double(f);
g = zeros(d1, d2);

if strcmp(method,'roberts')
    if nargin == 2
        threshold = 0.15;
    end
    for i = 1:d1-1
        for j = 1:d2-1
            g(i,j) = abs(f(i,j)-f(i+1,j+1)) + abs(f(i+1,j)-f(i,j+1));
            if g(i,j) < threshold
                g(i,j) = 0;
            else
                g(i,j) = 255;
            end
        end
    end
end

if strcmp(method,'prewitt')
    if nargin == 2
        threshold = 0.55;
    end
    h1 = [
        -1,0,1;
        -1,0,1;
        -1,0,1
    ];
    h2 = [
        -1,-1,-1;
        0, 0, 0;
        1, 1, 1
    ];
    for i = 2:d1-1
        for j = 2:d2-1
            tmp = f(i-1:i+1,j-1:j+1);
            fx = tmp.*h1;
            fy = tmp.*h2;
            g(i,j) = abs(sum(fx(:)))+abs(sum(fy(:)));
            if g(i,j) < threshold
                g(i,j) = 0;
            else
                g(i,j) = 255;
            end
        end
    end
end            

if strcmp(method,'sobel')
    if nargin == 2
        threshold = 0.6;
    end
    h1 = [
        -1,0,1;
        -2,0,2;
        -1,0,1
    ];
    h2 = [
        -1,-2,-1;
        0, 0, 0;
        1, 2, 1
    ];
    for i = 2:d1-1
        for j = 2:d2-1
            tmp = f(i-1:i+1,j-1:j+1);
            fx = tmp.*h1;
            fy = tmp.*h2;
            g(i,j) = abs(sum(fx(:)))+abs(sum(fy(:)));
            if g(i,j) < threshold
                g(i,j) = 0;
            else
                g(i,j) = 255;
            end
        end
    end    
end

if strcmp(method,'marr')
    if nargin == 2
        threshold = 0.8;
    end
    log = [
        0,0,-1,0,0;
        0,-1,-2,-1,0;
        -1,-2,16,-2,-1;
        0,-1,-2,-1,0;
        0,0,-1,0,0
    ];
    for i = 3:d1-2
        for j = 3:d2-2
            tmp = f(i-2:i+2,j-2:j+2);
            r = tmp.*log;
            g(i,j) = sum(r(:));
        end
    end
    for i = 3:d1-3
        for j = 3:d2-3
            pro1 = g(i,j)*g(i+1,j);
            pro2 = g(i,j)*g(i,j+1);
            diff1 = abs(g(i,j)-g(i+1,j));
            diff2 = abs(g(i,j)-g(i,j+1));
            if (pro1 <= 0 && diff1 > threshold) || (pro2 <= 0 && diff2 > threshold)
               g(i,j) = 255;
            else
                g(i,j) = 0;
            end
        end
    end
end
    
if strcmp(method,'canny')
    if nargin == 2
        threshold = 0.07;
    end
    gaus = fspecial('gaussian');
    f = imfilter(f,gaus,'replicate');
    h1 = [-1,-1;1,1];
    h2 = [1,-1;1,-1];
    fx = conv2(f,h1,'same');
    fy = conv2(f,h2,'same');
    grad = sqrt(fx.*fx+fy.*fy);
%     I_max = max(max(NVI));
%     I_min = min(min(NVI));
%     alfa = 0.1;
%     level = alfa * (I_max - I_min) + I_min;
%     Ibw = max(NVI, level.*ones(size(NVI)));
    direction = ones(d1,d2);
    for i = 1:d1
        for j = 1:d2
            if fx(i,j) == 0
                direction(i,j) = 2;
            else
                ang = atan(fy(i,j)/fx(i,j));
                ang = ang / pi * 8;
                ang = round(ang);
                if ang >= 0
                    sec = mod(ang,8);
                else
                    sec = abs(mod(ang,-8));
                end
                if sec == 0 || sec == 7
                    direction(i,j) = 4;
                elseif sec == 1 || sec == 2
                    direction(i,j) = 1;
                elseif sec == 3 || sec == 4
                    direction(i,j) = 2;
                elseif sec == 5 || sec == 6
                    direction(i,j) = 3;
                end
            end
        end
    end
    for i = 2:d1-1
        for j = 2:d2-1
            dire = direction(i,j);
            if dire == 1
                p1 = grad(i+1,j-1);
                p2 = grad(i-1,j+1);
            elseif dire == 2
                p1 = grad(i,j-1);
                p2 = grad(i,j+1);
            elseif dire == 3
                p1 = grad(i-1,j-1);
                p2 = grad(i+1,j+1);
            else
                p1 = grad(i+1,j);
                p2 = grad(i-1,j);
            end
            
            if max([grad(i,j),p1,p2]) ~= grad(i,j)
                grad(i,j) = 0;
            end
        end
    end
    g = im2bw(grad, 0.05);  %0.05 is acceptable for lena
    t1 = threshold; %0.07 ok
    t2 = 2 * t1;
    out1 = g;
    out2 = g;
    for i = 1:d1
        for j = 1:d2
            if grad(i,j) < t1
                out1(i,j) = 0;
            end
            if grad(i,j) < t2
                out2(i,j) = 0;
            end
        end
    end
%     imshow(out1),figure, imshow(out2),figure;
    for i = 2:d1-1
        for j = 2:d2-1
            if out2(i,j) == 0 && out1(i,j) == 1
                tmp = out1(i-1:i+1,j-1:j+1);
                tmp(2,2) = 0;
                if any(tmp)
                    out2(i,j) = 1;
                end
            end
        end
    end
    g = out2;
%     imshow(out1),figure, imshow(out2);
end

    