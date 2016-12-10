vidObj=VideoReader('MajisAquarium_lowres.mov');
vidHeight = vidObj.Height;
vidWidth = vidObj.Width;
s = struct('cdata',zeros(vidHeight,vidWidth,3,'uint8'),...
    'colormap',[]);
k = 1;
numFrame=2000;
movie = zeros(vidHeight,vidWidth,3,numFrame,'uint8');
while k<numFrame+1
    movie(:,:,:,k) = readFrame(vidObj);

    k = k+1;
end
%background =mean(movie(:,:,:,1:numFrame),4);%uint8
% for k=1:numFrame
%    movie(:,:,:,k) = s(k).cdata; 
% end



% for i =1:numFrame
% image(movie(:,:,:,i));%im2uint8(movie(:,:,:,i)));
% pause(0.01);
% end