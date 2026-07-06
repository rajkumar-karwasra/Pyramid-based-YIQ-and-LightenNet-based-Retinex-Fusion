# Pyramid-based-YIQ-and-LightenNet-based-Retinex-Fusion


MATLAB implementation of our proposed Pyramid-based YIQ enhancement, LightenNet-based illumination estimation, and adaptive weighted local energy (WLE) fusion.

Language: MATLAB

**Main Pipeline:**
Read input image
Pyramid-based YIQ enhancement (LLIE)
LightenNet-based CNN enhancement (CNN)
Weighted Local Entropy (WLE) fusion
Compute PSNR and SSIM
Compute additional evaluation metrics


**Clone the repository**

[git clone https://github.com/username/Proposed_1.git]

**Running the Code**

Run the following file:

main.m

**Structure**
Proposed_1 (LLIE-CNN-Fused)
│
├── dataset/                  % Input and reference images
│   ├── D1.jpg
│   ├── D1_ref.jpg
│   ├── D2.jpg
│   ├── D2_ref.jpg
│   ├── ...
│
├── low_light_code_CNN/       % LightenNet-based enhancement stage
│
├── YIQ/                      % Pyramid-based YIQ enhancement stage
│
├── main.m                    % Main execution file
│
└── README.md
