namespace :none do
  task :check do
    true
  end

  task :create_release do
    on release_roles(:web) do |_host|
      execute :mkdir, '-p', release_path
    end
  end

  task :set_current_revision do
    on release_roles(:web) do |_host|
      execute :ln, '-s', release_path, current_path
    end
  end
end