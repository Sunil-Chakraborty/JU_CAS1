class ViewPDF(View):
    
	def get(self, request, *args, **kwargs):
            user_id = kwargs.get("user_id")
            
            account = Account.objects.get(pk=user_id)
            
            user = request.user
            
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
            jrnl_paper=account.jrnlpaper_ugc_set.all() 
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
                        
                        pdf = render_to_pdf('account/pdf_template.html', context)
                        #pdf = render_to_pdf('account/pdf_template1.html', context)  # for blank pdf only

                        return HttpResponse(pdf, content_type='application/pdf')
                        

