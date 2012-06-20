f1 = imread('lena_noise.bmp');
f2 = imread('lena_blur.bmp');
gl1 = myfilter(f1, 'ILPF', 50);
gl2 = myfilter(f1, 'BLPF', 50);
gl3 = myfilter(f1, 'ELPF', 50);

gh1 = myfilter(f2, 'IHPF', 2);
gh2 = myfilter(f2, 'BHPF', 2);
gh3 = myfilter(f2, 'EHPF', 2);

fake1 = myfakecolor(f1);
fake2 = myfakecolor(f2);

subplot(2,5,1),imshow(f1),title('origin-noise');
subplot(2,5,2),imshow(gl1),title('ILPF');
subplot(2,5,3),imshow(gl2),title('BLPF');
subplot(2,5,4),imshow(gl3),title('ELPF');
subplot(2,5,5),imshow(fake1),title('fake1');

subplot(2,5,6),imshow(f2),title('origin-blur');
subplot(2,5,7),imshow(gh1),title('IHPF');
subplot(2,5,8),imshow(gh2),title('BHPF');
subplot(2,5,9),imshow(gh3),title('EHPF');
subplot(2,5,10),imshow(fake2),title('fake2');
