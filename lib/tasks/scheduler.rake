desc "Destory all Messages"
task :destroy_all_messages => :environment do
  Message.destroy_all
end
