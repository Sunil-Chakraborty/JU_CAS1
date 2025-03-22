# from asyncio.windows_events import NULL
# from http.client import REQUEST_ENTITY_TOO_LARGE
from django.shortcuts import render, redirect, get_object_or_404
from django.http import HttpResponseRedirect
from django.core.exceptions import ObjectDoesNotExist
from django.http import Http404, HttpResponse, HttpResponseForbidden
from django.contrib.auth import login, authenticate, logout
from django.contrib.auth.models import User
from django.contrib import messages, auth
from django.core.mail import send_mail, EmailMessage
from django.conf import settings
from account.models import Account, Academic, Research, PriorPost,PresentPost,TeachingExp,Orientation,ApiCatg_I, ApiCatg_II, CasFormSts,Department 
from django.core.files.storage import FileSystemStorage
from django.core.files.storage import default_storage
from django.views.generic import TemplateView, ListView, CreateView, View
from django.db.models import Count,Sum,Min,Max,Avg
from django.contrib.auth.decorators import login_required
from django.db.models import Q, Case, When, Value, IntegerField, Count, Sum, F
from django.db.models.functions import Coalesce
from django.db import models 
import pdfkit
import logging
from django.template.loader import render_to_string  # Import render_to_string
import re  # Import the 're' module

from reportlab.pdfbase import pdfmetrics
from reportlab.pdfbase.ttfonts import TTFont

from reportlab.pdfgen import canvas
from reportlab.pdfbase import pdfmetrics
from reportlab.pdfbase.ttfonts import TTFont
from django.template.loader import get_template
from io import StringIO

from catg_3.models import Jrnl_pub,Pub_other,Resch_proj,Resch_cons,Prj_outcm, Resch_guide,Fellow_Award,Lecture_Paper,E_Learning,JrnlPaper_UGC
from datetime import datetime

import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
from matplotlib import rcParams
from matplotlib.font_manager import FontProperties
import numpy as np

import io
import base64
import string
import random
import codecs

import os
from pathlib import Path

from io import BytesIO

from PIL import Image, ImageDraw, ImageFont

from weasyprint import HTML, CSS

# Register the font
#pdfmetrics.registerFont(TTFont('Arial Unicode MS', 'D:/JU_CAS1/Mylogin/static/font/arial-unicode-ms.ttf'))

# from django.views import View

from xhtml2pdf import pisa
#from xhtml2pdf.default import DEFAULT_FONT_CONFIG

from account.forms import RegistrationForm, AccountAuthenticationForm, AccountUpdateForm, AccountEditForm, ApiCatg_IForm, ApiCatg_IIForm
from account.forms import AccountCasForm, AcademyForm, ResearchForm, PrestsForm, PresentPostForm,TeachingExpForm, OrientationForm

global pk_var

import json


"""
# Configure the Bengali font in DEFAULT_FONT_CONFIG
DEFAULT_FONT_CONFIG['fonts'].update({
    'SolaimanLipi': {
        'normal': 'C:\Windows\Fonts\SolaimanLipi.ttf',
        #'bold': 'path/to/your/font/YourBengaliFont-Bold.ttf',
        #'italic': 'path/to/your/font/YourBengaliFont-Italic.ttf',
        #'bolditalic': 'path/to/your/font/YourBengaliFont-BoldItalic.ttf',
    }
})

def render_to_pdf(template_src, context_dict={}):
	pdfmetrics.registerFont(TTFont('NotoSansBengali-Regular', 'D:/JU_CAS1/NotoSansBengali-Regular.ttf'))
	template = get_template(template_src)
	html  = template.render(context_dict)
	result = BytesIO()
	pdf = pisa.pisaDocument(BytesIO(html.encode("utf-8")), result)
    
   
	if not pdf.err:
		return HttpResponse(result.getvalue(), content_type='application/pdf')
	return None
 

def render_to_pdf(template_src, context_dict={}):
    template = get_template(template_src)
    html = template.render(context_dict)
    
    # Convert HTML to PDF using WeasyPrint
    pdf = HTML(string=html).write_pdf()

    # Return the generated PDF as an HTTP response
    return HttpResponse(pdf, content_type='application/pdf')
    

"""

def fetch_resources(uri, rel):
    if uri.startswith('/static/'):
        path = os.path.join(os.path.abspath(os.path.dirname(__file__)), 'static', uri.replace('/static/', ''))
        return path
    return None   


def render_to_pdf(template_src, context_dict={}):

    account_id = context_dict.get('id')
    account = Account.objects.get(pk=account_id)
    
    # Check admin status from context_dict
    admin = context_dict.get('admin', False)  # Default to False if not provided
    print(f"Admin status: {admin}")  # Debugging: Print True if admin, False if not.

    # Define the directory and filename for the PDF
    pdf_dir = "D:/JU_CAS1/cas_pdf"
    #pdf_dir = "/home/iqac-cas/cas_pdf"
    
    filename = f"{account.username.upper()}_{account.id}.pdf"

    # Render HTML content using the specified template and context
    html_content = render_to_string(template_src, context_dict)

    # Define CSS styles, ensuring font paths are correct
    font_path = os.path.join('D:/JU_CAS1/NotoSansBengali-Regular.woff2')
    #font_path = os.path.join('/home/iqac-cas/cas_font/NotoSansBengali-Regular.woff2')  # Change to correct woff2 path if necessary
    
    
    css_string = f"""
    @font-face {{
        font-family: 'NotoSansBengali';
        src: url('{font_path}') format('woff2');
    }}
    body {{
        font-family: 'NotoSansBengali', Arial, sans-serif;
        margin: 0;
        padding: 0;
    }}
    @page {{
        size: A4;
        margin: 20mm;
    }}
    table {{
        width: 100%;
        border-collapse: collapse;
    }}
    th, td {{
        padding: 5px;
        border: 1px solid black;
        text-align: left;
    }}
    """

    # Generate PDF using WeasyPrint
    css = CSS(string=css_string)
    pdf = HTML(string=html_content).write_pdf(stylesheets=[css])

    # Save the PDF to a file if the user is not an admin
    if not admin:
        pdf_path = os.path.join(pdf_dir, filename)
        with open(pdf_path, 'wb') as f:
            f.write(pdf)
        print(f"PDF written to {pdf_path}")
    else:
        print("No PDF written to a file as the user is an admin.")

    # Return the generated PDF as an HTTP response
    return HttpResponse(pdf, content_type='application/pdf')    
    
def render_to_pdf2(template_src, context_dict={}):
    # Generate HTML
    html = render_to_string(template_src, context_dict)
    
    # Define CSS styles, ensuring font paths are correct
    font_path = os.path.join('D:/JU_CAS1/NotoSansDevanagari-Regular.woff2')  # Change to correct woff2 path if necessary
    css_string = f"""
    @font-face {{
        font-family: 'NotoSansDevanagari';
        src: url('{font_path}') format('woff2');
    }}

    body {{
        font-family: 'NotoSansDevanagari', sans-serif;
        margin: 0;
        padding: 0;
    }}

    @page {{
        size: A4;
        margin: 20mm;
    }}

    table {{
        width: 100%;
        border-collapse: collapse;
    }}

    th, td {{
        padding: 5px;
        border: 1px solid black;
        text-align: left;
    }}
    """

    # Generate PDF using WeasyPrint
    css = CSS(string=css_string)
    pdf = HTML(string=html).write_pdf(stylesheets=[css])

    # Return the generated PDF as an HTTP response
    return HttpResponse(pdf, content_type='application/pdf')
    
    
    
def render_to_pdf1(template_src, context_dict={}):
	
	template = get_template(template_src)
	html  = template.render(context_dict)
	result = BytesIO()
	pdf = pisa.pisaDocument(BytesIO(html.encode("utf-8")), result)
    
   
	if not pdf.err:
		return HttpResponse(result.getvalue(), content_type='application/pdf')
	return None
 
# Create image with text
def text_to_image(text, font_path='NotoSansBengali-Regular.ttf'):
    try:
        font = ImageFont.truetype(font_path, 40)
    except Exception as e:
        print(f"Error loading font: {e}")
        return

    print(os.path.exists(font_path))  # This should return True

    # Create a temporary image to get text size
    temp_img = Image.new('RGB', (1, 1))
    d = ImageDraw.Draw(temp_img)

    # Calculate the bounding box of the text
    bbox = d.textbbox((0, 0), text, font=font)
    text_width = bbox[2] - bbox[0]  # right - left
    text_height = bbox[3] - bbox[1]  # bottom - top
    
    # Create an image with adequate size
    img = Image.new('RGB', (text_width + 20, text_height + 20), color=(255, 255, 255))
    d = ImageDraw.Draw(img)
    
    # Draw the text on the image
    d.text((10, 10), text, font=font, fill=(0, 0, 0))
    img.save('text_image.png')

   
class AboutView(TemplateView):
    template_name = "account/about.html"

class NoticeView(TemplateView):
    template_name = "account/notification.html"

class InstructionView(TemplateView):
    template_name = "account/Instruction.html"

