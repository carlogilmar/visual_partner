# Star

## For deploy in Heroku

1. Follow this guide [link](https://alchemist.camp/episodes/deploy-phoenix-heroku)
2. Add the files: `Procfile`, `elixir_buildpack.config`, `phoenix_static_buildpack.config`
3. Remember purge the deployment `heroku repo:purge_cache -a starcg`
4. Create a hobby db

## Generate Live View Scaffolding

1. Generate an empty live view
2. Generate the migration, and fill your schema
3. Run the follow command for scaffold your model `mix create_model comment_note`



