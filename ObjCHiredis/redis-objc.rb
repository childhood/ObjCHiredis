# redis.rb
# ObjCHiredis
#
# Created by Louis-Philippe on 10-11-02.
# Copyright 2010 Modul. All rights reserved.

# A wrapper for the ObjCHiredis framework mimicking the redis-rb gem

framework "/Users/lpperron/Documents/lllaptop/git_repos/Redis/ObjCHiredis/ObjCHiredis/build/Debug/ObjCHiredis.framework"

class RedisObjC

  # class methods
  
  def initialize(opts=nil)
    if opts.nil?
      @hiredis = ObjCHiredis.redis
    else
      # redis = Redis.new(:host => host, :port => port, :thread_safe => true, :db => db)
      # db option?
      @hiredis = ObjCHiredis.redis(opts[:host], on:opts[:port])
    end
  end
  
  # Most methods will fit in here
  def method_missing(meth_symbol, *args)
    @hiredis.command("#{meth_symbol.to_s.upcase} #{args.join(' ')}")
  end
  
  # the one that don't
  
  def [](key)
    @hiredis.command("GET #{key}")
  end
  
  def []=(key, value)
    @hiredis.command("SET #{key} #{value}")
  end

end