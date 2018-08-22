load all_shapes.mat
all_shapes{4} = all_shapes{5};
all_shapes{5} = all_shapes{6};
all_shapes{6} = all_shapes{7};
count = 0;
for s=1:3
    shape = all_shapes{s};
    test;
end
for s=6
    shape = all_shapes{s};
    test;
end
