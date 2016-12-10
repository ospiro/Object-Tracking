function [fish,frameDiffs] = shortestPathsFish( fish,numFish, startFrame )
%1) Build graph from list of connected components
%2) Return shortest paths from first frame to lasts

complist = fish(:,5:6,startFrame:end);
K = size(complist,1);
fish(:,7,startFrame)=[1:numFish]';
% g = zeros(size(complist,1)*size(complist,3));

for k = 1:size(complist,3)-1
    frameDiffs(:,:,k) = pdist2(complist(:,:,k),complist(:,:,k+1));%[numframes*numfish numFrames]
end
frameDiffs=cat(3, zeros(numFish,numFish,startFrame-1), frameDiffs);
for k =startFrame:size(frameDiffs,3)-1
    [short, I] = min(frameDiffs(:,:,k));
    best_match_vec=I;
   %best_match_vec(short>50)=-99;
 	vec = fish(best_match_vec,7,k);
    vec(short>10)=-99;
     %a=vec;
    goodColors=vec(find(vec>-99));
    
    missingColors=setdiff(1:numFish,goodColors);
    numColors=numFish-length(goodColors);
    vec(vec==-99)=missingColors(1:numColors);
    fish(:,7,k+1) = vec;
end
%fish(:,7,size(complist,3))=fish(:,7,size(complist,3)-1);



% for i = 1:size(g,1)-1
%     for j = 1:size(g,2)-1
%         if floor(j/K)==floor(i/K)+1
%             g(i,j) = frameDiffs(mod(i-1,K)+1,mod(j-1,K)+1,int8(ceil(i/K)));
%         end
%     end
% end


% g = digraph(g);
% % zero_nodes = []
% % for i =1:g.numnodes
% % %     i
% %     if indegree(g,i)==0 ||indegree(g,i)==0
% %         zero_nodes = [zero_nodes i]; 
% %     end
% % end
% g=g.rmnode(zero_nodes)
% plot(g,'EdgeLabel',g.Edges.Weight)



end

