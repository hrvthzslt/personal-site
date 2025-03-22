---
title: "Creating a Low-Quality Translation API with Language Models"
date: 2025-03-18T10:08:57Z
draft: false
---

After [experimenting with local language models using **ollama**](/posts/running-rhyming-language-model-in-a-container-because-i-dont-have-a-gpu-anyway/), the time has come to create something with it. During a conversation, it was suggested that it could be used to automate translation processes.

<!--more-->

Let's ignore the fact that this could be done with other translation APIs with much better results. First, let's create a custom model for this task.

## The Model

This will be created again with a `Modelfile`. Initially, I tried to create a very convoluted SYSTEM instruction that defines an input format and an output format in JSON. This could work quite well with a model that has a `tool` role, but the smaller models I used failed with this.

In the end, I found it much easier to define the instructions in plain English using a model with an `assistant` role.

This time, I wanted less creativity, so I lowered the temperature to 0.6. This will result in more common translations.

This performed quite well, but some models have complicated templates, so I made a much simpler one. The benefit is that it is easier to understand and modify, but the drawback is that the current template would only work with models created using the _ollama_ architecture.

All in all, the modelfile looks like this:

```
FROM basemodel

PARAMETER temperature 0.6

TEMPLATE """
{{- if .System }}<|start_header_id|>system<|end_header_id|>
{{ .System }}<|eot_id|>
{{- end }}

{{ if .Prompt }}<|im_start|>user
{{ .Prompt }}<|im_end|>
{{ end }}<|im_start|>assistant
"""

SYSTEM """
You're a translation model.
The requests you receive will contain the source language and the target language, and the text to be translated.
You will get the request in the following format: "translate the following text from {source language} to {target language}: {text}"
You will reply with the translated text.
Only answer the translated text. Never explain the translation process. Never reference the languages or what you did.
"""
```

The template and system instructions will influence every prompt that is sent to the model. The user prompt includes the instruction to perform the translation itself.

We can observe the composed message if we run ollama in debug mode:

```
<|start_header_id|>system<|end_header_id|>
You're a translation model.
The requests you receive will contain the source language and the target language, and the text to be translated.
You will get the request in the following format: "translate the following text from {source language} to {target language}: {text}
You will reply with the translated text.
Only answer the translated text. Never explain the translation process. Never reference the languages or what you did.
<|eot_id|>

<|im_start|>user
translate the following text from english to italian: The quick brown fox jumps over the lazy dog<|im_end|>
<|im_start|>assistant
```

## The API

Short story short: I read the documentation of **FastAPI** and created an endpoint for a POST request. The ollama integration is done with the `ollama` package, which is simple as well. After creating a working endpoint, I reorganized the code and included `ruff` for some code quality improvements and my own satisfaction.

Sending a request and receiving a response looks like this:

```shell
curl -X POST "http://localhost:8000/translate" \
    -H "Content-Type: application/json" \
    -d '{"text": "The quick brown fox jumps over the lazy dog", "source": "english", "target": "italian"}'

{"text":"Il volpe rosso veloce balza sopra il cane pigro."}
```

Of course, I'm not sure about the quality of the translation because I don't know Italian. However, retranslating it back to English yields: "The swift red fox leaps over the lazy dog." You can be the judge.

You can check out the code on [GitHub](https://github.com/hrvthzslt/transloth).
