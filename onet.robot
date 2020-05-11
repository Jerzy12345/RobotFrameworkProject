*** Settings ***
Library   SeleniumLibrary
Library   BuiltIn
Test Setup     Otwarcie przegladarki
Test Teardown  Zamkniecie przegladarki

*** Variables ***
${Browser}  Firefox
${URL}  https://www.onet.pl/
${mail}   xpath://span[contains(.,'E-MAIL')]
${login_field}   xpath://input[@name='login']
${pass_field}   xpath://input[@type='password']
${login}   konto_dla_testera@onet.eu
${password}   Haslo-tester-2020
${Login_button}   xpath://input[@class='loginButton']
${Rodo}   xpath://button[contains(.,'Przejdź do serwisu')]
${Axel}   Ringier Axel Springer Polska sp. z o.o.
${Bad_user}   tester@onet.eu
${Bad_password}   tester2020
${log_in_error}   Nie pamiętam hasła
${napisz}   Napisz wiadomość
${send_mail}	xpath://span[@class='sc-AykKD itGidr button-label'][contains(.,'Napisz wiadomość')]
${pole_odbiorcy}   xpath://input[@class='bubble-field']
${pole_tematu}   xpath://input[@class='form-field-medium']
${temat}   Weryfikacja poprawności wysyłania wiadmosci
${send}   xpath://span[@class='sc-AykKD itGidr button-label'][contains(.,'Wyślij')]
${Yes_button}   xpath://button[@type='button'][contains(.,'Tak')]

*** Test Cases ***
Test poprwnego otwarcia strony onet.pl
    Akceptacja Rodo
    Test strony

Test zalogowania sie do poczyt onet.pl z uzyciem poprawnych danych
	Akceptacja Rodo
	Klikniecie ikony poczty
	Wprowadzenie uzytkownika
	Wprowadzenie hasla
	Klikniecie zaloguj
	Weryfikacja poprawnego zalogowania

Test zalogowania sie z uzyciem blednego loginu
	Akceptacja Rodo
	Klikniecie ikony poczty
	Wprowadzenie blednego uzytkownika
	Wprowadzenie hasla
	Klikniecie zaloguj
	Weryfikacja blednego logowania

Test zalogowania sie z uzyciem blednego hasla
    Akceptacja Rodo
	Klikniecie ikony poczty
	Wprowadzenie uzytkownika
	Wprowadzenie blednego hasla
	Klikniecie zaloguj
	Weryfikacja blednego logowania

Test wysylania nowej wiadmosci e-mail
	Akceptacja Rodo
	Klikniecie ikony poczty
	Wprowadzenie uzytkownika
	Wprowadzenie hasla
	Klikniecie zaloguj
	Klikniecie przycisku nowa wiadomosc
	Wprowadz odbiorce
	Wprowadz temat
	Wyslij wiadomosc
	Potwierdz brak zalacznika


*** Keywords ***
Otwarcie przegladarki
   Open browser   ${URL}   ${Browser}

Akceptacja Rodo
	Wait Until Element Is Visible   ${Rodo}   5
	Click Element   ${Rodo}

Test strony
   Page Should Contain	${Axel}
   Capture Page Screenshot

Klikniecie ikony poczty
	Click Element   ${mail}

Wprowadzenie uzytkownika
   Wait Until Element Is Enabled   ${login_field}
   Input Text   ${login_field}   ${login}   clear=True

Wprowadzenie hasla
   Input Text   ${pass_field}   ${password}   clear=True

Klikniecie zaloguj
	Click Element   ${Login_button}

Weryfikacja poprawnego zalogowania
	Page Should Contain   ${napisz}
   Capture Page Screenshot

Wprowadzenie blednego uzytkownika
	Wait Until Element Is Enabled   ${login_field}
	Input Text   ${login_field}   ${Bad_user}   clear=True

Wprowadzenie blednego hasla
	Input Text   ${pass_field}   ${bad_password}   clear=True

Weryfikacja blednego logowania
	Page Should Contain   ${log_in_error}
	Capture Page Screenshot

Klikniecie przycisku nowa wiadomosc
	Wait Until Element Is Enabled   ${send_mail}
	Click Element   ${send_mail}

Wprowadz odbiorce
	Wait Until Element Is Enabled   ${pole_odbiorcy}
	Input Text   ${pole_odbiorcy}   ${login}
	Press Keys   none   RETURN

Wprowadz temat
	Wait Until Element Is Enabled   ${pole_tematu}
	Input Text   ${pole_tematu}   ${temat}

Wprowadz tekst
   Input text   ${tekst}   ${wiadomosc}

Wyslij wiadomosc
	Wait Until Element Is Enabled   ${send}
	Click Element   ${send}

Potwierdz brak zalacznika
	Wait Until Element Is Enabled   ${Yes_button}
	Click Element   ${Yes_button}
	Sleep   5
	Capture Page Screenshot

Zamkniecie przegladarki
   Close All Browsers
