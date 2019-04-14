load mri.mat;   old_img = double(squeeze(D));

	old_M = [0.88 0.5 3 -90; -0.5 0.88 3 -126; 0 0 2 -72; 0 0 0 1];
	new_img = affine(old_img, old_M, 2);
	[x y z] = meshgrid(1:128,1:128,1:27);
	sz = size(new_img);
	[x1 y1 z1] = meshgrid(1:sz(2),1:sz(1),1:sz(3));
	figure; slice(x, y, z, old_img, 64, 64, 13.5);
	shading flat; colormap(map); view(-66, 66);
	figure; slice(x1, y1, z1, new_img, sz(1)/2, sz(2)/2, sz(3)/2);
	shading flat; colormap(map); view(-66, 66);