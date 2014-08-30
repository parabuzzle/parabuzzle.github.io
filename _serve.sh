#!/bin/bash

export JEKYLL_ENV='development'
export JEKYLL_SKIP_DISQUS=true
export JEKYLL_SKIP_SOCIAL=false

jekyll server &
jekyll build --watch --drafts
