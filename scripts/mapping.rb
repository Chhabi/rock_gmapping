require 'orocos'
require 'orocos/log'
require 'vizkit'
require 'transformer/runtime'

include Orocos
Orocos.initialize

# Here give the location of the log files
replay = Log::Replay.open('/home/krishna/bagfiles/rock_log/aria.1.log','/home/krishna/bagfiles/rock_log/hokuyo.1.log')

Orocos.run 'rock_gmapping::Task' => 'rock_gmapping' do
  
  rock_gmapping = Orocos.name_service.get('rock_gmapping')
  aria = Orocos.name_service.get('aria')

  replay.aria.robot_pose_raw.connect_to  rock_gmapping.dynamic_transformations
  #,:type => :buffer, :size => 30
  replay.hokuyo.scans.connect_to rock_gmapping.scan
  #,:type => :buffer, :size => 30


  rock_gmapping.apply_conf_file("../config.yml")

  rock_gmapping.configure
  
  rock_gmapping.start
  puts "task started.."
  Vizkit.control replay
  Vizkit.exec

  
end