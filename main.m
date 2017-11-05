% Skyler Cowley
% CS 6680
% Homework 5

close all;

% -----Start Solving Problem I-----
%% -----Start Solving Problem 1-----

f = imread('City.jpg');

b = strel('square',3);

g = ( imdilate(f, b) - imerode(f, b) );

figure(1);
imshow(g);
title 'Resultant Image'

%%%describe Something -  enlarge one shrink other leaves inside%%%

%% -----Finish Solving Problem 1-----
pause();
%% -----Start Solving Problem 2-----

imI2 = imread('SmallSquares.tif');

bI2 = [[-1 1 0];[-1 1 1];[-1 -1 -1];];

resI2 =  bwhitmiss(imI2, bI2);

figure(2);
imshow(resI2);
title 'Pixels w/ E & N neighbors'

fprintf('Problem I.2: Pixel count = %d\n', sum(sum(resI2)));

%% -----Finish Solving Problem 2-----
pause();
%% -----Start Solving Problem 3-----

imI3 = imread('Wirebond.tif');
bI3 = imI3;
cI3 = imI3;
dI3 = imI3;

for i=1:6 bI3 = imerode(bI3, strel('square',3)); end

for i=1:3 cI3 = imerode(cI3, strel('square',3)); end

for i=1:16 dI3 = imerode(dI3, strel('square',3)); end

figure(3);
subplot(1,3,1);
imshow(bI3);
title '(b) Desired Image 1'
subplot(1,3,2);
imshow(cI3);
title '(c) Desired Image 2'
subplot(1,3,3);
imshow(dI3);
title '(d) Desired Image 3'

%% -----Finish Solving Problem 3-----
pause();
%% -----Start Solving Problem 4-----

imI4 = imread('Shapes.tif');

bI4 = imI4;
cI4 = imI4;
dI4 = imI4;

for i=1:10 bI4 = imerode(bI4, strel('square',3)); end
for i=1:7 bI4 = imdilate(bI4, strel('square',3)); end

for i=1:8 cI4 = imdilate(cI4, strel('square',3)); end
for i=1:8 cI4 = imerode(cI4, strel('square',3)); end

for i=1:8 dI4 = imdilate(dI4, strel('square',3)); end
for i=1:17 dI4 = imerode(dI4, strel('square',3)); end

figure(3);
subplot(1,3,1);
imshow(bI4);
title '(b) Desired Image 1'
subplot(1,3,2);
imshow(cI4);
title '(b) Desired Image 1'
subplot(1,3,3);
imshow(dI4);
title '(b) Desired Image 1'

%% -----Finish Solving Problem 4-----
pause();
%% -----Start Solving Problem 5-----

A = imread('Dowels.tif');

B = strel('disk',5);

Aco = imclose(imopen(A,B),B);

Aoc = imopen(imclose(A,B),B);

figure(5);
subplot(1,2,1);
imshow(Aco);
title 'Close-Open w/ disk=5'
subplot(1,2,2);
imshow(Aoc);
title 'Open-Close w/ disk=5'

%%%explain something%%%

Aco2 = A;
Aoc2 = A;

for i = 2:5
    B2 = strel('disk',i);
    Aco2 = imclose(imopen(Aco2,B2),B2);
end

for i = 2:5
    B2 = strel('disk',i);
    Aoc2 = imopen(imclose(Aoc2,B2),B2);
end


figure(6);
subplot(1,2,1);
imshow(Aco2);
title 'Close-Open w/ disks=2,3,4,5'
subplot(1,2,2);
imshow(Aoc2);
title 'Open-Close w/ disks=2,3,4,5'

%%%explain something%%%

%% -----Finish Solving Problem 5-----
% -----Finish Solving Problem I-----
pause();
% -----Start Solving Problem II-----
%% -----Start Solving Problem 1-----

imin = imread('Ball.tif');

se = strel('disk', 1);

[a, b] = FindComponentLabels(imin, se);

figure(7);
imshow(label2rgb(a));
title 'My Connected Objects'

fprintf('Problem II.1: Connected Particles = %d\n', b);

%% -----Finish Solving Problem 1-----
pause();
%% -----Start Solving Problem 2-----

imin = imread('Ball.tif');

[L,num] = bwlabel(imin); 

figure(8);
imshow(label2rgb(L));
title 'Matlab Connected Objects'

fprintf('Problem II.2: Connected Particles = %d\n', num);

%% -----Finish Solving Problem 2-----
pause();
%% -----Start Solving Problem 3-----

imin = imread('Ball.tif');

se = strel('disk', 1);

[a, b] = FindComponentLabels(imin, se);

list = [a(1,:),a(:,1).',a(end,:),a(:,end).'];
ulist = unique(list);

if(ulist(1)==0)
    ulist = ulist(2:end);
end

for i = ulist
    a(a==i)=-1;
end

a(a~=-1) = 0;

a = -a;

figure(9);
subplot(1,2,1);
imshow((imin));
title 'Original Image'
subplot(1,2,2);
imshow((a));
title 'Connected Particles on border'

fprintf('Problem II.3: Connected Particles on border = %d\n', size(ulist(:),1));

%% -----Finish Solving Problem 3-----
pause();
%% -----Start Solving Problem 4-----

imin = imread('Ball.tif');

se = strel('disk', 1);

[a, b] = FindComponentLabels(imin, se);

list = [a(1,:),a(:,1).',a(end,:),a(:,end).'];
ulist = unique(list);

if(ulist(1)==0)
    ulist = ulist(2:end);
end

for i = ulist
    a(a==i)=-1;
end

a(a~=-1) = 0;

a = -a;

a = ~a;

imin2 = a & imin;

[a, b] = FindComponentLabels(imin2, se);

vlas = histcounts(a(a~=0));

min(round(vlas,-2));

singles = find(round(vlas,-2) == min(round(vlas,-2)));

imin4 = a;

for s = singles
    imin4(a == s) = 0;
end

figure(10)
subplot(1,2,1)
imshow(imin)
title 'Original Image'
subplot(1,2,2)
imshow(imin4)
title 'Overlapping Connected Particles not on border'

ulist2 = unique(imin4(:));
if(ulist2(1)==0)
    ulist2 = ulist2(2:end);
end

fprintf('Problem II.4: Overlapping Connected Particles not on border = %d\n', size(ulist2(:),1));
