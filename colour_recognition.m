%-------------------------------------------Training Code----------------------------------------------------------------
clear all; clc; close all;
test_sensitivity = input('input sensitivity of test data to target color\n(the lower it i1s, the more accepting it is to darker colors. best from 30 to 150): ');
sensitivity = input('input sensitivity(best from 1 to 2.5): ');
masked = imread('green_test.jpg');

[nrow, ncol, ~] = size(masked);

count=0;
for i = 1:1:nrow
    for j = 1:1:ncol
        c = masked(i,j,:);

        if any(c>test_sensitivity)
            count = count + 1;
            reds(count) = double(masked(i, j, 1));
            grns(count) = double(masked(i, j, 2));
            blus(count) = double(masked(i, j, 3));
        end            
    end
end

avgorange = [0, 0, 0];
avgorange(1) = mean(reds);
avgorange(2) = mean(grns);
avgorange(3) = mean(blus);

stdorange = [0, 0, 0];
stdorange(1) = std(reds);
stdorange(2) = std(grns);
stdorange(3) = std(blus);

upper = ceil(avgorange + (sensitivity*stdorange));
lower = floor(avgorange - (sensitivity*stdorange));

for i = 1:1:length(lower)
    if lower(i)<0
        lower(i)=0;
    end
end

%-------------------------------------------Training Code----------------------------------------------------------------

image = imread('peppers.jpg');
[nrow, ncol, ncolor] = size(image);

for i = 1:1:nrow
    for j = 1:1:ncol
        values(1) = image(i, j, 1);
        values(2) = image(i, j, 2);
        values(3) = image(i, j, 3);
        if (values>=lower) == (values<=upper)
           image(i, j, :) = 255;
        end
    end
end

imshow(image)

