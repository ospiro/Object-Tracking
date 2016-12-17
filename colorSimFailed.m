speedLight=12;
for i=speedLight:1000
%i=speedLight;
comps=fullComps{i};
numPixels = cellfun(@numel,comps.PixelIdxList);
[~,idx] = sort(numPixels);
colors={[255 0 0],[0 255 0],[0 0 255], [255 0 213],...
    [171 0 255]};%,[0 239 255],[255 247 0]};
fish1Im=imread('Fish1.png');
fish2Im=imread('Fish2.png');
fish3Im=imread('Fish3.png');
fish4Im=imread('Fish4.png');
fish5Im=imread('Fish5.png');

fish_mean(1,:)=squeeze(mean(mean(fish1Im)));
fish_mean(2,:)=squeeze(mean(mean(fish2Im)));
fish_mean(3,:)=squeeze(mean(mean(fish3Im)));
fish_mean(4,:)=squeeze(mean(mean(fish4Im)));
fish_mean(5,:)=squeeze(mean(mean(fish5Im)));


height=size(movie,1);
width=size(movie,2);
movieUpdate=movie(:,:,:,i);
loopend=min(length(idx),7);

for j=1:5%numFish
    pixelI=comps.PixelIdxList{idx(end-j+1)};
    is_used = ones(5,1);
    [xIdx, yIdx] = ind2sub([height, width], pixelI);
    min_x = min(xIdx);
    min_y = min(yIdx);
    max_x = max(xIdx);
    max_y = max(yIdx);
    patch=movieUpdate(min_x:max_x,min_y:max_y,:);
    patch_mean=mean(mean(patch));
    dist2Fish=ones(5,1)*1000000;
    for k=1:5
        if is_used(k)
            dist2Fish(k)=sum((fish_mean(k)-patch_mean).^2);
            is_used(k)=0;
        end
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