# End-to-end Image Analysis Pipeline for Liquid Transmission Electron Microscopy Imaging  

_Gabriele Marchello, Cesare De Pace, Aroa Duro-Castano, Giuseppe Battaglia, Lorena Ruiz-Perez_  


Liquid phase transmission electron microscopy allows the imaging of materials in liquid environments. The sample is encapsulated within electron-beam transparent windows and hence protected by the ultra-high vacuum necessary within the electron gun. Such an approach allows us to study biological and soft materials in their natural environment and offers the possibility of accessing their dynamic nature. Yet, the electron beam scattering from the windows and solvent increases the image noise and blur. Herein, we propose a pipeline to both de-noise and sharpen images obtained by liquid transmission electron microscopy. We develop the workflow in a way that it does not require any human interference, nor introduce artefacts, but actually unveils features of the imaged samples covered by the noise and the blur.

The approach proposed in this work is a two-stage single input pipeline, aiming to recover the noiseless image I<sub>out</sub> from the noisy image I<sub>N</sub>. The first stage of the pipeline is responsible for identifying and suppressing the noise, whilst the second stage restores the sharpness of the image, estimating and removing the blurring function.

The most significant outcome achieved by the proposed image analysis method arises in its ability to unveil details in images of organic materials obtained by LSTEM, details that are otherwise hidden below noise and blur effects.  
![](images/results.png)

The noisy image in _a_ depicts PEG-PMET vesicles and micelles in solution obtained via LTEM in STEM mode. The raw image _a_ displays aggregation of spherical nanoparticles, but it is not possible to discern whether the nanostructures are membrane-bound _i.e._ vesicles or solid-core spherical structures _i.e._ micelles. Image _b_ corresponds to the denoised image, and _c_ to the deblurred image. _d_ depicts a zoomed region of the deblurred _c_, containing vesicles surrounded by membranes.  

# Implementation

The algorithm is written in Matlab and receives the noisy images in input. First the input is pre-processed applying a median filter to remove the salt-and-pepper noise, and then the mean value is locally subtracted to remove any source of bias. The bias is computed by dividing the input image into patches and subtracting their mean values; the user defines the size of the patches and the stride (how many pixels two consecutive patches share). The image is then denoised by applying the Progressive Image Denoising (PID) algorithm [1], and deblurred via the algorithm proposed by Yuan [2]. This latter algorithm was locally extended, by further dividing the image into patches to deblur. 
The _scripts_ folder contain the files to implement this algorithm, including the implementation of the PID proposed in the paper itself and the Yuan's method implementation https://github.com/jtyuan/deblur.
  
![](images/blockscheme.jpg)  

### References 
[1] C. Knaus and M. Zwicker, “Progressive image denoising,” IEEE Trans. Image Process., 2014.  

[2] L. Yuan, J. Sun, L. Quan, and H.-Y. Shum, “Image deblurring with blurred/noisy image pairs,” ACM Trans. Graph., vol. 26, no. 3, p. 1, Jul. 2007.
