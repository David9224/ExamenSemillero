Una vez creada la instancia de EC2 correr los siguientes dentro de la instancia:
````
wget https://packages.erlang-solutions.com/erlang-solutions_2.0_all.deb && sudo dpkg -i erlang-solutions_2.0_all.deb
 sudo apt-get update
 sudo apt-get install -y esl-erlang
 sudo apt-get install -y inotify-tools
 sudo apt-get install elixir
 
 sudo apt-get install -y nodejs
 sudo apt-get install -y npm
 
 sudo apt-get install -y postgresql postgresql-contrib
 
 mix local.hex --force
 wget https://github.com/phoenixframework/archives/raw/master/phoenix_new.ez
 mix archive.install ./phoenix_new.ez --force
 
 mkdir phoenix
 cd phoenix/
 mix phoenix.new web --no-brunch --no-ecto
 cd web/
 mix phoenix.server
`````
Una vez se hayan ejecutado todos los comandos, ingresar a la ip publica por el puerto 4000