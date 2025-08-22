import os
from flask import Blueprint, request, jsonify
import google.generativeai as genai
from datetime import datetime

# Create a Blueprint for the Maintenance API
maintain_blueprint = Blueprint('maintain', __name__)

# Configure Gemini API 
genai.configure(api_key="AIzaSyAB2n8jngooeHFtd6y_0X8YofACpNZLcao")

# Comprehensive Safety Prompt Template
SAFETY_PROMPT_TEMPLATE = """
You are an expert mine safety equipment inspector. Analyze the following detailed equipment information:

Equipment Specifications:
- Name: {equipment_name}
- Type: {equipment_type}
- Age: {equipment_age} years
- Last Maintenance: {last_maintenance_date}
- Current Condition: {current_condition}
- Usage Frequency: {usage_frequency}

Comprehensive Analysis Requirements:
1. Detailed Usability Status
2. Critical Safety Precautions
3. Urgent Maintenance Recommendations
4. Potential Operational Risks
5. Estimated Remaining Equipment Lifecycle

Provide a structured, actionable, and precise assessment that enables immediate decision-making for mine safety managers.
"""

def validate_equipment_input(data):
    """
    Comprehensive input validation for equipment details
    """
    # Required fields for validation
    required_fields = [
        'equipment_name', 
        'equipment_type', 
        'equipment_age', 
        'last_maintenance_date', 
        'current_condition', 
        'usage_frequency'
    ]
    
    # Check for missing fields
    for field in required_fields:
        if field not in data:
            return False, f"Critical Error: Missing mandatory field '{field}'"
    
    try:
        # Validate numeric age
        age = int(data['equipment_age'])
        if age < 0 or age > 50:
            return False, "Invalid Age: Must be between 0-50 years"
        
        # Validate maintenance date format
        datetime.strptime(data['last_maintenance_date'], "%Y-%m-%d")
    
    except ValueError as validation_error:
        return False, f"Validation Error: {str(validation_error)}"
    
    return True, "Validation Successful"

def generate_ai_safety_assessment(equipment_details):
    """
    Generate comprehensive safety assessment using Gemini AI
    """
    try:
        # Initialize Gemini Pro Model
        model = genai.GenerativeModel('gemini-pro')
        
        # Format prompt with equipment details
        prompt = SAFETY_PROMPT_TEMPLATE.format(**equipment_details)
        
        # Generate AI response
        response = model.generate_content(prompt)
        return response.text
    
    except Exception as ai_error:
        return f"AI Assessment Error: {str(ai_error)}"

@maintain_blueprint.route('/assess-equipment', methods=['POST'])
def assess_equipment_safety():
    """
    Primary endpoint for equipment safety assessment
    """
    # Extract request payload
    equipment_data = request.json
    
    # Validate input data
    is_valid, validation_message = validate_equipment_input(equipment_data)
    
    # Handle validation failures
    if not is_valid:
        return jsonify({
            "status": "error",
            "message": validation_message
        }), 400
    
    try:
        # Generate AI-powered safety assessment
        safety_assessment = generate_ai_safety_assessment(equipment_data)
        
        # Construct comprehensive response
        return jsonify({
            "status": "success",
            "timestamp": datetime.now().isoformat(),
            "equipment_details": equipment_data,
            "safety_assessment": safety_assessment
        })
    
    except Exception as processing_error:
        return jsonify({
            "status": "error",
            "message": str(processing_error)
        }), 500

def log_equipment_assessment(equipment_data, assessment):
    """
    Optional logging mechanism for equipment assessments
    
    Note: Implement your preferred logging strategy 
    (database, file logging, external service)
    """
    log_entry = {
        "timestamp": datetime.now().isoformat(),
        "equipment_name": equipment_data.get('equipment_name'),
        "assessment_details": assessment
    }
    
    # Placeholder for actual logging implementation
    # print(f"Logged Assessment: {log_entry}")
    return log_entry

