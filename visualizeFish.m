numFish=4;
speedLight=12;
startFrame=100;%must be greater than speedLight
intMovie=im2uint8(movie);
fish= Background_subtractionFishReturn(movie,newbackground,speedLight,numFish);
[fish, frameDiffs]=shortestPathsFish(fish,numFish, startFrame);


colors={[255 0 0],[0 255 0],[0 0 255], [255 0 213],...
    [255 255 255],[0 239 255],[255 247 0]};
count=1;
movieUpdateOld=movie(:,:,:,1);
for i =startFrame:1000
%     comps=fullComps{i};
%     numPixels = cellfun(@numel,comps.PixelIdxList);
%     [~,idx] = sort(numPixels);
    movieUpdate=movie(:,:,:,i);
%     loopend=min(length(idx),7);
    for j=1:numFish
         if fish(j,7,i)==-99
%             %do nothing because component is gone
         else
            
                movieUpdate=crossHairFish(movieUpdate, fish(j,:,i),colors{fish(j,7,i)});

%                 colorIdx=fish(j,i);
%                 movieUpdate=crossHair(comps.PixelIdxList{idx(end-j+1)},movieUpdate,colors{colorIdx},listCent(j,:,i));
%             end
         end
    end
    
    twofish=[movieUpdate];%[movieUpdateOld    %255*mask3 background];
   %figure
    imshow(twofish);

    movieUpdateOld=movieUpdate;
    pause(.000001)
end
