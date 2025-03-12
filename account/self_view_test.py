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
        account = Account.objects.all()
        context = {'account': account}
        context['pk_var'] = pk_var

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
            casform.orientation_sts=False
            fnl_sts=False
            
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
    else:
        return render(request, "account/cas_view.html", context)
