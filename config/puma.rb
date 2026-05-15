# This configuration file will be evaluated by Puma. The top-level methods that
# are invoked here are part of Puma's configuration DSL. For more information
# about methods provided by the DSL, see https://puma.io/puma/Puma/DSL.html.
#
# Puma starts a configurable number of processes (workers) and each process
# serves each request in a thread from an internal thread pool.
#
# You can control the number of workers using ENV["WEB_CONCURRENCY"]. You
# should only set this value when you want to run 2 or more workers. The
# default is already 1.
#
# The ideal number of threads per worker depends both on how much time the
# application spends waiting for IO operations and on how much you wish to
# prioritize throughput over latency.
#
# As a rule of thumb, increasing the number of threads will increase how much
# traffic a given process can handle (throughput), but due to CRuby's
# Global VM Lock (GVL) it has diminishing returns and will degrade the
# response time (latency) of the application.
#
# The default is set to 3 threads as it's deemed a decent compromise between
# throughput and latency for the average Rails application.
#
# Any libraries that use a connection pool or another resource pool should
# be configured to provide at least as many connections as the number of
# threads. This includes Active Record's `pool` parameter in `database.yml`.

# Threads — same in both environments
max_threads_count = ENV.fetch("RAILS_MAX_THREADS", 5)
min_threads_count = ENV.fetch("RAILS_MIN_THREADS", 2)
threads min_threads_count, max_threads_count

# Workers — 0 means single mode (no cluster). Set WEB_CONCURRENCY=1+ in production.
workers ENV.fetch("WEB_CONCURRENCY", 0)

# preload_app! only makes sense in cluster mode (workers >= 1).
# Calling it in single mode is a no-op but harmless; gating it is cleaner.
preload_app! if ENV.fetch("WEB_CONCURRENCY", 0).to_i > 0

# Bind to a Unix socket if RAILS_SOCKET is set (production via Nginx),
# otherwise fall back to the TCP port (local dev).
if ENV["RAILS_SOCKET"]
  bind ENV.fetch("RAILS_SOCKET")
else
  port ENV.fetch("PORT", 3000)
end

# Solid Queue supervisor — only when explicitly enabled
plugin :solid_queue if ENV["SOLID_QUEUE_IN_PUMA"]

# PID and state files — only set if requested (Rails sets sensible defaults otherwise)
pidfile ENV["PIDFILE"] if ENV["PIDFILE"]
state_path ENV["STATE_PATH"] if ENV["STATE_PATH"]

plugin :tmp_restart
