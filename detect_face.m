% Author : Kemal Akkoyun
% Institue : Istanbul Bilgi University
% Id : 11076004
% Description : A function to detect face in an image file.

function [ face_image ] = detect_face(image)
    % Example:
    % image = imread('jaffe/YM.NE3.51.tiff');

    % Create a cascade detector object.
    % Uses Viola-Jones algorithm. Default recognizes front-face.
    %      Available parameters.
    %      Frontal Face (CART) [Default]
    %      Frontal Face (LBP)
    %      Upper Body
    %      Eye Pair
    %      Single Eye
    %      Single Eye (CART)
    %      Profile Face
    %      Mouth
    %      Nose
    faceDetector = vision.CascadeObjectDetector();
    bbox = step(faceDetector, image);
    face_image = imcrop(image, bbox);
    % face_fig = insertObjectAnnotation(image,'rectangle', bbox, 'Face');
    % figure, imshow(face_fig), title('Detected Face');
end