class ViewPDF(View):    
    
	def get(self, request, *args, **kwargs):
    
            user_id = kwargs.get("user_id")

            user = request.user

            if user.is_admin:
                user_id = kwargs.get("user_id")
            else:
                user_id = request.user.id

            
            account = Account.objects.get(pk=user_id)
            
            
            act = Account.objects.get(pk=user_id)
            
            if not act.frm_general_info :
                messages.error(request,"PDF is not generating due to General information not yet completed")
                return redirect("account:home", user_id=request.user.id)
            
            act = Account.objects.get(pk=user.id)    
            admin = act.is_admin
            
            if account.is_admin:
                messages.success(request,"You can get PDF of your applicant's ! Pl.click on your member's row")
                # return HttpResponse(messages,"You are already authenticated as " + str(user.email))                
               
                # return HttpResponseRedirect(self.request.META.get('HTTP_REFERER'))
                # return render(self.request, 'account/cas_view.html',"account:home", user_id=user.id)
                # return HttpResponseRedirect(request.META.get('HTTP_REFERER'))
                # return HttpResponseRedirect(request.META.get('HTTP_REFERER'))
                # return redirect("account:home", user_id=request.user.id)
                
                
                # html = "<html><body><div><h1>Hi &nbsp&nbsp&nbsp <br>Sorry, you are not the Applicant ! <br> Please select the applicant preview buttom <br>%s.</h1></div></body></html>" % user.email
                # return HttpResponse(html) 

                
            # messeges = ""
            
            
            if Account.is_admin:
                account = Account.objects.get(pk=user_id)
                
            else:
                account = Account.objects.get(pk=request.user.id)  
            
    
            academy = account.academic_set.all()
            academy_count = academy.filter(year_passing__isnull=False).count()
            
            if academy_count == 0:
                messages.error(request,"Please complete Academic Information page to generate PDF!")
                return redirect("account:home", user_id=request.user.id)
               
            research = account.research_set.all()
            prests = account.priorpost_set.all()
            
            curpost = account.presentpost_set.all()
            curpost_count = curpost.filter(pay_scale__isnull=False).count()
            print(curpost_count)
            
            if curpost_count == 0:
                messages.error(request,'Part C(b) - "Posts held after Appointment at the University" is incomplete')
                return redirect("account:home", user_id=request.user.id)
            
            teach = account.teachingexp_set.all()
            teach_count = teach.filter(pg_class__isnull=False).count()
            
            if teach_count == 0:
                messages.error(request,"PDF is not generating due to no data available Teaching experience")
                return redirect("account:home", user_id=request.user.id)

            
            orient = account.orientation_set.all()
            
            try :
              api1 = ApiCatg_I.objects.get(pk=user_id)
              
            except ApiCatg_I.DoesNotExist:
                #return HttpResponse(messages,"API-Catg-I is not completed")
                messages.error(request,"PDF is not generating due to API-Catg-I is not completed")
                return redirect("account:home", user_id=request.user.id)
                
            else:
                pass      
            
            try :
              api2 = ApiCatg_II.objects.get(pk=user_id)
              
            except ApiCatg_II.DoesNotExist:
                #return HttpResponse(messages,"API-Catg-II is not completed")
                messages.error(request,"PDF is not generating due to API-Catg-II is not completed")                
                return redirect("account:home", user_id=request.user.id)
                
            else:
                pass
            
            jrnl = account.jrnl_pub_set.all()
            pub = account.pub_other_set.all()
            jrnl_paper=account.jrnlpaper_ugc_set.all().order_by('-yr_review').values()
            res = account.resch_proj_set.all()
            cons = account.resch_cons_set.all()
            prj = account.prj_outcm_set.all()
            res_guide = account.resch_guide_set.all()
            fellow = account.fellow_award_set.all()
            lec = account.lecture_paper_set.all()
            elearn = account.e_learning_set.all()
            
            api_t=0
            
            
            api_1=(api1.self_api_dt+api1.self_api_ed+api1.self_api_it)
                
                
            api_2=(api2.self_api_fba+api2.self_api_clm+api2.self_api_pda)
            
                
            # Summary of API I Category
            
            if account.to_dsg == 'Stage 2' or account.to_dsg == 'Stage 3':
                api_factor = 7.50
                dt_marks=70
                
                if (api_1 < 80):                   
                    api_sts1 = "Min Score not attained"				
                else:			
                    api_sts1 = "Criteria Satisfied"
                    api_t=api_t+1
                    
            else :
                api_factor = 7.75
                dt_marks=60
                
                if account.to_dsg == 'Stage 4':
                    if (api_1 < 75):				
                        api_sts1 = "Min Score not attained"
                    else:
                        api_sts1 = "Criteria Satisfied"
                        api_t=api_t+1
                        
                if account.to_dsg == 'Stage 5':
                    if (api_1 < 70):				
                        api_sts1 = "Min Score not attained"
                    else:
                        api_sts1 = "Criteria Satisfied"
                        api_t=api_t+1
			   
                
            
            if account.to_dsg == 'Stage 2' or account.to_dsg == 'Stage 3' or account.to_dsg == 'Stage 4':
                ed_factor = 10
                ed_marks=20
            else :
                ed_factor = 10
                ed_marks=10     
            
            if account.to_dsg == 'Stage 2' or account.to_dsg == 'Stage 3':
                it_factor = 10
                it_marks = 10
            elif account.to_dsg == 'Stage 4':
                it_factor = 10
                it_marks = 15
            else:
                it_factor = 10
                it_marks = 20 
                
            # Summary of API II Category
            api_2a=0
            api_2a=api_2*account.ass_yr
            
            if (api_2a < 50):
                api2_sts = "Min Score not attained"
            else:        
                api2_sts = "Criteria Satisfied"
                api_t=api_t+1
                
                
            # API III-A.  Journal Publication
            tot_3a=0 
            tot_3=0    
            tot_3a=jrnl.aggregate(Sum('self_api_score'))
            val=list(tot_3a.values())
            if val[0]:
                tot_3=tot_3+val[0]
            
            # API III-B(i) : Publications other than journal articles
            tot_3b=0   
            tot_3b=pub.aggregate(Sum('self_api_score'))
            val=list(tot_3b.values())
            if val[0]:
                tot_3=tot_3+val[0]
            
            # API III-B(ii) : Referring of Journal Papers from UGC list
            tot_3b2=0   
            tot_3b2=jrnl_paper.aggregate(Sum('self_api_score'))
            val=list(tot_3b2.values())
            if val[0]:
                tot_3=tot_3+val[0]
            
            
            # API III-C (i):  Sponsored Project            
            tot_3c=0   
            tot_3c=res.aggregate(Sum('self_api_score'))
            val=list(tot_3c.values())
            if val[0]:
                tot_3=tot_3+val[0]
            
            # API III-C (ii):  Consultancy Project            
            tot_3d=0   
            tot_3d=cons.aggregate(Sum('self_api_score'))
            val=list(tot_3d.values())
            if val[0]:
                tot_3=tot_3+val[0]
            
            # API III-C (iii):  Projects Outcome/Output            
            tot_3e=0   
            tot_3e=prj.aggregate(Sum('self_api_score'))
            val=list(tot_3e.values())
            if val[0]:
                tot_3=tot_3+val[0]
            
            
            # API III-D:  Research Guidance            
            tot_3f=0   
            tot_3f=res_guide.aggregate(Sum('self_api_score'))
            val=list(tot_3f.values())
            if val[0]:
                tot_3=tot_3+val[0]
            
            # API III-E : (i)  Fellowship / Award from Academic Bodies/Associations            
            tot_3g=0   
            tot_3g=fellow.aggregate(Sum('self_api_score'))
            val=list(tot_3g.values())
            if val[0]:
                tot_3=tot_3+val[0]
            
           
            # API III-E : (ii) Invited Lecture / Paper presented            
            tot_3h=0   
            tot_3h=lec.aggregate(Sum('self_api_score'))
            val=list(tot_3h.values())
            if val[0]:
                tot_3=tot_3+val[0]

            # API IIIE (iii) e-Learning Delivery Process/Material            
            tot_3i=0   
            tot_3i=elearn.aggregate(Sum('self_api_score'))
            val=list(tot_3i.values())
            if val[0]:
                tot_3=tot_3+val[0]
            
            tot_sts3=""
            
            # Summary of API III Category
            if account.to_dsg == 'Stage 2':
                if (tot_3 < 20) :
                    tot_sts3 = "Min Score not attained"
                else:
                    tot_sts3 = "Criteria Satisfied"
                    
            if account.to_dsg == 'Stage 3':
                if (tot_3 < 50) :
                    tot_sts3 = "Min Score not attained"
                else:
                    tot_sts3 = "Criteria Satisfied"
                    
            if account.to_dsg == 'Stage 4':
                if (tot_3 < 75) :
                    tot_sts3 = "Min Score not attained"
                else:
                    tot_sts3 = "Criteria Satisfied"
                    
            if account.to_dsg == 'Stage 5':
                if (tot_3 < 100) :
                    tot_sts3 = "Min Score not attained"
                else:
                    tot_sts3 = "Criteria Satisfied"
        
            tot_2_3=0        
            tot_2_3=api_2a+tot_3
            
            if not account.frm_general_info:
                messages.success(request,"You can not get PDF ! Pl.click the form")
                # return HttpResponse(messages,"You are already authenticated as " + str(user.email))                
               
                # return HttpResponseRedirect(self.request.META.get('HTTP_REFERER'))
                # return render(self.request, 'account/cas_view.html',"account:home", user_id=user.id)
                # return HttpResponseRedirect(request.META.get('HTTP_REFERER'))
                # return HttpResponseRedirect(request.META.get('HTTP_REFERER'))
                # return redirect("account:home", user_id=request.user.id)
                
                
                html = "<html><body><div><h1>Hi &nbsp&nbsp&nbsp <br>Sorry, you are not the Applicant ! <br> Please select the applicant preview buttom <br>%s.</h1></div></body></html>" % user.email
                return HttpResponse(html)
            
               
            
            context={}            
    
            if account :   
                        context['id'] = account.id
                        context['frm_general_info'] = account.frm_general_info
                        context['emp_id'] = str(account.emp_id).zfill(6)                       
                        context['username'] = account.username.upper()
                        context['email'] = account.email
                        context['parent'] = account.parent.upper()
                        context['catg'] = account.get_catg_display
                        context['Department'] = account.Department
                        context['Designation'] = account.get_Designation_display
                        context['from_dsg'] = account.get_from_dsg_display
                        context['to_dsg'] = account.get_to_dsg_display
                        context['pan_no'] = account.pan_no
                        context['is_pwd'] = account.is_pwd
                        context['pwd_link'] = account.pwd_link
                        context['agp'] = account.get_agp_display
                        context['dt_last_promo'] = account.dt_last_promo
                        context['dt_eligibility'] = account.dt_eligibility
                        context['addr_corres'] = account.addr_corres
                        context['addr_perm'] = account.addr_perm
                        context['mobile'] = account.mobile
                        context['highest_quali'] = account.get_highest_quali_display
                        context['ass_yr'] = account.ass_yr
                        context['gender'] = account.get_gender_display
                        context['dt_ob'] = account.dt_ob
                        context['date_joined'] = account.date_joined
                        context['quali_year'] = account.quali_year
                        context['tot_experience'] = account.tot_experience
                        context['doc_link'] = account.doc_link
                        context['promo_link'] = account.promo_link                        
                        context['pdf'] = account.pdf
                        context['fwd_link'] = account.fwd_link
                        context['academy'] = academy
                        context['research'] = research
                        context['prests'] = prests
                        context['curpost'] = curpost
                        context['teach'] = teach
                        context['orient'] = orient
                        context['api1'] = api1
                        context['dt_marks'] = dt_marks
                        context['ed_marks'] = ed_marks
                        context['it_marks'] = it_marks
                        context['admin'] = admin
                        context['api2'] = api2
                        context['jrnl'] = jrnl
                        context['pub'] = pub
                        context['jrnl_paper'] = jrnl_paper
                        context['res'] = res
                        context['cons'] = cons
                        context['prj'] = prj
                        context['res_guide'] = res_guide
                        context['fellow'] = fellow
                        context['lec'] = lec
                        context['elearn'] = elearn
                        context['api_1'] = api_1
                        context['api_sts1'] = api_sts1
                        context['api_2'] = api_2
                        context['api_2a'] = api_2a
                        context['api2_sts'] = api2_sts                       
                        context['tot_3a'] = tot_3a
                        context['tot_3b'] = tot_3b
                        context['tot_3b2'] = tot_3b2
                        context['tot_3c'] = tot_3c
                        context['tot_3d'] = tot_3d
                        context['tot_3e'] = tot_3e
                        context['tot_3f'] = tot_3f
                        context['tot_3g'] = tot_3g
                        context['tot_3h'] = tot_3h
                        context['tot_3i'] = tot_3i
                        context['tot_3'] = tot_3
                        context['tot_sts3'] = tot_sts3
                        context['tot_2_3'] = tot_2_3
                        
                        department_name = account.Department.name
                        
                        checked = request.GET.get('checked', 'false').lower()  # Get 'checked' parameter from URL
        
                        if checked == 'true':  
                            pdf = render_to_pdf('account/pdf_admin.html', context)
                        else:
                            pdf = render_to_pdf('account/pdf_template4.html', context)  # Bengali/Other template
                        
                        
                        
                        
                        """
                        if department_name == "BENGALI":                           
                            pdf = render_to_pdf('account/pdf_template4.html', context)  # For Bengali template
                        elif department_name == "SANSKRIT":
                            pdf = render_to_pdf2('account/pdf_template5.html', context)  # For Sanskrit template
                        else:    
                            pdf = render_to_pdf1('account/pdf_template.html', context)  # For English template
                            pdf = render_to_pdf('account/pdf_template4.html', context)  # For Bengali and others template
                        """
                        
                        return HttpResponse(pdf, content_type='application/pdf')
                        
             

