---
title: "Serving Markdown Files With Flask"
date: 2024-06-07T14:41:15Z
draft: false
---

I created a simple Flask app that serves markdown files. It use a folder structure for routing, reads the markdown file and converts it to HTML and serves it.

<!--more-->

Basicly the following structure:

```
.
└── content
    └── content_management
        ├── index.md
        └── route_example
            └── index.md
```

Will be served as two routes:

```
/content_management
/content_management/route_example
```

You can try it or read the explanation in the [repository](https://github.com/hrvthzslt/markdown-server-flask).

There are some things that I want to write about but does not have to be in the main README.

## Python environments makes me confused

Well, that's not true, I really like the concept of virtual environments. If you want to understand the concept print your `PATH` environmental variable before and after activating a virtual environment. You will see that the **beginning** of your path list changed.

But what is confusing about this topic?

If you want to deliver your application in a container the following question will come up:

- Should I use a virtual environment in my container? I could install the dependencies globally in the container. It would make sense.
- If I don't use a virtual environment in the container how will I found the dependencies during local development?
- If I use a Debian based container it won't let me install the dependencies with `pip` globally. So should I use a virtual environment in the container after all?

Now I do not know all the answers but I can tell you what did I do.

Usually I work locally with a development container and the production container is a different one. But now I only have one container, for delivering the whole application.

Locally I use a virtual environment. In an active venv I can install the frozen dependencies with `pip install -r requirements.txt`. I do the installation the same way in the container as well but without a virtual environment.

This way the local and the container environment is the same. I can use the same `requirements.txt` file for both environments.

But there is one **big** problem. Python itself.

Currently my local Python is 3.11 and I used 3.11 in the container as well. But this will break in the future. When this becomes a real problem I will use **conda** locally, because it can manage different Python versions. If you use Python and you do not know **conda**, you should [check it out](https://conda.io/projects/conda/en/latest/user-guide/install/index.html), it's rad.

## Structuring Flask

When I first created this while thing I took one file and It would never become a big thing. But I still wanted to check out how to structure a Flask app. As far as I know there are a lot of good ideas but no standard.

I could not resist myself and created a `src` and a `test` folder.

```
├── src
│   ├── blueprint
│   │   └── markdown_server
│   │       ├── action.py
│   │       ├── blueprint.py
│   │       ├── domain.py
│   │       ├── responder.py
│   │       └── templates
│   │           ├── 404.html
│   │           ├── base.html
│   │           └── index.html
│   └── infrastructure
│       └── cache.py
└── test
    ├── __init__.py
    ├── test_generate_content.py
    └── test_load_file.py
```

Blueprint holds one blueprint which is the meat of the application. It is not necessary, in this case I have only one, but I really like how blueprints organizes flasks building blocks. I like nice things, sue me.

I created modules for **action**, **domain** and **responder**, and defined the routes in the **blueprint** module.
If you're unfamiliar with this pattern I could explain it or I could say: `request -> action -> domain -> action -> responder -> response`. This is possibly the worst explanation ever but I hope you get the idea.

Infrastructure is just for importing the flask cache module without causing a fabulous circular import.

I'm sure you know what **test** is for, and you write a lot. I'm sure you do. Good for you.

## Code quality

For formatting I use `black`, for linting I use `ruff` and for testing I use `unittest`. All of these can be run in the container, so I use them for a nice little Github action.

I usually create a `Makefile` for these tasks. I really like to create small targets and chain them together.

Setting up a local environment will need the following command:

```bash
make dev-build dev-run
```

Running code quality checks:

```bash
make build format-check lint test
```

This is what I use in the github action as well.

I should write about makefiles, but that is a tale for another time.

Thank you for reading, as most of the time there is no conclusion or lesson. Do some _computering_ and enjoy life!
