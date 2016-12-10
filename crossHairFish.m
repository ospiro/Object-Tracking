function [im] =  crossHairFish(im, fish, color)
    %[xIdx, yIdx] = ind2sub([size(im,1), size(im,2)], pixelI);
    min_x = fish(1);
    min_y = fish(2);
    max_x = fish(3);
    max_y = fish(4);
    center = fish(5:6);
    if(min_y+3>0 && min_x+3>0 && max_y-3>0 && max_x-3>0)
    
    im(center(1), center(2), 1, :)=color(1);
    im(center(1), center(2), 2, :)=color(2);
    im(center(1), center(2), 3, :)=color(3);  
        
    %min_y
    im(min_x:max_x, min_y:min_y, 1, :)=color(1);
    im(min_x:max_x, min_y:min_y, 2, :)=color(2);
    im(min_x:max_x, min_y:min_y, 3, :)=color(3);
    
    %max_y
    im(min_x:max_x, max_y:max_y, 1, :)=color(1);
    im(min_x:max_x, max_y:max_y, 2, :)=color(2);
    im(min_x:max_x, max_y:max_y, 3, :)=color(3);
    
    %min_x
    im(min_x:min_x, min_y:max_y, 1, :)=color(1);
    im(min_x:min_x, min_y:max_y, 2, :)=color(2);
    im(min_x:min_x, min_y:max_y, 3, :)=color(3);
    
    %max_x 
    im(max_x:max_x, min_y:max_y, 1, :)=color(1);
    im(max_x:max_x, min_y:max_y, 2, :)=color(2);
    im(max_x:max_x, min_y:max_y, 3, :)=color(3);
    end
end