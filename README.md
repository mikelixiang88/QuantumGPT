# Quantum GPT

Quantum GPT is an online tool designed to answer quantum-related questions with accuracy and rigor. Built on the ChatGPT3.5 model, this tool aims to bridge the gap between complex quantum concepts and those seeking to understand or apply them.

## Table of Contents

- [Features](#features)
- [Technologies Used](#technologies-used)
- [Directory Structure](#directory-structure)

## Features

- **Ask Question**: Users can pose quantum-related questions.
- **Generate Prompt**: Generates a prompt for the user.
- **Submit Comment**: Allows users to provide feedback on answers.
- **Check Token**: Validates user tokens.
- **User Registration**: New users can create an account.
- **User Login**: Registered users can log in.

## Technologies Used

- Django
- HTML
- CSS
- JavaScript
- MySQL

## Directory Structure

- `quantum_gpt/`
  - `manage.py`
  - `templates/`
    - `app.html`
    - `index.html`
    - `login.html`
    - `register.html`
  - `quantum_accounts/`
    - `forms.py`
    - `models.py`
    - `urls.py`
    - `views.py`
  - `quantum_app/`
    - `forms.py`
    - `models.py`
    - `urls.py`
    - `views.py`
  - `quantum_gpt/`
    - `settings.py`
    - `urls.py`
