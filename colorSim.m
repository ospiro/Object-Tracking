speedLight=12;
fishIm=cell(5,1);
fishIm{1}=imread('Fish1.png');
fishIm{2}=imread('Fish2.png');
fishIm{3}=imread('Fish3.png');
fishIm{4}=imread('Fish4.png');
fishIm{5}=imread('Fish5.png');

for h=1:5
    fish=fishIm{h};
    %fish(fish<50)=0;
    fish_red=fish(:,:,1);
    fish_mean(1,h)=mean(fish_red(find(fish_red>20)));
    fish_green=fish(:,:,2);
    fish_mean(2,h)=mean(fish_green(find(fish_green>20)));
    fish_blue=fish(:,:,3);
    fish_mean(3,h)=mean(fish_blue(find(fish_blue>20)));
%     fish_mean(:,h)=mean(fish(find(fish>50)));
    fishIm{h}=fish;
end
colors={[255 0 0],[0 255 0],[0 0 255], [255 0 213],...
    [171 0 255]};%,[0 239 255],[255 247 0]};
for i=speedLight:1000
%i=speedLight;
comps=fullComps{i};
numPixels = cellfun(@numel,comps.PixelIdxList);
[~,idx] = sort(numPixels);





% fish1mean=mean(mean(fish1Im));
% fish2mean=mean(mean(fish2Im));
% fish3mean=mean(mean(fish3Im));
% fish4mean=mean(mean(fish4Im));
% fish5mean=mean(mean(fish5Im));


height=size(movie,1);
width=size(movie,2);
movieUpdate=movie(:,:,:,i);
loopend=min(length(idx),7);

for j=1:2%numFish
    pixelI=comps.PixelIdxList{idx(end-j+1)};
    
    [xIdx, yIdx] = ind2sub([height, width], pixelI);
    min_x = min(xIdx);
    min_y = min(yIdx);
    max_x = max(xIdx);
    max_y = max(yIdx);
    cent_x=floor((max_x-min_x)/2);
    cent_y=floor((max_y-min_y)/2);
    box_length=3;% real lenght is 2*boxlength+1
    %patch=movieUpdate(cent_x-box_length:cent_x+box_length,cent_y-box_length:cent_y+box_length,:);
    %patch_mean=squeeze(mean(mean(patch)));
    %movieUpdate=movie(:,:,:,i);
    patch_mean=squeeze(mean(mean(movie(xIdx,yIdx,:,i))));
    for h=1:5
        dist2Fish(h)=sum((fish_mean(:,h)-patch_mean).^2);
    end
%     dist2Fish(2)=sum((fish2mean-patch_mean).^2);
%     dist2Fish(3)=sum((fish3mean-patch_mean).^2);
%     dist2Fish(4)=sum((fish4mean-patch_mean).^2);
%     dist2Fish(5)=sum((fish5mean-patch_mean).^2);
    [~,colorIdx]=min(dist2Fish);
    
    movieUpdate=crossHair(comps.PixelIdxList{idx(end-j+1)},movieUpdate,colors{colorIdx},listCent(j,:,i));
end

imshow(movieUpdate)
end