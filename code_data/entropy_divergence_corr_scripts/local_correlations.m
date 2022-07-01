%% Correlations between KL, Entropy, and Areal expansion

% GLOBAL CORRELATIONS
addpath /Users/shaunwarrington/Documents/MATLAB/cifti-matlab-master
addpath /Users/shaunwarrington/Documents/MATLAB/gifti-1.6
WBC='/Applications/workbench/bin_rh_linux64/wb_command';

cd /Users/shaunwarrington/Documents/baby_xtract_git

nvert = 10242;

spec1='hum'; spec2='mac';
entropy_cohort='hcp';

% KL map
fname=['Results/' spec1 spec2 '_min_KLD.dscalar.nii'];
kl = ft_read_cifti(fname);
kl = kl.dscalar(1:nvert);
kl(isnan(kl))=0;

% Entropy map
% fname=['Results/bootstrap_results/' spec1 '_manu_entropy.dscalar.nii']; % for group-level entropy 

fname=['Results/bootstrap_results/var_' entropy_cohort '_ent.dscalar.nii']; % for entropy variance

en = ft_read_cifti(fname);
en = en.dscalar(1:nvert);
en(isnan(en))=0;

%%
mask = ~~kl & ~~en;

figure
[H,AX,BigAx,P,PAx] = plotmatrix([kl(mask),en(mask)]);

r = corrcoef(kl(mask),en(mask));
r(1,2)
set(gcf,'color','w');

%% LOCAL CORRELATIONS

% get sphere from human 
sph = gifti('Surfs/resample_sphere.L.surf.gii');
r1 = surflocalcorr(kl,en,sph,20);

v=sph.vertices;
v=v./repmat(sqrt(sum(v.^2,2)),1,3);
j=(acosd(v*v(1,:)')<20);
r4 = 0*r1;
r4(j) = 1;

r = [r1 r4];

save localcorr.mat r


%%

addpath /Users/shaunwarrington/Documents/MATLAB/ciftiHCP

cii = ft_read_cifti(fname);
cii.dscalar = r1;
cii.pos=cii.pos(1:nvert,:);
cii.brainstructure = cii.brainstructure(1:nvert);
cii.brainstructurelabel={'CORTEX_LEFT'};
cii.hdr.dim(7) = nvert;

% for group-level
% ft_write_cifti(['/Users/shaunwarrington/Documents/' spec1 spec2 '_ent_minKL'], cii, 'parameter', 'dscalar')
% for variance
ft_write_cifti(['/Users/shaunwarrington/Documents/' entropy_cohort '_' spec1 spec2 '_varent_minKL'], cii, 'parameter', 'dscalar')

%% 

function r=surflocalcorr(x,y,sph,a)
% r=surflocalcorr(x,y,sph,[angle=10])
% local correlations between x and y on the spherical surface sph
%
% S.Jbabdi 03/13
v=sph.vertices;
v=v./repmat(sqrt(sum(v.^2,2)),1,3);
r=0*v(:,1);
vals=~~x&~~y;
for i=1:size(v,1)
    j=(acosd(v*v(i,:)')<a) & vals;
    if(sum(j)>30)
        c=corrcoef(x(j),y(j));
        r(i)=c(1,2);        
    end
end
r(~vals)=0;

end