id_var = 0 


def register_view(request, *args, **kwargs):
    user = request.user
    if user.is_authenticated:
        return redirect("logout")    
        #return HttpResponse("You are already authenticated as " + str(user.email))
        
    
    context={}
    
    if request.POST:
        form = RegistrationForm(request.POST)
        
        
        if form.is_valid():
            pwd="CasApp@ju23"
            
            
            form.save()
           
            
            email = form.cleaned_data.get('email').lower()
            
            raw_password = form.cleaned_data.get('password1')
               
            account = authenticate(email=email, password=raw_password)
            login(request, account)
            #login(request, user, backend='django.contrib.auth.backends.ModelBackend')
            # destination = get_redirect_if_exists(request)
            destination = kwargs.get("next")
           
            if destination:
                return redirect(destination)
                
            #messages.success(request,'You have successfully signed up!')
            
            subject = 'Welcome to  JU CAS Application'
            message = f'Hello {account.username} , thank you for registering in Jadavpur University CAS Application portal!\nThe initial password for first login is as below:\n\n{raw_password}'
            
            send_mail(
                subject,
                message,                   
                settings.EMAIL_HOST_USER,
                [account.email],
                fail_silently=False,
            )
            account.facult=account.Department.faculty
            account.is_first_login = True
            
            account.save()
            #return redirect("password_change_done")
            return render(request, "password_reset/password_first_setting.html")
            #return redirect("account:home", user_id=request.user.id)
            
            
        else:
            context['registration_form'] = form
                   
            #return redirect(request.path) 
           
    
    else:
        form = RegistrationForm()
        
        context['registration_form'] = form
        
        
    return render(request, 'account/new_login.html', context)


def logout_view(request):
    print("Logging out...")
    logout(request)
    print("Redirecting to register...")
    return redirect('register')
    
    
def login_view(request, *args, **kwargs):
    context = {}
    	
    user = request.user
    
    
    if user.is_authenticated:
        return redirect("account:home", user_id=request.user.id)
   
        
    destination=get_redirect_if_exists(request)
    print("destination: " + str(destination))

    if request.POST:
        form = AccountAuthenticationForm(request.POST)
        if form.is_valid():
            email = request.POST['email']
            password = request.POST['password']
            
            user = authenticate(email=email, password=password)
            
            
            if user:
                login(request, user)
                if destination:
                    return redirect(destination)
                    
                #try:
                    #casform = CasFormSts.objects.get(pk=user_id)
                #except CasFormSts.DoesNotExist:
                    #casform=CasFormSts.objects.create(pk=user_id,email_id=user_id).save()  
                
                if request.user.is_first_login:
                    return redirect("password_change2")
                   
                return redirect("account:home", user_id=request.user.id)
        else:
            #return HttpResponse("Login is not valid try again")
            return render(request, "account/login_error.html")  
            #return redirect("register")
        
        
        
    else:
        form = AccountAuthenticationForm()
	
 
    context['login_form'] = form
    
    return render(request, "account/new_login.html", context)


def get_redirect_if_exists(request):
    redirect = None
    if request.GET:
        if request.GET.get("next"):
            redirect = str(request.GET.get("next"))
    return redirect


def account_view(request, *args, **kwargs):
    """
    - Logic here is kind of tricky
            is_self (boolean)
                    is_friend (boolean)
                            -1: NO_REQUEST_SENT
                            0: THEM_SENT_TO_YOU
                            1: YOU_SENT_TO_THEM
    """
    context = {}
    user_id = kwargs.get("user_id")
    account = Account.objects.get(pk=user_id)
    """
    try:
        account = Account.objects.get(pk=user_id)
    except:
        pass
        # account = Account.objects.all()
        # return HttpResponse("Something went wrong line-102 ???.")
    """
    if account:
        context['id'] = account.id
        context['username'] = account.username
        context['email'] = account.email
        context['profile_image'] = account.profile_image.url
        context['hide_email'] = account.hide_email
        context['last_login'] = account.last_login
        context['Department'] = account.Department
        context['Designation'] = account.get_Designation_display
        context['pan_no'] = account.pan_no
        context['highest_quali'] = account.highest_quali
        context['gender'] = account.get_gender_display
        context['dt_ob'] = account.dt_ob
        context['date_joined'] = account.date_joined
        context['quali_year'] = account.quali_year
        context['tot_experience'] = account.tot_experience
        context['pdf'] = account.pdf
        # Define template variables
        is_self = True
        is_friend = False
        user = request.user
        if user.is_authenticated and user != account:
            is_self = False
        elif not user.is_authenticated:
            is_self = False

        # Set the template variables to the values
        context['is_self'] = is_self
        context['is_friend'] = is_friend
        context['BASE_URL'] = settings.BASE_URL
        return render(request, "account/account.html", context)


def edit_account_view(request, *args, **kwargs):
    if not request.user.is_authenticated:
        return redirect("login")
    user_id = kwargs.get("user_id")
    account = Account.objects.get(pk=user_id)

    if request.method == "GET":
        if user_id == 0:
            form = AccountUpdateForm()
        else:
            account = Account.objects.get(pk=user_id)
            form = AccountUpdateForm(instance=account)
        return render(request, "account/edit2_account.html", {'form': form})

    else:
        if user_id == 0:
            form = AccountUpdateForm(request.POST)
        else:
            account = Account.objects.get(pk=user_id)
            form = AccountUpdateForm(request.POST, instance=account)
        if form.is_valid():
            form.save()
        # return redirect("account:view", pk=account.id)
        return redirect("account:view", user_id=account.pk)


