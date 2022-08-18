
function s = SimplexNoise(m,args)
  arguments
  m               (1,1) {mustBeNumeric}
  args.Seed       (1,1) {mustBeInteger} = 2
  end
  
  
  rng(args.Seed);

  s = zeros([m,m]);     % Prepare output image (size: m x m)
  w = m;
  i = 0;
  while w > 3
    i = i + 1;
    d = interp2(randn([m,m]), i-1, 'spline');
    s = s + i * d(1:m, 1:m);
    w = w - ceil(w/2 - 1);
  end
  s = (s - min(min(s(:,:)))) ./ (max(max(s(:,:))) - min(min(s(:,:))));
end