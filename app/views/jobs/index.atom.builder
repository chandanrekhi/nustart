atom_feed do |feed|
  if @query
    feed.title("WorkForAStartup Jobs for #{@query}")
  else
    feed.title("All WorkForAStartup Jobs")
  end
  feed.updated((@all_jobs.first.created_at)) unless @all_jobs and @all_jobs.empty?
  
  for job in @all_jobs
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