def cas_view(request, *args, **kwargs):

    user_id = kwargs.get("user_id")
    user = request.user
    
    if not request.user.is_authenticated:
        return redirect("login")
        
    if user.is_admin:
        user_id = kwargs.get("user_id")
    else:
        user_id = request.user.id
         
    account = Account.objects.get(pk=user_id)

    global pk_var
    pk_var = user_id
    
    global user_var
    user_var = user_id
    	
    context = {}
    
    if request.method == "GET":
        if user_id == 0:
            form = AccountCasForm()
        else:
            accounts = Account.objects.get(pk=user_id)
            form = AccountCasForm(instance=account)

            academy = accounts.academic_set.all()
            
            context['pdf'] = account.pdf
            msg1="Please fill out all the required fields on this page for further processing of your application!"

                        
            context = {
                'form': form,
                'academy': academy,
                'pk_var': pk_var,
                'user_var': user_var,
                'accounts' : accounts,
                'msg1': msg1
                   
            }
        
        return render(request, "account/cas_register.html", context)

    else:
        if user_id == 0:
            form = AccountCasForm(request.POST)
        else:
            account = Account.objects.get(pk=user_id)
            form = AccountCasForm(request.POST, request.FILES, instance=account)

        if form.is_valid():
            account.frm_general_info = True                       
            form.save()
           
            messages.success(request,('Record has been saved successfully!'))
        else:            
            error_string = ' '.join([' '.join(x for x in l) for l in list(form.errors.values())])

            messages.error(request,error_string)

                
        return redirect(request.path)
        #return redirect("account:academy", user_id=account.id)
        



def self_view(request, *args, **kwargs):

    if not request.user.is_authenticated:
        return redirect("login")

    user_id = kwargs.get("user_id")
    
    account = Account.objects.get(pk=user_id)
    user = request.user
    
    if account.is_first_login:
        account.is_first_login = False
        account.save()
        
    if not account.facult:
        account.facult=account.Department.faculty
        account.save()
        
    if user != account.id:
        HttpResponseForbidden('You cannot view what is not yours') #Or however you want to handle this
 
    global pk_var     
    pk_var=user_id
    request.user.is_first_login = False
    context = {}
    context['pk_var'] = pk_var
    context['username'] = account.username
    context['email'] = account.email
    context['Department'] = account.Department    
    context['Designation'] = account.get_Designation_display()
    context['facult'] = account.facult
    context['is_hod'] = account.is_hod 
    context['is_applicant'] = account.is_applicant
    
    
    if not user.is_applicant:
        # IDs to exclude
        #exclude_ids = [1, 11, 25]
        
        exclude_ids = [1, ]
        # Query to retrieve all Account objects ordered by username, excluding specific IDs
        account = Account.objects.all().exclude(id__in=exclude_ids).order_by('username')
        
        #account = Account.objects.all().order_by('username')
        #account = Account.objects.all()

        ac_reg_count = account.filter(frm_general_info=False).count()
        ac_frm_submitted = account.filter(frm_submitted=True).count()
        ac_post_reg_count = account.filter(frm_general_info=True,frm_submitted=False).count()
        

        admin = Account.is_admin
        print(admin)
        context = {'account': account}
        context['ac_reg_count'] = ac_reg_count
        context['ac_post_reg_count'] = ac_post_reg_count
        context['ac_frm_submitted'] = ac_frm_submitted
        
        for acts in account:
            match = re.match(r".*_\d+$", acts.username)  # Check if it ends with "_number"
            acts.has_suffix = bool(match)  # True if it has a suffix, False otherwise

        context = {
            'account': account  # Pass modified queryset
        }

        context['pk_var'] = pk_var
        context['admin'] = admin
    else:
    
        try:
            casform = CasFormSts.objects.get(pk=user_id)                
        except CasFormSts.DoesNotExist:
            casform=CasFormSts.objects.create(pk=user_id,email_id=user_id).save()  
            return redirect(request.path)
            
        account = Account.objects.get(pk=user_id)
        academy = account.academic_set.all()
        research = account.research_set.all()
        prests = account.priorpost_set.all()
        curpost = account.presentpost_set.all()
        
        try :
            teach = TeachingExp.objects.get(pk=user_id)              
        except TeachingExp.DoesNotExist:
            teach = False
            pass
            
        #teach = account.teachingexp_set.all()
        orient = account.orientation_set.all()
        
        try :
            api1 = ApiCatg_I.objects.get(pk=user_id)              
        except ApiCatg_I.DoesNotExist:
            api1 = False
            pass
            
        try :
            api2 = ApiCatg_II.objects.get(pk=user_id)              
        except ApiCatg_II.DoesNotExist:
            api2 = False
            pass 
         
        jrnl = account.jrnl_pub_set.all()
        pub = account.pub_other_set.all()
        jrnl_paper=account.jrnlpaper_ugc_set.all()
        res = account.resch_proj_set.all()
        cons = account.resch_cons_set.all()
        prj = account.prj_outcm_set.all()
        res_guide = account.resch_guide_set.all()
        fellow = account.fellow_award_set.all()            
        lec = account.lecture_paper_set.all()
        elearn = account.e_learning_set.all()


        if account.frm_general_info:
            casform.general_sts=True
            fnl_sts=True
        else:
            casform.general_sts=False        
            fnl_sts=False
        
        if academy :                    
            casform.academy_sts=True
            fnl_sts=True
        else:
            casform.academy_sts=False
            fnl_sts=False
        
        if research :                    
            casform.research_paper_sts=True                    
        else:
            casform.research_paper_sts=False                    
            
        if prests :
            casform.priorpost_sts=True                    
        else:
            casform.priorpost_sts=False                    
            
        if curpost :                    
            casform.present_post_sts=True
            fnl_sts=True
        else:
            casform.present_post_sts=False
            fnl_sts=False    
              
        if teach:
            if teach.pg_class is not None :
               casform.teaching_sts=True
               fnl_sts=True
        else:
            casform.teaching_sts=False
            fnl_sts=False
        
        if orient :                    
            casform.orientation_sts=True
            fnl_sts=True        
        else:
            if account.from_dsg == "Stage 4":
                casform.orientation_sts=True
                fnl_sts=True
                print('l-846',fnl_sts)    
            else:
                casform.orientation_sts=False
                fnl_sts=False
                print('l-850',fnl_sts)

            
        if api1:
            if api1.direct_teaching: 
                casform.api_catg1_sts=True
                fnl_sts=True
            else:
                casform.api_catg1_sts=False
                fnl_sts=False
        else:
            casform.api_catg1_sts=False
            fnl_sts=False
        
        if api2:
            if api2.field_based_activities: 
                casform.api_catg2_sts=True
                fnl_sts=True
            else:
                casform.api_catg2_sts=False
                fnl_sts=False 
        else:
            casform.api_catg2_sts=False
            fnl_sts=False               
        
        if jrnl :                    
            casform.jrnl_pub_sts=True                    
        else:
            casform.jrnl_pub_sts=False                    
            
        if pub :                    
            casform.pub_other_sts=True                    
        else:
            casform.jpub_other_sts=False                    

        if jrnl_paper :                    
            casform.jrnlpaper_sts=True                    
        else:
            casform.jrnlpaper_sts=False                    

        if res :                    
            casform.resch_proj_sts=True                    
        else:
            casform.resch_proj_sts=False

        if cons :                    
            casform.resch_cons_sts=True                    
        else:
            casform.resch_cons_sts=False
            
        if prj :                    
            casform.prj_outcm_sts=True                    
        else:
            casform.prj_outcm_sts=False

        if res_guide :                    
            casform.resch_guide_sts=True                    
        else:
            casform.resch_guide_sts=False

        if fellow :                    
            casform.fellow_award_sts=True                    
        else:
            casform.fellow_award_sts=False
        
        if lec :                    
            casform.lecture_paper_sts=True
            #fnl_sts=True
        else:
            casform.lecture_paper_sts=False
            #fnl_sts=False
            
        if elearn :                    
            casform.e_learning_sts=True                    
        else:
            casform.e_learning_sts=False
            
        casform.final_sts=fnl_sts
        print(fnl_sts)    
        casform.save()
        
        context = {
            'casform': casform                      
        }
        
        context['pk_var'] = pk_var
        context['username'] = account.username
        context['emp_id'] = account.emp_id
        context['email'] = account.email
        context['Department'] = account.Department    
        context['Designation'] = account.get_Designation_display()
        context['facult'] = account.facult
        context['faculty'] = account.faculty
        context['is_hod'] = account.is_hod 
        context['is_applicant'] = account.is_applicant
        
        #return render(request, 'account/cas_view.html', context)
         
        if account.frm_submitted :
            return render(request, "account/cas_view2.html", context)
        
    
    if not user.is_applicant:              
        return render(request, "account/cas_view_admin.html", context)
    else:
        return render(request, "account/cas_view.html", context)

def academy_view(request, *args, **kwargs):

    user_id = kwargs.get("user_id")
    user = request.user
    
    
    if not request.user.is_authenticated:
        return redirect("login")
    #user_id = request.user.id 
    
    if user.is_admin:
        user_id = kwargs.get("user_id")
    else:
        user_id = request.user.id
  
    global pk_var
    pk_var = user_id
    
    global user_var
    user_var = user_id
     
    account = Account.objects.get(pk=user_id)
    
    
    context = {}
                  
    #acad = account.academic_set.all()
    acad = account.academic_set.all().order_by("year_passing")  # Ascending order
    #acad = account.academic_set.all().order_by("-year_passing")  # Descending order
    
    research = account.research_set.all()
       
    acad_count = acad.count()
    
    context = {
        'acad': acad,
        'research': research,               
        'acad_count': acad_count,
        'pk_var': pk_var,
        'user_var': user_var,
    }

    return render(request, "account/next_register.html", context)

