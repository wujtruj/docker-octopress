Octopress framework Dockerfile
==============================

Dockerfile to build an Octopress image of the [Octopress framework](https://github.com/imathis/octopress) for [Jekyll](https://github.com/mojombo/jekyll)

## Deploy from index.docker.io

    docker pull wujtruj/octopress

### Interactive shell 

Run fresh instance of an Octopress:

    docker run -i -t -entrypoint="/bin/bash" wujtruj/octopress

Inside docker:
    
    cd /srv/octopress-master
    rake preview

Check port and navigate to `http://localhost:port`

### Permanent config

To run an instance with persistant config and posts, You have to map local directory with Octopress files:

    git clone https://github.com/wujtruj/docker-octopress
    cd docker-octopress
    docker run -d -v `pwd`/posts:/srv/octopress-master/source/_posts -v `pwd`/config:/srv/octopress-master/config -p 80:4000 wujtruj/octopress

Edit `config/` files to meet Your needs  
Then navigate to `http://localhost`

## Roll your own image

To build your own image, run `sudo docker build -t <image_name> .` in the directory with the `Dockerfile` after cloning this.

## Blogging with Octopress

2 ways of doing this

### Automatic (if You are in an interactive shell)

    rake new_post["Post title"]

Then You edit it in `posts` directory.

### Manual

In `posts` directory create `YYYY-MM-DD-title.markdown` file:
    
    ---
    layout: post
    title: "Hello World"
    date: 2013-11-01 11:11
    comments: true
    categories: General
    ---
    **Hello World!**
    This an example post with very short content

## License

[MIT License](http://opensource.org/licenses/mit-license.html)
