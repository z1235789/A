function Bild_test = disk(bild)
for stru_size = 25;
se = strel('disk',stru_size);
Bild_test = imdilate(bild,se);
end