def academy_edit1(request, pk):
    academy = Academic.objects.get(id=pk)
    
    form1 = AcademyForm(instance=academy)
    user_id=academy.email_id
    acad_id=academy.id
    
    if request.method == 'POST':
            form1 = AcademyForm(request.POST, request.FILES, instance=academy)
            if form1.is_valid():
                form1.save()
                messages.success(request,('Record has been modified successfully!'))
                return redirect("account:academy", user_id=academy.email_id)
            else:
                #print(form2.errors)
                error_string = ' '.join([' '.join(x for x in l) for l in list(form1.errors.values())])
                messages.error(request,error_string)   
    
    context = {
        'form1': form1,
        'user_id': user_id,
        'acadid': acad_id,
        'academy': academy,
        
        }
    
    return render(request, 'account/edit_register.html', context)

@login_required(login_url="login")
def academy_add(request):
    
    form1 = AcademyForm()
    
    if request.method == 'POST':
         
            form1 = AcademyForm(request.POST, request.FILES)
            
            
            if form1.is_valid():
                rec = form1.save(commit=False)
                rec.email_id = request.user.id
                rec.save()
                messages.success(request,('Record has been added successfully'))
                return redirect("account:academy", user_id=rec.email_id)
            else:                
                error_string = ' '.join([' '.join(x for x in l) for l in list(form1.errors.values())])
                messages.error(request,error_string)                
                return redirect(request.path)
  
    context = {
        'form1': form1,
        }
    
    return render(request, 'account/next_register1.html', context)


def academy_delete(request, pk):
    academy = Academic.objects.get(id=pk)
    
    if request.method == "POST":
        academy.delete()
        return redirect("account:academy", user_id=academy.email_id)
    
    context = {'item':academy}
    return render(request, 'account/delete.html', context)


@login_required(login_url="login")
def research_add(request):
    
    form2 = ResearchForm()
    
    
    if request.method == 'POST':
            form2 = ResearchForm(request.POST,request.FILES)
            if form2.is_valid():
                rec = form2.save(commit=False)
                rec.email_id = request.user.id
                rec.save()
                messages.success(request,('Record has been added successfully!'))
                return redirect("account:academy", user_id=rec.email_id)
            else:                
                error_string = ' '.join([' '.join(x for x in l) for l in list(form2.errors.values())])
                messages.error(request,error_string)               
                return redirect(request.path)    
   
    context = {
        'form2': form2,       
        }
    return render(request, 'account/next_register2.html', context)

def research_edit1(request, pk):
    research = Research.objects.get(id=pk)
    
    form2 = ResearchForm(instance=research)
    user_id=research.email_id
    
    if request.method == 'POST':
            form2 = ResearchForm(request.POST,request.FILES, instance=research)
            if form2.is_valid():
                form2.save()
                messages.success(request,('Record has been modified successfully!'))
                return redirect("account:academy", user_id=research.email_id)
            else:
                #print(form2.errors)
                error_string = ' '.join([' '.join(x for x in l) for l in list(form2.errors.values())])
                messages.error(request,error_string)

                
    context = {
        'form2': form2,
        'user_id': user_id,
        }
    return render(request, 'account/edit_research.html', context)

def research_delete(request, pk):
    research = Research.objects.get(id=pk)
    
    if request.method == "POST":
        research.delete()
        return redirect("account:academy", user_id=research.email_id)
    
    context = {'item':research}
    return render(request, 'account/research_delete.html', context)

@login_required(login_url="login")
def prests_add(request):
    
    form3 = PrestsForm()
    
    
    if request.method == 'POST':
            form3 = PrestsForm(request.POST,request.FILES)
            if form3.is_valid():
                rec = form3.save(commit=False)
                rec.email_id = request.user.id    
                rec.save()    
                form3.save()
                messages.success(request,('Record has been added successfully!'))
                return redirect("account:professional", user_id=rec.email_id)
            else :                
                error_string = ' '.join([' '.join(x for x in l) for l in list(form3.errors.values())])
                messages.error(request,error_string)                
                return redirect(request.path) 
   
    context = {
        'form3': form3,        
        }
        
    return render(request, 'account/next_register3.html', context)

def prests_edit1(request, pk):
    prests = PriorPost.objects.get(id=pk)
    
    form3 = PrestsForm(instance=prests)
    user_id=prests.email_id
    
    if request.method == 'POST':
            form3 = PrestsForm(request.POST,request.FILES, instance=prests)
            if form3.is_valid():
                form3.save()
                messages.success(request,('Record has been modified successfully!'))
                return redirect("account:professional", user_id=prests.email_id)
            else :
                error_string = ' '.join([' '.join(x for x in l) for l in list(form3.errors.values())])
                messages.error(request,error_string)
    
                
    context = {
        'form3': form3,
        'user_id': user_id,
        }
    return render(request, 'account/edit_prests.html', context)

def prests_delete(request, pk):
    prests = PriorPost.objects.get(id=pk)
    
    if request.method == "POST":
        prests.delete()
        return redirect("account:professional", user_id=prests.email_id)
    
    context = {'item':prests}
    return render(request, 'account/prests_delete.html', context)

def professional_view(request, *args, **kwargs):
    
    user_id = kwargs.get("user_id")
    user = request.user    
    
    if not request.user.is_authenticated:
        return redirect("login")    
    
    if user.is_admin:
        user_id = kwargs.get("user_id")
    else:        
        user_id = request.user.id
   
    global pk_var
    pk_var = user_id
    
    global user_var
    user_var = user_id 
        
    #account = Account.objects.get(pk=user_id)
    account = get_object_or_404(Account, pk=user_id)
    
    context = {}
    
    prests = account.priorpost_set.all()
            
    curpost = account.presentpost_set.all().order_by('designation')
    
   
         
    context = {              
                'prests'  : prests,
                'curpost' : curpost,
                'pk_var': pk_var,
                'user_var': user_var,               
            }
    
    return render(request, "account/professional_register.html", context)


def curpost_add(request):
    
    form4 = PresentPostForm()
    
    if request.method == 'POST':
            form4 = PresentPostForm(request.POST,request.FILES)
            if form4.is_valid():
                rec = form4.save(commit=False)
                rec.email_id = request.user.id
                print('l-1302 ',rec.email_id)    
                rec.save()
                messages.success(request,('Record has been added successfully!!!!!!!'))
                return redirect("account:professional", user_id=rec.email_id)
            else :
                error_string = ' '.join([' '.join(x for x in l) for l in list(form4.errors.values())])
                messages.error(request,error_string)
                return redirect(request.path)
            
    context = {
        'form4': form4,
        }
        
    return render(request, 'account/next_register4.html', context)


def curpost_edit1(request, pk):
    curpost = PresentPost.objects.get(id=pk)
    
    form4 = PresentPostForm(instance=curpost)
    user_id=curpost.email_id
   
    
    if request.method == 'POST':
            form4 = PresentPostForm(request.POST,request.FILES, instance=curpost)
            if form4.is_valid():
                form4.save()
                messages.success(request,('Record has been modified successfully!'))
                return redirect("account:professional", user_id=curpost.email_id)
            else :
                error_string = ' '.join([' '.join(x for x in l) for l in list(form4.errors.values())])
                messages.error(request,error_string)
    
                
    context = {
        'form4': form4,
        'user_id': user_id,
        
        }
    return render(request, 'account/edit_curpost.html', context)

def curpost_delete(request, pk):
    curpost = PresentPost.objects.get(id=pk)
    
    if request.method == "POST":
        curpost.delete()
        return redirect("account:professional", user_id=curpost.email_id)
    
    context = {'item':curpost}
    return render(request, 'account/curpost_delete.html', context)

def teaching_view(request, *args, **kwargs):
    
    user_id = kwargs.get("user_id")
    user = request.user    
    
    if not request.user.is_authenticated:
        return redirect("login")    
    
    if user.is_admin:
        user_id = kwargs.get("user_id")
    else:        
        user_id = request.user.id
   
    global pk_var
    pk_var = user_id
    
    global user_var
    user_var = user_id 
        
    account = Account.objects.get(pk=user_id)
    
    teach = account.teachingexp_set.all()
    
    if teach.count() == 0:
        teach=TeachingExp.objects.create(pk=user_id,email_id=user_id).save()  
        teach = account.teachingexp_set.all()
    
    
    context = {}
    
    
     
    if request.method == "GET":
        if user_id == 0:
            form5 = TeachingExpForm()
        else:
            teach = TeachingExp.objects.get(pk=user_id)
            form5 = TeachingExpForm(instance=teach)
                        
            context = {
                'form5': form5,                
                'pk_var': pk_var,
                'user_var': user_var,
                'account' : account,
                'teach': teach,  
            }
        
        return render(request, "account/teaching_register.html", context)

    else:
        if user_id == 0:
            form5 = TeachingExpForm(request.POST)
        else:
            teach = TeachingExp.objects.get(pk=user_id)
            form5 = TeachingExpForm(request.POST, request.FILES, instance=teach)

        if form5.is_valid():            
            form5.save()
            messages.success(request,('Record has been saved successfully!'))
        else:
            messages.warning(request, "Invalid form")                
            messages.error(request, form5.errors) 
         
       
    
        return redirect(request.path)
        #return redirect("account:academy", user_id=account.id)


