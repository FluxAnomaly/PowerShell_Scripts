# Use PowerShell to Send Beep to Console

# Change the value of the first number to alter the pitch (anything lower than 190 or higher than 8500 can’t be heard), 
# and change the value of the second number to alter the duration:

[console]::beep(500,300)

[console]::beep(2000,500)


[System.Media.SystemSounds]::Exclamation.Play()   
[System.Media.SystemSounds]::Asterisk.Play() 
[System.Media.SystemSounds]::Beep.Play()   

[System.Media.SystemSounds]::Hand.Play()   

# TEXT TO SPEECH:
# https://stackoverflow.com/questions/56032478/how-do-you-get-windows-powershell-to-play-a-sound-after-bat-job-has-finished-ru
# SpVoice Interface (SAPI 5.3)
    # https://docs.microsoft.com/en-us/previous-versions/windows/desktop/ms723602(v=vs.85)

# Create a new SpVoice objects
$voice = New-Object -ComObject Sapi.spvoice

# Set the speed - positive numbers are faster, negative numbers, slower
$voice.rate = 0

# Say something
$voice.speak("Hey, Greg! You enjoying that show? You better get some icecream before it's all gone.")


[console]::beep(1200,300)
[console]::beep(800,300)
[console]::beep(1000,300)
[console]::beep(400,300)
[console]::beep(300,600)


[console]::beep(1200,100)
[console]::beep(1000,100)
[console]::beep(1200,100)
[console]::beep(1000,100)
[console]::beep(1200,100)
[console]::beep(1000,100)



(New-Object Media.SoundPlayer "C:\WINDOWS\Media\ring08.wav").Play();

