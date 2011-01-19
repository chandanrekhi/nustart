atom_feed do |feed|
  if @squery
    feed.title("WorkForAStartup Jobs for #{@squery}")
  else
    feed.title("All WorkForAStartup Jobs")
  end
  feed.updated((@resultset.first.created_at)) unless @resultset.empty?

  for job in @resultset
    if job
      feed.entry(job) do |entry|
        entry.title(job.title)
        entry.content(job.overview, :type => 'html')

        entry.author do |author|
          author.name("WFAS")
        end
      end
    end
  end
end