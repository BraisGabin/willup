# Willup - DST Dedicated Servers made easy
The main idea beyond Willup is to automate the tedious task of setup a [Don't Starve Together][dst]
(DST) server. Willup give you a working server with a [default sensible settings](#default-settings).
Then you can customize your server or just play. That's up to you!

Willup is a newburn script. He need to grow up. Right now it's just tested to work on Ubuntu 14.04
but the idea is to support the major Linux distributions. If the community want to support Mac OS
and Windows (with [cygwin][cygwin]) we can try it *together*.

## Download
There are two ways to download it:

1. Using `git`
   ```shell
   git clone https://github.com/BraisGabin/willup.git hi-willup
   ```

2. [Downloading][zip] and uncompressing the `.zip`
   ```shell
   wget -O /tmp/willup.zip https://github.com/BraisGabin/willup/archive/master.zip
   unzip /tmp/willup.zip
   mv willup-master hi-willup
   rm /tmp/willup.zip
   ```

You must download it in the server.

## Install
First of all you need to have your `server_token.txt` file. You can find info about how to obtain
this file [here][server_token]. Ones you have the file execute this command inside `hi-willup`:

```shell
./install.sh --server_name="My awesome server" path_to_server_token_txt
```

Once you installed Willup you can remove the `hi-willup` directory `rm -r hi-willup`.

## Usage
You are ready to go! You just need to tell Willup to start the server for you:

```shell
willup start
```

That's it! Your server is ready to go. Remember, Don't Starve!

### Other commands

##### Restart your server:
```shell
willup restart
```

##### Update your server:
```shell
willup update
```

##### Stop your server:
```shell
willup stop
```

## Default settings
How does Willup configure the server? Well these are the highlights:

* Cooperative server
* Survival mode
* An overworld and a cave
* Both maps with the default settings
* Ports:
 * 10999 overworld
 * 11000 cave
* Without password (but you can set it easily: add `--server-password=your_password` to the install
  command)
* No mods

## Contributing
You can contribute with this project in three different ways:

1. Share the project! Blogs, forums, twitter... There is not a yell enough lauder.
2. Open an issue. If you find a bug, the documentation is not clear enough, you have a question, you
want a new feature... Just open an issue. It's not necessary to yell there.
3. Fork the repo and send Pull Request. This is the best one. If you know how to improve the code or
the documentation, please do it!

## How it works
The installation script have four steps:

1. It create a new user for Willup to work in.
2. Install Steam and DST.
3. Set the default settings for the server.
4. Create a command to manage the server.

Willup uses `screen` to run the servers.

## Resources
Some good resources about how to setup a DST Server, Willup is based in them:

* [Don't Starve Wiki: Guides/Don’t Starve Together Dedicated Servers](http://dont-starve-game.wikia.com/wiki/Don%E2%80%99t_Starve_Together_Dedicated_Servers)
* [Don't Starve Forum: \[GUIDE\] How to setup server dedicated cave on Linux](http://forums.kleientertainment.com/topic/59563-/)
* [Dont' Starve Forum: worldgenoverride.lua with the new post-Caves settings](http://forums.kleientertainment.com/topic/53014-/)

## License

    Copyright 2015 Brais Gabín

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.

 [dst]: http://dontstarvetogether.com/
 [zip]: https://github.com/BraisGabin/willup/archive/master.zip
 [server_token]: http://dont-starve-game.wikia.com/wiki/Don%E2%80%99t_Starve_Together_Dedicated_Servers#Server_Tokens
 [cygwin]: https://www.cygwin.com/
