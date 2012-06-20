function g = myfilter(f, varargin)
%MYFILTER intergret some useful filter  
%   myfilter(f, method, d0) where f is the input image, method is among 
%   {'ILPF', 'IHPF', 'IBPF', 'IBSF', 'BLPF', 'BHPF', 'BBPF', 'BSPF', 'ELPF', 'EHPF'}.
%   The first letter in method name represents method used: I for ideal, B for
%   Butterworth, E for exponent. 
%   The second letter in method name represents LOW, HIGH or BOND.
%   The third letter in method name represents PASS or NOTPASS(S)
%   d0 is the cut-down frequency, which means that only points whose radius within
%   d0 will pass.
% 
%   For BOND type, a bondwidth is needed, such as myfilter(f, 'IBPF', d0,
%   bondwidth).
%   For method Butterworth and Exponent, an order is optional, the default
%   order is 1. example as myfilter(f, 'BLPF', d0, 2)
%   

[d1, d2, d3] = size(f);
if d3 > 1
    f = rgb2gray(f);
end
if nargin < 3
    error('At least 3 arguments are needed, use "help myfilter" get detail.');       
end
method = varargin{1};
d0 = varargin{2};
if any(strcmp(method,{'BLPF','BHPF','ELPF','EHPF'}))
    if nargin == 4
        orderN = varargin{3};
    else
        orderN = 1;
    end
end
if any(strcmp(method,{'BBPF','BBSF'}))
    if nargin == 5
        orderN = varargin{4};
    else
        orderN = 1;
    end
end
g = zeros(d1, d2);
H = zeros(d1, d2);
G = zeros(d1, d2);
cx = d1 / 2;
cy = d2 / 2;
F = fftshift(fft2(f));

if strcmp(method,'ILPF')
    for i = 1:d1
        for j = 1:d2
            x = abs(i-cx);
            y = abs(j-cy);
            distance = sqrt(x^2+y^2);
            if distance <= d0
                H(i,j) = 1;
            else
                H(i,j) = 0;
            end
        end
    end
end

if strcmp(method,'IHPF')
    for i = 1:d1
        for j = 1:d2
            x = abs(i-cx);
            y = abs(j-cy);
            distance = sqrt(x^2+y^2);
            if distance <= d0
                H(i,j) = 0;
            else
                H(i,j) = 1;
            end
        end
    end
end

if strcmp(method,'IBPF')
    bondwidth = varargin{3};
    for i = 1:d1
        for j = 1:d2
            x = abs(i-cx);
            y = abs(j-cy);
            distance = sqrt(x^2+y^2);
            if (distance <= d0-bondwidth/2 || distance >= d0+bondwidth/2)
                H(i,j) = 0;
            else
                H(i,j) = 1;
            end
        end
    end
end

if strcmp(method,'IBSF')
    bondwidth = varargin{3};
    for i = 1:d1
        for j = 1:d2
            x = abs(i-cx);
            y = abs(j-cy);
            distance = sqrt(x^2+y^2);
            if (distance <= d0-bondwidth/2 || distance >= d0+bondwidth/2)
                H(i,j) = 1;
            else
                H(i,j) = 0;
            end
        end
    end
end

if strcmp(method,'BLPF')
    for i = 1:d1
        for j = 1:d2
            x = i - cx;
            y = j - cy;
            d = (x^2+y^2)/d0^2;
            d = d^orderN;
            H(i,j) = 1 / (1+d);
        end
    end
end

if strcmp(method,'BHPF')
    for i = 1:d1
        for j = 1:d2
            x = i - cx;
            y = j - cy;
            d = d0^2/(x^2+y^2);
            d = d^orderN;
            H(i,j) = 1 / (1+d);
        end
    end
end

if strcmp(method,'BBPF')
    bondwidth = varargin{3};
    for i = 1:d1
        for j = 1:d2
            x = i - cx;
            y = j - cy;
            r = x^2 + y^2;
            d = r*bondwidth^2/(r^2-d0^4);
            d = d^orderN;
            H(i,j) = 1 / (1+d);
        end
    end
end

if strcmp(method,'BBSF')
    bondwidth = varargin{3};
    for i = 1:d1
        for j = 1:d2
            x = i - cx;
            y = j - cy;
            r = x^2 + y^2;
            d = (r^2-d0^4) / r*bondwidth^2;
            d = d^orderN;
            H(i,j) = 1 / (1+d);
        end
    end
end

if strcmp(method,'ELPF')
    for i = 1:d1
        for j = 1:d2
            x = i - cx;
            y = j - cy;
            d = (x^2 + y^2) / d0^2;
            d = - d^orderN;
            H(i,j) = exp(d);
        end
    end
end

if strcmp(method,'EHPF')
    for i = 1:d1
        for j = 1:d2
            x = i - cx;
            y = j - cy;
            d = d0^2 / (x^2 + y^2) ;
            d = - d^orderN;
            H(i,j) = exp(d);
        end
    end
end


G = F .* H;
g = real(ifft2(ifftshift(G)));
g = uint8(g);