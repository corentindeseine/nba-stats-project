namespace :purgecss do
  desc 'Run PurgeCSS'
  task :run do
    system('purgecss --config ./purgecss.config.js')
  end
end
