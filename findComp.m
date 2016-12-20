function complist = findComp(centerlist)
thresh = 100;
distances = pdist2(centerlist,centerlist);
distances = (eye(size(distances)) + distances).*(distances<thresh);

nodelist = zeros([length(centerlist) 2]);
nodelist(:,1) = realmax;

complist = cell([length(centerlist) 1]);
while(any(nodelist(:,1)>0))
root = find(nodelist(:,1)>0,1);
Q = [];
nodelist(root,1) = 0
Q = [Q root];
complist{root} = [complist{root} root];
while ~isempty(Q)
    current  = Q(1);
    Q(1) = []; %dequeue
    for i=1:length(centerlist)
       if distances(current,i) > 0%adjacent
          if nodelist(i,1) >0 
              nodelist(i,1) = 0;
              complist{root} = [complist{root} i];
              Q = [Q i];
          end
       end
    end
end
end

% centout = cell([length(complist) 1]);
% for i=1:length(complist)
%     for j=1:length(complist{i})
%         centout{i} = [centout{i};centerlist(complist{i}(j),:)];
%     end
% end
