#!/usr/bin/env ruby19

#
# Tested with Ruby 1.9
#
# squid.conf:
#   url_rewrite_program <path>/cache.rb
#   url_rewrite_host_header off
#   cache deny to_localhost
#   header_access Server deny to_localhost
#

require "syslog"
require "base64"

class SquidRequest
	attr_accessor :url, :user
	attr_reader :client_ip, :method

	def method=(s)
		@method = s.downcase
	end

	def client_ip=(s)
		@client_ip = s.split('/').first
	end
end

def read_requests
	# URL <SP> client_ip "/" fqdn <SP> user <SP> method [<SP> kvpairs]<NL>
	STDIN.each_line do |ln|
		r = SquidRequest.new
		r.url, r.client_ip, r.user, r.method, *dummy = ln.rstrip.split(' ')
		(STDOUT << "#{yield r}\n").flush
	end
end

def log(msg)
	Syslog.log(Syslog::LOG_ERR, "%s", msg)
end

def main
	Syslog.open('cache.rb', Syslog::LOG_PID)
	log("Started")

	read_requests do |r|
		if r.method == 'get' && r.url =~ %r{\Ahttp://.+\.youtube\.com/videoplayback\?}
			log("YouTube Video [#{r.url}].")
			"http://127.0.0.1/youtube.php?url=#{Base64.encode64(r.url).delete("\n")}"
		else
			r.url
		end
	end
end

main