def orient_view(request, *args, **kwargs):
    
    user_id = kwargs.get("user_id")
    user = request.user    
    
    if not request.user.is_authenticated:
        return redirect("login")    
    
    if user.is_admin:
        user_id = kwargs.get("user_id")
    else:        
        user_id = request.user.id
   
    global pk_var
    pk_var = user_id
    
    global user_var
    user_var = user_id 
        
    account = Account.objects.get(pk=user_id)
    
    context = {}
          
    orient = account.orientation_set.all()
     
    context = {              
                'orient'  : orient,
                'pk_var'  : pk_var,
                'user_var' : user_var,                              
            }
    
    return render(request, "account/orientation_register.html", context)

@login_required(login_url="login")
def orient_add(request):
   
    form6 = OrientationForm()
    
    
    if request.method == 'POST':
            form6 = OrientationForm(request.POST,request.FILES)
            
            if form6.is_valid():
                rec = form6.save(commit=False)
                rec.email_id = request.user.id    
                rec.save()
                messages.success(request,('Record has been saved successfully!'))
                return redirect("account:orient", user_id=rec.email_id)
            else :
                error_string = ' '.join([' '.join(x for x in l) for l in list(form6.errors.values())])
                messages.error(request,error_string)
                return redirect(request.path)
    
    context = {
        'form6': form6,
        
    }
    return render(request, 'account/next_register6.html', context)


def orient_delete(request, pk):
    orient = Orientation.objects.get(id=pk)
    
    if request.method == "POST":
        orient.delete()
        return redirect("account:orient", user_id=orient.email_id)
    
    context = {'item':orient}
    return render(request, 'account/orient_delete.html', context)

def orient_edit1(request, pk):
    orient = Orientation.objects.get(id=pk)
    
    form6 = OrientationForm(instance=orient)
    user_id=orient.email_id
    
    if request.method == 'POST':
            form6 = OrientationForm(request.POST,request.FILES, instance=orient)
            if form6.is_valid():
                form6.save()
                messages.success(request,('Record has been modified successfully!'))
                return redirect("account:orient", user_id=orient.email_id)
                
    context = {
        'form6': form6,
        'user_id': user_id,
        }
    return render(request, 'account/edit_orient.html', context)


def cas_edit(request, pk):
    account = Account.objects.get(id=pk)
    
    form7 = AccountCasForm(instance=account)
    user_id=account.email
    
    if request.method == 'POST':
            form7 = AccountCasForm(request.POST,request.FILES, instance=account)
            if form7.is_valid():
                form7.save()
                return redirect("account:cas", user_id=account.id)
    context = {
        'form7': form7,
        'user_id': user_id,
        }
    return render(request, 'account/general_register.html', context)

def cas_edit1(request,pk):
    
    account = Account.objects.get(id=pk)
    
    form8 = AccountEditForm(instance=account)
    user_id=account.id
    pdf_url=account.pdf
   
    pdffile=account.pdf

    file= pdffile.filepath

    fullfilepath= "media/" + str(file)

    filesize= os.path.getsize(fullfilepath)

    form8 = AccountEditForm(request.POST)
    
    if request.method == 'POST':
            form8 = AccountEditForm(request.POST,request.FILES, instance=account)
            if form8.is_valid():               
                form8.save()
                return redirect("account:cas", user_id=account.id)
            else:
                return HttpResponse(form8.errors.values())  # Validation failed
                
    context={'pdf':account.pdf}
                     
    context = {
        'form8': form8,
        'user_id': user_id,
        'pdf_url':pdf_url,
        'account':account,
        'filesize': filesize,
        'file': file,
        }
    
    return render(request, 'account/edit_general.html', context)

def api1_view(request, *args, **kwargs):
        
    user_id = kwargs.get("user_id")
    user = request.user    
    
    if not request.user.is_authenticated:
        return redirect("login")    
    
    if user.is_admin:
        user_id = kwargs.get("user_id")
    else:        
        user_id = request.user.id
   
    global pk_var
    pk_var = user_id
    
    global user_var
    user_var = user_id 
    
    try:
        api1 = ApiCatg_I.objects.get(pk=user_id)
    except ApiCatg_I.DoesNotExist:
        api1=ApiCatg_I.objects.create(pk=user_id,email_id=user_id).save()  
        #pass
        # account = Account.objects.all()
        #return HttpResponse("Something went wrong line-1063 ???.")
        return redirect(request.path)
        
      
    account = Account.objects.get(pk=user_id) # applicant row
    act = Account.objects.get(pk=request.user.id) # admin row
    admin=act.is_admin
   
    
    if account.to_dsg == 'Stage 2' or account.to_dsg == 'Stage 3':
        api_factor = 7.50
        dt_marks=70
    else :
        api_factor = 7.75
        dt_marks=60 
    
    if account.to_dsg == 'Stage 2' or account.to_dsg == 'Stage 3' or account.to_dsg == 'Stage 4':
        ed_factor = 10
        ed_marks=20
    else :
        ed_factor = 10
        ed_marks=10     
    
    if account.to_dsg == 'Stage 2' or account.to_dsg == 'Stage 3':
        it_factor = 10
        it_marks = 10
    elif account.to_dsg == 'Stage 4':
        it_factor = 10
        it_marks = 15
    else:
        it_factor = 10
        it_marks = 20 
    
    tot_marks = dt_marks + ed_marks + it_marks
    tot_self_api = 0
    tot_veri_api = 0
    
    if api1.self_api_dt :
        tot_self_api = api1.self_api_dt 
   
    if api1.self_api_ed :
        tot_self_api += api1.self_api_ed
        
    if api1.self_api_it :    
        tot_self_api += api1.self_api_it 
       
    
    if api1.veri_api_dt:
        tot_veri_api = api1.veri_api_dt 
    if api1.veri_api_ed :
        tot_veri_api += api1.veri_api_ed
    if api1.veri_api_it :    
        tot_veri_api += api1.veri_api_it 
   	
    context = {}
    
    if request.method == "GET":
        if user_id == 0:
            form = ApiCatg_IForm()
        else:
            api1 = ApiCatg_I.objects.get(pk=user_id)
            form = ApiCatg_IForm(instance=api1)

                        
            context = {
                'form': form,
                'pk_var': pk_var,
                'user_var': user_var,
                'account' : account,
                'api_factor':api_factor,
                'dt_marks': dt_marks,
                'api1':api1,
                'ed_factor':ed_factor,
                'ed_marks':ed_marks,
                'it_factor':it_factor,
                'it_marks':it_marks,
                'tot_marks':tot_marks,
                'tot_self_api' : tot_self_api,
                'tot_veri_api' : tot_veri_api,
                'admin':admin
            }
        
        return render(request, "account/api_catg1.html", context)

    else:
        if user_id == 0:
            form = ApiCatg_IForm(request.POST)
        else:
            api1 = ApiCatg_I.objects.get(pk=user_id)
            form = ApiCatg_IForm(request.POST, request.FILES, instance=api1)

        if form.is_valid():
           form.save()
           messages.success(request,('Record has been saved successfully!'))
        return redirect(request.path)
        #return redirect("account:home", user_id=api1.id)
        


def api2_view(request, *args, **kwargs):
        
    user_id = kwargs.get("user_id")
    user = request.user    
    
    if not request.user.is_authenticated:
        return redirect("login")    
    
    if user.is_admin:
        user_id = kwargs.get("user_id")
    else:        
        user_id = request.user.id
   
    global pk_var
    pk_var = user_id
    
    global user_var
    user_var = user_id 
    
    try:
        api2 = ApiCatg_II.objects.get(pk=user_id)
    except ApiCatg_II.DoesNotExist:
        api2=ApiCatg_II.objects.create(pk=user_id,email_id=user_id).save()  
        pass
        # account = Account.objects.all()
        #return HttpResponse("Go Back and Try again!")
        return redirect(request.path)
      
    account = Account.objects.get(pk=user_id)
    act = Account.objects.get(pk=request.user.id) # admin row
    admin=act.is_admin
    
    api_factor = 10
    fba_marks=15
    clm_marks=15
    pda_marks=15
    
    tot_marks = fba_marks + clm_marks + pda_marks
    tot_self_api = 0
    tot_veri_api = 0
    
    if api2.veri_api_fba:
        tot_veri_api = api2.veri_api_fba 
    if api2.veri_api_clm :
        tot_veri_api += api2.veri_api_clm
    if api2.veri_api_pda :    
        tot_veri_api += api2.veri_api_pda 
    
    if api2.self_api_fba:
        tot_self_api = api2.self_api_fba 
    if api2.self_api_clm :
        tot_self_api += api2.self_api_clm
    if api2.self_api_pda :    
        tot_self_api += api2.self_api_pda 
     	
    context = {}
    
    if request.method == "GET":
        if user_id == 0:
            form = ApiCatg_IIForm()
        else:
            api2 = ApiCatg_II.objects.get(pk=user_id)
            form = ApiCatg_IIForm(instance=api2)

                        
            context = {
                'form': form,
                'pk_var': pk_var,
                'user_var': user_var,
                'account' : account,
                'api_factor':api_factor,
                'fba_marks': fba_marks,
                'api2':api2,                
                'clm_marks':clm_marks,                
                'pda_marks':pda_marks,
                'tot_marks':tot_marks,
                'tot_self_api' : tot_self_api,
                'tot_veri_api' : tot_veri_api,
                'admin':admin,
            }
        
        return render(request, "account/api_catg2.html", context)

    else:
        if user_id == 0:
            form = ApiCatg_IIForm(request.POST)
        else:
            api1 = ApiCatg_II.objects.get(pk=user_id)
            form = ApiCatg_IIForm(request.POST, request.FILES, instance=api2)

        if form.is_valid():
           form.save()
           messages.success(request,('Record has been saved successfully!'))
        return redirect(request.path)
        #return redirect("account:home", user_id=api2.id)

