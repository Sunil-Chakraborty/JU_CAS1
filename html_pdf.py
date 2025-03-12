import pdfkit

# install from net wkhtmltopdf - wkhtmltopdf and wkhtmltoimage are open source (LGPLv3) command line tools to render HTML into PDF and various image formats using the Qt WebKit ..
def convert_html_to_pdf(html_content, output_filename):
    # Convert HTML to PDF
    pdfkit.from_string(html_content, output_filename)

# Example usage
html_content = """
<!DOCTYPE html>
<html>
<head>
    <title>Multi-Page Report</title>
    <meta charset="UTF-8">
 
</head>
<body>
    <h1>Page 1</h1>
    <p>मूल श्लोकःधृतराष्ट्र उवाच धर्मक्षेत्रे कुरुक्षेत्रे समवेता युयुत्सवः।
                   मामकाः पाण्डवाश्चैव किमकुर्वत सञ्जय।।1.1।।
                যদি কেউ কথা না কয়,
                ওরে ওরে ও অভাগা কেউ কথা না কয়
                যদি সবাই থাকে মুখ ফিরায়ে সবাই করে ভয়,
                যদি সবাই থাকে মুখ ফিরায়ে সবাই করে ভয়,
                তবে পরান খুলে
      There are many variations of passages
      of Lorem Ipsum available, but the majority 
      have suffered alteration in some form, 
      by injected humour, or randomised words 
      which don't look even slightly believable. 
      
    </p>
    
    <div style="page-break-before: always;"></div>
    <h1>Page 2</h1>
    <p>This is some content for page 2.</p>
    <div style="page-break-before: always;"></div>
    <h1>Page 3</h1>
    <p>This is some content for page 3.</p>
</body>
</html>
"""

output_filename = "multi_page_report.pdf"
convert_html_to_pdf(html_content, output_filename)
