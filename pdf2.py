from django.http import HttpResponse
from reportlab.lib.pagesizes import letter
from reportlab.pdfgen import canvas
from reportlab.lib.utils import ImageReader  # Import ImageReader
from PIL import Image, ImageDraw, ImageFont
import io

def create_text_image(text, font_size=24, font_path=None):
    # Create a blank image with white background
    image = Image.new('RGB', (800, 600), color='white')
    draw = ImageDraw.Draw(image)

    # Load a font
    if font_path:
        font = ImageFont.truetype(font_path, font_size)
    else:
        font = ImageFont.load_default()

    # Draw the text on the image
    draw.text((10, 10), text, fill='black', font=font)

    return image

def generate_pdf_response(text):
    # Create an image with the Sanskrit text
    image = create_text_image(text)

    # Create a PDF
    buffer = io.BytesIO()
    pdf_canvas = canvas.Canvas(buffer, pagesize=letter)
    pdf_canvas.drawImage(ImageReader(image), 100, 500)  # Adjust the position as needed
    pdf_canvas.showPage()
    pdf_canvas.save()

    # Return the PDF content
    buffer.seek(0)
    return buffer.getvalue()

def my_view(request):
    # Example Sanskrit text
    text = "नमो भगवते वासुदेवाय"

    # Generate PDF content
    pdf_content = generate_pdf_response(text)

    # Return the PDF as a response
    response = HttpResponse(pdf_content, content_type='application/pdf')
    response['Content-Disposition'] = 'attachment; filename="sanskrit_text.pdf"'
    return response