def faculy_summary(request):
        
        current_date = datetime.now()
       
        # IDs to exclude
        exclude_email_ids = [1, 11, 25]

        faculty_summary = Department.objects.values('faculty').annotate(
            total_users=Coalesce(Count('account', filter=~Q(account__id__in=exclude_email_ids)), Value(0)),
            frm_general_info=Coalesce(Count('account', filter=~Q(account__id__in=exclude_email_ids) & Q(account__frm_general_info=True)), Value(0)),
            frm_submitted=Coalesce(Count('account', filter=~Q(account__id__in=exclude_email_ids) & Q(account__frm_submitted=True)), Value(0)),
            only_reg=F('total_users') - F('frm_general_info'),
            gen_info=F('frm_general_info') - F('frm_submitted'),
        ).order_by('faculty')
        
        grand_total_faculty_users = sum([item['total_users'] for item in faculty_summary])
        grand_total_only_reg = sum([item['only_reg'] for item in faculty_summary])
        grand_total_gen_info = sum([item['gen_info'] for item in faculty_summary])
        grand_total_sumitted = sum([item['frm_submitted'] for item in faculty_summary])
        
        plot_data3 = plot_bar_graph3(faculty_summary)
        
        """
        # Example usage:
        for entry in faculty_summary:
            print(f"Faculty: {entry['faculty']}")
            print(f"Total Users: {entry['total_users']}")
            print(f"frm_general_info: {entry['frm_general_info']}")
            print(f"frm_submitted: {entry['frm_submitted']}")
            print("------")
        """
            
        faculty_stats = Department.objects.values('faculty').annotate(
            num_users=Count(
                Case(
                    When(account__jrnl_pub__email__id__in=exclude_email_ids, then=None),
                    default='account__jrnl_pub__email',
                ),
                distinct=True,
            ),
            num_publications=Count(
                Case(
                    When(account__jrnl_pub__email__id__in=exclude_email_ids, then=None),
                    default='account__jrnl_pub__yr_pub',
                )
            ),
            total_impact_factor=Sum(
                Case(
                    When(account__jrnl_pub__email__id__in=exclude_email_ids, then=None),
                    default='account__jrnl_pub__imp_fac',
                )
            ),
        ).order_by('faculty')

        department_stats = Department.objects.annotate(
            num_users=Count(
                Case(
                    When(account__jrnl_pub__email__id__in=exclude_email_ids, then=None),
                    default='account__jrnl_pub__email',
                ),
                distinct=True,
            ),
            num_publications=Count(
                Case(
                    When(account__jrnl_pub__email__id__in=exclude_email_ids, then=None),
                    default='account__jrnl_pub__yr_pub',
                )
            ),
            total_impact_factor=Sum(
                Case(
                    When(account__jrnl_pub__email__id__in=exclude_email_ids, then=None),
                    default='account__jrnl_pub__imp_fac',
                )
            ),
        ).order_by('faculty')

        # Calculate grand totals
        grand_total_users = sum([faculty_stat['num_users'] for faculty_stat in faculty_stats])
        grand_total_publications = sum([faculty_stat['num_publications'] for faculty_stat in faculty_stats])
        
        
        plot_data = plot_bar_graph(faculty_stats)
        
        pub_other_stats = Department.objects.values('faculty').annotate(
            num_users=Count(
                Case(
                    When(account__pub_other__email__id__in=exclude_email_ids, then=None),
                    default='account__pub_other__email',
                ),
                distinct=True,
            ),
            text_book=Count(
                Case(
                    When(
                        account__pub_other__email__id__in=exclude_email_ids,
                        then=None,
                    ),
                    default=Case(
                        When(account__pub_other__pub_type='TEXT_BK', then=1),
                        default=None,
                        output_field=IntegerField(),
                    ),
                )
            ),
            ref_book=Count(
                Case(
                    When(
                        account__pub_other__email__id__in=exclude_email_ids,
                        then=None,
                    ),
                    default=Case(
                        When(account__pub_other__pub_type='REF_BK', then=1),
                        default=None,
                        output_field=IntegerField(),
                    ),
                )
            ),
            bk_chap=Count(
                Case(
                    When(
                        account__pub_other__email__id__in=exclude_email_ids,
                        then=None,
                    ),
                    default=Case(
                        When(account__pub_other__pub_type='BK_CHAP', then=1),
                        default=None,
                        output_field=IntegerField(),
                    ),
                )
            )
            
        ).order_by('faculty')
        
        plot_data2 = plot_bar_graph2(pub_other_stats)
        
        # Calculate grand totals
        grand_total_pub_users = sum([pub_stat['num_users'] for pub_stat in pub_other_stats])
        grand_total_pub_text_book = sum([pub_stat['text_book'] for pub_stat in pub_other_stats])
        grand_total_pub_ref_book = sum([pub_stat['ref_book'] for pub_stat in pub_other_stats])
        grand_total_pub_bk_chap = sum([pub_stat['bk_chap'] for pub_stat in pub_other_stats])
         
        
        context = {'faculty_stats': faculty_stats,
                   'grand_total_users': grand_total_users,
                   'grand_total_publications': grand_total_publications, 
                   'department_stats': department_stats,
                   'current_date': current_date,**plot_data,**plot_data2,**plot_data3,
                   'pub_other_stats': pub_other_stats,                   
                   'grand_total_pub_users': grand_total_pub_users,
                   'grand_total_pub_text_book': grand_total_pub_text_book,
                   'grand_total_pub_ref_book' : grand_total_pub_ref_book,
                   'grand_total_pub_bk_chap' : grand_total_pub_bk_chap,
                   'faculty_summary' : faculty_summary,
                   'grand_total_faculty_users' : grand_total_faculty_users,
                   'grand_total_only_reg' : grand_total_only_reg,
                   'grand_total_gen_info' : grand_total_gen_info,
                   'grand_total_sumitted' : grand_total_sumitted
                   
                   }
                   
                    
        return render(request, 'account/cas_view_annotate.html', context)

def plot_bar_graph(faculty_stats):
    
    # Extract data for plotting
    faculties = [entry['faculty'] for entry in faculty_stats]
    
    # Replace 'ENGINEERING & TECHNOLOGY' with 'Engg. & Tech'
    faculties_modified = ['Engg. & Tech' if faculty == 'ENGINEERING & TECHNOLOGY' else faculty for faculty in faculties]

    num_users = [entry['num_users'] for entry in faculty_stats]
    num_publications = [entry['num_publications'] for entry in faculty_stats]
    #total_impact_factor = [entry['total_impact_factor'] for entry in faculty_stats]

    # Plotting
    fig, ax = plt.subplots(figsize=(9,3))
    
    # Set the bar width and adjust the positions
    bar_width = 0.35
    bar1 = ax.bar([x - bar_width/2 for x in range(len(faculties))], num_users, bar_width, label='Faculties')
    bar2 = ax.bar([x + bar_width/2 for x in range(len(faculties))], num_publications, bar_width, label='Publications')
    
    # Extend the y-axis tick marks and labels
    ax.set_yticks(range(0, max(max(num_users), max(num_publications)) + 50, 40))

    
    # Add labels on top of the bars
    for i, value in enumerate(num_users):
        ax.text(i - bar_width/2, value + 0.05, str(value), ha='center', va='bottom', fontweight='bold')

    for i, value in enumerate(num_publications):
        ax.text(i + bar_width/2, value + 0.05, str(value), ha='center', va='bottom', fontweight='bold')
    
    # Set font properties
    font_properties = {
        'weight': 'bold',     # Change the font weight
        'size': 20,           # Change the font size
        'family': 'Comic Sans MS',    # Change the font family
    }
    font_prop1 = {
        'weight': 'bold',     # Change the font weight
        'size': 15,           # Change the font size
        'family': 'Arial',    # Change the font family
    }
    
    #ax.set_xlabel('Faculty', **font_properties)
    ax.set_ylabel('Counts', **font_prop1)
    ax.set_title('Faculty vis-a-vis Journal Publication', **font_properties)
    
    ax.set_xticks(range(len(faculties_modified)))
    ax.set_xticklabels(faculties_modified)
    
     
    # Assuming you have a legend, apply font properties to the legend
    legend = ax.legend()
    #legend = ax.legend(loc='center right', bbox_to_anchor=(0.5, 0.5))  # Adjust the values as needed

    if legend is not None:
        for text in legend.get_texts():
            text.set(**font_prop1)
        
    # Apply font properties to y-axis labels
    for label in ax.get_yaxis().get_majorticklabels():
        label.set(**font_prop1)
   
    # Set font properties for x-axis labels
    font_properties_xaxis = FontProperties(weight='bold', size=15, family='Arial')

    # Assuming you have x-axis labels, apply font properties
    for label in ax.get_xaxis().get_majorticklabels():
        label.set_fontproperties(font_properties_xaxis)
    
    # Assuming you have a legend, place it at the bottom with a line break
    legend = ax.legend(loc='upper center', bbox_to_anchor=(0.5, -0.2), ncol=3, prop={'weight': 'bold', 'size': 15, 'family': 'Arial'})  # Adjust the values as needed

    # Enable grid lines
    ax.grid(True, axis='y', linestyle='--', alpha=.9)  # Customize linestyle and alpha as needed

    # Adjust the layout to add space between x-axis labels and legend
    #plt.subplots_adjust(bottom=0.5)
    
    # Adjust the layout to add space between x-axis labels and legend
    plt.subplots_adjust(bottom=0.3, top=.8)  # Adjust the top margin as needed
    
    # Save the plot to a BytesIO buffer
    buffer = io.BytesIO()
    plt.savefig(buffer, format='png')
    buffer.seek(0)

    # Convert the plot to base64
    graphic = base64.b64encode(buffer.read()).decode('utf-8')
    
    return {'graphic': graphic}
    
