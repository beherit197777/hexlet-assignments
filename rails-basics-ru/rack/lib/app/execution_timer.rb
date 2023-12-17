class ExecutionTimer
  def initialize(app)
    @app = app
  end

  def call(env)
    start_time = Time.now
    status, headers, response = @app.call(env)
    end_time = Time.now
    elapsed_time = ((end_time - start_time) * 1_000_000).to_i

    log_execution_time(elapsed_time)

    [status, headers, response]
  end

  private

  def log_execution_time(time)
    puts "Execution Time: #{time} microseconds"
  end
end
