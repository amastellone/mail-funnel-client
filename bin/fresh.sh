#!/bin/bash

bin/rails db:environment:set RAILS_ENV=development

rails db:drop && rails db:create && rails db:migrate