def plot_bar_graph2(pub_other_stats):
    pub_other = [entry['faculty'] for entry in pub_other_stats]
    faculties_modified = ['Engg. & Tech' if faculty == 'ENGINEERING & TECHNOLOGY' else faculty for faculty in pub_other]
    text_bk = [entry['text_book'] for entry in pub_other_stats]
    ref_bk = [entry['ref_book'] for entry in pub_other_stats]
    bk_chap = [entry['bk_chap'] for entry in pub_other_stats]

    # Plotting
    fig, ax = plt.subplots(figsize=(9, 3))
    bar_width = 0.35
    gap_width = 0.2
    positions = np.arange(len(pub_other_stats))
    faculty_positions = positions + (bar_width + gap_width) * (positions % len(set(pub_other)))

    bar1 = ax.bar(faculty_positions, text_bk, bar_width, label='Text Book')
    bar2 = ax.bar(faculty_positions + bar_width, ref_bk, bar_width, label='Ref. Book')
    bar3 = ax.bar(faculty_positions + 2 * bar_width, bk_chap, bar_width, label='Book Chapter')

    # Add labels on top of the bars
    for bars, values in zip([bar1, bar2, bar3], [text_bk, ref_bk, bk_chap]):
        for bar, value in zip(bars, values):
            ax.text(bar.get_x() + bar.get_width() / 2, value + 0.05, str(value),
                    ha='center', va='bottom', fontweight='bold')

    ax.set_ylabel('Counts', weight='bold', size=20, family='Arial')
    ax.set_title('Faculty wise Other Publication', weight='bold', size=20, family='Comic Sans MS')

    ax.set_xticks(faculty_positions + bar_width)
    ax.set_xticklabels(faculties_modified)

    y_ticks = range(0, max(max(text_bk), max(ref_bk), max(bk_chap)) + 50, 20)
    ax.set_yticks(y_ticks)

    legend = ax.legend()
    if legend is not None:
        for text in legend.get_texts():
            text.set(weight='bold', size=15, family='Arial')

    for label in ax.get_yaxis().get_majorticklabels():
        label.set(weight='bold', size=15, family='Arial')

    font_properties_xaxis = {'weight': 'bold', 'size': 15, 'family': 'Arial'}
    for label in ax.get_xaxis().get_majorticklabels():
        label.set(**font_properties_xaxis)

    legend = ax.legend(loc='upper center', bbox_to_anchor=(0.5, -0.2), ncol=3,
                       prop={'weight': 'bold', 'size': 15, 'family': 'Arial'})

    ax.grid(True, axis='y', linestyle='--', alpha=.9)
    plt.subplots_adjust(bottom=0.3, top=.8)

    buffer = BytesIO()
    plt.savefig(buffer, format='png')
    buffer.seek(0)

    graphic2 = base64.b64encode(buffer.read()).decode('utf-8')

    return {'graphic2': graphic2}
    
def plot_bar_graph3(faculty_summary):
    # Extract data for plotting
    faculty = [entry['faculty'] for entry in faculty_summary]
    registered_only = [entry['only_reg'] for entry in faculty_summary]
    in_process = [entry['gen_info'] for entry in faculty_summary]
    final_submitted = [entry['frm_submitted'] for entry in faculty_summary]
    faculties_modified = ['Engg. & Tech' if facult == 'ENGINEERING & TECHNOLOGY' else facult for facult in faculty]

    # Set font properties
    font_properties = {
        'weight': 'bold',     # Change the font weight
        'size': 20,           # Change the font size
        'family': 'Comic Sans MS',    # Change the font family
    }
    font_prop1 = {
        'weight': 'bold',     # Change the font weight
        'size': 15,           # Change the font size
        'family': 'Arial',    # Change the font family
    }

    # Plotting
    fig, ax = plt.subplots(figsize=(9, 3))

    # Set the bar width and gap width
    bar_width = 0.25  # Adjust the bar width as needed
    gap_width = 0.0  # Adjust the gap width as needed

    # Calculate the positions for bars and gaps
    positions = np.arange(len(faculty))
    faculty_positions = positions + (bar_width + gap_width) * (positions % len(set(faculty)))
    
    # Plot the bars
    bar1 = ax.bar(faculty_positions, registered_only, bar_width, label='Registered')
    bar2 = ax.bar(faculty_positions + bar_width, in_process, bar_width, label='In Process')
    bar3 = ax.bar(faculty_positions + 2 * bar_width, final_submitted, bar_width, label='Final Submitted')

    # Add labels and title
    ax.set_ylabel('Counts', **font_prop1)
    ax.set_title('Faculty-wise CAS Status', **font_properties)
    
    #ax.set_xticks(positions)
    ax.set_xticks(faculty_positions + bar_width)
    ax.set_xticklabels(faculties_modified)
    
    
    # Add labels on top of the bars
    for bars, values in zip([bar1, bar2, bar3], [registered_only, in_process, final_submitted]):
        for bar, value in zip(bars, values):
            ax.text(bar.get_x() + bar.get_width() / 2, value + 0.05, str(value),
                    ha='center', va='bottom', fontweight='bold', family='Arial')

    y_ticks = range(0, max(max(registered_only), max(in_process), max(final_submitted)) + 5, 3)
    ax.set_yticks(y_ticks)

    # Apply font properties to y-axis labels
    for label in ax.get_yaxis().get_majorticklabels():
        label.set(**font_prop1)

    # Assuming you have a legend, place it at the bottom with a line break
    legend = ax.legend(loc='upper center', bbox_to_anchor=(0.5, -0.2), ncol=3, prop={'weight': 'bold', 'size': 15, 'family': 'Arial'})  # Adjust the values as needed

    # Enable grid lines
    ax.grid(True, axis='y', linestyle='--', alpha=.9)  # Customize linestyle and alpha as needed
    
    plt.subplots_adjust(bottom=0.3, top=.8)

    font_properties_xaxis = {'weight': 'bold', 'size': 15, 'family': 'Arial'}
    for label in ax.get_xaxis().get_majorticklabels():
        label.set(**font_properties_xaxis)

    # Save the plot to a BytesIO buffer
    buffer = io.BytesIO()
    plt.savefig(buffer, format='png')
    buffer.seek(0)

    # Convert the plot to base64
    graphic3 = base64.b64encode(buffer.read()).decode('utf-8')

    return {'graphic3': graphic3}
    
def generate_pdf(request):
    # Register the TTF font
    font_path = 'account/fonts/TiroDevanagariSanskrit-Regular.ttf'  # Adjust the path accordingly
    pdfmetrics.registerFont(TTFont('TiroDevanagariSanskrit-Regular', font_path))
    # Create a PDF document
    response = HttpResponse(content_type='application/pdf')
    response['Content-Disposition'] = 'attachment; filename="mypdf.pdf"'

    # Create the PDF content in-memory
    pdf_buffer = BytesIO()
    p = canvas.Canvas(pdf_buffer)
    
    p.drawString(100, 800, 'संस्कृत टेक्स्ट!, Hello , World')

    # Save the PDF to the response
    p.showPage()
    p.save()

    # Get the value from BytesIO buffer and write it to the response
    pdf_value = pdf_buffer.getvalue()
    pdf_buffer.close()
    response.write(pdf_value)

    return response



def generate_unique_username(base_username):
    # Try to match the pattern of username with suffix `_number`
    match = re.match(r"(.*_)(\d+)$", base_username)

    if match:  
        base_name = match.group(1)  # Extract actual username without the suffix
        has_suffix = base_name.endswith("_")
    else:
        base_name = base_username  # Keep original if no match
        has_suffix = False  # No suffix

    counter = 1
    new_username = f"{base_name}{counter if has_suffix else f'_{counter}'}"

    while Account.objects.filter(username=new_username).exists():
        counter += 1
        new_username = f"{base_name}{counter if has_suffix else f'_{counter}'}"

    return new_username
    
def generate_unique_email(base_email):
    domain = "jadavpuruniversity.in"

    # Extract the hostname before '@'
    match = re.match(r"^(.*?)(?:_(\d+))?@.+$", base_email)

    if match:
        base_hostname = match.group(1)  # Extract actual hostname without suffix
    else:
        base_hostname = base_email.split('@')[0]  # Fallback

    counter = 1
    new_email = f"{base_hostname}_{counter}@{domain}"

    while Account.objects.filter(email=new_email).exists():
        counter += 1
        new_email = f"{base_hostname}_{counter}@{domain}"

    return new_email

def generate_unique_emp_id():
    emp_id = 900001
    while Account.objects.filter(emp_id=str(emp_id)).exists():
        emp_id += 1
    return str(emp_id)

@login_required
def update_account_fields(request, user_id):
    account = get_object_or_404(Account, pk=user_id)

    if Account.objects.filter(username=account.username).exists():
        account.username = generate_unique_username(account.username)

    if Account.objects.filter(email=account.email).exists():
        account.email = generate_unique_email(account.email)

    if not account.emp_id or Account.objects.filter(emp_id=account.emp_id).exists():
        account.emp_id = generate_unique_emp_id()

    account.save()
    return redirect("logout")
    #return redirect("success_page")  # Redirect after update

