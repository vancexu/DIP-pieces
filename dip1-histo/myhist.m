% lab1 - histogram 091250183 xubowei
function g = myhist(f, varargin)
%MYHIST compute the histogram of an input image
%
%

error(nargchk(1, 2, nargin));

[d1, d2, d3] = size(f);
if d3 > 1
    f = rgb2gray(f);
end
f = im2uint8(f);

if nargin == 1
    defaultn = 256;
    outHist = zeros(defaultn, 1);
    for r = 1:d1
        for c = 1:d2
            outHist(f(r,c)+1, 1) = outHist(f(r,c)+1, 1) + 1;
        end
    end
end

if nargin == 2
    defaultn = varargin{1};
    outHist = zeros(defaultn, 1);
    quan = floor(256 / defaultn);
    for r = 1:d1
        for c = 1:d2
            tmp = f(r,c);
            tmp = double(tmp);  % this is nessary because tmp is uint8(0-255) 
            x = floor( tmp / quan ) + 1; % there are a bug before
            outHist(x, 1) = outHist(x, 1) + 1;
        end
    end
end
g= outHist;