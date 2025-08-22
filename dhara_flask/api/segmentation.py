from flask import Blueprint,Flask, request, jsonify, send_file
import os
import json
import wget
import torch
import numpy as np
from PIL import Image
from io import BytesIO
import matplotlib.pyplot as plt
from segment_anything import sam_model_registry, SamAutomaticMaskGenerator

segment_blueprint = Blueprint('segment', __name__)

# Setup directories
data_folder = "./Segmentation Images"
os.makedirs(data_folder, exist_ok=True)

class MineSafetySegmentation:
    def __init__(self, image_path, model_type="vit_h"):
        self.image_path = image_path
        self.model_type = model_type
        self.sam_checkpoint = "./sam_vit_h_4b8939.pth"  # Adjusted for local path
        self.json_path = "./mask_data/mask_data.json"
        self.device = torch.device("cpu")  # Set to CPU-only

        # Download model weights if not exists
        if not os.path.exists(self.sam_checkpoint):
            url = "https://dl.fbaipublicfiles.com/segment_anything/sam_vit_h_4b8939.pth"
            wget.download(url, self.sam_checkpoint)
            print("\nWeights downloaded.")

        # Load SAM model
        self.sam = self.load_sam()

    def load_sam(self):
        print("Loading SAM model...")
        try:
            checkpoint = torch.load(self.sam_checkpoint, map_location=self.device)
            sam = sam_model_registry[self.model_type](checkpoint=self.sam_checkpoint)
            sam.load_state_dict(checkpoint)
            sam.to(device=self.device)
            return sam
        except Exception as e:
            print(f"Error loading SAM model: {e}")
            raise

    def load_and_resize_image(self, max_dimension=2500):
        image = Image.open(self.image_path).convert('RGB')
        width, height = image.size
        if width > height:
            new_width = max_dimension
            new_height = int(height * (max_dimension / width))
        else:
            new_height = max_dimension
            new_width = int(width * (max_dimension / height))
        return image.resize((new_width, new_height), Image.LANCZOS)

    def generate_masks(self):
        image = np.array(self.load_and_resize_image())
        mask_generator = SamAutomaticMaskGenerator(
            model=self.sam,
            points_per_side=32,
            pred_iou_thresh=0.86,
            stability_score_thresh=0.92,
            crop_n_layers=1,
            crop_n_points_downscale_factor=2,
            min_mask_region_area=100
        )
        print("Generating masks...")
        masks = mask_generator.generate(image)

        mask_data = []
        for mask in masks:
            mask_coords = np.column_stack(np.where(mask['segmentation']))
            mask_data.append({
                'area': int(mask['area']),
                'bbox': mask['bbox'],
                'coordinates': mask_coords.tolist()
            })

        os.makedirs(os.path.dirname(self.json_path), exist_ok=True)
        with open(self.json_path, 'w') as f:
            json.dump(mask_data, f)

        print(f"Masks generated and saved. Total masks: {len(masks)}")
        return image, masks

@segment_blueprint.route('/process_image', methods=['POST'])
def process_image():
    """
    Upload an image, process it with segmentation, and return the segmented image.
    """
    if 'image' not in request.files:
        return jsonify({"error": "No image file provided."}), 400

    image = request.files['image']
    image_path = os.path.join(data_folder, image.filename)
    image.save(image_path)

    try:
        # Initialize segmentation
        segmentation = MineSafetySegmentation(image_path=image_path)
        
        # Generate masks
        image, masks = segmentation.generate_masks()

        # Convert segmented image to an in-memory file
        image_pil = Image.fromarray(image)
        image_io = BytesIO()
        image_pil.save(image_io, format='JPEG')
        image_io.seek(0)

        return send_file(image_io, mimetype='image/jpeg')
    except Exception as e:
        return jsonify({"error": str(e)}), 500
