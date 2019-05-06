namespace :prove_keybase do
  desc 'Queue a job to update from Keybase for every keybase proof'
  task :update_proofs do
    puts 'We recommend implementing this especially for your site and running it from time to time.'
    puts 'It might be as easy as `ProveKeybase::KeybaseProof.all.find_each(&:refresh)` though.'
  end
end
