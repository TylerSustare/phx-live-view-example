# # Extend from the official Elixir image
# FROM bitwalker/alpine-elixir-phoenix:latest

# # Create app directory and copy the Elixir projects into it
# # RUN apk update \
# #   && apk --no-cache --update add nodejs nodejs-npm \
# #   && mix local.rebar --force \
# #   && mix local.hex --force
# RUN mkdir /app
# COPY . /app
# WORKDIR /app

# # Install hex package manager
# # By using --force, we don’t need to type “Y” to confirm the installation
# # RUN mix local.hex --force
# # RUN mix local.rebar --force

# # Compile the project
# ARG MIX_ENV=prod 

# RUN mix deps.get --only prod
# RUN mix compile
# RUN mix release
# RUN npm install
# RUN npm run deploy --loglevel verbose --prefix ./assets
# RUN mix phx.digest

# CMD PORT=4001 MIX_ENV=prod mix phx.server


# WORK DAMMIT
FROM bitwalker/alpine-elixir-phoenix:latest

# Set exposed ports
# EXPOSE 5000
# ENV PORT=5000 
ENV MIX_ENV=prod

# Cache elixir deps
ADD mix.exs mix.lock ./
RUN mix do deps.get, deps.compile

# Same with npm deps
ADD assets/package.json assets/
RUN cd assets && \
  npm install

ADD . .

# Run frontend build, compile, and digest assets
RUN cd assets/ && \
  npm run deploy && \
  cd - && \
  mix do compile, phx.digest

RUN mix release

# USER default

CMD ["_build/prod/rel/live_view_studio/bin/live_view_studio", "start"]