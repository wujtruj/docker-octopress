Octopress framework Dockerfile
==============================

Dockerfile to build an Octopress image of the [Octopress framework](https://github.com/imathis/octopress)

## Deploy from index.docker.io

To run an instance with persistant config and posts, You have to map local directory with Octopress files:

    docker pull wujtruj/octopress
    git clone https://github.com/wujtruj/docker-octopress
    cd docker-octopress
    docker run -d -v `pwd`/source:/srv/octopress-master/source -v `pwd`/config:/srv/octopress-master/config -v `pwd`/themes:/srv/octopress-master/.themes -p 4000:80 wujtruj/octopress

Edit `config/` files to meet Your needs  
Install themes in `themes/` and mount to `.themes/`. Then run `rake install['<theme name here>']`  
Writes posts in `source/_posts/`
Then navigate to `http://localhost:4000`

## Roll your own image

To build your own image, run `sudo docker build -t <image_name> .` in the directory with the `Dockerfile` after cloning this.

## Blogging with Octopress

2 ways of doing this:

### Automatic

Run an interactive shell:

    docker run -v `pwd`/source:/srv/octopress-master/source -v `pwd`/config:/srv/octopress-master/config -p 4000:80 -i -t --entrypoint="/bin/bash" wujtruj/octopress

    rake new_post["Post title"]

Then you edit it in `source/_posts/` directory.
When you finish writing new post, it can be published by re-running Octopress container in daemon mode.

### Manual

In `source/_posts` directory create `YYYY-MM-DD-title.markdown` file:
    
    ---
    layout: post
    title: "Post Title"
    date: YYYY-MM-DD HH:MM
    comments: true
    categories: General
    ---
    **Hello World!**
    This an example post with very short content

Then restart container.

## License

[MIT License](http://opensource.org/licenses/mit-license.html)
