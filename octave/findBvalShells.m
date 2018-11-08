function shells = findBvalShells(bval)

%bval contains bvalues

nbins_vec=10:5:100;

for i=1:length(nbins_vec)
   
%first estimate centers with hist
[counts,centers]=hist(bval,nbins_vec(i));

%excluding first count (b~=0), get non-zero counts
bcenters{i}=centers(find(counts >0));
ncenters(i)=length(bcenters{i});

end

inds_valid=find(ncenters==min(ncenters));

best=bcenters{inds_valid(end)};

%round to nearest hundred 
shells=round( best(2:end)./100  ).*100;
end
