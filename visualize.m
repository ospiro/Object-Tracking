speedLight=12;
%[listCent,fullComps]= Background_subtraction(movie,background,speedLight);
[matches, frameDiffs]=shortestPaths(listCent);


colors={[255 0 0],[0 255 0],[0 0 255], [255 0 213],...
    [171 0 255],[0 239 255],[255 247 0]};
count=1;
movieUpdateOld=movie(:,:,:,1);
for i =speedLight:length(fullComps)
    comps=fullComps{i};
    numPixels = cellfun(@numel,comps.PixelIdxList);
    [~,idx] = sort(numPixels);
    movieUpdate=movie(:,:,:,i);
    loopend=min(length(idx),7);
    for j=1:loopend%numFish
        if matches(j,i)==-99
            %do nothing because component is gone
        else
            if i==speedLight
                movieUpdate=crossHair(comps.PixelIdxList{idx(end-j+1)},movieUpdate,colors{j},listCent(j,:,i));
                
            else
                colorIdx=matches(j,i);
                movieUpdate=crossHair(comps.PixelIdxList{idx(end-j+1)},movieUpdate,colors{colorIdx},listCent(j,:,i));
            end
        end
    end
    
    twofish=[movieUpdateOld movieUpdate];%255*mask3 background];
   %figure
    imshow(twofish);
    movieUpdateOld=movieUpdate;
    pause(.000001)
end
