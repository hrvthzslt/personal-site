---
title: "Running a Rhyming Language Model in a Container Because I Don't Have a GPU Anyway"
date: 2025-03-03T07:37:00Z
draft: true
---

Some of the conversation around AI I found interesting, but more of it I found tiring. What I never find boring is running technologies on your own machine.

So I was delighted when I tried **Ollama** and created my own Shakespeare.

<!--more-->

## Ollama

After two months of caring about a baby, not a pet project (well, my projects are more like a pet of a pet project in scope, but that is beside the point), I wanted to try something new. I already knew about **Ollama**, but the first shock was how easy it is to install and run. With appropriate hardware, it is possible to set up your own "Home AI" with multiple models, without any hassle.

That is not what I did because I'm surrounded by mid-tier laptops, so I started my search for the smallest but usable models. Without any scientific measurement, it looked like models having parameters between _1b_ and _2b_ can act like something that works, and with decent performance. This is really subjective, and my goal wasn't to create performance tests, but this is my two cents for now.

## Customizing a model

I had some ideas to create a model for specific use cases. First, I wanted a chatbot that can answer questions about my resume. That turned out quite well except for two things: Company names were made up, and dates never aligned.

So I reached for the thing that I like to do with every new model I try: ask it to answer in rhymes.

**Ollama** provides a tool for this purpose; you can create models from a `Modelfile`. This file name is really reminiscent of `Dockerfile`, and it is not an accident.

The `Modelfile` I created currently looks like this:

```yaml
FROM basemodel

PARAMETER temperature 1.0

SYSTEM """
You are William Shakespeare.
Everything you respond must be answered as a shakespearian poem, there can be no simple sentences.
Never break role. Never use the word "Shakespearian" and "Shakespeare", and never explain what you're doing and why.
Keep your poems short and modest.
"""
```

The `FROM` keyword is used to define the base model. It can be a model that you create or find in the **Ollama** model repository.
You can set parameters with... well, the `PARAMETER` keyword. I raised the temperature to 1.0 because I wanted to see more creative answers.
The `SYSTEM` block is a set of instructions that define how the model should behave and respond, ensuring it adheres to the desired style and persona.

You can see in the system instruction I explicitly stated what should and what should not be done. With multiple models, the answers included an explanation and always pointed out that this is written in "Shakespearian" style. If I wanted the role not to be broken, it could be done with another hundred instructions. Currently, you can make it speak plain English.

## Containerizing

This is something I would not do necessarily if I were hosting my own server with a GPU. But I still wanted to try it because creating a POC is much easier if you provide an environment for it as well.

**Ollama** has a Docker image, so that is covered. Basically, you have to start it and pull or build the model.

Because the **Ollama** service has to be running for pulling, there were some examples that did the whole model-related setup in an entry point. That can work, and if you use volumes, the base model will be persistent, so it does not have to be pulled every time.

I still wanted to build everything in an image. Building the **"shake"** model could be done like this:

```Dockerfile
RUN ollama serve & sleep 5 && ollama create shake -f Modelfile
```

Yes, there is a sleep, sue me. But there is a bigger problem here. This is one layer, so every time I change the Modelfile, the base model would be pulled again.

The inspiration came from Docker itself. I created `Modelfile.base` and `Modelfile.shake` files, like it's a multistage build. In layers, the base model file gets copied, then the base model gets pulled, the shake modelfile gets copied, and then it gets built. This way, if I change `Modelfile.shake`, the base model's layer will be reused, and the whole build will be very fast.

If you want to try it, please check out the [repository](https://github.com/hrvthzslt/verse).

Build silly things and enjoy life!

P.S: I did not explain my stance on the current commercial state of AI, so let me do it now: 

![Ian Malcolm](ian.png)
