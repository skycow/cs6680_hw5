function [ labelIm, num ] = FindComponentLabels( im, se )
%FindComponentLabels label connected objects in a binary image
%   Detailed explanation goes here

labelIm = zeros(size(im));
num = 0;

while sum(sum(im))

[fx, fy] = find(im,1);

Xo = zeros(size(im));

Xo(fx, fy) = 1;

Xi = imdilate(Xo, se) & im;

while ~isequal(Xo, double(Xi)) 
    Xo = Xi;
    Xi = imdilate(Xo, se) & im;
end

im = im - Xi;

num = num+1;
labelIm = labelIm + Xi * num;

end

end

