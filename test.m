load mitsubahalf1_vs_2
shape = mitsubahalf1_vs_2;
K = 100;            % number of eigenfunctions
alpha = 2;          % log scalespace basis

T1 = [1:0.5:30];    % time scales for HKS

%T1 = [1:0.8:40];

%T1 = [40:2:50];  % for A
%T2 = [30:2:55];  % for A

T2 = [1:0.2:30];    % time scales for SI-HKS
Omega = 1:40;       % frequencies for SI-HKS

for k = 1:2
    % compute cotan Laplacian
    [shape{k}.W shape{k}.A] = mshlp_matrix(shape{k});
    shape{k}.A = spdiags(shape{k}.A,0,size(shape{k}.A,1),size(shape{k}.A,1));

    % compute eigenvectors/values
    [shape{k}.evecs,shape{k}.evals] = eigs(shape{k}.W,shape{k}.A,K,'SM');
    shape{k}.evals = -diag(shape{k}.evals);

    % compute descriptors
    shape{k}.hks   = hks(shape{k}.evecs,shape{k}.evals,alpha.^T1);
    [shape{k}.sihks, shape{k}.schks] = sihks(shape{k}.evecs,shape{k}.evals,alpha,T2,Omega); 
end

%default
%i = [959 7106 43365];

%capsules
%i = [ 315 200 555 ];

%A
%i = [ 23 13 12 ];

%mitsuba
%i = [ 1550 15400 5600 ];

% show examples of HKS and SI-HKS at a few points


HKS_measures1 = minmaxavg(shape{1}.hks);
HKS_measures2 = minmaxavg(shape{2}.hks);

SIHKS_measures1 = minmaxavg(shape{1}.sihks);
SIHKS_measures2 = minmaxavg(shape{2}.sihks);

SCHKS_measures1 = minmaxavg(shape{1}.schks);
SCHKS_measures2 = minmaxavg(shape{2}.schks);

%i = [ HKS_measures1(1) HKS_measures1(2) HKS_measures1(3) ];
i = [ SIHKS_measures1(1) SIHKS_measures1(2) SIHKS_measures1(3) ];

figure(1)
%subplot(1,4,1),
hold on
trisurf(shape{1}.TRIV,shape{1}.X,shape{1}.Y,shape{1}.Z), axis image, shading interp, 
%trisurf(shape{2}.TRIV,shape{2}.X+150,shape{2}.Y,shape{2}.Z), axis image, shading interp, 
view([-10 20]), colormap([1 1 1]*0.9), lighting phong, camlight
SYM = {'b.','g.','r.'};
for k = 1:length(i)
    plot3(shape{1}.X(i(k)),shape{1}.Y(i(k)),shape{1}.Z(i(k)),SYM{k})
    %plot3(shape{2}.X(i(k))+150,shape{2}.Y(i(k)),shape{2}.Z(i(k)),SYM{k})    
end
axis off

figure(2)
hold on
trisurf(shape{2}.TRIV,shape{2}.X+150,shape{2}.Y,shape{2}.Z), axis image, shading interp,
view([-10 20]), colormap([1 1 1]*0.9), lighting phong, camlight
SYM = {'b.','g.','r.'};
for k = 1:length(i)
    plot3(shape{2}.X(i(k))+150,shape{2}.Y(i(k)),shape{2}.Z(i(k)),SYM{k})    
end
axis off

figure(3)
%subplot(1,4,2), 
hold on
%plot(T1,log(shape{1}.hks(i,:)))
r = { [0 0 1], [0 1 0], [1 0 0] };

for k=1:3
plot(T1,log(shape{1}.hks(i(k),:)), 'Color', r{k})
%plot(T1,log(shape{2}.hks(i,:)),'--')
plot(T1,log(shape{2}.hks(i(k),:)),'--', 'Color', r{k})
end
title('HKS (log-log)')
xlabel('\tau')
axis square

figure(8)
%subplot(1,4,3),
hold on
for k=1:3
plot(T2,shape{1}.schks(i(k),:), 'Color', r{k})
plot(T2,shape{2}.schks(i(k),:),'--', 'Color', r{k})
title('Scale-covariant HKS')
xlabel('\tau')
axis square
end

figure(9)
%subplot(1,4,4),
hold on
for k=1:3
plot(Omega(:),shape{1}.sihks(i(k),:), 'Color', r{k})
plot(Omega(:),shape{2}.sihks(i(k),:),'--', 'Color', r{k})
title('Scale-invariant HKS')
xlabel('\omega')
axis square
end


%show one component of HKS and SI-HKS at all points
%figure(s+6)


figure(4)
%subplot(1,2,1)
hold on
trisurf(shape{1}.TRIV,shape{1}.X,shape{1}.Y,shape{1}.Z, shape{1}.hks(:,20)), axis image, shading interp,
title('HKS')
axis off

figure(5)
trisurf(shape{2}.TRIV,shape{2}.X+150,shape{2}.Y,shape{2}.Z, shape{2}.hks(:,20)), axis image, shading interp, 
%view([-10 20]),
title('HKS')
axis off

%subplot(1,2,2)

figure(6)
hold on
trisurf(shape{1}.TRIV,shape{1}.X,shape{1}.Y,shape{1}.Z, shape{1}.sihks(:,1)), axis image, shading interp,
title('SI-HKS')
axis off

figure(7)
trisurf(shape{2}.TRIV,shape{2}.X+150,shape{2}.Y,shape{2}.Z, shape{2}.sihks(:,1)), axis image, shading interp, 
%view([-10 20]),
title('SI-HKS')
axis off

