require_relative '../config/environment'



app = Cli.create
app.welcome
app.login


#sometimes quitting from inside the program is annoying because of the way we handled errors. perhaps "q" could return to main menu or
#shut the program down?