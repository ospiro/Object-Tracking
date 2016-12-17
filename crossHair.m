function [im] =  crossHair(pixelI,im,color,center)
    [xIdx, yIdx] = ind2sub([size(im,1), size(im,2)], pixelI);
    min_x = min(xIdx);
    min_y = min(yIdx);
    max_x = max(xIdx);
    max_y = max(yIdx);
    
    if(min_y+3>0 && min_x+3>0 && max_y-3>0 && max_x-3>0)
    
    im(center(1), center(2), 1, :)=color(1);
    im(center(1), center(2), 2, :)=color(2);
    im(center(1), center(2), 3, :)=color(3);  
        
    %min_y
    im(min_x:max_x, min_y:min_y+3, 1, :)=color(1);
    im(min_x:max_x, min_y:min_y+3, 2, :)=color(2);
    im(min_x:max_x, min_y:min_y+3, 3, :)=color(3);
    
    %max_y
    im(min_x:max_x, max_y-3:max_y, 1, :)=color(1);
    im(min_x:max_x, max_y-3:max_y, 2, :)=color(2);
    im(min_x:max_x, max_y-3:max_y, 3, :)=color(3);
    
    %min_x
    im(min_x:min_x+3, min_y:max_y, 1, :)=color(1);
    im(min_x:min_x+3, min_y:max_y, 2, :)=color(2);
    im(min_x:min_x+3, min_y:max_y, 3, :)=color(3);
    
    %max_x 
    im(max_x-3:max_x, min_y:max_y, 1, :)=color(1);
    im(max_x-3:max_x, min_y:max_y, 2, :)=color(2);
    im(max_x-3:max_x, min_y:max_y, 3, :)=color(3);
    end
end