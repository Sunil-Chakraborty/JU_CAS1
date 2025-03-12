# models.py
from django.db import models

class TextEntry(models.Model):
    text = models.CharField(max_length=255)

    def __str__(self):
        return self.text


# forms.py
from django import forms
from .models import TextEntry

class DynamicForm(forms.Form):
    def __init__(self, *args, **kwargs):
        super(DynamicForm, self).__init__(*args, **kwargs)
        entries = TextEntry.objects.all()

        if entries.count() > 10:  # Change this threshold as needed
            choices = [(entry.id, entry.text) for entry in entries]
            self.fields['entry'] = forms.ChoiceField(choices=choices)
        else:
            self.fields['entry'] = forms.CharField(max_length=255)


# views.py
from django.shortcuts import render, redirect
from .models import TextEntry
from .forms import DynamicForm

def dynamic_form_view(request):
    if request.method == 'POST':
        form = DynamicForm(request.POST)
        if form.is_valid():
            if isinstance(form.cleaned_data['entry'], str):
                TextEntry.objects.create(text=form.cleaned_data['entry'])
            else:
                selected_entry = TextEntry.objects.get(id=form.cleaned_data['entry'])
                # Handle selected entry if needed
            return redirect('dynamic_form_view')
    else:
        form = DynamicForm()

    return render(request, 'dynamic_form.html', {'form': form})


<!-- templates/dynamic_form.html -->
<!DOCTYPE html>
<html>
<head>
    <title>Dynamic Form</title>
</head>
<body>
    <h1>Dynamic Form</h1>
    <form method="post">
        {% csrf_token %}
        {{ form.as_p }}
        <button type="submit">Submit</button>
    </form>
</body>
</html>


