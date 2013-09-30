pizza-distro-sys
================

A Pizza Distribution System for Engineering Enterprise Software

Important Information:
----------------------
The first step you should take is to pull down the project from github. If you're using windows, [GitHub for Windows](http://windows.github.com/ "Github for Windows") is by far the easiest tool for git management. Download it, set it up with your git account information, and clone the repo. If the repo isn't listed, I may not have added you as a collaborator. Email me at ross.kahn@outlook.com with your username. When you clone the project, it will add a project folder somewhere on your computer (by default, in Documents/github). Keep navigating until you get to a folder that has an "app", "config", "db", etc. subfolders. This is your project folder. I'll reference it from now on. All command prompt commands should happen inside of this folder.
 1. Before you can get started coding for this project, you need to have rails installed. It's easiest to use the rails installer [here](www.railsinstaller.org/en "Rails Installer")
	* After it's done, try typing "rails" into your command prompt. If it recognizes the command, proceed.
	
 2. If you're doing any local development, you're also going to need postgresql. This one is a bit trickier. First of all, download the postgres installer [here](http://www.postgresql.org/download/ "Postgres Downloads")
	* During the download, it will ask you at some point for a password. Make the password the word "secret"
	* After the download, make sure the postgres bin folder is on your system path. Add "C:\Program Files\PostgreSQL\9.3\bin" (or the equivalent) to your system path
		* Type "psql" into the command prompt. If your computer doesn't recognize it, you haven't added it to your path correctly. If it prompts you for a password, just type whatever (this was just to check if you had the path right)
	* Then, open up PGAdminIII
	* Double-click on the "PostgreSQL 9.3..." entry on the explorer pane on the left. It should have a symbol with an X, and it will prompt you for a password. Enter "secret"
	* Left-click on Login Roles and select "New Login Role"
		* On the main tab, enter "Pizza" as the role name
		* On the Definition page, enter "Secret" as the password in both fields
		* On the Role Privileges page, check every box
		* Press OK (you should see the role appear in the explorer pane under Login Roles when you refresh)
	* Open up a command prompt and navigate to your project folder
	* Type "createdb -U Pizza pizzamaster" in your command prompt. Enter "secret" as the password. If you refresh pgadminIII, you should see the database appear under databases
	* If everything has worked up to this point, you're doing great!
	
  3. Navigate to your project folder in the command prompt.
	* type "bundle install". You'll see a bunch of stuff happen. Hopefully you don't get any errors
	* MOMENT OF TRUTH: type "rake db:migrate". If this works, you're ready for local development! If not, contact me.

Important Links:
----------------
- [Team Blog](http://teamtwo-kahn.blogspot.com/ "Team Blog") 